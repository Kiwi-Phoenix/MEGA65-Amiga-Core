-- TB for Agnus, Blitter, and Copper
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.debug_utils_pkg.all;

entity tb_agnus_blitter_V1_0 is
end entity;

architecture sim of tb_agnus_blitter_V1_0 is

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
    signal address_in_81 : std_logic_vector(8 downto 1) := (others => '0');
    signal data_in       : std_logic_vector(15 downto 0) := (others => '0');
    signal dma_data_in   : std_logic_vector(15 downto 0) := (others => '0');
    signal cpu_data_in   : std_logic_vector(15 downto 0) := (others => '0');
    signal data_out      : std_logic_vector(15 downto 0);

    -- Agnus Outputs
    signal address_out   : std_logic_vector(20 downto 1);
    signal reg_address_out : std_logic_vector(8 downto 1);
    signal hpos_tb       : std_logic_vector(8 downto 0) := (others => '0');
    
    signal cpu_custom    : std_logic;
    signal dbr           : std_logic;
    signal dbwe          : std_logic;
    signal x_hsync       : std_logic := '0';
    signal x_vsync       : std_logic := '0';
    signal x_csync       : std_logic := '0';
    signal field1        : std_logic;
    signal lace          : std_logic;
    signal hblank        : std_logic := '0';
    signal vblank        : std_logic := '0';
    signal hde           : std_logic;
    signal sol           : std_logic;
    signal sof           : std_logic;
    signal vbl_int       : std_logic := '0';
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
    --signal hpos_tb       : std_logic_vector(8 downto 0) := (others => '0');
    signal vpos_tb       : std_logic_vector(10 downto 0) := (others => '0');  
    signal copen_tb      : std_logic := '0';
    signal req_cop_tb    : std_logic := '0';    
    signal dmacon_tb     : std_logic_vector(12 downto 0) := (others => '0');
    signal cpu_write_pending_tb    : std_logic := '0';
    signal reg_address_sync_tb     : std_logic_vector(8 downto 1) := (others => '0');
    signal data_in_sync_tb         : std_logic_vector(15 downto 0) := (others => '0');
    signal blt_state_tb        : std_logic_vector(4 downto 0) := (others => '0');
--    signal blitter_wr_valid_tb : std_logic := '0';
--    signal blitter_wr_addr_tb : std_logic_vector(8 downto 1) := (others => '0');
--    signal blitter_wr_data_tb : std_logic_vector(15 downto 0) := (others => '0');
   

    -- Simple chip RAM model (64K words for now)
    constant RAM_SIZE : integer := 2048;
    --constant RAM_SIZE : integer := 1024;
    --type ram_t is array (0 to 65535) of std_logic_vector(15 downto 0);    
    type ram_t is array (0 to RAM_SIZE - 1) of std_logic_vector(15 downto 0);    
     
            
    signal bus_owner : std_logic := '0';  -- '0' = CPU, '1' = DMA
    --signal dmaconr_val : std_logic_vector(15 downto 0);
    

    -- Internal helper
    function to_integer_21(s : std_logic_vector(20 downto 1)) return integer is
    begin
        return to_integer(unsigned(s));
    end function;
    
    function ram_index (
        addr : std_logic_vector(20 downto 1);
        size : integer
    ) return integer is
        variable a : integer;
    begin
        -- Convert byte address -> word index
        --a := to_integer(unsigned(addr(20 downto 5)));
        a := to_integer(unsigned(addr(20 downto 1)));
        
        -- Wrap into ram SIZE (must be power of 2)
        return a mod size;
    end function;
    
    function cpu_index (
        addr : std_logic_vector(8 downto 0);
        size : integer
    ) return integer is
    begin
        return to_integer(unsigned(addr)) mod size;    
    end function;
    
    -- Define and preload chipram
    signal chipram : ram_t := (ram_index(x"08000", RAM_SIZE) => x"CAFE", others => (others => '0'));
    --signal chipram : ram_t := (others => (others => '0'));


begin

address_in_81 <= address_in(8 downto 1);

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
  

RAM: process(clk)
    variable dma_addr : integer;
    variable cpu_addr : integer;
begin
    -- preload 
    --chipram(16#00400#) <= x"CAFE";
    --chipram(ram_index(x"08000", RAM_SIZE)) <= x"CAFE";

    if rising_edge(clk) then
        if clk7_en = '1' then
                    
            dma_addr := ram_index(address_out, RAM_SIZE);   -- DMA address (Agnus)
            cpu_addr := cpu_index(address_in, RAM_SIZE);    -- CPU address        
            --report "dma_addr= " & integer'image(dma_addr);
            --report "cpu_addr= " & integer'image(cpu_addr);
            -- DMA Write
            if dbwe = '1' then
              --chipram(ram_index(address_out, RAM_SIZE)) <= data_out;
              chipram(dma_addr) <= data_out;
              
              report "dma_addr= " & integer'image(dma_addr);
            end if;
            
            -- CPU Write (word)
            if hwr = '1' or lwr = '1' then                
                chipram(cpu_addr) <= cpu_data_in;
                --chipram(cpu_index(address_in, RAM_SIZE)) <= cpu_data_in;
                --chipram(cpu_addr) <= cpu_data_in;
                --chipram(to_integer(unsigned(cpu_addr))) <= data_in;                
            end if;
            
            -- DMA Read
            --dma_data_in <= chipram(ram_index(address_out, RAM_SIZE));
            dma_data_in <= chipram(dma_addr);
--            if dbr = '1' then
--                dma_data_in <= chipram(dma_addr);
--            else   
--                dma_data_in <= (others => '0');
--            end if;                      
        end if;
    end if;
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
    --dut : entity work.agnus_wrapper_m65
    dut : entity work.agnus_wrapper_DJR
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
            --,copen_tb        => copen_tb
            --,req_cop_tb      => req_cop_tb
            --,dmacon_tb       => dmacon_tb
            --,cpu_write_pending_tb => cpu_write_pending_tb
            --,reg_address_sync_tb  => reg_address_sync_tb
            --,data_in_sync_tb      => data_in_sync_tb
            --,blt_state_tb        => blt_state_tb
            --,blitter_wr_valid_tb => blitter_wr_valid_tb
            --,blitter_wr_addr_tb => blitter_wr_addr_tb
            --,blitter_wr_data_tb => blitter_wr_data_tb
            
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
--ram_proc : process(clk)
--  -- local RAM storage (single writer)
--  --variable chipram : ram_t := (others => (others => '0'));
--  variable addr    : integer;
--  variable cpu_addr: integer;
--begin
--  if rising_edge(clk) then

--    -- DMA path: Agnus owns the bus (dbr='1')
--    if dbr = '1' then
--      addr := to_integer_21(address_out);
--      if addr >= 0 and addr <= chipram'high then
--        if dbwe = '1' then
--          -- DMA write (disk/blitter)
--          chipram(addr) <= data_out;
--          dma_data_in <= (others => '0'); -- not driving read data this cycle
--        else
--          -- DMA read (Copper, audio, bitplane, etc.)
--          dma_data_in <= chipram(addr);
--        end if;
--      else
--        dma_data_in <= (others => '0');
--      end if;

--    -- CPU path: CPU owns the bus and is performing a full 16-bit write
--    -- NOTE: address_in is 8:1 in your DUT (register bank). Here we use it
--    -- as a simple word index into chipram for TB CPU writes. Adjust mapping
--    -- if your real CPU address mapping differs.
--    --elsif bus_owner = '0' and aen = '0' and hwr = '1' and lwr = '1' then
--    elsif bus_owner = '0' and aen = '1' and hwr = '1' and lwr = '1' then
--      -- map the 8-bit address_in to a chipram word address
--      cpu_addr := to_integer(unsigned(address_in));
--      if cpu_addr >= 0 and cpu_addr <= chipram'high then
--        chipram(cpu_addr) <= cpu_data_in;  -- CPU write into chip RAM
--      end if;
--      dma_data_in <= (others => '0');

--    else
--      -- neither DMA nor CPU write: release dma_data_in
--      dma_data_in <= (others => '0');
--    end if;

--  end if;
--end process;


 
  --------------------------------------------------------------------
  -- Stimulus: reset, enable DMA, set Copper list pointer, run
  --------------------------------------------------------------------
stim_proc : process
    -- Note: These addresses get "transformed" with a right bit-shift,
    --       so that they will line up with what Agnus and the Custom Chip modules do.
    constant DMACON  : std_logic_vector(11 downto 0) := x"096";
    constant DMACONR : std_logic_vector(11 downto 0) := x"002";
    constant DIWSTRT : std_logic_vector(11 downto 0) := x"08E";
    constant DIWSTOP : std_logic_vector(11 downto 0) := x"090";
    constant DIWHIGH : std_logic_vector(11 downto 0) := x"1E4";
    
    -- Copper Addresses
    constant COP1LCH : std_logic_vector(11 downto 0) := x"088"; -- 0x088
    constant COP1LCL : std_logic_vector(11 downto 0) := x"08A"; -- 0x08A
    
    
    -- Blitter Addresses
    constant BLTADAT : std_logic_vector(11 downto 0) := x"074";         -- 3A
    constant BLTBDAT : std_logic_vector(11 downto 0) := x"072";         -- 39    
    constant BLTCDAT : std_logic_vector(11 downto 0) := x"070";         -- 38
    constant BLTDDAT : std_logic_vector(11 downto 0) := x"000";         -- 38
    constant BLTSIZE : std_logic_vector(11 downto 0) := x"058";         -- 2C
    constant BLTSIZH : std_logic_vector(11 downto 0) := x"05E";         -- 2F
    constant BLTSIZV : std_logic_vector(11 downto 0) := x"05C";         -- 2E  
    
    constant BLTCON0  : std_logic_vector(11 downto 0) := x"040";  
    constant BLTCON0L : std_logic_vector(11 downto 0) := x"05A";  
    constant BLTCON1  : std_logic_vector(11 downto 0) := x"042";  
    constant BLTAFWM  : std_logic_vector(11 downto 0) := x"044";  
    constant BLTALWM  : std_logic_vector(11 downto 0) := x"046";  
    
    -- Blitter adrgen addresses
    
    constant BLTAMOD  : std_logic_vector(11 downto 0) := x"064";  
    constant BLTBMOD  : std_logic_vector(11 downto 0) := x"062";  
    constant BLTCMOD  : std_logic_vector(11 downto 0) := x"060";  
    constant BLTDMOD  : std_logic_vector(11 downto 0) := x"066";  
    constant BLTAPTH  : std_logic_vector(11 downto 0) := x"050";  
    constant BLTAPTL  : std_logic_vector(11 downto 0) := x"052";  
    constant BLTBPTH  : std_logic_vector(11 downto 0) := x"04c";  
    constant BLTBPTL  : std_logic_vector(11 downto 0) := x"04e";  
    constant BLTCPTH  : std_logic_vector(11 downto 0) := x"048";  
    constant BLTCPTL  : std_logic_vector(11 downto 0) := x"04a";  
    constant BLTDPTH  : std_logic_vector(11 downto 0) := x"054";  
    constant BLTDPTL  : std_logic_vector(11 downto 0) := x"056";  
                 
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

procedure write_reg(
  constant addr     : in  std_logic_vector(11 downto 0);
  constant value    : in  std_logic_vector(15 downto 0)
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
  
  if clk7_en = '1' then
    aen        <= '1';
    hwr        <= '1';
    lwr        <= '1';
    address_in <= addr(8 downto 0);
    cpu_data_in    <= value;
  end if;

  wait until rising_edge(clk);
  wait until clk7_en = '1';
  
      -- if DMA stole the bus mid-write → abort and retry
    if dbr='1' then
      -- release bus immediately
      aen <= '0'; hwr <= '0'; lwr <= '0';      
      cpu_data_in <= (others => '0');
      address_in  <= (others => '0');
      next write_retry;
    end if;
  
      if clk7_en = '1' then
        aen        <= '0';
        hwr        <= '0';
        lwr        <= '0';
        address_in <= (others => '0');
        cpu_data_in    <= (others => '0');
      end if;
  
      -- write completed successfully
    exit write_retry;
  end loop;  
end procedure;



procedure cpu_read(
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
  
  
  
-------------------------------------------------------------------------
-- Test Procedures  
-------------------------------------------------------------------------  
  
procedure blit_test_simple_copy is
    variable r : std_logic_vector(15 downto 0);
begin
    report "=== BLIT TEST: SIMPLE A -> D COPY ===";

    -- preload RAM
    chipram(ram_index(x"08000", RAM_SIZE)) <= x"CAFE";

    -- setup registers
    cpu_write(BLTCON0, x"09F0");  -- A→D copy
    cpu_write(BLTCON1, x"0000");
    cpu_write(BLTAPTH, x"0000");
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTDPTH, x"0000");
    cpu_write(BLTDPTL, x"9000");
    cpu_write(BLTSIZE, x"0001");

    -- wait for blitter to finish
    wait for 2000 ns;

    -- verify result
    r := chipram(ram_index(x"09000", RAM_SIZE));
    assert r = x"CAFE"
        report "BLIT FAIL: expected CAFE, got " & to_hstring(r)
        severity error;

    report "BLIT PASS: simple copy";
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

    -- Development test
--    cpu_write(DMACON, x"8240");     -- bit9 + bit6 = 0x0200 + 0x0040 = 0x0240   -- To enable DMA bit15 must also be set.  Bit 6 & 9 enable the blitter
--    cpu_read(DMACONR, r);
--    report "DMACONR readback = " & slv_to_hex_any(r);

--    cpu_write(BLTADAT, x"00F0");    -- channel A data
--    cpu_write(BLTBDAT, x"00E0");    -- channle B data    
--    cpu_write(BLTSIZE, x"0001");    -- width=1 (start blit)        
            
-- Test 1 - Basic 1-word blit test
-- Verifies strart, busy, DMA handshake, and completion

--    -- Enable blitter DMA (DMACON bits 9 and 6)
--    cpu_write(DMACON, x"8240");     -- Set: DMAEN + BLTEN
    
--    -- Write source data
--    cpu_write(BLTADAT, x"00F0");
--    cpu_write(BLTBDAT, x"00E0");
    
--    --cpu_write(BLTCON0, x"0002");
--    --cpu_write(BLTCON0, x"0240");
--    cpu_write(BLTCON0, x"0241");
    
--    --wait for 3 * CLK28_PERIOD;
--    -- Trigger a 1-word blit
--    cpu_write(BLTSIZE, x"0001");
--    -- Blitter adrgen - should produce an address    
--    cpu_write(BLTAPTL, x"2000");

-- Minimal TB Sequence to test Blitter

---- --- RESET ---
--cpu_write(DMACON, x"8000");   -- DMACON: set DMAEN (master enable) SET/CLR Flag
--cpu_write(DMACON, x"0241");   -- DMACON: enable blitter DMA (BLTEN)

---- --- BLITTER CONTROL ---
--cpu_write(BLTCON0, x"09F0");   -- BLTCON0: use A + D, minterm = A (0xF0)
--cpu_write(BLTCON1, x"0000");   -- BLTCON1: no line mode, no shifts

---- --- MASKS ---
--cpu_write(BLTAFWM, x"FFFF");   -- BLTAFWM: full mask
--cpu_write(BLTALWM, x"FFFF");   -- BLTALWM: full mask

---- --- POINTERS (A source = $0012000, D dest = $0013000) ---
--cpu_write(BLTAPTH, x"0001");   -- BLTAPTH
--cpu_write(BLTAPTL, x"2000");   -- BLTAPTL

---- Channel B
--cpu_write(BLTBPTH, x"0001");   -- BLTBPTH
--cpu_write(BLTBPTL, x"2100");   -- BLTBPTL

---- Channel C
--cpu_write(BLTCPTH, x"0001");   -- BLTCPTH
--cpu_write(BLTCPTL, x"2200");   -- BLTCPTL

---- Channel D
--cpu_write(BLTDPTH, x"0001");   -- BLTDPTH
--cpu_write(BLTDPTL, x"3000");   -- BLTDPTL

---- --- DATA FOR CHANNEL A (source word) ---
--cpu_write(BLTADAT, x"00F0");   -- BLTADAT = example pattern

---- --- BLIT SIZE (1 word × 1 line) ---
--cpu_write(BLTSIZE, x"0001");   -- BLTSIZE: width=1, height=1

-------------------------------------------------------------------------
-- -- 1. Program A and D pointers via Agnus register map
--cpu_write(BLTAPTH , x"0001");
--cpu_write(BLTAPTL , x"8000");
--cpu_write(BLTDPTH , x"0001");
--cpu_write(BLTDPTL , x"9000");

---- 2. Basic BLTCON0/1 setup (simple A->D copy, no line mode)
--cpu_write(BLTCON0 , x"0FCA");
--cpu_write(BLTCON1 , x"0000");

-- -- 3. Enable DMA: DMAEN + BLTEN + BZERO (DMACON = $096)
--  cpu_write(DMACON  , x"8241");  -- SET: bit15=1, DMAEN, BLTEN, BZERO
 
-- -- 4. Start blitter: BLTSIZE = 1x1
-- cpu_write(BLTSIZE  , x"0001");

-- Test 2 
-- The blitter reads from Channel A pointer
-- The blitter writes to Channel D pointer
-- The minterm logic is correct (A -> D copy)
-- The write-enable (we) pulses at the correct time
-- The data_out from blkitter is the transformed word
-- Agnus routes the write to the correct address
-- TB RAM sees the write. 

-- Preload RAM at the A pointer
-- Don't do this, instead done in the process for loading data_in into RAM.
--chipram(16#08000#) <= x"CAFE";      -- This word is expected to appear in the D pointer
--chipram(16#00400#) <= x"CAFE";      -- This word is expected to appear in the D pointer

---- Enable DMA + Blitter
cpu_write(DMACON, x"8241");     -- DMAEN + BLTEN + BZERO
-- A -> D copy
cpu_write(BLTCON0, x"09F0");    -- use A + D, minterm F0
-- Area mode
cpu_write(BLTCON1, x"0000");
-- Set A pointer = $08000
--cpu_write(BLTAPTH, x"0008");
--cpu_write(BLTAPTL, x"0000");
cpu_write(BLTAPTH, x"0000");
cpu_write(BLTAPTL, x"8000");
-- Set D pointer = $09000
--cpu_write(BLTDPTH, x"0009");
--cpu_write(BLTDPTL, x"0000");
cpu_write(BLTDPTH, x"0000");
cpu_write(BLTDPTL, x"9000");
-- Trigger by setting BLTSIZE
cpu_write(BLTSIZE, x"0001");


--write_reg(DMACON, x"8241");     -- DMAEN + BLTEN + BZERO
---- A -> D copy
--write_reg(BLTCON0, x"09F0");    -- use A + D, minterm F0
---- Area mode
--write_reg(BLTCON1, x"0000");
---- Set A pointer = $08000
--write_reg(BLTAPTH, x"0008");
--write_reg(BLTAPTL, x"0000");
---- Set D pointer = $09000
--write_reg(BLTDPTH, x"0009");
--write_reg(BLTDPTL, x"0000");
---- Trigger by setting BLTSIZE
--write_reg(BLTSIZE, x"0001");









    -- Let it run for some lines
    --wait for 1 ms;
    wait for 2000 ns;

    --assert false report "Simulation finished" severity failure;
  end process;



    --------------------------------------------------------------------
    -- Monitor Copper register writes (Agnus -> custom regs)
    --------------------------------------------------------------------
    monitor : process(clk)
        variable cycle : integer := 0;
    begin              
        if rising_edge(clk)and clk7_en = '1' then
            cycle := cycle + 1;
                                    
            report "[TB: INOUT][CYCLE " & integer'image(cycle) & "]" & "," & 
                "T="                & time_to_str(now) & "," &
                -- Send to DUT    
                "clk7_en="          & clk7_en'image(clk7_en)                        & "," &
                "cck="              & cck'image(cck)                                & "," &
                "reset="            & reset'image(reset)                            & "," &
                "aen="              & aen'image(aen)                                & "," &
                "hwr="              & rd'image(hwr)                                 & "," &
                "lwr="              & rd'image(lwr)                                 & "," &
                "rd="               & rd'image(rd)                                  & "," &                
                "address_in="       & slv_to_hex_any(address_in(8 downto 1))        & "," &
                "data_in="          & slv_to_hex_any(data_in)                       & "," &
                "dma_data_in="      & slv_to_hex_any(dma_data_in)                   & "," &
                "cpu_data_in="      & slv_to_hex_any(cpu_data_in)                   & "," &
                
                -- Receive back from DUT
                "reg_address_out="  & slv_to_hex_any(reg_address_out)               & "," &
                "address_out="      & slv_to_hex_any(address_out)                   & "," &
                "data_out="         & slv_to_hex_any(data_out)                      & "," &                               
                "dbr="              & dbr'image(dbr)                                & "," &
                "dbwe="             & dbwe'image(dbwe)                              & "," &                
                   
--                "hpos_tb="          & integer'image(to_integer(unsigned(hpos_tb)))  & "," &                
                --"data_out="         & slv_to_str(data_out) & "," &
                --"copen="            & copen_tb'image(copen_tb) & "," &
                --"req_cop="          & req_cop_tb'image(req_cop_tb) & "," &
                --"dmacon_tb="        & slv_to_hex_any(dmacon_tb)         & "," &
                --"bus_owner="        & bus_owner'image(bus_owner)                    & "," &
            "";
                       
          end if;    -- Rising_edge    
    end process;

end architecture;
