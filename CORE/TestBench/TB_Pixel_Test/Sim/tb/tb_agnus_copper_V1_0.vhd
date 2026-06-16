library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.debug_utils_pkg.all;

entity tb_agnus_copper_V1_0 is
end entity;

architecture sim of tb_agnus_copper_V1_0 is

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
    signal address_in    : std_logic_vector(8 downto 1) := (others => '0');
    signal data_in       : std_logic_vector(15 downto 0) := (others => '0');
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
    signal hpos_tb       : std_logic_vector(8 downto 0);
    signal vpos_tb       : std_logic_vector(10 downto 0);

    signal bus_owner : std_logic := '0';  -- '0' = CPU, '1' = DMA


    -- Simple chip RAM model (64K words for now)
    type ram_t is array (0 to 65535) of std_logic_vector(15 downto 0);
    signal chipram : ram_t := (others => (others => '0'));

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
--    process
--    begin
--        reset <= '1';
--        wait for 500 ns;
--        reset <= '0';
--        wait;
--    end process;
    reset_n <= not reset;


process(clk)
begin
  if rising_edge(clk) then
    if dbr = '1' then
      bus_owner <= '1';  -- DMA owns bus
    else
      bus_owner <= '0';  -- CPU owns bus
    end if;
  end if;
end process;



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
            ,address_in      => address_in
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
        );

   --------------------------------------------------------------------
  -- Simple chip RAM model for DMA (Copper list, etc.)
  -- When Agnus owns the bus (dbr='1'):
  --   - if dbwe='1'  -> write data_out to RAM
  --   - if dbwe='0'  -> drive data_in from RAM
  -- When CPU owns the bus (dbr='0'):
  --   - data_in is driven by CPU driver process
  --------------------------------------------------------------------
ram_proc : process(clk)
  variable addr : integer;
begin
  if rising_edge(clk) then

    if bus_owner='1' then
      addr := to_integer_21(address_out);

      if addr >= 0 and addr <= chipram'high then
        if dbwe='1' then
          chipram(addr) <= data_out;      -- DMA write
        else
          data_in <= chipram(addr);       -- DMA read
        end if;
      else
        data_in <= (others => '0');
      end if;

    else
      -- CPU owns bus → RAM must release it
      data_in <= (others => '0');
    end if;

  end if;
end process;

    
--  ram_proc : process(clk)
--    variable addr : integer;
--  begin
--    if rising_edge(clk) then
--      if dbr = '1' then
--        addr := to_integer_21(address_out);
--        if addr >= 0 and addr <= chipram'high then
--          if dbwe = '1' then
--            chipram(addr) <= data_out;
--          else
--            data_in <= chipram(addr);
--          end if;
--        else
--          data_in <= (others => '0');
--        end if;
--      end if;
--    end if;
--  end process;
--  ram_proc : process(clk)
--    variable addr : integer;
--  begin
--    if rising_edge(clk) then
--      if dbr = '1' then
--        if dbwe='1' then
--          chipram(addr) <= data_out;
--        else
--          data_in <= chipram(addr);
--        end if;
--      else
--        data_in <= (others => '0');   -- <-- release bus
--      end if;
--    end if;
--  end process;
  --------------------------------------------------------------------
  -- Preload a tiny Copper list into chip RAM
  -- Example at address $0100 (word address):
  --   0100: WAIT  vpos=0x0010, hpos=0x0010
  --   0102: MOVE  COLOR00, $0F00
  --   0104: MOVE  COLOR01, $00F0
  --   0106: MOVE  BPL1DAT, $FFFF
  --   0108: END   (MOVE to COPJMP1 or illegal -> stop)
  --------------------------------------------------------------------
  init_proc : process
  begin
    -- WAIT  $0010,$0010
    chipram(16#0100#) <= x"0010";  -- VP,HP
    --chipram(16#0101#) <= x"0010";
    chipram(16#0101#) <= x"001F";

    -- MOVE COLOR00,$0F00  (COLOR00 = $0180 on OCS/ECS)
    chipram(16#0102#) <= x"0180";  -- COLOR00 address
    chipram(16#0103#) <= x"0F00";  -- red
    
    -- MOVE COLOR01,$00F0
    chipram(16#0104#) <= x"0182";  -- COLOR01 address
    chipram(16#0105#) <= x"00F0";  -- green
    
    -- MOVE BPL1DAT
    chipram(16#0106#) <= x"00E0";   -- BPL1DAT address
    chipram(16#0107#) <= x"FFFF";   -- pattern
    
    -- END: simple NOP/illegal (Copper will stop)
    chipram(16#0108#) <= x"FFFF";
    chipram(16#0109#) <= x"FFFE";

    wait;
  end process;
  

  --------------------------------------------------------------------
  -- Stimulus: reset, enable DMA, set Copper list pointer, run
  --------------------------------------------------------------------
  stim_proc : process
    constant DMACON  : std_logic_vector(8 downto 1) := x"96"; -- 0x096
    constant COP1LCH : std_logic_vector(8 downto 1) := x"88"; -- 0x088
    constant COP1LCL : std_logic_vector(8 downto 1) := x"8A"; -- 0x08A
    
    --------------------------------------------------------------------
    -- Simple CPU write helper (blocking)
    --------------------------------------------------------------------
      procedure cpu_write(
        constant reg_addr : in std_logic_vector(8 downto 1);
        constant value    : in std_logic_vector(15 downto 0)
      ) is
      begin
       write_retry : loop
    -- wait for CPU slot
    wait until rising_edge(clk);
    while clk7_en='0' loop
      wait until rising_edge(clk);
    end loop;

    -- wait until DMA releases bus
    while dbr='1' loop
      wait until rising_edge(clk);
    end loop;

    -- begin write
    aen       <= '1';
    rd        <= '0';
    hwr       <= '1';
    lwr       <= '1';
    address_in<= reg_addr;
    data_in   <= value;

    -- wait one cycle
    wait until rising_edge(clk);

    -- if DMA stole the bus mid-write → abort and retry
    if dbr='1' then
      -- release bus immediately
      aen     <= '0';
      hwr     <= '0';
      lwr     <= '0';
      data_in <= (others => '0');
      next write_retry;
    end if;

    -- write completed successfully
    exit write_retry;

  end loop;

      -- release bus
      aen     <= '0';
      hwr     <= '0';
      lwr     <= '0';
      data_in <= (others => '0');
      end procedure;
  
  begin
    -- hold reset for a bit
    reset <= '1';
    --wait for 2 us;
    wait for 200 ns;
    reset <= '0';

    -- small delay after reset
    wait for 2 us;

    -- Set Copper list pointer to $0100 (word address)
    cpu_write(COP1LCH, x"0000");  -- high 5 bits of 21-bit address
    cpu_write(COP1LCL, x"0100");  -- low 16 bits

    -- Enable DMA + Copper (DMACON: set bits via bit15=1)
    -- Example: master + Copper + bitplane (you can tweak)
    cpu_write(DMACON, x"83A0");   -- adjust to your exact bit layout

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
        cycle := cycle + 1;
        
        if rising_edge(clk) then
        
        assert not (bus_owner = '0' and dbr = '1')
            report "ERROR: CPU driving bus while DMA owns it!"
            severity failure;
        
        
            report "[TB][CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," &
                "bus_owner="        & bus_owner'image(bus_owner)                    & "," &
                "dbr="              & dbr'image(dbr)                                & "," &
                "dbwe="             & dbwe'image(dbwe)                              & "," &
                
                "aen="              & aen'image(aen)                                & "," &
                "rd="               & rd'image(rd)                                  & "," &
                "hwr="              & rd'image(hwr)                                 & "," &
                "lwr="              & rd'image(lwr)                                 & "," &
                "address_in="       & integer'image(to_integer(unsigned(address_in))) & "," &
                --"data_in="          & slv_to_hex_any(data_in) & "," &
                "data_in="          & slv_to_str(data_in) & "," &
                "reg_address_out="  & integer'image(to_integer(unsigned(reg_address_out))) & "," &
                "data_out="         & slv_to_hex_any(data_out) & "," &
            "";
                
        
            if dbr = '1' and dbwe = '1' then
                report "DMA WRITE: reg=" &
                       integer'image(to_integer(unsigned(reg_address_out))) & "," &
                       "data_out=" & slv_to_hex_any(data_out) & "," &
                       "hpos_tb=" & integer'image(to_integer(unsigned(hpos_tb))) & "," &
                       "vpos_tb=" & integer'image(to_integer(unsigned(vpos_tb))) & "," &
                       "";
            end if;
        end if;
    end process;

end architecture;
