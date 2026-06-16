
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.debug_utils_pkg.all;

entity tb_agnus_copper_v1_4 is
end entity;

architecture sim of tb_agnus_copper_V1_4 is

    constant CLK28_PERIOD : time := 35 ns;  -- ~28 MHz
      
    -- DUT ports
    signal clk           : std_logic := '0';
    signal clk7_en       : std_logic := '0';
    signal clk7n_en      : std_logic := '0';
    signal c1            : std_logic := '0';
    signal c3            : std_logic := '0';
    signal cck           : std_logic := '0';
    signal eclk          : std_logic_vector(9 downto 0) := (others=>'0');
    signal reset         : std_logic := '1';
    signal reset_n       : std_logic := '0';

    -- CPU bus
    signal aen           : std_logic := '0';
    signal rd            : std_logic := '0';
    signal hwr           : std_logic := '0';
    signal lwr           : std_logic := '0';
    --signal address_in    : std_logic_vector(8 downto 1) := (others => '0');
    signal address_in    : std_logic_vector(8 downto 0) := (others => '0');
    signal data_in       : std_logic_vector(15 downto 0) := (others => '0');
    signal dma_data_in   : std_logic_vector(15 downto 0) := (others => '0');
    signal cpu_data_in   : std_logic_vector(15 downto 0) := (others => '0');
    signal data_out      : std_logic_vector(15 downto 0);

    -- Agnus Outputs
    signal address_out   : std_logic_vector(20 downto 1);
    signal reg_address_out : std_logic_vector(8 downto 1);
    signal cpu_custom    : std_logic;
    signal dbr           : std_logic;
    signal dbwe          : std_logic;
    signal x_hsync       : std_logic;
    signal x_vsync       : std_logic;
    signal x_csync       : std_logic;
    signal field1        : std_logic;
    signal lace          : std_logic;
    signal hblank        : std_logic;
    signal vblank        : std_logic;
    signal hde           : std_logic;
    signal sol           : std_logic;
    signal sof           : std_logic;
    signal vbl_int       : std_logic;
    signal strhor_denise : std_logic;
    signal strhor_paula  : std_logic;
    signal htotal        : std_logic_vector(8 downto 0);
    signal harddis       : std_logic;
    signal varbeamen     : std_logic;
    signal int3          : std_logic;
    signal audio_dmal    : std_logic_vector(3 downto 0) := (others => '0');
    signal audio_dmas    : std_logic_vector(3 downto 0) := (others => '0');
    signal disk_dmal     : std_logic := '0';
    signal disk_dmas     : std_logic := '0';
    signal bls           : std_logic := '0';
    signal ntsc          : std_logic := '0';
    signal a1k           : std_logic := '0';
    signal ecs           : std_logic := '0';
    signal aga           : std_logic := '0';
    signal floppy_speed  : std_logic := '0';

    -- Testbench Signals
    signal hpos_tb       : std_logic_vector(8 downto 0) := (others => '0');
    signal vpos_tb       : std_logic_vector(10 downto 0) := (others => '0');  
    signal copen_tb      : std_logic := '0';
    signal req_cop_tb    : std_logic := '0';    
    signal dmacon_tb     : std_logic_vector(12 downto 0) := (others => '0');
    signal cpu_write_pending_tb    : std_logic := '0';
    signal reg_address_sync_tb     : std_logic_vector(8 downto 1) := (others => '0');
    signal data_in_sync_tb         : std_logic_vector(15 downto 0) := (others => '0');
    signal blt_state_tb        : std_logic_vector(4 downto 0) := (others => '0');
    signal blitter_wr_valid_tb : std_logic := '0';
    signal blitter_wr_addr_tb : std_logic_vector(8 downto 1) := (others => '0');
    signal blitter_wr_data_tb : std_logic_vector(15 downto 0) := (others => '0');
    

    -- Simple chip RAM model (64K words for now)
    type ram_t is array (0 to 65535) of std_logic_vector(15 downto 0);    
    
    signal bus_owner : std_logic := '0';  -- '0' = CPU, '1' = DMA
    --signal dmaconr_val : std_logic_vector(15 downto 0);
    

    -- Internal helper
    function to_integer_21(s : std_logic_vector(20 downto 1)) return integer is
    begin
        return to_integer(unsigned(s));
    end function;

begin
  --------------------------------------------------------------------
  -- 28 MHz clock
  --------------------------------------------------------------------
  clk_proc : process
  begin
    clk <= '0';
    wait for CLK28_PERIOD/2;
    clk <= '1';
    wait for CLK28_PERIOD/2;
  end process;  
  --------------------------------------------------------------------
  -- clk7_en and cck generation (4-phase)
  -- phase 0: clkdiv=0  -> cck='1', clk7_en='0'
  -- phase 1: clkdiv=1  -> cck='0', clk7_en='1'
  -- phase 2: clkdiv=2  -> cck='0', clk7_en='0'
  -- phase 3: clkdiv=3  -> cck='1', clk7_en='0'
  --------------------------------------------------------------------
amg_clk : entity work.amiga_clk
   port map (
     clk_28     => clk
    ,reset_n    => reset_n
    ,clk7_en    => clk7_en
    ,clk7n_en   => clk7n_en
    ,c1         => c1
    ,c3         => c3
    ,cck        => cck
    ,eclk       => eclk    
   );    
    --------------------------------------------------------------------
    -- Reset
    --------------------------------------------------------------------
    reset_n <= not reset;

    --------------------------------------------------------------------
    -- DUT
    --------------------------------------------------------------------
    dut : entity work.agnus_wrapper_m65
        port map (
             clk             => clk
            ,clk7_en         => clk7_en
            ,cck             => cck
            ,reset           => reset
            ,aen             => aen
            ,rd              => rd
            ,hwr             => hwr
            ,lwr             => lwr
            ,data_in         => data_in
            ,data_out        => data_out
            ,address_in      => address_in(8 downto 1)
            ,address_out     => address_out
            ,reg_address_out => reg_address_out
            ,cpu_custom      => cpu_custom
            ,dbr             => dbr
            ,dbwe            => dbwe
            ,x_hsync         => x_hsync
            ,x_vsync         => x_vsync
            ,x_csync         => x_csync
            ,field1          => field1
            ,lace            => lace
            ,hblank          => hblank
            ,vblank          => vblank
            ,hde             => hde
            ,sol             => sol
            ,sof             => sof
            ,vbl_int         => vbl_int
            ,strhor_denise   => strhor_denise
            ,strhor_paula    => strhor_paula
            ,htotal          => htotal
            ,harddis         => harddis
            ,varbeamen       => varbeamen
            ,int3            => int3
            ,audio_dmal      => audio_dmal
            ,audio_dmas      => audio_dmas
            ,disk_dmal       => disk_dmal
            ,disk_dmas       => disk_dmas
            ,bls             => bls
            ,ntsc            => ntsc
            ,a1k             => a1k
            ,ecs             => ecs
            ,aga             => aga
            ,floppy_speed    => floppy_speed
            ,hpos_tb         => hpos_tb
            ,vpos_tb         => vpos_tb
            ,copen_tb        => copen_tb
            ,req_cop_tb      => req_cop_tb
            ,dmacon_tb       => dmacon_tb
            ,cpu_write_pending_tb => cpu_write_pending_tb
            ,reg_address_sync_tb  => reg_address_sync_tb
            ,data_in_sync_tb      => data_in_sync_tb
            ,blt_state_tb        => blt_state_tb
            ,blitter_wr_valid_tb => blitter_wr_valid_tb
            ,blitter_wr_addr_tb => blitter_wr_addr_tb
            ,blitter_wr_data_tb => blitter_wr_data_tb
            
        );

   --------------------------------------------------------------------
  -- Simple chip RAM model for DMA (Copper list, etc.)
  -- When Agnus owns the bus (dbr='1'):
  --   - if dbwe='1'  -> write data_out to RAM
  --   - if dbwe='0'  -> drive data_in from RAM
  -- When CPU owns the bus (dbr='0'):
  --   - data_in is driven by CPU driver process
  --------------------------------------------------------------------
data_in <= dma_data_in when dbr  = '1' else cpu_data_in;

  --------------------------------------------------------------------
  -- Preload a tiny Copper list into chip RAM
  -- Example at address $0100 (word address):
  --   0100: WAIT  vpos=0x0010, hpos=0x0010
  --   0102: MOVE  COLOR00, $0F00
  --   0104: MOVE  COLOR01, $00F0
  --   0106: MOVE  BPL1DAT, $FFFF
  --   0108: END   (MOVE to COPJMP1 or illegal -> stop)
  --------------------------------------------------------------------
-- single-writer RAM model with DMA reads/writes and CPU write support
ram_proc : process(clk)
  -- local RAM storage (single writer)
  variable chipram : ram_t := (others => (others => '0'));
  variable addr    : integer;
  variable cpu_addr: integer;
begin
  if rising_edge(clk) then

    -- preload Copper list once while in reset (or on first cycle)
    if reset = '1' then
      chipram := (others => (others => '0'));
      -- WAIT  $0010,$001F
      chipram(16#0100#) := x"0010";
      chipram(16#0101#) := x"001F";
      -- MOVE COLOR00,$0F00
      chipram(16#0102#) := x"0180";
      chipram(16#0103#) := x"0F00";
      -- MOVE COLOR01,$00F0
      chipram(16#0104#) := x"0182";
      chipram(16#0105#) := x"00F0";
      -- MOVE BPL1DAT
      chipram(16#0106#) := x"00E0";
      chipram(16#0107#) := x"FFFF";
      -- END
      chipram(16#0108#) := x"FFFF";
      chipram(16#0109#) := x"FFFE";
    end if;

    -- DMA path: Agnus owns the bus (dbr='1')
    if dbr = '1' then
      addr := to_integer_21(address_out);
      if addr >= 0 and addr <= chipram'high then
        if dbwe = '1' then
          -- DMA write (disk/blitter)
          chipram(addr) := data_out;
          dma_data_in <= (others => '0'); -- not driving read data this cycle
        else
          -- DMA read (Copper, audio, bitplane, etc.)
          dma_data_in <= chipram(addr);
        end if;
      else
        dma_data_in <= (others => '0');
      end if;

    -- CPU path: CPU owns the bus and is performing a full 16-bit write
    -- NOTE: address_in is 8:1 in your DUT (register bank). Here we use it
    -- as a simple word index into chipram for TB CPU writes. Adjust mapping
    -- if your real CPU address mapping differs.
    --elsif bus_owner = '0' and aen = '0' and hwr = '1' and lwr = '1' then
    elsif bus_owner = '0' and aen = '1' and hwr = '1' and lwr = '1' then
      -- map the 8-bit address_in to a chipram word address
      cpu_addr := to_integer(unsigned(address_in));
      if cpu_addr >= 0 and cpu_addr <= chipram'high then
        chipram(cpu_addr) := cpu_data_in;  -- CPU write into chip RAM
      end if;
      dma_data_in <= (others => '0');

    else
      -- neither DMA nor CPU write: release dma_data_in
      dma_data_in <= (others => '0');
    end if;

  end if;
end process;


 
  --------------------------------------------------------------------
  -- Stimulus: reset, enable DMA, set Copper list pointer, run
  --------------------------------------------------------------------
stim_proc : process
--    constant DMACON  : std_logic_vector(8 downto 1) := x"96"; -- 0x096
--    constant DMACONR : std_logic_vector(8 downto 1) := x"02"; -- 0x002
--    constant COP1LCH : std_logic_vector(8 downto 1) := x"88"; -- 0x088
--    constant COP1LCL : std_logic_vector(8 downto 1) := x"8A"; -- 0x08A
    constant DMACON  : std_logic_vector(11 downto 0) := x"096"; -- 0x096
    constant DMACONR : std_logic_vector(11 downto 0) := x"002"; -- 0x002
    constant COP1LCH : std_logic_vector(11 downto 0) := x"088"; -- 0x088
    constant COP1LCL : std_logic_vector(11 downto 0) := x"08A"; -- 0x08A
    
    -- Blitter register addresses (use values printed by BLT CONSTS)
--    constant BLTADAT : std_logic_vector(8 downto 1) := x"3A";
--    constant BLTBDAT : std_logic_vector(8 downto 1) := x"39";
--    constant BLTCDAT : std_logic_vector(8 downto 1) := x"38";
--    constant BLTSIZE : std_logic_vector(8 downto 1) := x"2C";
--    constant BLTSIZH : std_logic_vector(8 downto 1) := x"2F";
--    constant BLTSIZV : std_logic_vector(8 downto 1) := x"2E";
    constant BLTADAT : std_logic_vector(11 downto 0) := x"03A";
    constant BLTBDAT : std_logic_vector(11 downto 0) := x"039";
    constant BLTCDAT : std_logic_vector(11 downto 0) := x"038";
    constant BLTSIZE : std_logic_vector(11 downto 0) := x"02C";
    constant BLTSIZH : std_logic_vector(11 downto 0) := x"02F";
    constant BLTSIZV : std_logic_vector(11 downto 0) := x"02E";    
    
    --variable dmaconr_val : std_logic_vector(15 downto 0);    
    variable r : std_logic_vector(15 downto 0);  
    variable i : integer;  
    
    -- Data sent to DMACON controls what DMA is enable
    -- These need to be set depening on the DMA path/s to test.
    -- bit 9 - Master DMA
    -- bit 8 - bitplane DMA
    -- bit 7 - Copper DMA
    -- bit 6 - blitter DMA
    -- bit 5 - sprite DMA    
    
    --------------------------------------------------------------------
    -- Simple CPU write helper (blocking)
    --------------------------------------------------------------------
 procedure cpu_write(
        --constant reg_addr : in std_logic_vector(8 downto 1);
        --constant reg_addr : in std_logic_vector(8 downto 0);
        constant reg_addr : in std_logic_vector(11 downto 0);
        constant value    : in std_logic_vector(15 downto 0)
      ) is
      begin
       write_retry : loop
    -- wait for a free bus and for a rising clock
    wait until rising_edge(clk);
    while clk7_en='0' loop
      wait until rising_edge(clk);
    end loop;

    -- wait until DMA not holding the bus
    while dbr='1' loop
      wait until rising_edge(clk);
    end loop;

    -- begin write
    --address_in    <= reg_addr;    
    address_in    <= reg_addr(8 downto 0);    
    cpu_data_in   <= value;
    aen       <= '1';    
    hwr       <= '1';
    lwr       <= '1';
    rd        <= '0';        
    
    -- wait until we see clk7_en asserted (the DUT samples on this)
    wait until rising_edge(clk);
    wait until clk7_en = '1';
    -- keep the write asserted for one more rising edge to be safe
    wait until rising_edge(clk);

    -- if DMA stole the bus mid-write → abort and retry
    if dbr='1' then
      -- release bus immediately
      aen <= '0'; hwr <= '0'; lwr <= '0';      
      cpu_data_in <= (others => '0');
      address_in  <= (others => '0');
      next write_retry;
    end if;

    -- deassert and finish
    aen <= '0'; hwr <= '0'; lwr <= '0';
    cpu_data_in <= (others => '0');
    address_in  <= (others => '0');

    -- write completed successfully
    exit write_retry;

  end loop;
 end procedure;

procedure cpu_read(
  --constant reg_addr : in std_logic_vector(8 downto 1);
  --constant reg_addr : in std_logic_vector(8 downto 0);
  constant reg_addr : in std_logic_vector(11 downto 0);
  variable out_val  : out std_logic_vector(15 downto 0)
) is
begin
  -- wait for CPU slot
  wait until rising_edge(clk);
  while clk7_en = '0' loop
    wait until rising_edge(clk);
  end loop;

  -- wait until DMA releases bus
  while dbr = '1' loop
    wait until rising_edge(clk);
  end loop;

  -- assert read
  aen        <= '1';
  rd         <= '1';
  hwr        <= '0';
  lwr        <= '0';
  --address_in <= reg_addr;
  address_in <= reg_addr(8 downto 0);

  -- sample on next clk (Agnus samples on clk/clk7_en)
  wait until rising_edge(clk);
  wait until clk7_en = '1';
  wait until rising_edge(clk);
  -- capture what Agnus drove on data_out
  out_val := data_out;

  -- deassert
  aen <= '0';
  rd  <= '0';
  address_in <= (others => '0');

  -- keep bus released one cycle
  wait until rising_edge(clk);
end procedure;
  
  begin
    -- hold reset for a bit
    reset <= '1';
    --wait for 2 us;
    wait for 200 ns;
    reset <= '0';

    -- small delay after reset
    --wait for 2 us;
    wait for 200 ns;

    -- Set Copper list pointer to $0100 (word address)
--    cpu_write(COP1LCH, x"0000");  -- high 5 bits of 21-bit address
--    cpu_write(COP1LCL, x"0100");  -- low 16 bits
--    cpu_write(DMACON,  x"8280");  -- Enable master + copper DMA only  0 Bit 8 enables Cooper
    
    -- Blitter
--    cpu_write(BLTADAT, x"00F0");    -- channel A data
--    cpu_write(BLTBDAT, x"00E0");    -- channle B data

    --cpu_write(DMACON, x"0240");     -- bit9 + bit6 = 0x0200 + 0x0040 = 0x0240
    cpu_write(DMACON, x"8240");     -- bit9 + bit6 = 0x0200 + 0x0040 = 0x0240   -- To enable DMA bit15 must also be set.  Bit 6 & 9 enable the blitter
    --cpu_write(DMACON, x"0140");     -- bit9 + bit6 = 0x0200 + 0x0040 = 0x0240
    cpu_read(DMACONR, r);
    report "DMACONR readback = " & slv_to_hex_any(r);

    cpu_write(BLTADAT, x"00F0");    -- channel A data
    cpu_write(BLTBDAT, x"00E0");    -- channle B data    
    cpu_write(BLTSIZE, x"0001");    -- width=1 (start blit)        
            
--    cpu_read(DMACONR, r); report "DMACONR readback = " & slv_to_hex_any(r);
--    cpu_read(COP1LCL, r); report "COP1LCL readback = " & slv_to_hex_any(r);
    

    -- Enable DMA + Copper (DMACON: set bits via bit15=1)
    -- Example: master + Copper + bitplane (you can tweak)
    --cpu_write(DMACON, x"83A0");   -- adjust to your exact bit layout
    --cpu_write(DMACON, x"8380");   -- Enable master + copper + bitplane
    --cpu_write(DMACON, x"8280");   -- Enable master + copper DMA only   
    
--    for i in 128 to 159 loop -- 0x80..0x9F
--        cpu_read(std_logic_vector(to_unsigned(i,8)), r);
--        report "READ SWEEP addr=" & integer'image(i) & " data=" & slv_to_hex_any(r);
--    end loop;
    
--    for i in 0 to 255 loop -- 0x80..0x9F
--        cpu_read(std_logic_vector(to_unsigned(i,8)), r);
--        if r /= x"0000" then
--            report "READ SWEEP found addr=" & integer'image(i) & " data=" & slv_to_hex_any(r);
--        end if;
--    end loop;
        
    --cpu_read(DMACON, r);  report "DMACONR readback = " & slv_to_hex_any(r);

    --cpu_write(DMACON, x"0280"); -- try without top bit set
    --cpu_read(DMACON, r); report "DMACON read after plain write = " & slv_to_hex_any(r);
    --cpu_write(DMACON, x"8280"); -- try with top bit set (set semantics)
    --cpu_read(DMACON, r); report "DMACON read after set write = " & slv_to_hex_any(r);

    -- Let it run for some lines
    wait for 1 ms;

    assert false report "Simulation finished" severity failure;
  end process;

    --------------------------------------------------------------------
    -- Monitor Copper register writes (Agnus -> custom regs)
    --------------------------------------------------------------------
    monitor : process(clk)
        variable cycle : integer := 0;
    begin              
        if rising_edge(clk)and clk7_en = '1' then
            cycle := cycle + 1;
                                    
            report "[TB][CYCLE " & integer'image(cycle) & "]" & "," & 
                "T="                & time_to_str(now) & "," &
                "bus_owner="        & bus_owner'image(bus_owner)                    & "," &
                "dbr="              & dbr'image(dbr)                                & "," &
                "dbwe="             & dbwe'image(dbwe)                              & "," &                
                "aen="              & aen'image(aen)                                & "," &
                "rd="               & rd'image(rd)                                  & "," &
                "hwr="              & rd'image(hwr)                                 & "," &
                "lwr="              & rd'image(lwr)                                 & "," &
                "address_in="       & slv_to_hex_any(address_in)                    & "," &
                "data_in="          & slv_to_hex_any(data_in)                       & "," &
                "dma_data_in="      & slv_to_hex_any(dma_data_in)                   & "," &
                "cpu_data_in="      & slv_to_hex_any(cpu_data_in)                   & "," &
                "reg_address_out="  & slv_to_hex_any(reg_address_out)               & "," &
                "data_out="         & slv_to_hex_any(data_out)                      & "," &
                --"data_out="         & slv_to_str(data_out) & "," &
                --"copen="            & copen_tb'image(copen_tb) & "," &
                --"req_cop="          & req_cop_tb'image(req_cop_tb) & "," &
                --"dmacon_tb="        & slv_to_hex_any(dmacon_tb)         & "," &
            "";
                
        
            if dbr = '1' and dbwe = '1' then
                report "TB DMA WRITE:" & "," &
                       "T=" & time_to_str(now) & "," & 
                       "reg=" & integer'image(to_integer(unsigned(reg_address_out))) & "," &
                       "data_out=" & slv_to_hex_any(data_out) & "," &
                       "hpos_tb=" & integer'image(to_integer(unsigned(hpos_tb))) & "," &
                       "vpos_tb=" & integer'image(to_integer(unsigned(vpos_tb))) & "," &
                       "";
            end if;
          end if;        
    end process;

--dma_monitor : process(clk)
--begin
--  if rising_edge(clk) and clk7_en = '1' then
--    if dbr = '1' then
--      report "[TB DMA]" & "," &
--             "T=" & time_to_str(now) & "," &
--             "dbr=1,addr_out=" & integer'image(to_integer_21(address_out)) & "," &
--             "reg_addr_out=" & integer'image(to_integer(unsigned(reg_address_out))) & "," &
--             "dma_data_in=" & slv_to_hex_any(dma_data_in) &  "," &
--             "";
--    end if;
--  end if;
--end process;

sync_monitor : process(clk)
begin
    if rising_edge(clk) and clk7_en = '1' then
        report "[TB DBG SYNC]" & "," &
             "T="                   & time_to_str(now)                          & "," &
             "aen="                 & sl_to_str(aen)                            & "," &
             "hwr="                 & sl_to_str(hwr)                            & "," &
             "lwr="                 & sl_to_str(lwr)                            & "," &
             "rd="                  & sl_to_str(rd)                             & "," &
             "address_in="          & slv_to_hex_any(address_in)                & "," &
             "data_in="             & slv_to_hex_any(data_in)                   & "," &
             "dmacon_tb="           & slv_to_hex_any(dmacon_tb)                 & "," &
             "reg_addres_sync="     & slv_to_hex_any(reg_address_sync_tb)       & "," &
             "data_in_sync="        & slv_to_hex_any(data_in_sync_tb)           & "," &
             "cpu_write_pending="   & sl_to_str(cpu_write_pending_tb)           & "," &
             "copen_tb="            & copen_tb'image(copen_tb)                  & "," &
             "req_cop_tb="          & req_cop_tb'image(req_cop_tb)              & "," &
             "dbr="                 & dbr'image(dbr)                            & "," &
             "address_out="         & integer'image(to_integer_21(address_out)) & "," &
             "dma_data_in="         & slv_to_hex_any(dma_data_in)               & "," &
             "data_out="            & slv_to_hex_any(data_out)                  & "," &
             "blt_state_tb="        & slv_to_hex_any(blt_state_tb)              & "," &
             "blitter_wr_valid_tb=" & sl_to_str(blitter_wr_valid_tb)            & "," &
             "blitter_wr_addr_tb="  & slv_to_hex_any(blitter_wr_addr_tb)        & "," &
             "blitter_wr_data_tb="  & slv_to_hex_any(blitter_wr_data_tb)        & "," &
             "";
    end if;
end process;
  
--cpu_write_monitor : process(clk)
--begin
--  if rising_edge(clk) and clk7_en = '1' then
--    if aen = '1' and hwr = '1' and lwr = '1' then
--      report "[TB CPU WRITE] " & "," &
--             "T=" & time_to_str(now) & "," &
--             "addr=" & slv_to_hex_any(address_in) & "," &
--             "data=" & slv_to_hex_any(cpu_data_in) &  "," &
--             "";
--    end if;
--  end if;  
--end process;

-- monitor every clk7_en for address_out changes
--addr_trace : process(clk)
--begin
--  if rising_edge(clk) and clk7_en = '1' then
--    report "[TB TRACE] clk7_en" & "," &
--           "T=" & time_to_str(now) & "," &
--           "dbr=" & dbr'image(dbr) & "," &
--           "addr_out=" & slv_to_hex_any(address_out) & "," &
--           "reg_addr_out=" & integer'image(to_integer(unsigned(reg_address_out))) &  "," &
--           "";
--  end if;  
--end process;

reg_access_monitor : process(clk)
begin
  if rising_edge(clk) and clk7_en = '1' then
    if aen = '1' and (hwr = '1' or rd = '1') then
      report "[TB REG ACCESS]" & "," &
             "T=" & time_to_str(now) & "," &
             "aen=" & aen'image(aen) & "," &
             "hwr=" & hwr'image(hwr) & "," &
             "rd=" & rd'image(rd) & "," &
             "address_in=" & slv_to_hex_any(address_in) & "," &
             "reg_address_out=" & integer'image(to_integer(unsigned(reg_address_out))) & "," &
             "cpu_data_in=" & slv_to_hex_any(cpu_data_in) & "," &
             "data_out=" & slv_to_hex_any(data_out) &  "," &
             "";
    end if;
  end if;
end process;



end architecture;
