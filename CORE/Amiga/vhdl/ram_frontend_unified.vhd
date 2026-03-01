-- Front End of the Mega65 Amiga Core Memory Controller
-- It's purpose is to prepare any signals (parameters) for use in the main controller module.
--
-- January 2026      David Raynor (Kiwi)
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.ram_type_pkg.all;
use work.Amiga_Debug_pkg.all;
use work.debug_utils_pkg.all;


entity ram_frontend_unified is
    generic (
        DEBUG_ENABLE    : boolean := true;
        DATA_WIDTH      : integer := 16;
        NUM_BANKS       : integer := 3;
        WORD_ADDR_W     : integer := 20;
        BANK_SEL_HI     : integer := 28;
        BANK_SEL_LO     : integer := 27
    );
    port (
        --------------------------------------------------------------------
        -- Clocks / resets
        --------------------------------------------------------------------
        sysclk              : in std_logic;
        reset_n             : in std_logic;

        -- cache_rst can come from top-level (MiSTer style) or be tied high
        cache_rst           : in std_logic;
        cache_inhibit_ext   : in std_logic;
        cpu_cache_ctrl      : in std_logic_vector(3 downto 0);       

        --------------------------------------------------------------------
        -- CPU side (MiSTer cpu_wrapper style)
        --------------------------------------------------------------------
        cpuCS           : in std_logic;                             -- We don't see read/write cpustates when cpuCS='0'
        cpuAddr         : in std_logic_vector(28 downto 1);         -- Memory address provide by CPU
        cpustate        : in std_logic_vector(1 downto 0);          -- Status of CPU: 00 - Fetch code, 01 = no memaccess (idle), 10 - read data, 11 - write data
        cpuL            : in std_logic;                             -- lower byte select (active low in TG68K world)
        cpuU            : in std_logic;                             -- upper byte select
        cpuWR           : in std_logic_vector(15 downto 0);         -- cpu data to write to memory

        cpuRD           : out std_logic_vector(15 downto 0);        -- cpu data read from memory
        cpu_ack         : out std_logic;
        ramready        : out std_logic;

        --------------------------------------------------------------------
        -- CHIP side (Minimig / Agnus side)
        --------------------------------------------------------------------
        chipAddr        : in std_logic_vector(24 downto 1);
        chipL           : in std_logic;
        chipU           : in std_logic;
        chipRW          : in std_logic;  -- 1 = write, 0 = read (MiSTer convention)
        chipDMA         : in std_logic;  -- OE-style DMA indicator
        chipWR          : in std_logic_vector(15 downto 0);

        chipRD          : out std_logic_vector(15 downto 0);
        chip48          : out std_logic_vector(47 downto 0);
        chip48_1        : out std_logic_vector(DATA_WIDTH-1 downto 0);
        chip48_2        : out std_logic_vector(DATA_WIDTH-1 downto 0);
        chip48_3        : out std_logic_vector(DATA_WIDTH-1 downto 0);

        chipBurstLen    : in std_logic_vector(2 downto 0);          -- Agnus Burst read mode.  Specified the number of consective memory locations to stream / burst.  Max 4096
        
        chip_rd_done    : out std_logic;
        dma_wr_done     : out std_logic        

    );
end entity;


architecture rtl of ram_frontend_unified is

    -- Out Port Record
    type OP_rec_type is record
        cpuRD           : std_logic_vector(15 downto 0);
        cpu_ack         : std_logic;
        ramready        : std_logic;
        chipRD          : std_logic_vector(15 downto 0);        
        chip48          : std_logic_vector(47 downto 0);
        chip48_1        : std_logic_vector(15 downto 0);
        chip48_2        : std_logic_vector(15 downto 0);
        chip48_3        : std_logic_vector(15 downto 0);
        chip_rd_done    : std_logic;           
        dma_wr_done     : std_logic;     
    end record;
    
    -- In Port Record
    type IP_rec_type is record
        cache_rst           : std_logic;
        cache_inhibit_ext   : std_logic;
        cpu_cache_ctrl      : std_logic_vector(3 downto 0);  
        
        cpuCS               : std_logic;                            
        cpuAddr             : std_logic_vector(28 downto 1);        
        cpustate            : std_logic_vector(1 downto 0);         
        cpuL                : std_logic;                            
        cpuU                : std_logic;                            
        cpuWR               : std_logic_vector(15 downto 0); 
        
        chipAddr            : std_logic_vector(24 downto 1);
        chipL               : std_logic;
        chipU               : std_logic;
        chipRW              : std_logic;  
        chipDMA             : std_logic;  
        chipWR              : std_logic_vector(15 downto 0);
        chipBurstLen        : std_logic_vector(2 downto 0);
    end record;
  
    -- Out signals from RAM Controller
    type RAM_REC_TYPE is record
        cpuRD           : std_logic_vector(15 downto 0);
        cpu_ack         : std_logic;
        ramready        : std_logic;
        chipRD          : std_logic_vector(15 downto 0);
        chip48          : std_logic_vector(47 downto 0);
        chip48_1        : std_logic_vector(15 downto 0);
        chip48_2        : std_logic_vector(15 downto 0);
        chip48_3        : std_logic_vector(15 downto 0);        
        chip_rd_done    : std_logic;
        dma_wr_done     : std_logic;
        --cur_reg_o       : t_reg_type;     -- needs to be decalred in arch, doesn't see it in pkg!!!!        
    end record;

    
    signal op   : op_rec_type;
    signal ip   : ip_rec_type;
    signal ram  : RAM_REC_TYPE;

    ------------------------------------------------------------------------
    -- Signals to ram_ctrl_unified
    ------------------------------------------------------------------------
    signal ramsel_i         : std_logic;
    signal cpu_read_req     : std_logic;
    signal cpu_write_req    : std_logic;
    signal ramaddr_i        : std_logic_vector(28 downto 1);
    signal ramlds_i         : std_logic;  -- active low
    signal ramuds_i         : std_logic;  -- active low
    signal ramdin_i         : std_logic_vector(15 downto 0);

    -- Check signals from unified controller (can be left open if unused)   
    signal cache_inhibit_region : std_logic;
    signal cache_inhibit_final  : std_logic;
    signal cache_inhibit_fast   : std_logic;
   
    -- Memory Region Signals
    signal addr_hi          : std_logic_vector(7 downto 0);
    signal region_chip      : std_logic;
    signal region_fast      : std_logic;
    signal region_shared    : std_logic;
    signal region_io        : std_logic;
    signal region_rom       : std_logic;    
    
    
    -- NOTE: Because of the limited address spacing that is available in BRAM, I.e. max of 20bits address with.
    -- The Amiga as 24-bits address space.  Therefore need to break the address into "Banks" and create an instance of BRAM
    -- for each Bank.  We then use the MSB bit, i.e. 24-21 of the Amiga address to allocate the bank and therefore BRAM instance.
    -- This limits it to a max of 1MB per bank for each BRAM bank instance.
    -- For A500, CHIP ram is ok as the range specific is only 1MB for CHIP.  Will need another bank for CHIP ram for the A1200.
    -- But for the A1200 we would also need to start using SDRAM on the M65 to get the extra RAM.
    -- Same story for FAST Ram.  For now, limiting it to 1MB max. range
    -- Keep in mind that to go beyond that, will likley need to specify more Banks, other the data will simply override each other
    -- if trying to "squeeze" it into the one Bank.  Simply because we lose some Address information by removeing teh MSB when writing / read BRAM.
    -- 
    constant CHIP_HI        : std_logic_vector(7 downto 0) := x"00";        -- CHIP RAM region: 0x000000 - 0x1FFFFF (Amiga 2MB)
    constant FAST_LO        : std_logic_vector(7 downto 0) := x"02";
    constant FAST_HI        : std_logic_vector(7 downto 0) := x"02";    
    constant SHARED_HI      : std_logic_vector(7 downto 0) := x"0C";
    constant IO_HI          : std_logic_vector(7 downto 0) := x"0D";        -- Custom Chip Registers.  The controller should ignore this memory address range.
    constant KICK_HI        : std_logic_vector(7 downto 0) := x"0F";        -- Kickstart ROM: 0xF80000 - 0xFFFFF
    
    signal ramshared        : std_logic;      
    
    signal dma_rd_addr      : std_logic_vector(WORD_ADDR_W-1 downto 0);
   
    signal cpu_bs           : std_logic_vector(1 downto 0);
    signal cpu_we           : std_logic;
    signal cpu_ir           : std_logic;
    signal cpu_dr           : std_logic;
    
    signal cur_req_i        : t_req_type;
    
   
begin
    
    -- Mapping of IN Port signal to internal signals
    ip.cache_rst            <= cache_rst;
    ip.cache_inhibit_ext    <= cache_inhibit_ext;
    ip.cpu_cache_ctrl       <= cpu_cache_ctrl;
    ip.cpuCS                <= cpuCS;
    ip.cpuAddr              <= cpuAddr;
    ip.cpuState             <= cpuState;
    ip.cpuL                 <= cpuL;
    ip.cpuU                 <= cpuU;
    ip.cpuWR                <= cpuWR;
    ip.chipAddr             <= chipAddr;
    ip.chipL                <= chipL;
    ip.chipU                <= chipU;
    ip.chipRW               <= chipRW;
    ip.chipDMA              <= chipDMA;
    ip.chipWR               <= chipWR;
    ip.chipBurstLen         <= chipBurstLen;             
           
    -- Mapping of OUT Port signals from internal signals
    cpuRD           <= op.cpuRD;
    cpu_ack         <= op.cpu_ack;
    ramready        <= op.ramready;
    chipRD          <= op.chipRD;
    chip48          <= op.chip48;
    chip48_1        <= op.chip48_1; 
    chip48_2        <= op.chip48_2; 
    chip48_3        <= op.chip48_3; 
    chip_rd_done    <= op.chip_rd_done; 
    dma_wr_done     <= op.dma_wr_done; 
                   
    op.cpu_ack      <= ram.cpu_ack;    
    op.chipRD       <= ram.chipRD;    
    op.chip48       <= ram.chip48;
    op.chip48_1     <= ram.chip48_1;
    op.chip48_2     <= ram.chip48_2;
    op.chip48_3     <= ram.chip48_3;
    op.chip_rd_done <= ram.chip_rd_done;
    op.dma_wr_done  <= ram.dma_wr_done;
    
    -- Outputs to CPU wrapper    
    op.cpuRD    <= ram.cpuRD when ramshared = '0'
                 else ram.cpuRD(7 downto 0) & ram.cpuRD(15 downto 8);    
    
    op.ramready <= ram.ramready;
    
    cpu_bs  <= (not ip.cpuU) & (not ip.cpuL);        

    ------------------------------------------------------------------------
    -- CPU → unified controller mapping (MiSTer style)
    ------------------------------------------------------------------------
    
-- CPU State
-- 00 - Instruction fetch
-- 01 - No memory access - idle
-- 10 - Data read
-- 11 - Data write
-- Should not see a read/write state when cpuCS='0'

    cpu_ir  <= '1' when (ip.cpustate = "00") else '0';     -- Instruction fetch
    cpu_dr  <= '1' when (ip.cpustate = "10") else '0';     -- Data Read
    cpu_we  <= '1' when (ip.cpustate = "11") else '0';     -- Data Write    
   
    cpu_read_req    <= '1' when (ip.cpuCS = '1' and ip.cpustate = "10") else '0';                                       
    cpu_write_req   <= '1' when (ip.cpuCS = '1' and ip.cpustate = "11" and (ip.cpuL = '0' or ip.cpuU = '0')) else '0';  
    ramsel_i        <= cpu_read_req or cpu_write_req;
    
    -- Memory Regions
    -- NB: This is driven from the CPU Address only.

    addr_hi         <= ip.cpuAddr(28 downto 21);
    region_chip     <= '1' when addr_hi = CHIP_HI else '0';
    region_fast     <= '1' when (unsigned(addr_hi) >= unsigned(FAST_LO) and
                                 unsigned(addr_hi) <= unsigned(FAST_HI)) else '0';
    region_shared   <= '1' when addr_hi = SHARED_HI else '0';
    region_io       <= '1' when addr_hi = IO_HI else '0';
    region_rom      <= '1' when addr_hi = KICK_HI else '0';     

    -- Treat FAST + SHARED as swap regions for now    
    ramshared   <= '1' when region_shared = '1' else '0';        
                
    ramaddr_i <= ip.cpuAddr
                    when ((cur_req_i = REQ_CPU_FAST_RD) or (cur_req_i = REQ_CPU_CHIP_RD) or (cur_req_i = REQ_CPU_RD) 
                            or cur_req_i = REQ_CPU_WR)
                        else std_logic_vector(resize(unsigned(dma_rd_addr), ramaddr_i'length))
                            when (cur_req_i = REQ_DMA_CHIP_RD)
                                else std_logic_vector(resize(unsigned(ip.chipAddr), ramaddr_i'length))
                                    when (cur_req_i = REQ_DMA_WR)
                                        else ip.cpuAddr;
   
        
    ramdin_i    <= ip.cpuWR when ramshared = '0'
                    else ip.cpuWR(7 downto 0) & ip.cpuWR(15 downto 8);
                        
    -- CHIP, ROM, IO, SHARED are cache inhibited; FAST is cacheable
    cache_inhibit_region    <= '1' when (
                                        region_chip   = '1' or
                                        region_rom    = '1' or
                                        region_io     = '1' or
                                        region_shared = '1'
                                        ) else '0';   
    
    -- FAST is cacheable only when cache is enabled
    cache_inhibit_fast <= '1' when (region_fast = '1' and ip.cpu_cache_ctrl(0) = '0') else '0';                                                                      
    
    cache_inhibit_final <= cache_inhibit_region or ip.cache_inhibit_ext or cache_inhibit_fast;
        
 

                                        
    ------------------------------------------------------------------------
    -- Instantiate unified controller
    ------------------------------------------------------------------------
    ram_ctrl : entity work.ram_ctrl_unified
        generic map (
             DEBUG_ENABLE => DEBUG_ENABLE
            ,DATA_WIDTH   => DATA_WIDTH
            ,NUM_BANKS    => NUM_BANKS
            ,WORD_ADDR_W  => WORD_ADDR_W
            ,BANK_SEL_HI  => BANK_SEL_HI
            ,BANK_SEL_LO  => BANK_SEL_LO
        )
        port map (
            -- System / cache
             sysclk           => sysclk
            ,reset_n          => reset_n
            ,cache_rst        => ip.cache_rst
            -- Note: The cache is simplay a pass-thru for now.
            ,cache_inhibit    => cache_inhibit_final            
            ,cpu_cache_ctrl   => ip.cpu_cache_ctrl
            ,cpuCS            => ip.cpuCS
                                     
            ,chipBurstLen     => ip.chipBurstLen                        
            ,dma_rd_addr      => dma_rd_addr                        

            -- CPU RAM bus
            ,ramsel           => ramsel_i
            ,ramaddr          => ramaddr_i
            ,ramdin           => ramdin_i
            ,ramshared        => ramshared
            ,cpustate         => ip.cpustate
            ,cpu_ack          => ram.cpu_ack
            ,cpuRD            => ram.cpuRD
            
            ,cpu_bs           => cpu_bs
            ,cpu_we           => cpu_we
            ,cpu_ir           => cpu_ir
            ,cpu_dr           => cpu_dr
                        
            ,ramready         => ram.ramready            

            -- CHIP RAM bus
            ,chipAddr         => ip.chipAddr
            ,chipL            => ip.chipL
            ,chipU            => ip.chipU
            ,chipRW           => ip.chipRW
            ,chipDMA          => ip.chipDMA
            ,chipWR           => ip.chipWR
            ,chipRD           => ram.chipRD
            ,chip48           => ram.chip48
            ,chip48_1_o       => ram.chip48_1
            ,chip48_2_o       => ram.chip48_2
            ,chip48_3_o       => ram.chip48_3
            ,chip_rd_done     => ram.chip_rd_done
            ,dma_wr_done      => ram.dma_wr_done
            
            ,cur_req_o      => cur_req_i
        
        );


FE_dbg_reporting: if DEBUG_LEVEL >= DBG_VERBOSE generate

begin


debug_frontend : process(sysclk)
    variable cycle : integer := 0;
    begin
        if rising_edge(sysclk) then
            report "[CYCLE_FE_PORTS " & int_img(cycle) &  " Time=" & time_to_str(now) & "]" & "," &
                    "FE_IN_PORTS: "                                                         & "," &
                    "cache_rst="            & std_logic'image(ip.cache_rst)                 & "," &
                    "cache_inhibit_ext="    & std_logic'image(ip.cache_inhibit_ext)         & "," &
                    "cpu_cache_ctrl="       & slv_to_str(ip.cpu_cache_ctrl)                 & "," &
                    "cpuCS="                & std_logic'image(ip.cpuCS)                     & "," &
                    "cpuState="             & slv_to_str(ip.cpuState)                       & "," &
                    "cpuAddr="              & slv_to_hex_any(ip.cpuAddr)                    & "," &
                    "cpuWR="                & slv_to_hex16(ip.cpuWR)                        & "," &
                    "cpuL="                 & std_logic'image(ip.cpuL)                      & "," &
                    "cpuU="                 & std_logic'image(ip.cpuU)                      & "," &
                    "chipAddr="             & slv_to_hex_any(ip.chipAddr)                   & "," &
                    "chipWR="               & slv_to_hex16(ip.chipWR)                       & "," &
                    "chipRW="               & std_logic'image(ip.chipRW)                    & "," &
                    "chipDMA="              & std_logic'image(ip.chipDMA)                   & "," &
                    "chipL="                & std_logic'image(ip.chipL)                     & "," &
                    "chipU="                & std_logic'image(ip.chipU)                     & "," &                    
                    "chipBurstLen="         & slv_to_hex_any(ip.chipBurstLen)               & "," &
                    ""                               
                severity note;
        
            report "[CYCLE_FE_PORTS " & int_img(cycle) &  " Time=" & time_to_str(now) & "]" & "," &
                    "FE_OUT_PORTS: "                                                        & "," &
                    "cpu_ack="              & std_logic'image(op.cpu_ack)                   & "," &
                    "chip_rd_done="         & std_logic'image(op.chip_rd_done)              & "," &
                    "cpuRD="                & slv_to_hex16(op.cpuRD)                        & "," &                    
                    "chipRD="               & slv_to_hex16(ram.chipRD)                      & "," &
                    "chip48="               & slv_to_hex_any(op.chip48)                     & "," &
                    "ramReady="             & std_logic'image(op.ramReady)                  & "," &
                    ""                                 
                severity note;
                
                report "[CYCLE_FE " & int_img(cycle) &  " Time=" & time_to_str(now) & "]" & "," & 
                       "FE: "                                                             & "," & 
                       "ramaddr_i="             & slv_to_hex_any(ramaddr_i)               & "," &
                       "addr_hi="               & slv_to_hex_any(addr_hi)                 & "," &
                       "ramdin_i="              & slv_to_hex16(ramdin_i)                  & "," &
                       "cpuRD_i="               & slv_to_hex16(ram.cpuRD)                 & "," &                   
                       "cpu_ack_i="             & std_logic'image(ram.cpu_ack)            & "," &
                       "ramshared="             & std_logic'image(ramshared)              & "," &
                       "ramready_i="            & std_logic'image(ram.ramready)           & "," &  
                       "cache_inhibit="         & std_logic'image(cache_inhibit_final)    & "," &
                       "cache_inhibit_region="  & std_logic'image(cache_inhibit_region)   & "," &
                       "cache_inhibit_ext="     & std_logic'image(ip.cache_inhibit_ext)   & "," &
                       "cache_inhibit_fast="    & std_logic'image(cache_inhibit_fast)     & "," &
                       ""                       
                        severity note;            
        end if;        
    end process;
    

end generate;    
    
end architecture;