-- April 2026
-- Testbench to test complete Denise module
--
-- Some Notes
-- The clk stobes need to be perfect.  C1 and C3 MUST overlap once in each 28Mhz tick
-- Watch out for the data / registers that is being sent to Denise.  Denise effectivelly right-shifts the bits
-- so the value you send and the value it expects can end up being different.  This caused a lot of problems during testing.
-- Therefore the TB had to be adjusted according to send the correct bits from the registar. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.debug_utils_pkg.all;

entity tb_denise is
end entity;

architecture sim of tb_denise is

    -- Clocking
    signal clk_28mhz  : std_logic := '0';
    --constant CLK28_PERIOD : time := 35 ns;  -- ~28.6 MHz, close enough for TB
    constant CLK28_PERIOD : time := 35.6 ns;  -- ~28.6 MHz, close enough for TB

    signal clk7_en    : std_logic := '0';
    signal clk7n_en   : std_logic := '0';
    signal c1         : std_logic := '0';
    signal c3         : std_logic := '0';
    signal cck        : std_logic := '0';
    signal eclk       : std_logic_vector(9 downto 0) := (others=>'0');
    signal clk_div    : unsigned(1 downto 0) := (others => '0');

    -- Reset
    signal reset      : std_logic := '1';
    signal reset_n    : std_logic := '0';

    -- Denise interface
    signal strhor         : std_logic := '0';
    signal reg_address_in : std_logic_vector(8 downto 1) := (others => '0');
    signal data_in        : std_logic_vector(15 downto 0) := (others => '0');
    signal chip48         : std_logic_vector(47 downto 0) := (others => '0');
    signal data_out       : std_logic_vector(15 downto 0);
    signal blank          : std_logic := '0';
    signal red            : std_logic_vector(7 downto 0);
    signal green          : std_logic_vector(7 downto 0);
    signal blue           : std_logic_vector(7 downto 0);
    signal a1k            : std_logic := '0';
    signal ecs            : std_logic := '0';
    signal aga            : std_logic := '0';
    signal hires          : std_logic;
    signal shres          : std_logic;

    -- Local TB beam counter for strhor generation (Denise-only)
    signal tb_hpos        : unsigned(8 downto 0) := (others => '0');
    signal tb_vpos        : unsigned(10 downto 0) := (others => '0');  -- not used by Denise, but handy
        

    -- Simple state for register write sequencer
type write_state_t is (
     W_RESET
    ,W_DIWSTRT
    ,W_DIWSTOP
    ,W_DIWHIGH
    ,W_BPLCON0
    ,W_COLOR00
    ,W_COLOR01
    ,W_BPL1DAT
    ,W_DONE
);
signal wstate : write_state_t := W_RESET;

signal wr_active : std_logic := '0';
signal wr_addr   : std_logic_vector(8 downto 1)  := (others => '0');
signal wr_data   : std_logic_vector(15 downto 0) := (others => '0');

signal cycle_7 : integer := 0;

begin

    --------------------------------------------------------------------
    -- 28 MHz clock
    --------------------------------------------------------------------
    clk_proc : process
    begin
        clk_28mhz <= '0';
        wait for CLK28_PERIOD/2;
        clk_28mhz <= '1'; 
        wait for CLK28_PERIOD/2;
    end process;

    --------------------------------------------------------------------
    -- clk7_en / c1 / c3 / cck generation (Minimig-style)
    --------------------------------------------------------------------
--clkgen_proc : process(clk_28mhz)
--begin
--  if rising_edge(clk_28mhz) then
--    clk_div <= clk_div + 1;

--    -- 7 MHz enable (same as before)
--    if clk_div = "00" then
--      clk7_en <= '1';
--    else
--      clk7_en <= '0';
--    end if;

--    -- cck (same as before)
--    if clk_div(0) = '0' then
--      cck <= '1';
--    else
--      cck <= '0';
--    end if;

--    -- NEW: stretch c1 and c3 so they overlap at clk_div="10"
--    case clk_div is
--      when "00" =>
--        c1 <= '0';
--        c3 <= '0';
--      when "01" =>
--        c1 <= '1';
--        c3 <= '0';
--      when "10" =>
--        c1 <= '1';
--        c3 <= '1';  -- overlap here
--      when others =>  -- "11"
--        c1 <= '0';
--        c3 <= '1';
--    end case;
--  end if;
--end process;

amg_clk : entity work.amiga_clk
    port map (
        clk_28  => clk_28mhz
       ,reset_n => reset_n
       ,clk7_en => clk7_en
       ,clk7n_en=> clk7n_en
       ,c1      => c1
       ,c3      => c3
       ,cck     => cck
       ,eclk    => eclk       
    );
    
    --------------------------------------------------------------------
    -- Reset sequence
    --------------------------------------------------------------------
    reset_proc : process
    begin
        reset <= '1';
        --wait for 500 ns;
        wait for 200 ns;
        reset <= '0';
        wait;
    end process;
reset_n <= not reset;
    --------------------------------------------------------------------
    -- Local beam counter + strhor generation (Minimig-compatible)
    -- This is *only* for driving Denise in isolation.
    -- hpos increments on clk7_en; strhor asserted at hpos=11 (6*2-1).
    --------------------------------------------------------------------
    beam_proc : process(clk_28mhz)
    constant HPOS_END : unsigned(8 downto 0) := to_unsigned(16#1C3#, 9);    -- 451
    begin
        if rising_edge(clk_28mhz) then
            if reset = '1' then
                tb_hpos <= (others => '0');
                tb_vpos <= (others => '0');
                strhor  <= '0';
            elsif clk7_en = '1' then
                -- Horizontal position
                if tb_hpos = HPOS_END then
                    tb_hpos <= (others => '0');
                    tb_vpos <= tb_vpos + 1;
                else
                    tb_hpos <= tb_hpos + 1;
                end if;

                -- Minimig-style strhor for Denise
                -- strhor at hpos = 11 (minimig)               
                if tb_hpos = to_unsigned(6*2-1, tb_hpos'length) then  -- 11
                    strhor <= '1';
                else
                    strhor <= '0';
                end if;                
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    -- Simple chip48 pattern generator
    -- Just toggles bitplanes so we can see something non-zero.
    --------------------------------------------------------------------
    chip48_proc : process(clk_28mhz)
    begin
        if rising_edge(clk_28mhz) then
            if clk7_en = '1' then
                if tb_hpos(4) = '0' then
                    chip48 <= (others => '1');  -- FFFF FFFF FFFF
                else
                    chip48 <= (others => '0');  -- 0000 0000 0000
                end if;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    -- Simple register write helper (one-cycle at clk7_en)
    --------------------------------------------------------------------
 ------------------------------------------------------------------
-- TB write engine: Amiga-style bus writes on clk7_en
------------------------------------------------------------------
reg_bus_proc : process(wr_active, wr_addr, wr_data)
begin
  if wr_active = '1' then
    reg_address_in <= wr_addr;
    data_in        <= wr_data;
  else
    reg_address_in <= (others => '0');
    data_in        <= (others => '0');
  end if;
end process;

reg_write_proc : process(clk_28mhz)
  -- local helper
  procedure write_reg(
    constant addr : in std_logic_vector(12 downto 1);    
    constant val  : in std_logic_vector(15 downto 0)
  ) is
  begin
    --wr_addr <= addr(8 downto 1);
    wr_addr <= addr(9 downto 2);
    wr_data <= val;
    wr_active <= '1';
  end procedure;

  constant HPOS_END : unsigned(8 downto 0) := to_unsigned(16#1C3#, 9);
  variable hpos_next : integer;
begin
  if rising_edge(clk_28mhz) then
    if reset = '1' then
      wstate  <= W_RESET;
      wr_active <= '0';
      wr_addr <= (others => '0');
      wr_data <= (others => '0');

    else

      if clk7_en = '1' then
        wr_active <= '0';
        -- what HPOS will be *after* beam_proc updates it on this same edge?
        if tb_hpos = HPOS_END then
          hpos_next := 0;
        else
          hpos_next := to_integer(tb_hpos) + 1;
        end if;

        case wstate is
          when W_RESET =>
            wstate <= W_DIWSTRT;

          when W_DIWSTRT =>
            write_reg(x"08E", x"2C81");
            wstate <= W_DIWSTOP;

          when W_DIWSTOP =>
            write_reg(x"090", x"2CC1");
            wstate <= W_DIWHIGH;

          when W_DIWHIGH =>
            --write_reg(x"0E4", x"0000");
            write_reg(x"1E4", x"0000");
            wstate <= W_BPLCON0;

          when W_BPLCON0 =>
            write_reg(x"100", x"2200");
            wstate <= W_COLOR00;

          when W_COLOR00 =>
            write_reg(x"180", x"0000");
            wstate <= W_COLOR01;

          when W_COLOR01 =>
            write_reg(x"182", x"0F00");
            wstate <= W_DONE;

          when W_DONE =>
            case hpos_next is
              -- these are now the HPOS values you *want Denise to see*
              when 21 | 53 | 85 | 117 | 149 | 181 | 213 | 245 =>
                write_reg(x"110", x"FFFF");
                report "TB: Writing BPL1DAT=FFFF at HPOS=" &
                       integer'image(hpos_next);

              when 37 | 69 | 101 | 133 | 165 | 197 | 229 | 261 =>
                write_reg(x"110", x"0000");
                report "TB: Writing BPL1DAT=0000 at HPOS=" &
                       integer'image(hpos_next);

              when others =>
                write_reg((others => '0'), (others => '0'));
                --null;
            end case;

          when others =>
            write_reg((others => '0'), (others => '0'));
            --null;
        end case;
      end if;
    end if;
  end if;
end process;

    --------------------------------------------------------------------
    -- DUT: Denise
    --------------------------------------------------------------------
    U_DENISE : entity work.denise_m65
        port map (
             clk            => clk_28mhz
            ,clk7_en        => clk7_en
            ,c1             => c1
            ,c3             => c3
            ,cck            => cck
            ,reset          => reset
            ,strhor         => strhor
            ,reg_address_in => reg_address_in
            ,data_in        => data_in
            ,chip48         => chip48
            ,data_out       => data_out
            ,blank          => blank
            ,red            => red
            ,green          => green
            ,blue           => blue
            ,a1k            => a1k
            ,ecs            => ecs
            ,aga            => aga
            ,hires          => hires
            ,shres          => shres
        );

log_proc : process(clk_28mhz)
    begin
        if rising_edge(clk_28mhz) then
            if clk7_en = '1' then
                report "HPOS=" & integer'image(to_integer(tb_hpos)) &
                       " RGB=" & slv_to_str(red) &
                       slv_to_str(green) &
                       slv_to_str(blue);
            end if;
        end if;
end process;

--debug_report : process (clk_28mhz)
--    variable cycle : integer := 0;
--begin
--    cycle := cycle + 1;
    
--    report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," &
--            "reg_address_in="   & slv_to_hex_any(reg_address_in)                & "," &
--            "data_in="          & slv_to_hex_any(data_in)                       & "," &       
--            "tb_hpos="          & integer'image(to_integer(tb_hpos))            & "," &                                        
--    "";        
    
--end process;



cycle7_proc : process(clk_28mhz)
begin
    if rising_edge(clk_28mhz) then
        if clk7_en = '1' then
            cycle_7 <= cycle_7 + 1;
        end if;
    end if;
end process;

denise_bus_log_proc : process(clk_28mhz)
    variable cycle_28 : integer := 0;
    constant ZERO_ADDR : std_logic_vector(8 downto 1) := (others => '0');
begin
    if rising_edge(clk_28mhz) then
        cycle_28 := cycle_28 + 1;
        
        if clk7_en = '1' and reg_address_in /= ZERO_ADDR then
            report "DENISE BUS WRITE | CYCLE28=" & integer'image(cycle_28) &
                   " CYCLE7=" & integer'image(cycle_7) &
                   " HPOS=" & integer'image(to_integer(tb_hpos)) &
                   " reg_address_in=" & slv_to_hex_any(reg_address_in) &
                   " data_in=" & slv_to_hex_any(data_in);
        end if;
    end if;
end process;

--strobe_log : process(clk_28mhz)
--begin
--    if rising_edge(clk_28mhz) then
--        report "CLKDIV=" & integer'image(to_integer(clk_div)) &
--               " c1=" & std_logic'image(c1) &
--               " c3=" & std_logic'image(c3) &
--               " clk7_en=" & std_logic'image(clk7_en);
--    end if;
--end process;


end architecture;
