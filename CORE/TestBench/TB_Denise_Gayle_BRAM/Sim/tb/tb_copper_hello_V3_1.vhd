library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_copper_hello_V3_1 is
end entity;

architecture sim of tb_copper_hello_V3_1 is

  constant CLK_PERIOD : time := 10 ns;

  signal clk          : std_logic := '0';
  signal clk7_en      : std_logic := '0';
  signal reset        : std_logic := '1';
  signal ecs          : std_logic := '1';

  signal reqdma       : std_logic;
  signal ackdma       : std_logic := '0';
  signal enadma       : std_logic := '1';

  signal sof          : std_logic := '0';
  signal blit_busy    : std_logic := '0';
  signal vpos         : std_logic_vector(7 downto 0) := (others => '0');
  signal hpos         : std_logic_vector(8 downto 0) := (others => '0');

  signal data_in      : std_logic_vector(15 downto 0) := (others => '0');
  signal reg_address_in  : std_logic_vector(8 downto 1) := (others => '0');
  signal reg_address_out : std_logic_vector(8 downto 1);
  signal address_out     : std_logic_vector(20 downto 1);

  -- simple fake chip RAM for copper list
  type ram_t is array (0 to 255) of std_logic_vector(15 downto 0);
  signal chipram : ram_t := (others => (others => '0'));

  -- constants (match your Verilog)
  constant COP1LCH  : std_logic_vector(8 downto 1) := x"80";
  constant COP1LCL  : std_logic_vector(8 downto 1) := x"82";
  constant COPJMP1  : std_logic_vector(8 downto 1) := x"88";
  constant COPINS   : std_logic_vector(8 downto 1) := x"8C";

  -- example target registers (COLOR00..COLOR03)
  constant COLOR00  : std_logic_vector(8 downto 1) := x"18"; -- 0x180
  constant COLOR01  : std_logic_vector(8 downto 1) := x"19"; -- 0x182
  constant COLOR02  : std_logic_vector(8 downto 1) := x"1A"; -- 0x184
  constant COLOR03  : std_logic_vector(8 downto 1) := x"1B"; -- 0x186
  
  constant NULL_REG : std_logic_vector(8 downto 1) := (others => '1');

  signal clk7_div   : integer := 0;
  constant HPOS_MAX : integer := 455;  -- PAL lores line length
  constant VPOS_MAX : integer := 311;  -- PAL frame height
  
  signal copper_state_tb : std_logic_vector(2 downto 0);
  signal dma_req_tb      : std_logic;
  signal enable_tb       : std_logic;

begin

--    ackdma <= '0';
--    enadma <= '1';


  -- clock + clk7_en
  clk <= not clk after CLK_PERIOD/2;

--------------------------------------------------------------------
-- 28 MHz clock already generated as "clk"
-- Now generate clk7_en, hpos, vpos, sof exactly like Agnus expects
--------------------------------------------------------------------

-- 7 MHz enable (toggles every 4 master clocks)


process(clk)
begin
  if rising_edge(clk) then
    if clk7_div = 3 then
      clk7_div <= 0;
      clk7_en  <= '1';
    else
      clk7_div <= clk7_div + 1;
      clk7_en  <= '0';
    end if;
  end if;
end process;

--------------------------------------------------------------------
-- Horizontal and vertical beam counters
-- These match the Minimig/Agnus timing model closely enough for Copper
--------------------------------------------------------------------



process(clk)
begin
  if rising_edge(clk) then
    if clk7_en = '1' then

      -- increment hpos
      if unsigned(hpos) = HPOS_MAX then
        hpos <= (others => '0');

        -- increment vpos
        if unsigned(vpos) = VPOS_MAX then
          vpos <= (others => '0');
          sof  <= '1';   -- start of frame pulse
        else
          vpos <= std_logic_vector(unsigned(vpos) + 1);
          sof  <= '0';
        end if;

      else
        hpos <= std_logic_vector(unsigned(hpos) + 1);
        sof  <= '0';
      end if;

    end if;
  end if;
end process;


  -- DUT
  uut: entity work.agnus_copper
    port map (
       clk             => clk
      ,clk7_en         => clk7_en
      ,reset           => reset
      ,ecs             => ecs
      ,reqdma          => reqdma
      ,ackdma          => ackdma
      ,enadma          => enadma
      ,sof             => sof
      ,blit_busy       => blit_busy
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

-- Simple Agnus-like DMA for Copper: when it requests, we:
-- 1) assert ackdma
-- 2) present COPINS on reg_address_in
-- 3) drive data_in from chipram[address_out]
--process(clk)
--  variable addr : integer;
--begin
--  if rising_edge(clk) then
--    if clk7_en = '1' then

--      if reqdma = '1' and enadma = '1' then
--        ackdma        <= '1';
--        reg_address_in <= COPINS;

--        addr := to_integer(unsigned(address_out(8 downto 1)));
--        data_in <= chipram(addr);

--      else
--        ackdma        <= '0';
--        reg_address_in <= (others => '0');
--        data_in        <= (others => '0');
--      end if;

--    end if;
--  end if;
--end process;

process (clk)
    variable addr : integer;
begin
if rising_edge(clk) then
    if reqdma = '1' then
        ackdma <= '1';
        reg_address_in <= COPINS;
        addr := to_integer(unsigned(address_out(8 downto 1)));
        data_in <= chipram(addr);
    else
        ackdma <= '0';
        reg_address_in <= (others => '0');
        data_in <= (others => '0');
    end if;
end if;

end process;




  -- stimulus
  stim: process
    variable base : integer := 16#20#; -- arbitrary chip address for COP1 list
  begin
    -- init RAM with a simple list:
    -- 0: MOVE #$1234, COLOR00
    -- 2: MOVE #$5678, COLOR01
    -- 4: MOVE #$9ABC, COLOR02
    -- 6: MOVE #$FFFF, COLOR03

    chipram(base + 0) <= x"1234";  -- IR1
    chipram(base + 1) <= x"0180";  -- IR2: COLOR00
    chipram(base + 2) <= x"5678";
    chipram(base + 3) <= x"0182";  -- COLOR01
    chipram(base + 4) <= x"9ABC";
    chipram(base + 5) <= x"0184";  -- COLOR02
    chipram(base + 6) <= x"FFFF";
    chipram(base + 7) <= x"0186";  -- COLOR03

    -- reset
    reset <= '1';
    wait for 100 ns;
    reset <= '0';

    -- program COP1LC to point at 'base'
    -- high word
    reg_address_in <= COP1LCH;
    data_in        <= (15 downto 5 => '0') & std_logic_vector(to_unsigned(base / 2, 5)); -- rough
    wait until rising_edge(clk) and clk7_en = '1';

    -- low word
    reg_address_in <= COP1LCL;
    data_in        <= std_logic_vector(to_unsigned(base, 16));
    wait until rising_edge(clk) and clk7_en = '1';

    -- trigger COPJMP1 (start Copper)
    reg_address_in <= COPJMP1;
    data_in        <= (others => '0');
    wait until rising_edge(clk) and clk7_en = '1';

-- trigger COPJMP1 (start Copper)
reg_address_in <= COPJMP1;
data_in        <= (others => '0');
wait until rising_edge(clk) and clk7_en = '1';

-- release CPU bus for one cycle
reg_address_in <= (others => '0');
data_in        <= (others => '0');
wait until rising_edge(clk) and clk7_en = '1';

-- now *we* act as Agnus and feed instructions via COPINS

-- MOVE #$1234, COLOR00
reg_address_in <= COPINS;
data_in        <= x"1234";
wait until rising_edge(clk) and clk7_en = '1';

reg_address_in <= COPINS;
data_in        <= x"0180";
wait until rising_edge(clk) and clk7_en = '1';

-- MOVE #$5678, COLOR01
reg_address_in <= COPINS;
data_in        <= x"5678";
wait until rising_edge(clk) and clk7_en = '1';

reg_address_in <= COPINS;
data_in        <= x"0182";
wait until rising_edge(clk) and clk7_en = '1';

-- MOVE #$9ABC, COLOR02
reg_address_in <= COPINS;
data_in        <= x"9ABC";
wait until rising_edge(clk) and clk7_en = '1';

reg_address_in <= COPINS;
data_in        <= x"0184";
wait until rising_edge(clk) and clk7_en = '1';

-- MOVE #$FFFF, COLOR03
reg_address_in <= COPINS;
data_in        <= x"FFFF";
wait until rising_edge(clk) and clk7_en = '1';

reg_address_in <= COPINS;
data_in        <= x"0186";
wait until rising_edge(clk) and clk7_en = '1';

-- release
reg_address_in <= (others => '0');
data_in        <= (others => '0');

wait for 10 us;
report "Copper hello test completed" severity note;
wait;


  end process;

  -- simple checker: watch reg_address_out sequence
  check: process(clk)
    type reg_seq_t is array (0 to 3) of std_logic_vector(8 downto 1);
    constant expected_regs : reg_seq_t :=
      (COLOR00, COLOR01, COLOR02, COLOR03);
    variable idx : integer := 0;
  begin
    if rising_edge(clk) then
      if clk7_en = '1' then
        -- when Copper issues a MOVE, selreg is active internally and reg_address_out != COPINS/FF        
        if reg_address_out /= COPINS and reg_address_out /= NULL_REG then
          assert idx <= 3 report "Too many MOVE instructions" severity error;
          assert reg_address_out = expected_regs(idx)
            report "Unexpected MOVE target" severity error;
          idx := idx + 1;
        end if;
      end if;
    end if;
  end process;

end architecture;