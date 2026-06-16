-- TB for Agnus, Blitter, and Copper
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.debug_utils_pkg.all;

entity tb_agnus_blitter is
end entity;

architecture sim of tb_agnus_blitter is

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
    --constant RAM_SIZE : integer := 2048;
    --constant RAM_SIZE : integer := 1024;
    --type ram_t is array (0 to 65535) of std_logic_vector(15 downto 0);    
    --type ram_t is array (0 to RAM_SIZE - 1) of std_logic_vector(15 downto 0);   
    
--    constant RAM_BASE : integer := 16#08000#;   -- lowest address you use
--    constant RAM_BASE : integer := 16#04000#;   -- lowest address you use
    constant RAM_BASE : integer := 16#03000#;   -- lowest address you use
    constant RAM_TOP  : integer := 16#0BFFF#;   -- highest address you use
    --constant RAM_TOP  : integer := 16#0AFFF#;   -- highest address you use
    constant RAM_DIVS : integer := 100;
    constant RAM_ADD  : integer := 256;
   
    --constant RAM_SIZE : integer := RAM_TOP - RAM_BASE + 1;
    --constant RAM_SIZE : integer := (RAM_TOP - RAM_BASE + 2) / 2;            -- number of words
    constant RAM_SIZE : integer := ((RAM_TOP - RAM_BASE) / RAM_DIVS) + RAM_ADD;
    
    --type ram_t is array (0 to (RAM_SIZE/2)+1 - 1) of std_logic_vector(15 downto 0); 
    type ram_t is array (0 to RAM_SIZE - 1) of std_logic_vector(15 downto 0); 
    --type ram_t is array ( 0 to RAM_SIZE) of std_logic_vector(15 downto 0); 
     
            
    signal bus_owner : std_logic := '0';  -- '0' = CPU, '1' = DMA
    --signal dmaconr_val : std_logic_vector(15 downto 0);
    
    signal dma_addr_reg : integer := 0;
    signal dma_data_q   : std_logic_vector(15 downto 0) := (others => '0');

    -- Internal helper
    function to_integer_21(s : std_logic_vector(20 downto 1)) return integer is
    begin
        return to_integer(unsigned(s));
    end function;
    
--function ram_index(addr : std_logic_vector) return integer is
--    variable a_byte  : integer;
--    variable a_word  : integer;
--begin
--    a_byte := to_integer(unsigned(addr));      -- 0x00000..0xFFFFF
--    a_word := a_byte / 2;                      -- word address
    
--    if a_byte < 256 then
--        return a_byte;
--    elsif
----    if 
--        a_byte < RAM_BASE or a_byte > RAM_TOP then
--        -- outside window: force to 0 or report
--        report "RAM_INDEX: addr out of range " & slv_to_hex_any(addr);
--        return 0;
--    else
--        return a_word - (RAM_BASE / 2);        -- 0..RAM_SIZE-1
--    end if;
--end function;


    function ram_index (
        --addr : std_logic_vector(20 downto 1)        
        addr : std_logic_vector        
    ) return integer is
        variable a : integer;
        variable b : integer;
    begin
        -- Convert byte address -> word index
        a := to_integer(unsigned(addr));                        
        if a < RAM_BASE then 
            b := a;
        else
            b := ((a - RAM_BASE)/RAM_DIVS) + RAM_ADD;
        end if;
                
        --report "T= " & time_to_str(now) & " addr= " & slv_to_hex_any(addr) & " idx=" & integer'image(b);        
        
        return b;
    end function;
    
    signal chipram : ram_t := (others => (others => '0'));
    


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
    variable cpu_addr_in : std_logic_vector(20 downto 1) := (others => '0');
begin

    if rising_edge(clk) then
        -- Running teh RAM off clk28, while Agnus runs off clk7_en
            if reset = '1' then
                -- Note: Could change this to use a CASE statment driven by a test_run_id for furture "bulk" testing.
                -- Pre-load RAM for blit_test_simple_copy 
                -- NOTE: Pre-load to the RAM address that is different to the pointer address due the the right bit-shifting that AGNUS does
                --       Not really sure how that works in a real Amiga unless the ROM routines take care of it for the programmer.
                
                -- Pre-load RAM for blit_test_minterm_and
                chipram(ram_index(x"04000")) <= x"F0F0";        -- BLTA    0x08000 in Test case, gets bit right shifted in Agnus         
                chipram(ram_index(x"05000")) <= x"0FF0";        -- BLTB    0x0A000 in Test case             
                                                                                                                                                                                 
                --report "Chipram(" & integer'image(ram_index(x"04000")) & ")= " & slv_to_hex_any(chipram(ram_index(x"04000")));
                --report "Chipram(" & integer'image(ram_index(x"05000")) & ")= " & slv_to_hex_any(chipram(ram_index(x"05000")));
            else 
                    
                dma_addr := ram_index(address_out);   -- DMA address (Agnus)  
                cpu_addr := ram_index(address_in(8 downto 1));    -- CPU address        
                --report "RAM dma_addr= " & integer'image(dma_addr);
                --report "RAM cpu_addr= " & integer'image(cpu_addr);
                -- DMA Write
                if dbwe = '1' then                  
                  chipram(dma_addr) <= data_out;                 
                  --report "dma_addr= " & integer'image(dma_addr);
                end if;
                
                -- CPU Write (word)
                if hwr = '1' or lwr = '1' then                
                    chipram(cpu_addr) <= cpu_data_in;             
                end if;
                           
            end if;     -- reset
    end if;             -- clk 28
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
-- DMA Read                       
dma_data_in <= chipram(ram_index(address_out));
data_in <= dma_data_in when dbr  = '1' else cpu_data_in;

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
    constant BLTDDAT : std_logic_vector(11 downto 0) := x"000";         -- 00
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
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    
    -- setup registers
    -- Enable DMA + Blitter
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO        
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
    --r := chipram(ram_index(x"09000", RAM_SIZE));
    r := chipram(ram_index(x"09000"));
    assert r = x"CAFE"
        report "BLIT FAIL: expected CAFE, got " & slv_to_str(r)
        severity error;

    report "BLIT PASS: simple copy";
end procedure blit_test_simple_copy;  
  
procedure blit_test_minterm_and is
begin
    report "=== BLIT TEST: A AND B ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO      
   
    -- Enabling Bits for BLTCON0
    -- Bits 15-12 ASH (A-shift)
    -- bit 11: Use A
    -- bit 10: Use B
    -- bit 9:  Use C        -- Not actually used in MiSTer Agnus!!!
    -- bit 8:  Use D        -- D is the output
    -- bits 7-0: minterm (logic function)
    --
    -- minterm function     Value for lower Bits
    -- A AND B              C0
    -- A OR  B              54
    -- A XOR B              14
    -- A XNOR B             41
    -- A NAND B             15
    -- A NOR B              01
    -- A                    50
    -- B                    44
    -- NOT A                05
    -- NOT B                11
         
    -- Instruct Blitter to do something   
    cpu_write(BLTCON0, x"0DC0");  -- USEA, USEB, USED, minterm = A AND B           
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"00F0"    
        report "BLIT FAIL: A AND B wrong"
        severity error;

    report "BLIT PASS: A AND B";
end procedure blit_test_minterm_and;

procedure blit_test_minterm_or is
begin
    report "=== BLIT TEST: A OR B ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- BVLTCON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                            
    cpu_write(BLTCON0, x"0D54");  -- USEA, USEB, USED, minterm = A OR B           
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"FFF0"    
        report "BLIT FAIL: A OR B wrong"
        severity error;

    report "BLIT PASS: A OR B";
end procedure blit_test_minterm_or;

procedure blit_test_minterm_xor is
begin
    report "=== BLIT TEST: A XOR B ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D14");  -- USEA, USEB, USED, minterm = A XOR B           
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"FF00"    
        report "BLIT FAIL: A XOR B wrong"
        severity error;

    report "BLIT PASS: A XOR B";
end procedure blit_test_minterm_xor;

procedure blit_test_minterm_nand is
begin
    report "=== BLIT TEST: A NAND B ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D15");  -- USEA, USEB, USED, minterm = A NAND B           
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"FF0F"    
        report "BLIT FAIL: A NAND B wrong"
        severity error;

    report "BLIT PASS: A NAND B";
end procedure blit_test_minterm_nand;

procedure blit_test_minterm_nor is
begin
    report "=== BLIT TEST: A NOR B ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D01");  -- USEA, USEB, USED, minterm = A NOR B           
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"000F"    
        report "BLIT FAIL: A NOR B wrong"
        severity error;

    report "BLIT PASS: A NOR B";
end procedure blit_test_minterm_nor;

procedure blit_test_minterm_xnor is
begin
    report "=== BLIT TEST: A XNOR B ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D41");  -- USEA, USEB, USED, minterm = A XNOR B  --- NOTE this code is not correct!!!           
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"00FF"    
        report "BLIT FAIL: A XNOR B wrong"
        severity error;

    report "BLIT PASS: A XNOR B";
end procedure blit_test_minterm_xnor;

procedure blit_test_minterm_a is
begin
    report "=== BLIT TEST: Just A ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D50");  -- USEA, USEB, USED, minterm = Just A           
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"F0F0"    
        report "BLIT FAIL: JUST A  wrong"
        severity error;

    report "BLIT PASS: JUST A";
end procedure blit_test_minterm_a;

procedure blit_test_minterm_b is
begin
    report "=== BLIT TEST: Just B ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D44");  -- USEA, USEB, USED, minterm = Just B           
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"0FF0"    
        report "BLIT FAIL: JUST B  wrong"
        severity error;

    report "BLIT PASS: JUST B";
end procedure blit_test_minterm_b;

procedure blit_test_minterm_not_a is
begin
    report "=== BLIT TEST: NOT A ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D05");  -- USEA, USEB, USED, minterm = NOT A          
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"0F0F"    
        report "BLIT FAIL: NOT A  wrong"
        severity error;

    report "BLIT PASS: NOT A";
end procedure blit_test_minterm_not_a;

procedure blit_test_minterm_not_b is
begin
    report "=== BLIT TEST: NOT B ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D11");  -- USEA, USEB, USED, minterm = NOT B          
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"F00F"    
        report "BLIT FAIL: NOT B  wrong"
        severity error;

    report "BLIT PASS: NOT B";
end procedure blit_test_minterm_not_b;

procedure blit_test_minterm_con0 is
begin
    report "=== BLIT TEST: CONSTANT 0 ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0D00");  -- USEA, USEB, USED, minterm = NOT B          
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"0000"    
        report "BLIT FAIL: CONSTANT 0  wrong"
        severity error;

    report "BLIT PASS: NOT B";
end procedure blit_test_minterm_con0;

procedure blit_test_minterm_con1 is
begin
    report "=== BLIT TEST: CONSTANT 1 ===";

    -- preload RAM
    -- NB: Pre loading of ram needs to be done in the RAM  process, above.
    -- Check that before running the test.

    -- DMACON, BLTCON0, and BLTCON1 are important registers for Agnus, essentially instructs it what function/s to perform.       
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO                  
    cpu_write(BLTCON0, x"0DFF");  -- USEA, USEB, USED, minterm = NOT B          
    cpu_write(BLTCON1, x"0000");
    
    -- Set up the address pointers for the Blitter channels
    -- Note: The effective address is half of the pointer value due to the right bit shift that occurs in Agnus 
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTBPTL, x"A000");
    cpu_write(BLTDPTL, x"9000");

    -- Setting BLTSIZE set eveything in motion.  Therefore, always set this last.
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;
  
    assert chipram(ram_index(x"04800")) = x"FFFF"    
        report "BLIT FAIL: CONSTANT 1 wrong"
        severity error;

    report "BLIT PASS: NOT B";
end procedure blit_test_minterm_con1;

  
procedure blit_test_fill_mode is
begin
    report "=== BLIT TEST: FILL MODE ===";

    --chipram(ram_index(x"08000", RAM_SIZE)) <= x"0001";
    --preload_ram(x"08000", x"0001");
    
    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO      
    cpu_write(BLTCON0, x"0BF0"); -- use A, fill enable bits
    cpu_write(BLTCON1, x"0002"); -- IFE=1
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTDPTL, x"9000");
    cpu_write(BLTSIZE, x"0001");

    wait for 2000 ns;

    --assert chipram(ram_index(x"09000", RAM_SIZE)) = x"FFFF"
    assert chipram(ram_index(x"04800")) = x"FFFF"
        report "BLIT FAIL: fill mode wrong"
        severity error;

    report "BLIT PASS: fill mode";
end procedure blit_test_fill_mode;

procedure blit_test_multiword is
begin
    report "=== BLIT TEST: MULTIWORD ===";

    --chipram(ram_index(x"08000", RAM_SIZE)) <= x"1111";
    --chipram(ram_index(x"08002", RAM_SIZE)) <= x"2222";
    --chipram(ram_index(x"08004", RAM_SIZE)) <= x"3333";
    --preload_ram(x"08000", x"1111");
    --preload_ram(x"08002", x"2222");
    --preload_ram(x"08004", x"3333");

    cpu_write(DMACON,  x"8241");  -- DMAEN + BLTEN + BZERO      
    cpu_write(BLTCON0, x"09F0");
    cpu_write(BLTAPTL, x"8000");
    cpu_write(BLTDPTL, x"9000");
    cpu_write(BLTSIZE, x"0003"); -- 3 words

    wait for 5000 ns;

    --assert chipram(ram_index(x"09000", RAM_SIZE)) = x"1111";
    --assert chipram(ram_index(x"09002", RAM_SIZE)) = x"2222";
    --assert chipram(ram_index(x"09004", RAM_SIZE)) = x"3333";
    assert chipram(ram_index(x"04800")) = x"1111";
    assert chipram(ram_index(x"04802")) = x"2222";
    assert chipram(ram_index(x"04804")) = x"3333";    

    report "BLIT PASS: multiword";
end procedure blit_test_multiword;   
  
begin
  
    
    -- hold reset for a bit
    reset <= '1';
    --wait for 2 us;
    wait for 200 ns;
    reset <= '0';

    -- small delay after reset
    --wait for 2 us;
    wait for 200 ns;

-- Run Tests
--blit_test_simple_copy;

-- Testing possible comninations for minterm
--blit_test_minterm_and;          -- pass
--blit_test_minterm_or;           -- pass
--blit_test_minterm_xor;          -- pass
--blit_test_minterm_nand;         -- pass
--blit_test_minterm_nor;          -- pass
--blit_test_minterm_xnor;         -- pass
--blit_test_minterm_a;            -- pass
--blit_test_minterm_b;            -- pass
--blit_test_minterm_not_a;        -- pass        
--blit_test_minterm_not_b;        -- pass     
--blit_test_minterm_con0;         -- pass
--blit_test_minterm_con1;         -- pass         



blit_test_fill_mode;
--blit_test_multiword;



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
                "chipram(" & integer'image(ram_index(address_in)) & ") = " & slv_to_hex_any(chipram(ram_index(address_in)))  & "," &
                "data_in="          & slv_to_hex_any(data_in)                       & "," &
                --"data_in="          & slv_to_str(data_in)                       & "," &
                "dma_data_in="      & slv_to_hex_any(dma_data_in)                   & "," &
                --"dma_data_in="      & slv_to_str(dma_data_in)                   & "," &
                "cpu_data_in="      & slv_to_hex_any(cpu_data_in)                   & "," &
                
                -- Receive back from DUT
                "reg_address_out="  & slv_to_hex_any(reg_address_out)               & "," &
                "address_out="      & slv_to_hex_any(address_out)                   & "," &
                "chipram(" & integer'image(ram_index(address_out)) & ") = " & slv_to_hex_any(chipram(ram_index(address_out)))  & "," &    
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
