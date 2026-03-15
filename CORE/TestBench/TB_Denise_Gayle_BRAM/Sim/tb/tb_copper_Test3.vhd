-- March 2026
-- A more extensive test of Copper than the intial "Hello" test.
-- Same structure as the Hello test.
--
-- Test3: WAIT + SKIP (Conditional Execution)
-- Test goals:
-- Copper fetches a WAIT instruction
-- Copper fetches a SKIP instruction
-- SKIP condition is evaluated correctly
-- If the condition is true, then next MOVE is skipped
-- If the condition is false, the next MOVE is executed
-- Execution resumes normally after the skipped or executed instruction



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.debug_utils_pkg.all;

entity tb_copper_test3 is
end entity;

architecture sim of tb_copper_test3 is

  constant CLK_PERIOD : time := 10 ns;

  signal clk          : std_logic := '0';
  signal clk7_en      : std_logic := '0';
  signal reset        : std_logic := '1';

  signal reqdma       : std_logic;
  signal ackdma       : std_logic := '0';
  signal enadma       : std_logic := '0';       -- start with DMA disabled
  
  signal sof          : std_logic := '0';       -- Start of Frame

  signal vpos         : std_logic_vector(7 downto 0) := (others => '0');
  signal hpos         : std_logic_vector(8 downto 0) := (others => '0');

  signal data_in      : std_logic_vector(15 downto 0) := (others => '0');
  signal reg_address_in  : std_logic_vector(8 downto 1) := (others => '0');
  signal reg_address_out : std_logic_vector(8 downto 1);
  signal address_out     : std_logic_vector(20 downto 1) := (others => '0');

  -- simple fake chip RAM
  type ram_t is array (0 to 255) of std_logic_vector(15 downto 0);
  signal chipram : ram_t := (others => (others => '0'));
  
  
  -- Denise color RAM model (32 entries for OCS/ECS)
  type color_ram_t is array (0 to 31) of std_logic_vector(15 downto 0);
  signal color_ram : color_ram_t := (others => (others => '0'));
  

  -- Copper registers
  constant COP1LCH  : std_logic_vector(8 downto 1) := x"80";
  constant COP1LCL  : std_logic_vector(8 downto 1) := x"82";
  constant COPJMP1  : std_logic_vector(8 downto 1) := x"88";
  constant COPINS   : std_logic_vector(8 downto 1) := x"8C";

  -- COLOR registers
  constant COLOR00  : std_logic_vector(8 downto 1) := x"18";
  constant COLOR01  : std_logic_vector(8 downto 1) := x"19";
  constant COLOR02  : std_logic_vector(8 downto 1) := x"1A";
  constant COLOR03  : std_logic_vector(8 downto 1) := x"1B";

  constant NULL_REG : std_logic_vector(8 downto 1) := (others => '1');
  constant ZERO_REG : std_logic_vector(8 downto 1) := (others => '0');
  
  -- CPU-Side bus
  signal cpu_reg_addr : std_logic_vector(8 downto 1) := (others => '0');
  signal cpu_data_in  : std_logic_vector(15 downto 0) := (others => '0');
  
  -- DMA-side bus
  signal dma_reg_addr : std_logic_vector(8 downto 1) := (others => '0');
  signal dma_data_in  : std_logic_vector(15 downto 0) := (others => '0');
  
  signal copper_state_tb : std_logic_vector(2 downto 0) := (others => '0');
  signal dma_req_tb      : std_logic := '0';
  signal enable_tb       : std_logic := '0';


begin

  reg_address_in <= dma_reg_addr when ackdma = '1' else cpu_reg_addr;
  data_in        <= dma_data_in  when ackdma = '1' else cpu_data_in;

  --------------------------------------------------------------------
  -- 28 MHz clock
  --------------------------------------------------------------------
  clk <= not clk after CLK_PERIOD/2;

  --------------------------------------------------------------------
  -- 7 MHz enable
  --------------------------------------------------------------------
  process(clk)
    variable div : integer := 0;
  begin
    if rising_edge(clk) then
      div := div + 1;
      if div = 4 then
        div := 0;
        clk7_en <= '1';
      else
        clk7_en <= '0';
      end if;
    end if;
  end process;

  --------------------------------------------------------------------
  -- Simple hpos/vpos (no PAL timing needed)
  --------------------------------------------------------------------
  process(clk)
  begin
    if rising_edge(clk) then
      if clk7_en = '1' then
        hpos <= std_logic_vector(unsigned(hpos) + 1);
        if hpos = "111111111" then
          vpos <= std_logic_vector(unsigned(vpos) + 1);
        end if;
      end if;
    end if;
  end process;


p_color_capture : process(clk)
  variable idx : integer;
begin
  if rising_edge(clk) then
    if clk7_en = '1' then
      -- Detect Copper MOVE to COLORxx
      if reg_address_out >= COLOR00 and reg_address_out <= COLOR03 then
        --idx := to_integer(unsigned(reg_address_out(4 downto 1)));  -- low nibble
        idx := to_integer(unsigned(address_out(4 downto 1)));  -- low nibble
        color_ram(idx) <= data_in;
      end if;
    end if;
  end if;
end process;


  --------------------------------------------------------------------
  -- DUT
  --------------------------------------------------------------------
  uut: entity work.agnus_copper
    port map (
       clk             => clk
      ,clk7_en         => clk7_en
      ,reset           => reset
      ,ecs             => '1'
      ,reqdma          => reqdma
      ,ackdma          => ackdma
      ,enadma          => enadma
      ,sof             => sof
      ,blit_busy       => '0'
      ,vpos            => vpos
      ,hpos            => hpos
      ,data_in         => data_in
      ,reg_address_in  => reg_address_in
      ,reg_address_out => reg_address_out
      ,address_out     => address_out
      
      ,copper_state_tb => copper_state_tb
      ,dma_req_tb      => dma_req_tb
      ,enable_tb       => enable_tb      
    );

  --------------------------------------------------------------------
  -- DMA emulation (correct)
  --------------------------------------------------------------------
  process(clk)
    variable addr : integer;
  begin
    if rising_edge(clk) then
      if reqdma = '1' then
      --if enadma = '1' and reqdma = '1' then
        ackdma <= '1';
        dma_reg_addr <= COPINS;

        --addr := to_integer(unsigned(address_out(20 downto 2)));
        addr := to_integer(unsigned(address_out(20 downto 1)));
        dma_data_in <= chipram(addr);

      else
        ackdma <= '0';
        dma_reg_addr <= (others => '0');
        dma_data_in <= (others => '0');
      end if;

    end if;
  end process;


--------------------------------------------------------
  -- Stimulus
  --------------------------------------------------------------------
stim: process
  variable base : integer := 0;
begin
  --------------------------------------------------------------------
  -- Program Copper list
  --------------------------------------------------------------------
    -- WAIT until vpos=5, hpos=10
    chipram(base + 0) <= x"050A";
    chipram(base + 1) <= x"FFFF";
    
    -- SKIP if vpos>=0, hpos>=0  (always true)
    chipram(base + 2) <= x"0000";
    chipram(base + 3) <= x"FFFF";
    
    -- MOVE COLOR00, $AAAA   (should be skipped)
    chipram(base + 4) <= x"AAAA";
    chipram(base + 5) <= x"0018";
    
    -- MOVE COLOR01, $BBBB   (should execute)
    chipram(base + 6) <= x"BBBB";
    chipram(base + 7) <= x"0019";

  --------------------------------------------------------------------
  -- Reset
  --------------------------------------------------------------------
  enadma <= '0';
  reset  <= '1';
  wait for 200 ns;
  reset  <= '0';

  --------------------------------------------------------------------
  -- Program COP1LC
  --------------------------------------------------------------------
  cpu_reg_addr <= COP1LCH;
  cpu_data_in  <= std_logic_vector(to_unsigned(base, 16));
  wait until rising_edge(clk) and clk7_en = '1';

  cpu_reg_addr <= COP1LCL;
  cpu_data_in  <= std_logic_vector(to_unsigned(base, 16));
  wait until rising_edge(clk) and clk7_en = '1';

  --------------------------------------------------------------------
  -- Jump to list
  --------------------------------------------------------------------
  cpu_reg_addr <= COPJMP1;
  cpu_data_in  <= (others => '0');
  wait until rising_edge(clk) and clk7_en = '1';

  cpu_reg_addr <= (others => '0');
  cpu_data_in  <= (others => '0');

  --------------------------------------------------------------------
  -- Enable DMA
  --------------------------------------------------------------------
  enadma <= '1';
  wait until rising_edge(clk) and clk7_en = '1';

  --------------------------------------------------------------------
  -- Pulse SOF
  --------------------------------------------------------------------
  sof <= '1';
  wait until rising_edge(clk) and clk7_en = '1';
  sof <= '0';

  --------------------------------------------------------------------
  -- Let Copper run
  --------------------------------------------------------------------
  wait for 20 us;

  report "Copper WAIT test completed" severity note;
  wait;
end process;



--check: process(clk)
--  type reg_seq_t is array (0 to 3) of std_logic_vector(8 downto 1);
--  constant expected_regs : reg_seq_t :=
--    (COLOR00, COLOR01, COLOR02, COLOR03);
--  variable idx : integer := 0;
--begin
--  if rising_edge(clk) then
--    if clk7_en = '1' then

--      -- Only treat COLORxx as valid MOVE targets
--      if reg_address_out = COLOR00 or
--         reg_address_out = COLOR01 or
--         reg_address_out = COLOR02 or
--         reg_address_out = COLOR03 then

--        if idx <= expected_regs'high then
--          assert reg_address_out = expected_regs(idx)
--            report "Unexpected MOVE target" severity error;
--          idx := idx + 1;
--        else
--          assert false report "Too many MOVE instructions" severity error;
--        end if;
----        assert color_ram(0) = x"1234" report "COLOR00 mismatch " & slv_to_hex_any(color_ram(0))   severity error;
----        assert color_ram(1) = x"5678" report "COLOR01 mismatch " & slv_to_hex_any(color_ram(1))   severity error;
----        assert color_ram(2) = x"9ABC" report "COLOR02 mismatch " & slv_to_hex_any(color_ram(2))   severity error;
----        assert color_ram(3) = x"FFFF" report "COLOR03 mismatch " & slv_to_hex_any(color_ram(3))   severity error;
--      end if;

--    end if;
--  end if;
--end process;

check: process(clk)
  type reg_seq_t is array (0 to 3) of std_logic_vector(8 downto 1);
  constant expected_regs : reg_seq_t :=
    (COLOR00, COLOR01, COLOR02, COLOR03);

  variable idx : integer := 0;
  constant LAST_VALID_ADDR : integer := 5;  -- for WAIT test: 0..5 are valid
begin
  if rising_edge(clk) then
    if clk7_en = '1' then

      ----------------------------------------------------------------
      -- 1. Normal MOVE checking (your existing logic)
      ----------------------------------------------------------------
      if reg_address_out = COLOR00 or
         reg_address_out = COLOR01 or
         reg_address_out = COLOR02 or
         reg_address_out = COLOR03 then

        if idx <= expected_regs'high then
          assert reg_address_out = expected_regs(idx)
            report "Unexpected MOVE target" severity error;
          idx := idx + 1;
        else
          assert false report "Too many MOVE instructions" severity error;
        end if;
      end if;

      ----------------------------------------------------------------
      -- 2. NEW: No MOVE allowed after list end
      ----------------------------------------------------------------
      if to_integer(unsigned(address_out(20 downto 2))) > LAST_VALID_ADDR then
        assert not (reg_address_out = COLOR00 or
                    reg_address_out = COLOR01 or
                    reg_address_out = COLOR02 or
                    reg_address_out = COLOR03)
          report "Unexpected MOVE after list end" severity error;
      end if;

    end if;
  end if;
end process;

check_wait: process(clk)
  variable wait_satisfied : boolean := false;
begin
  if rising_edge(clk) then
    if clk7_en = '1' then

      -- Detect when WAIT condition is satisfied
      if unsigned(vpos) >= 5 and unsigned(hpos) >= 10 then
        wait_satisfied := true;
      end if;

      -- Detect COLOR writes
      if reg_address_out = COLOR00 then
        assert wait_satisfied
          report "COLOR00 written BEFORE WAIT satisfied!" severity error;
      end if;

      if reg_address_out = COLOR01 then
        assert wait_satisfied
          report "COLOR01 written BEFORE WAIT satisfied!" severity error;
      end if;

    end if;
  end if;
end process;


--rpt : process(clk)
--    variable cycle : integer := 0;
--begin
--    if rising_edge(clk) then
--      --if clk7_en = '1' then
--        cycle := cycle + 1;
        
--        report "[CYCLE "  & integer'image(cycle) & " Time=" & time_to_str(now) & "]"  & "," &
--        " TB SIGNALS: "                                                           & "," &
--                            "reqdma="         & sl_to_str(reqdma)                 & "," &
----                            "chipram(" & integer(to_integer(unsigned(address_out(20 downto 2)))) & ")=" &
----                            slv_to_hex_any(to_integer(unsigned(address_out(20 downto 2))))  & "," & 
--                            "address_out="    & slv_to_hex_any(address_out)       & "," &
--                            "reg_address_in=" & slv_to_hex_any(reg_address_in)    & "," &
--                            "dma_reg_addr="   & slv_to_hex_any(dma_reg_addr)      & "," &
--                            "cpu_reg_addr="   & slv_to_hex_any(cpu_reg_addr)      & "," &
--                            "data_in="        & slv_to_hex_any(data_in)           & "," &
--                            "dma_data_in="    & slv_to_hex_any(dma_data_in)       & "," &
--                            "cpu_data_in="    & slv_to_hex_any(cpu_data_in)       & "," &
--                            "";
--      --end if;
--    end if;
--end process;

end architecture;