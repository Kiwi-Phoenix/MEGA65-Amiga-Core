-- Unified RAM Controller.
-- Repalce the orignial two MiSTer Minimig RA SDRAM and DRAM contollers into one module
-- for the Mega65 Amiga Core.
--
-- Uses XPM to instantiate the BRAM and split into Banks / Regions so that
-- future development can move the region to a memory location external to the FPGA BRAM
--
-- There are four paths that the controller needs to managed:
-- CPU Read, CPU Write, DMA/CHIP Read, and DMA/CHIP Write 
--
-- The CPU can use a cache, but only for FAST Ram and only for the M68020 and above CPU.
-- For arbitration, the priority order is, DMA Write, CPU Write, DMA Read, CPU Read
-- ANGUS sends the CPU and DMA signals on different clock cycles, howver these signals
-- can arrive while a request is current in progress, therefore the controller will queue the request.
-- CPU will always wait for an acknowledgement signal from a previous CPU request before sending another request.
-- It doesn't know about any DMA requests.  Likewise for DMA.
-- Therefore, given the possibility of two requests coming while one is currently inflight and DMA always taking
-- priority it is possible to have a CPU request in the queue.  Never more that one request in the queue.
-- 
-- DMA/CHIP also has a Burst mode. Read/Write  
-- The chipBurstLen controls the, max 8 in a row.  Used mostly for reads.
-- The starting mem address is provided and then the Controller will deliver (assume read) the data from the memory locations
-- in sequences for the X busts.   
-- DMA is meant to be restricted ti CHIP RAM only, however this controller does not have any restrictions on that.
-- Will assume the Agnus takes care of that and will only send CHIP memory addresses.  However, if other resions are sent
-- is would not be a problem.
--
-- Basic Structure of the Controller:
-- Assess
--  Determine the type of reques, e.g. write/read, CPU/DMA
-- Setup
--  Prepare, determine the naks/region, memory address, data, bursts, etc.
-- Execute
--   Execute the request.  Write/Read BRAM, etc.
-- Acknowledgement
--   Return that data (read) and send ack signals to show "Done".  Ready for the next request. 
--
-- TODO:
-- The CPU cache is currently a pass-thru, I.e. no cacheing is happening in there. 
--
-- January 2026      David Raynor (Kiwi)
--
 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xpm;
use xpm.vcomponents.all;

library work;
use work.ram_type_pkg.all;
use work.Amiga_Debug_pkg.all;
use work.debug_utils_pkg.all;
--use work.debug_pkg_parm.all;
--use work.tb_debug_helpers.all;
--use work.ramctrl_debug_pkg.all;

entity ram_ctrl_unified is
  generic (
    DEBUG_ENABLE  : boolean := true;
    DATA_WIDTH    : integer := 16;
    NUM_BANKS     : integer := 3;
    WORD_ADDR_W   : integer := 20;
    READ_LATENCY  : integer := 1;   
    BANK_SEL_HI   : integer := 28;
    BANK_SEL_LO   : integer := 27
  );
  port (
    sysclk          : in  std_logic;
    reset_n         : in  std_logic;

    -- cache / FE
    cache_rst       : in  std_logic;
    cache_inhibit   : in  std_logic;
    cpu_cache_ctrl  : in  std_logic_vector(3 downto 0);

    -- FE / CPU side
    ramsel          : in  std_logic;
    ramaddr         : in  std_logic_vector(28 downto 1);
    ramdin          : in  std_logic_vector(15 downto 0);
    ramshared       : in  std_logic;
    cpustate        : in  std_logic_vector(1 downto 0);
    cpuCS           : in  std_logic;
    cpu_bs          : in  std_logic_vector(1 downto 0);
    cpu_we          : in  std_logic;
    cpu_ir          : in  std_logic;
    cpu_dr          : in  std_logic;
    cpuRD           : out std_logic_vector(15 downto 0);
    cpu_ack         : out std_logic;
    ramready        : out std_logic;

    -- CHIP bus / DMA
    chipAddr        : in  std_logic_vector(24 downto 1);
    chipL           : in  std_logic;
    chipU           : in  std_logic;
    chipRW          : in  std_logic;
    chipDMA         : in  std_logic;
    chipWR          : in  std_logic_vector(15 downto 0);
    chipRD          : out std_logic_vector(15 downto 0);
    chip48          : out std_logic_vector(47 downto 0);
    chip48_1_o      : out std_logic_vector(DATA_WIDTH-1 downto 0);
    chip48_2_o      : out std_logic_vector(DATA_WIDTH-1 downto 0);
    chip48_3_o      : out std_logic_vector(DATA_WIDTH-1 downto 0);
    chip_rd_done    : out std_logic;

    -- SDRAM/cache interface
    cur_req_o       : out t_req_type;
    sdr_read_req    : out std_logic;
    sdr_read_ack    : out std_logic;
    cpu_dat_r_final : out std_logic_vector(15 downto 0);

    -- Burst count
    chipBurstLen    : in  std_logic_vector(2 downto 0);
    
    -- DMA debug
    dma_rd_addr     : out std_logic_vector(WORD_ADDR_W-1 downto 0);
    dma_rd_done     : out std_logic;
    dma_wr_done     : out std_logic
    
  );
end entity;

architecture rtl of ram_ctrl_unified is

  constant DATA_W         : integer := 16;
  constant CHIP_RAM_BYTES : integer := 512 * 1024 * 8;
  constant FAST_RAM_BYTES : integer := 256 * 1024 * 8;
  constant ROM_BYTES      : integer := 256 * 1024 * 8;
  constant ROM_EXT_BYTES  : integer := 4   * 1024 * 8;
  --constant ROM_INIT_FILE  : string  := "none";
  constant ROM_INIT_FILE  : string  := "AA_Sim_Boot.mem";

  type OP_REC_TYPE is record
    chipRD      : std_logic_vector(15 downto 0);
    chip48      : std_logic_vector(47 downto 0);
    chip48_1_o  : std_logic_vector(15 downto 0);
    chip48_2_o  : std_logic_vector(15 downto 0);
    chip48_3_o  : std_logic_vector(15 downto 0);
    cpu_ack     : std_logic;
    cpuRD       : std_logic_vector(15 downto 0);
    ramready    : std_logic;
    dma_rd_done : std_logic;
    dma_wr_done : std_logic;    
  end record;

  type IP_REC_TYPE is record
    cache_inhibit   : std_logic;
    cpu_cache_ctrl  : std_logic_vector(3 downto 0);
    ramsel          : std_logic;
    ramaddr         : std_logic_vector(28 downto 1);
    ramdin          : std_logic_vector(15 downto 0);
    ramshared       : std_logic;
    cpustate        : std_logic_vector(1 downto 0);
    cpuCS           : std_logic;
    cpu_bs          : std_logic_vector(1 downto 0);
    cpu_we          : std_logic;
    cpu_ir          : std_logic;
    cpu_dr          : std_logic;
    chipAddr        : std_logic_vector(24 downto 1);
    chipL           : std_logic;
    chipU           : std_logic;
    chipRW          : std_logic;
    chipDMA         : std_logic;
    chipWR          : std_logic_vector(15 downto 0);
  end record;

  type CC_REC_TYPE is record
    cache_wr_done  : std_logic;
    cache_dat_r    : std_logic_vector(15 downto 0);
    cache_cpu_ack  : std_logic;
  end record;

  signal op : OP_REC_TYPE;
  signal ip : IP_REC_TYPE;
  signal cc : CC_REC_TYPE;

  signal rst : std_logic;

  constant BYTE_WRITE_WIDTH : integer := 8;
  constant WORDS_PER_BANK   : integer := 2**WORD_ADDR_W;
  constant MEMORY_SIZE_BITS : integer := (DATA_WIDTH * WORDS_PER_BANK) / 2;
  constant BANKS_W          : integer := integer(ceil(log(real(NUM_BANKS))/log(2.0)));

  subtype word_t is std_logic_vector(DATA_WIDTH-1 downto 0);
 
  type bank_t is (BANK_NONE, BANK_CHIP, BANK_FAST, BANK_ROM, BANK_ROM_EXT);

  function decode_region(addr24 : std_logic_vector(23 downto 0)) return bank_t is
    -- F00000-FFFFFF
    -- 1111 xxxx xxxx xxxx xxxx xxxx
    -- F00000 = 1111 0000 0000 0000 0000
    -- F80000 = 1111 1000 0000 0000 0000
    -- Therefore, bit 19 can be used to split ROM between normal ROM and extended ROM.
    variable hi_nibble : std_logic_vector(3 downto 0);
    variable rom_offset   : std_logic;
  begin
    hi_nibble := addr24(23 downto 20);
    rom_offset   := addr24(19);
    if hi_nibble = x"F" then
      if rom_offset = '0' then
        return BANK_ROM_EXT;
      else
        -- If rom_offset - 1 then ROM starts at F80000
        -- ROM_ext starts at F00000
        return BANK_ROM;
      end if;
    elsif hi_nibble = x"0" or hi_nibble = x"1" then
      return BANK_CHIP;     -- Max. 2MB
    elsif hi_nibble >= x"2" and hi_nibble <= x"9" then
      return BANK_FAST;     -- Max. 8MB
    else
      return BANK_NONE;
    end if;
  end function;
  
  -- FSM Requests
  signal cur_req  : t_req_type;
  
  -- BRAM Control / Switching
  signal wr_addr              : std_logic_vector(WORD_ADDR_W downto 1) := (others => '0');
  signal wr_data              : word_t := (others => '0');
  signal wr_be                : std_logic_vector(1 downto 0) := (others => '0');
  signal wr_en                : std_logic := '0';

  signal chip_wr_en           : std_logic;
  signal fast_wr_en           : std_logic;
  signal rom_wr_en            : std_logic;
  signal rom_ext_wr_en        : std_logic;

  signal rd_addr_reg          : std_logic_vector(WORD_ADDR_W-1 downto 0);
  signal rd_data              : std_logic_vector(15 downto 0) := (others => '0');
  signal rd_en                : std_logic := '0';

  signal chip_rd_en           : std_logic;
  signal fast_rd_en           : std_logic;
  signal rom_rd_en            : std_logic;
  signal rom_ext_rd_en        : std_logic;

  signal chip_ram_dout        : std_logic_vector(15 downto 0);
  signal fast_ram_dout        : std_logic_vector(15 downto 0);
  signal rom_dout             : std_logic_vector(15 downto 0);
  signal rom_ext_dout         : std_logic_vector(15 downto 0);
    
  signal rd_en_d              : std_logic := '0';
  signal rd_cnt               : integer range 0 to READ_LATENCY := 0;
  signal rd_data_valid        : std_logic := '0';

  signal chipRD_reg           : std_logic_vector(15 downto 0) := (others => '0');
  signal chip_rd_done_i       : std_logic := '0';

  signal chip48_1, chip48_2, chip48_3 : word_t := (others => '0');

  signal chipDMA_d            : std_logic;
  signal dma_beats_total      : integer range 1 to 8 := 1;
  signal dma_beat_count       : integer range 0 to 7 := 0;

  -- BRAM bypass
  signal bypass_valid         : std_logic := '0';
  signal bypass_addr          : std_logic_vector(WORD_ADDR_W downto 1) := (others => '0');
  signal bypass_data          : word_t := (others => '0');
  signal bypass_bank          : bank_t := BANK_NONE;
 
  -- cache/FE mux
  signal cache_cpuCS          : std_logic := '0';
  signal cache_ramAddr        : std_logic_vector(28 downto 1) := (others => '0');
  signal cache_cpu_we         : std_logic := '0';
  signal cache_cpu_bs         : std_logic_vector(1 downto 0) := (others => '0');
  signal cache_ramdin         : std_logic_vector(15 downto 0) := (others => '0');

  signal cache_rsp_valid      : std_logic := '0';
  signal cache_rsp_data_r     : std_logic_vector(15 downto 0) := (others => '0');
  
  signal cache_rd_ack         : std_logic := '0';
  signal cache_cs             : std_logic;
  signal cache_enable         : std_logic := '0';
  signal cache_write_enable   : std_logic := '0';

  signal fe_cpuCS             : std_logic;
  signal fe_ramAddr           : std_logic_vector(28 downto 1);
  signal fe_cpu_we            : std_logic;
  signal fe_cpu_bs            : std_logic_vector(1 downto 0);
  signal fe_ramdin            : std_logic_vector(15 downto 0);
  
  signal fe_cpuCS_d           : std_logic;

  -- CPU Reads
  signal cpu_rd_addr_reg      : std_logic_vector(WORD_ADDR_W downto 1);  
  signal cpu_rd_data_reg      : std_logic_vector(15 downto 0) := (others => '0');
  signal cpu_rd_pending       : std_logic := '0';
  signal cpu_rd_inflight      : std_logic := '0';
  signal cpu_rd_seq_issue     : unsigned(3 downto 0) := (others => '0');      -- next read id
  signal cpu_rd_seq_done      : unsigned(3 downto 0) := (others => '0');      -- id of completed read
  signal cpu_rd_seq_seen      : unsigned(3 downto 0) := (others => '0');      -- last id acked by FE

  signal cpu_dat_r_final_i    : std_logic_vector(15 downto 0) := (others => '0');

  -- CPU Writes
  signal cpu_wr_addr_reg      : std_logic_vector(WORD_ADDR_W downto 1);
  signal cpu_wr_data_reg      : std_logic_vector(15 downto 0);
  signal cpu_wr_pending       : std_logic := '0';  
  signal cpu_wr_inflight      : std_logic := '0';

  -- DMA/CHIP Read
  signal dma_addr_reg         : std_logic_vector(WORD_ADDR_W downto 1);
--  signal dma_rd_data_reg      : std_logic_vector(15 downto 0) := (others => '0');
  signal dma_rd_pending       : std_logic := '0';
  signal dma_rd_inflight      : std_logic := '0';  
  
  signal rd_data_dma          : std_logic_vector(15 downto 0);

  signal dma_rd_seq_issue     : unsigned(3 downto 0) := (others => '0');
  signal dma_rd_seq_done      : unsigned(3 downto 0) := (others => '0');
  signal dma_rd_seq_seen      : unsigned(3 downto 0) := (others => '0');

  -- DMA/CHIP Write
  -- DMA Writes use the same signals as DMA read, except for pending.
  -- There is no need for inflight tracking of DMA Writes as it always has priority.
  signal dma_wr_pending   : std_logic := '0';
      
  -- Signals for latching Bank / Region
  signal bank_cpu_int         : bank_t := BANK_NONE;  -- Only used for TB Log report / debugging 
  signal bank_chip_int        : bank_t := BANK_NONE;  -- Only used for TB Log report / debugging
  
  signal bank_at_issue        : bank_t := BANK_NONE;
  signal cpu_rd_bank_pending  : bank_t := BANK_NONE;
  signal cpu_wr_bank_pending  : bank_t := BANK_NONE;
  signal dma_rd_bank_pending  : bank_t := BANK_NONE;
  signal dma_wr_bank_pending  : bank_t := BANK_NONE;

  -- Ack Signals
  signal cpu_wr_ack           : std_logic := '0';
  signal cpu_rd_ack           : std_logic := '0';
  signal dma_wr_done_i        : std_logic := '0';
  signal dma_rd_done_i        : std_logic := '0';
  
  signal cpu_ack_int          : std_logic := '0';
  signal cpu_ack_reg          : std_logic := '0';
  signal cpu_ack_final        : std_logic := '0';

  --  ROM Write enable.  To become an In port and toggled by the core.
  signal rom_write_enable     : std_logic := '1';  
  
begin

  --------------------------------------------------------------------
  -- Input packing
  --------------------------------------------------------------------
  ip.cache_inhibit   <= cache_inhibit;
  ip.cpu_cache_ctrl  <= cpu_cache_ctrl;
  ip.ramsel          <= ramsel;
  ip.ramaddr         <= ramaddr;
  ip.ramdin          <= ramdin;
  ip.ramshared       <= ramshared;
  ip.cpustate        <= cpustate;
  ip.cpuCS           <= cpuCS;
  ip.cpu_bs          <= cpu_bs;
  ip.cpu_we          <= cpu_we;
  ip.cpu_ir          <= cpu_ir;
  ip.cpu_dr          <= cpu_dr;
  ip.chipAddr        <= chipAddr;
  ip.chipL           <= chipL;
  ip.chipU           <= chipU;
  ip.chipRW          <= chipRW;
  ip.chipDMA         <= chipDMA;
  ip.chipWR          <= chipWR;

  -- Map to Out ports of the entity
  chipRD            <= op.chipRD;
  chip48            <= op.chip48;
  chip48_1_o        <= op.chip48_1_o;
  chip48_2_o        <= op.chip48_2_o;
  chip48_3_o        <= op.chip48_3_o;
  cpu_ack           <= op.cpu_ack;
  cpuRD             <= op.cpuRD;
  ramready          <= op.ramready;
  cpu_dat_r_final   <= op.cpuRD;
  dma_rd_done       <= op.dma_rd_done;
  dma_wr_done       <= op.dma_wr_done;

  --------------------------------------------------------------------
  -- Cache / FE mux
  --------------------------------------------------------------------
  cache_enable       <= ip.cpu_cache_ctrl(0);
  cache_write_enable <= ip.cpu_cache_ctrl(1);
  cache_cs           <= ip.ramsel and (not ip.cache_inhibit) and cache_enable;

  fe_cpuCS   <= cache_cpuCS   when cache_cs = '1' else ip.cpuCS;
  fe_ramAddr <= cache_ramAddr when cache_cs = '1' else ip.ramaddr;
  fe_cpu_we  <= cache_cpu_we  when cache_cs = '1' else ip.cpu_we;
  fe_cpu_bs  <= cache_cpu_bs  when cache_cs = '1' else ip.cpu_bs;
  fe_ramdin  <= cache_ramdin  when cache_cs = '1' else ip.ramdin;

  --------------------------------------------------------------------
  -- Outputs
  --------------------------------------------------------------------
  op.chipRD         <= chipRD_reg;
  op.chip48         <= chip48_1 & chip48_2 & chip48_3;
  op.chip48_1_o     <= chip48_1;
  op.chip48_2_o     <= chip48_2;
  op.chip48_3_o     <= chip48_3;
  op.cpuRD          <= cpu_dat_r_final_i;
  op.dma_rd_done    <= dma_rd_done_i;
  op.dma_wr_done    <= dma_wr_done_i;
      
  chip_rd_done      <= dma_rd_done_i;
  
  op.cpu_ack  <= cpu_ack_final;
  op.ramready <= cpu_ack_final;

  cpu_ack_int   <= '1' when                             
                            ((fe_cpuCS = '1'       and cc.cache_cpu_ack = '1' ) or
                            (cpu_rd_inflight = '1' and cpu_rd_ack       = '1' ) or
                            (cpu_wr_inflight = '1' and cpu_wr_ack       = '1' ))
                       else '0';
                       
  process(sysclk)
  begin
    if rising_edge(sysclk) then
      cpu_ack_reg   <= cpu_ack_int;          
    end if;
  end process;

  cpu_ack_final <= cpu_ack_reg;
  
-----------------------------------------------------------------

  sdr_read_ack <= cache_rd_ack;

  rst <= not reset_n;

  dma_rd_addr <= rd_addr_reg;
  cur_req_o   <= cur_req;
 
  --------------------------------------------------------------------
  -- Cache stub
  --------------------------------------------------------------------
  cpu_cache_stub_inst : entity work.cpu_cache_stub
    port map (
       clk               => sysclk
      ,rst               => rst  -- active high
      ,cache_inhibit     => ip.cache_inhibit
      ,cache_enable      => cache_enable
      ,cache_write_enable=> cache_write_enable
      ,cache_wr_done     => cc.cache_wr_done
      ,cpu_cs            => cache_cs
      ,cpu_adr           => ip.ramaddr
      ,cpu_bs            => ip.cpu_bs
      ,cpu_we            => ip.cpu_we
      ,cpu_ir            => ip.cpu_ir
      ,cpu_dr            => ip.cpu_dr
      ,cpu_dat_w         => ip.ramdin
      ,cache_cpuCS       => cache_cpuCS
      ,cache_ramAddr     => cache_ramAddr
      ,cache_cpu_we      => cache_cpu_we
      ,cache_cpu_bs      => cache_cpu_bs
      ,cache_ramdout     => cache_ramdin
      ,cache_cpu_ack     => cc.cache_cpu_ack
      ,cpu_dat_r         => cc.cache_dat_r
    );

  --------------------------------------------------------------------
  -- Read-valid generator (for BRAM READ_LATENCY)
  --------------------------------------------------------------------
  read_valid_proc : process(sysclk)
  begin
    if rising_edge(sysclk) then
      rd_en_d       <= rd_en;
      rd_data_valid <= '0';

      if (rd_en = '1' and rd_en_d = '0') then
        rd_cnt <= READ_LATENCY;               
      elsif rd_cnt > 0 then
        rd_cnt <= rd_cnt - 1;
        if rd_cnt = 1 then
          rd_data_valid <= '1';
        end if;
      end if;
    end if;
  end process;

  --------------------------------------------------------------------
  -- Final data mux (cache vs BRAM)
  --------------------------------------------------------------------
  
final_data_mux : process(sysclk)
begin
    if rising_edge(sysclk) then
        if reset_n = '0' then            
            cpu_dat_r_final_i   <= (others => '0');
            cpu_rd_seq_seen     <= (others => '0');            
            dma_rd_seq_seen     <= (others => '0');
            --dma_rd_data_reg     <= (others => '0');
        else
            
            -- CPU read data/ack path
            -- When CPU read has completed (mem_ctrl_proc set cpu_rd_seq_done),
            -- and we haven't yet "seen" that completion, present data and pulse
            -- cpu_rd_done for one cycle. cpu_ack_final is generated elsewhere
            -- from cpu_rd_done + cache path.
            if cpu_rd_seq_done /= cpu_rd_seq_seen then
                cpu_rd_seq_seen <= cpu_rd_seq_done;
                
                cpu_dat_r_final_i <= cpu_rd_data_reg;

            end if;
            
            -- DMA read debug tracking (does NOT drive chipRD/chip_rd_done)
            if dma_rd_seq_done /= dma_rd_seq_seen then
                dma_rd_seq_seen <= dma_rd_seq_done;
                
                -- keep a copy of last DMA data for debug
                --dma_rd_data_reg <= dma_rd_data_reg;
            end if;
                        
        end if;
    end if;
end process;
   
  --------------------------------------------------------------------
  -- Main memory controller
  --------------------------------------------------------------------
  mem_ctrl_proc : process(sysclk)
    variable cpu_addr24b       : std_logic_vector(23 downto 0);
    variable chip_addr24b      : std_logic_vector(23 downto 0);
    variable cpu_sel_data      : std_logic_vector(15 downto 0);
    variable chip_sel_data     : std_logic_vector(15 downto 0);
    variable bank_cpu_int_v    : bank_t;
    variable bank_chip_int_v   : bank_t;
  begin
    if rising_edge(sysclk) then
        -- default each cycle
        rd_en           <= '0';
        wr_en           <= '0';
        chip_rd_done_i  <= '0';
        cpu_rd_ack      <= '0';
        cpu_wr_ack      <= '0';
        dma_wr_done_i   <= '0';
        dma_rd_done_i   <= '0';
                             
      if reset_n = '0' then
        cur_req              <= REQ_NONE;
        rd_en                <= '0';
        wr_en                <= '0';
        wr_be                <= "00";
        cpu_wr_ack           <= '0';
        dma_wr_done_i        <= '0';
        wr_addr              <= (others => '0');
        wr_data              <= (others => '0');
        cpu_wr_pending       <= '0';
        dma_wr_pending       <= '0';
        rd_addr_reg          <= (others => '0');
        chip48_1             <= (others => '0');
        chip48_2             <= (others => '0');
        chip48_3             <= (others => '0');
        bypass_valid         <= '0';
        bypass_addr          <= (others => '0');
        bypass_bank          <= BANK_NONE;
        bypass_data          <= (others => '0');
        cpu_rd_data_reg      <= (others => '0');
        cpu_rd_inflight      <= '0';        
        dma_rd_inflight      <= '0';
        cpu_wr_inflight      <= '0';
        chipRD_reg           <= (others => '0');        
        dma_rd_seq_issue     <= (others => '0');
        dma_rd_seq_done      <= (others => '0');        
        fe_cpuCS_d           <= '0';        
      else
        
        fe_cpuCS_d      <= fe_cpuCS;    
        cpu_addr24b     := fe_ramAddr(24 downto 1);
        -- Need to use a variable as a signal misses a cycle when later latched and the data can end up in the wrong bank
        bank_cpu_int_v  := decode_region(cpu_addr24b);
        bank_cpu_int    <= bank_cpu_int_v;              -- Retained for debug report purposes.

        chipDMA_d       <= ip.chipDMA;
        chip_addr24b    := ip.chipAddr;        
        bank_chip_int_v := decode_region(chip_addr24b);
        bank_chip_int   <= bank_chip_int_v;             -- Retained for debug report purposes.
                
        -- DMA burst start (read)
        -- A burst is starting, identify the first address and how many beats to expect.
        if (ip.chipRW = '0') and (ip.chipDMA = '1') and (chipDMA_d = '0') then
          chip_addr24b          := ip.chipAddr;
          dma_rd_bank_pending   <= bank_chip_int_v;
          
          dma_beats_total <= to_integer(unsigned(chipBurstLen)) + 1;
          dma_beat_count  <= 0;
          
          if bank_chip_int_v = BANK_ROM then
            dma_addr_reg              <= (others => '0');
            dma_addr_reg(WORD_ADDR_W-1 downto 1) <= ip.chipAddr(WORD_ADDR_W-1 downto 1);
          else
            dma_addr_reg    <= ip.chipAddr(WORD_ADDR_W downto 1);
          end if;
                                                 
          dma_rd_pending  <= '1';          
          
        end if;
        
        -- DMA Burst Start - (write)
        if (ip.chipRW = '1') and (ip.chipDMA = '1') and (chipDMA_d = '0') then
            chip_addr24b    := ip.chipAddr;
            dma_wr_bank_pending <= bank_chip_int_v;
            
            dma_beats_total <= to_integer(unsigned(chipBurstLen)) + 1;
            dma_beat_count  <= 0;
            
            if bank_chip_int_v = BANK_ROM then
                dma_addr_reg              <= (others => '0');
                dma_addr_reg(WORD_ADDR_W-1 downto 1) <= ip.chipAddr(WORD_ADDR_W-1 downto 1);
            else 
                dma_addr_reg <= ip.chipAddr(WORD_ADDR_W downto 1);
            end if;
                       
            dma_wr_pending  <= '1';
        end if;
                       
         -- Capture CPU read request on rising edge of fe_cpuCS
         if fe_cpuCS = '1' and fe_cpuCS_d = '0' and fe_cpu_we = '0' then
            cpu_rd_pending      <= '1';
            
            if bank_cpu_int_v = BANK_ROM then
                cpu_rd_addr_reg                         <= (others => '0');                
                cpu_rd_addr_reg(WORD_ADDR_W-1 downto 1) <= fe_ramAddr(WORD_ADDR_W-1 downto 1);
            else 
                cpu_rd_addr_reg     <= fe_ramAddr(WORD_ADDR_W downto 1);
            end if; 
                    
            cpu_rd_bank_pending <= bank_cpu_int_v;
         end if;
                                 
            -- Capture CPU write intent into pending state
         if fe_cpuCS = '1' and fe_cpuCS_d = '0' and fe_cpu_we = '1' then
            cpu_wr_pending      <= '1';                           
            cpu_wr_bank_pending <= bank_cpu_int_v;                
            
            if bank_cpu_int_v = BANK_ROM then
                cpu_wr_addr_reg                         <= (others => '0');
                cpu_wr_addr_reg(WORD_ADDR_W-1 downto 1) <= fe_ramAddr(WORD_ADDR_W-1 downto 1);
            else 
                cpu_wr_addr_reg     <= fe_ramAddr(WORD_ADDR_W downto 1);
            end if;            
            
            cpu_wr_data_reg     <= fe_ramdin;
                        
            -- Capture bypass metadata
            if bank_chip_int_v = BANK_FAST then
                bypass_valid    <= '1';
            else
                bypass_valid    <= '0';
            end if;
        
            bypass_addr <= fe_ramAddr(WORD_ADDR_W downto 1);
            bypass_bank <= bank_cpu_int;
            bypass_data <= fe_ramdin;
                                        
            end if;     
         -- Reset the pending and inflight signals once request has been completed.
         -- Note: A DMA write does not track pending or inflight as it always takes priority
         --       and therefore never "pending" execution.             
         --       Could be added it the requirement changes.
         if cpu_wr_ack = '1' then
            cpu_wr_inflight <= '0';
            cpu_wr_pending  <= '0';
         else 
            cpu_wr_inflight <= cpu_wr_inflight;
         end if;
         
         if cpu_rd_ack = '1' then
            cpu_rd_inflight <= '0';
            cpu_rd_pending  <= '0';
         else 
            cpu_rd_inflight <= cpu_rd_inflight; 
         end if; 
            
         if dma_rd_done_i = '1' then
            dma_rd_inflight <= '0';
            
            -- Only clear pending when the burst is fully complete
            if dma_beat_count = dma_beats_total then
                dma_rd_pending  <= '0';
            end if;
         else
            dma_rd_inflight <= dma_rd_inflight;
         end if;     
         
         -- Reset the BRAM Bank, for testing purposes so that we don't see carried over values for next req
         if (dma_rd_done_i = '1') or
            (dma_wr_done_i = '1') or
            (cpu_wr_ack    = '1') or
            (cpu_rd_ack    = '1') then
            bank_at_issue <= BANK_NONE;
         end if;
                                      
        ----------------------------------------------------------------
        -- Unified request decoder
        ----------------------------------------------------------------
        case cur_req is

          when REQ_NONE =>

            -- 1. pending DMA write
            if dma_wr_pending = '1' then
              wr_en          <= '1';
              wr_be          <= "11";                            
              bank_at_issue  <= dma_wr_bank_pending;
              wr_addr        <= dma_addr_reg;
              wr_data        <= ip.chipWR;
              
              cur_req        <= REQ_DMA_WR;
              
            -- 2. pending CPU write
            elsif cpu_wr_pending = '1' and cpu_wr_inflight = '0' then
              cpu_wr_pending    <= '0';
              cpu_wr_inflight   <= '1';
              wr_en             <= '1';
              wr_be             <= "11";              
              bank_at_issue     <= cpu_wr_bank_pending;
              wr_addr           <= cpu_wr_addr_reg;              
              wr_data           <= cpu_wr_data_reg;
              
              cur_req           <= REQ_CPU_WR;

            -- 3. pending DMA read
            elsif dma_rd_pending = '1' and dma_rd_inflight = '0' then              
              rd_en             <= '1';
              bank_at_issue     <= dma_rd_bank_pending;
              rd_addr_reg       <= dma_addr_reg;
              dma_rd_inflight   <= '1';
              dma_rd_seq_issue  <= dma_rd_seq_issue + 1;
              
              cur_req           <= REQ_DMA_CHIP_RD;                                                                               
            
            -- 4. CPU read (single in-flight)
            elsif cpu_rd_pending = '1' and cpu_rd_inflight = '0' then
              rd_en                 <= '1';
              bank_at_issue         <= cpu_rd_bank_pending;
              rd_addr_reg           <= cpu_rd_addr_reg;
              cpu_rd_inflight       <= '1';
              
              -- tag this read
              cpu_rd_seq_issue      <= cpu_rd_seq_issue + 1;
              
              cur_req               <= REQ_CPU_RD;
                                              
            else
              cur_req  <= REQ_NONE;
            end if;

          ----------------------------------------------------------------
          -- CPU read completion
          ----------------------------------------------------------------
          when REQ_CPU_RD =>
            -- BRAM read already issues this cycle via rd_en/rd_addr_reg
            -- move to wait state for rd_data_valid
            cur_req       <= REQ_CPU_RD_WAIT;
                    
          when REQ_CPU_RD_WAIT =>                        
            if rd_data_valid = '1' then
              -- Select from BRAM or bypass
              if bypass_valid = '1' and
                 bypass_bank = bank_at_issue and
                 bypass_addr = rd_addr_reg and
                (bank_at_issue = BANK_FAST) 
                 then              
                cpu_sel_data := bypass_data;
              else                  
                  case bank_at_issue is
                  when BANK_CHIP    => cpu_sel_data := chip_ram_dout;
                  when BANK_FAST    => cpu_sel_data := fast_ram_dout;
                  when BANK_ROM     => cpu_sel_data := rom_dout;
                  when BANK_ROM_EXT => cpu_sel_data := rom_ext_dout;
                  when others       => cpu_sel_data := (others => '0');
                end case;                 
              end if;
                           
              bypass_valid      <= '0';
              cpu_rd_data_reg   <= cpu_sel_data;

              cpu_rd_seq_done   <= cpu_rd_seq_issue;        
              cpu_rd_ack        <= '1';          -- data valid this cycle
              cur_req           <= REQ_NONE;                                                     
            end if;
          
          ----------------------------------------------------------------
          -- CPU write completion
          ----------------------------------------------------------------
          when REQ_CPU_WR =>
            cpu_wr_ack    <= '1';  
                                                         
            cur_req       <= REQ_NONE;

          ----------------------------------------------------------------
          -- DMA write completion
          ----------------------------------------------------------------
          when REQ_DMA_WR =>
            dma_wr_done_i   <= '1';
                        
            -- Continue burst if more beats remain
            if dma_beat_count + 1 < dma_beats_total then
                dma_addr_reg    <= std_logic_vector(unsigned(dma_addr_reg) + 1);
                dma_beat_count  <= dma_beat_count + 1;
                dma_wr_pending  <= '1';     -- schedule next beat
            else    
                dma_wr_pending  <= '0';     -- burst complete                
            end if;
            
            cur_req  <= REQ_NONE;

          ----------------------------------------------------------------
          -- DMA read completion
          ----------------------------------------------------------------
         
          when REQ_DMA_CHIP_RD =>
            -- BRAM read issued this cycle; now wait for rd_data_vallid
            cur_req         <= REQ_DMA_CHIP_RD_WAIT;
          
          when REQ_DMA_CHIP_RD_WAIT =>                                   
            if rd_data_valid = '1' then
               
                -- mark completion
                dma_rd_seq_done     <= dma_rd_seq_issue;
               
                -- visible DMA result                              
                case bank_at_issue is
                    when BANK_CHIP    => chip_sel_data := chip_ram_dout;
                    when BANK_FAST    => chip_sel_data := fast_ram_dout;
                    when BANK_ROM     => chip_sel_data := rom_dout;
                    when BANK_ROM_EXT => chip_sel_data := rom_ext_dout;
                    when others       => chip_sel_data := (others => '0');
                end case;                
                chipRD_reg          <= chip_sel_data;                
--                dma_rd_data_reg     <= chip_sel_data;
                
                -- 48-bit history (last three DMA words)
                chip48_1    <= chip48_2;
                chip48_2    <= chip48_3;                
                chip48_3    <= chip_sel_data;
                                                                                
                chip_rd_done_i      <= '1';     -- one cycle pulse
                dma_rd_done_i       <= '1';
                
                -- Continue bust if more beats remain
                if dma_beat_count + 1 < dma_beats_total then
                    dma_addr_reg    <= std_logic_vector(unsigned(dma_addr_reg) + 1);
                    dma_beat_count  <= dma_beat_count + 1;
                    dma_rd_pending  <= '1';
                else
                    dma_beat_count <= dma_beat_count + 1;   -- final beat
                end if;
                
                cur_req             <= REQ_NONE;
            end if;
            
          when others =>
            cur_req  <= REQ_NONE;
        end case;

      end if;       -- Reset                        
    end if;         -- clock
  end process;

  --------------------------------------------------------------------
  -- Banked read enables / writes
  -- Set the write/read enable for the BRAM Region write/read request
  -- Data is set to all instances, these signals gate which one gets
  -- the request.
  --------------------------------------------------------------------
  chip_wr_en     <= '1' when (wr_en = '1' and bank_at_issue = BANK_CHIP) else '0';
  fast_wr_en     <= '1' when (wr_en = '1' and bank_at_issue = BANK_FAST) else '0';  
  rom_wr_en      <= '1' when (wr_en = '1' and bank_at_issue = BANK_ROM     and rom_write_enable = '1')  else '0';  
  rom_ext_wr_en  <= '1' when (wr_en = '1' and bank_at_issue = BANK_ROM_EXT and rom_write_enable = '1')  else '0';  
   
  chip_rd_en     <= '1' when (rd_en = '1' and bank_at_issue = BANK_CHIP)    else '0';
  fast_rd_en     <= '1' when (rd_en = '1' and bank_at_issue = BANK_FAST)    else '0';
  rom_rd_en      <= '1' when (rd_en = '1' and bank_at_issue = BANK_ROM)     else '0';               
  rom_ext_rd_en  <= '1' when (rd_en = '1' and bank_at_issue = BANK_ROM_EXT) else '0';               

  --------------------------------------------------------------------
  -- BRAM instances
  --------------------------------------------------------------------
  chip_ram_inst : entity work.ramctrl_bram
    generic map (
       MEMORY_SIZE_BITS => CHIP_RAM_BYTES
      ,WORD_ADDR_W      => WORD_ADDR_W
      ,DATA_WIDTH       => DATA_W
      ,BYTE_WRITE_WIDTH => BYTE_WRITE_WIDTH
      ,READ_LATENCY     => READ_LATENCY
    )
    port map (
       sysclk => sysclk
      ,ena    => chip_wr_en
      ,wea    => wr_be
      ,addra  => wr_addr
      ,dina   => wr_data
      ,douta  => open
      ,enb    => chip_rd_en
      ,web    => (others => '0')
      ,addrb  => rd_addr_reg
      ,dinb   => (others => '0')
      ,doutb  => chip_ram_dout
    );

  fast_ram_inst : entity work.ramctrl_bram
    generic map (
       MEMORY_SIZE_BITS => FAST_RAM_BYTES
      ,WORD_ADDR_W      => WORD_ADDR_W
      ,DATA_WIDTH       => DATA_W
      ,BYTE_WRITE_WIDTH => BYTE_WRITE_WIDTH
      ,READ_LATENCY     => READ_LATENCY
    )
    port map (
       sysclk => sysclk
      ,ena    => fast_wr_en
      ,wea    => wr_be
      ,addra  => wr_addr
      ,dina   => wr_data
      ,douta  => open
      ,enb    => fast_rd_en
      ,web    => (others => '0')
      ,addrb  => rd_addr_reg
      ,dinb   => (others => '0')
      ,doutb  => fast_ram_dout
    );

  rom_inst : entity work.ramctrl_bram
    generic map (
       MEMORY_SIZE_BITS => ROM_BYTES
      ,WORD_ADDR_W      => WORD_ADDR_W
      ,DATA_WIDTH       => DATA_W
      ,BYTE_WRITE_WIDTH => BYTE_WRITE_WIDTH
      ,READ_LATENCY     => READ_LATENCY
      ,MEMORY_FILE      => ROM_INIT_FILE
    )
    port map (
       sysclk => sysclk
      ,ena    => rom_wr_en
      ,wea    => wr_be
      ,addra  => wr_addr
      ,dina   => wr_data
      ,douta  => open
      ,enb    => rom_rd_en
      ,web    => (others => '0')
      ,addrb  => rd_addr_reg
      ,dinb   => (others => '0')
      ,doutb  => rom_dout
    );

  rom_ext_inst : entity work.ramctrl_bram
    generic map (
       MEMORY_SIZE_BITS => ROM_EXT_BYTES
      ,WORD_ADDR_W      => WORD_ADDR_W
      ,DATA_WIDTH       => DATA_W
      ,BYTE_WRITE_WIDTH => BYTE_WRITE_WIDTH
      ,READ_LATENCY     => READ_LATENCY      
    )
    port map (
       sysclk => sysclk
      ,ena    => rom_wr_en
      ,wea    => wr_be
      ,addra  => wr_addr
      ,dina   => wr_data
      ,douta  => open
      ,enb    => rom_ext_rd_en
      ,web    => (others => '0')
      ,addrb  => rd_addr_reg
      ,dinb   => (others => '0')
      ,doutb  => rom_ext_dout
    );    

  --------------------------------------------------------------------
  -- Debug reporting
  --------------------------------------------------------------------

debug_reporting : if DEBUG_LEVEL >= DBG_VERBOSE generate
begin
-- Only useful for TB purposes.
-- Essentially dumps the contents of the signals into the TB log each cycle.
-- In a CSV format so that it can be copied into Excel or something similiar.
-- I use Notepad++ and a small macro to clean up the TB log before copying to Excel. 
-- Disable by setting the CONSTANT in debug_pkg

    debug_proc : process(sysclk)        
        variable cycle : integer := 0;
        variable region_chip    : std_logic := '0';
        variable region_fast    : std_logic := '0';
        variable region_rom     : std_logic := '0';
        variable region_rom_ext : std_logic := '0';
        variable region_none    : std_logic := '0';
        
    begin
        if rising_edge(sysclk) then
            region_chip     := '0';
            region_fast     := '0';
            region_rom      := '0';
            region_rom_ext  := '0';
            region_none     := '0';
                              
            case bank_at_issue is
                when BANK_CHIP     => region_chip    := '1';
                when BANK_FAST     => region_fast    := '1';
                when BANK_ROM      => region_rom     := '1';
                when BANK_ROM_EXT  => region_rom_ext := '1';
                when others        => region_none    := '1';
            end case;        
        
            cycle := cycle + 1;

            ------------------------------------------------------------------
            -- ACK / HANDSHAKE DEBUG
            ------------------------------------------------------------------
            report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," &        
                    "ACKDBG: "                                                          & "," &
                   "cpu_ack_final="      & sl_to_str(cpu_ack_final)                     & "," &
                   "cache_cpu_ack="      & sl_to_str(cc.cache_cpu_ack)                  & "," &
                   "cache_rd_ack="       & sl_to_str(cache_rd_ack)                      & "," &
                   "cache_cs="           & sl_to_str(cache_cs)                          & "," &
                   "ramsel="             & sl_to_str(ip.ramsel)                         & "," &                   
                   "cache_inhibit="      & sl_to_str(ip.cache_inhibit)                  & "," &
                   "cache_enable="       & sl_to_str(cache_enable)                      & "," &
                   "cache_write_enable=" & sl_to_str(cache_write_enable)                & "," &
                   "bypass_valid="       & std_logic'image(bypass_valid)                & "," &
                   "bypass_bank="        & bank_t'image(bypass_bank)                    & "," &
                   "bypass_addr="        & slv_to_hex_any(bypass_addr)                  & "," &
                   "bypass_data="        & slv_to_hex(bypass_data)                      & "," &
                   "";

            ------------------------------------------------------------------
            -- FINAL DATA MUX
            ------------------------------------------------------------------
            report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," &
                   "FINALMUX: "                                                         & "," &
                   "READ_LATENCY="     & integer'image(READ_LATENCY)                    & "," &
                   "cur_req="          & t_req_type'image(cur_req)                      & "," &
                   "cache_dat_r="      & slv_to_hex16(cc.cache_dat_r)                   & "," &
                   "rd_data_valid="    & std_logic'image(rd_data_valid)                 & "," &
                   "rd_data="          & slv_to_hex16(rd_data)                          & "," &
                   "rd_data_dma="      & slv_to_hex16(rd_data_dma)                      & "," &
--                   "dma_rd_data_reg="  & slv_to_hex16(dma_rd_data_reg)                  & "," &
                   "cpu_dat_r_final_i=" & slv_to_hex16(cpu_dat_r_final_i)               & "," &
                   "cpu_rd_seq_issue=" & integer'image(to_integer(cpu_rd_seq_issue))    & "," &
                   "cpu_rd_seq_done="  & integer'image(to_integer(cpu_rd_seq_done))     & "," &
                   "cpu_rd_seq_seen="  & integer'image(to_integer(cpu_rd_seq_seen))     & "," &                                     
                   "dma_rd_seq_issue=" & integer'image(to_integer(dma_rd_seq_issue))    & "," &
                   "dma_rd_seq_done="  & integer'image(to_integer(dma_rd_seq_done))     & "," &
                   "dma_rd_seq_seen="  & integer'image(to_integer(dma_rd_seq_seen))     & "," &                                      
                   "chipRD_reg="       & slv_to_hex16(chipRD_reg)                       & "," &
                   "";

            if cache_cs = '1' then                      
                report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," & 
                       "CACHE_IN: "                                                         & "," &
                       "cache_cs="              & sl_to_str(cache_cs)                       & "," &                                                                                           
                       "cache_inhibit="         & sl_to_str(ip.cache_inhibit)               & "," &                                                                                           
                       "cache_enable="          & sl_to_str(cache_enable)                   & "," &                                                                                           
                       "cache_write_enable="    & sl_to_str(cache_write_enable)             & "," &                                                                                           
                       "ramaddr="               & slv_to_hex_any(ip.ramaddr)                & "," &
                       "cpu_bs="                & slv_to_hex_any(ip.cpu_bs)                 & "," &
                       "cpu_we="                & sl_to_str(ip.cpu_we)                      & "," &
                       "cpu_ir="                & sl_to_str(ip.cpu_ir)                      & "," &
                       "cpu_dr="                & sl_to_str(ip.cpu_dr)                      & "," &
                       "ramdin="                & slv_to_hex16(ramdin)                      & "," &
                       "";                                                                                        

                report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," & 
                       "CACHE_OUT: "                                                        & "," &
                       "cache_wr_done="   & sl_to_str(cc.cache_wr_done)                     & "," &
                       "cache_cpu_ack="   & sl_to_str(cc.cache_cpu_ack)                     & "," &
                       "cache_dat_r="     & slv_to_hex16(cc.cache_dat_r)                    & "," &
                       "";                       
            end if;
            
            ------------------------------------------------------------------
            -- CPU
            ------------------------------------------------------------------
            report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," & 
                   "CPU: "                                                              & "," &
                   "cpuCS="            & sl_to_str(ip.cpuCS)                            & "," &
                   "fe_cpuCS="         & sl_to_str(fe_cpuCS)                            & "," &
                   "cpustate="         & slv_to_str(ip.cpustate)                        & "," &
                   "cpu_ir="           & std_logic'image(ip.cpu_ir)                     & "," &
                   "cpu_dr="           & std_logic'image(ip.cpu_dr)                     & "," &
                   "cpu_we="           & std_logic'image(ip.cpu_we)                     & "," &
                   "fe_cpu_we="        & std_logic'image(fe_cpu_we)                     & "," &
                   "cache_cs="         & sl_to_str(cache_cs)                            & "," &
                   "cpu_wr_pending="   & sl_to_str(cpu_wr_pending)                      & "," &
                   "cpu_wr_inflight="  & sl_to_str(cpu_wr_inflight)                     & "," &
                   "cpu_rd_pending="   & sl_to_str(cpu_rd_pending)                      & "," &
                   "cpu_rd_inflight="  & sl_to_str(cpu_rd_inflight)                     & "," &   
                   "cpu_wr_addr_reg="  & slv_to_hex_any(cpu_wr_addr_reg)                & "," &
                   "cpu_wr_data_reg="  & slv_to_hex16(cpu_wr_data_reg)                  & "," &
                   "cpu_wr_ack="       & sl_to_str(cpu_wr_ack)                          & "," &
                   "cpu_rd_addr_reg="  & slv_to_hex_any(cpu_rd_addr_reg)                & "," &
                   "cpu_rd_data_reg="  & slv_to_hex16(cpu_rd_data_reg)                  & "," &      
                   "cpu_rd_ack="       & sl_to_str(cpu_rd_ack)                          & "," &                                                                                    
                   "";                   
                                                                                     
            ------------------------------------------------------------------
            -- DMA
            ------------------------------------------------------------------
            report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," & 
                   "DMA: "                                                              & "," &
                   "chipDMA="           & sl_to_str(ip.chipDMA)                         & "," &
                   "chipDMA_d="         & sl_to_str(chipDMA_d)                          & "," &
                   "chipRW="            & sl_to_str(ip.chipRW)                          & "," &
                   "chipAddr="          & slv_to_hex_any(ip.chipAddr)                   & "," &
                   "dma_wr_pending="   & sl_to_str(dma_wr_pending)                      & "," &
                   "dma_rd_pending="   & sl_to_str(dma_rd_pending)                      & "," &
                   "dma_rd_inflight="  & sl_to_str(dma_rd_inflight)                     & "," &                                                         
                   "chipWR="            & slv_to_hex16(ip.chipWR)                       & "," &
                   "chipRD="            & slv_to_hex16(op.chipRD)                       & "," &
                   "chip48="            & slv_to_hex_any(op.chip48)                     & "," &
                   "chip_rd_done="      & sl_to_str(chip_rd_done_i)                     & "," &
                   "dma_addr_reg="      & slv_to_hex_any(dma_addr_reg)                  & "," &
                   "ChipBurstLen="      & slv_to_hex_any(ChipBurstLen)                  & "," &
                   "dma_rd_done="       & sl_to_str(dma_rd_done_i)                      & "," &
                   "dma_wr_done="       & sl_to_str(dma_wr_done_i)                      & "," &                   
                   "dma_beat_count="    & integer'image(dma_beat_count)                 & "," &
                   "dma_beats_total="   & integer'image(dma_beats_total)                & "," &
                   "";

            ------------------------------------------------------------------
            -- BANK REGION DECODING
            ------------------------------------------------------------------
            report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," & 
                   "BANK: "                                                             & "," &
                   "bank_cpu_int="         & bank_t'image(bank_cpu_int)                 & "," &
                   "bank_chip_int="        & bank_t'image(bank_chip_int)                & "," &
                   "cpu_rd_bank_pending="  & bank_t'image(cpu_rd_bank_pending)          & "," &
                   "cpu_wr_bank_pending="  & bank_t'image(cpu_wr_bank_pending)          & "," &
                   "dma_rd_bank_pending="  & bank_t'image(dma_rd_bank_pending)          & "," &
                   "dma_wr_bank_pending="  & bank_t'image(dma_wr_bank_pending)          & "," &
                   "bank_at_issue="        & bank_t'image(bank_at_issue)                & "," &
                    "";
                    
            report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," & 
                   "REGION: "                                                           & "," &
                   "CHIP="              & sl_to_str(region_chip)                        & "," &
                   "FAST="              & sl_to_str(region_fast)                        & "," &                                      
                   "ROM="               & sl_to_str(region_rom)                         & "," &
                   "ROM_EXT="           & sl_to_str(region_rom_ext)                     & "," &
                   "cache_inhibit="     & std_logic'image(ip.cache_inhibit)             & "," &
                   "";

            ------------------------------------------------------------------
            -- BRAM READ / WRITE
            ------------------------------------------------------------------
            if rd_data_valid = '1' or rd_en = '1' then
                report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," & 
                       "BRAM_RD: "                                                          & "," &
                       --"bank_cpu_int="     & bank_t'image(bank_cpu_int)                     & "," &
                       --"bank_chip_int="    & bank_t'image(bank_chip_int)                    & "," &
                       "bank_at_issue="    & bank_t'image(bank_at_issue)                    & "," &
                       "rd_add_reg="       & slv_to_hex_any(rd_addr_reg)                    & "," &      
                       "fe_ramaddr="       & slv_to_hex_any(fe_ramAddr)                     & "," &                 
                       "CHIPdata="         & slv_to_hex16(rd_data_dma)                      & "," &
                       "rd_en="            & std_logic'image(rd_en)                         & "," &
                       "chip_rd_en="       & std_logic'image(chip_rd_en)                    & "," &
                       "fast_rd_en="       & std_logic'image(fast_rd_en)                    & "," &
                       "rom_rd_en="        & std_logic'image(rom_rd_en)                     & "," &
                       "rd_data="          & slv_to_hex16(rd_data)                          & "," &
                       "chip_ram_dout="    & slv_to_hex16(chip_ram_dout)                    & "," &
                       "fast_ram_dout="    & slv_to_hex16(fast_ram_dout)                    & "," &
                       "rom_dout="         & slv_to_hex16(rom_dout)                         & "," &
                       "rd_data_dma="      & slv_to_hex16(rd_data_dma)                      & "," &                       
                       "chipRD_reg="       & slv_to_hex16(chipRD_reg)                       & "," &                    
                       "";
            end if;

            if wr_en = '1' then
                report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," & 
                       "BRAM_WR: "                                                          & "," &
                       --"bank_cpu_int="           & bank_t'image(bank_cpu_int)               & "," &
                       --"bank_chip_int="          & bank_t'image(bank_chip_int)              & "," &
                       "cpu_wr_bank_pending="    & bank_t'image(cpu_wr_bank_pending)        & "," &
                       "dma_wr_bank_pending="    & bank_t'image(dma_wr_bank_pending)        & "," &
                       "bank_at_issue="          & bank_t'image(bank_at_issue)              & "," &                       
                       "wr_addr="                & slv_to_hex_any(wr_addr)                  & "," &                                    
                       "wr_data="                & slv_to_hex16(wr_data)                    & "," &
                       "wr_be="                  & slv_to_str(wr_be)                        & "," &
                       "wr_we="                  & std_logic'image(wr_en)                   & "," &
                       "chip_wr_we="             & std_logic'image(chip_wr_en)              & "," &
                       "fast_wr_we="             & std_logic'image(fast_wr_en)              & "," &
                       "rom_wr_we="              & std_logic'image(rom_wr_en)               & "," &                      
                       "bypass_valid="           & std_logic'image(bypass_valid)            & "," &
                       "bypass_bank="            & bank_t'image(bypass_bank)                & "," &
                       "bypass_addr="            & slv_to_hex_any(bypass_addr)              & "," &
                       "bypass_data="            & slv_to_hex(bypass_data)                  & "," &                   
                       "";
            end if;
        end if;
    end process;

end generate;  -- debug_reporting

end architecture;
