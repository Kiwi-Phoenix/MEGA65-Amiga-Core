-- April 2026
-- Testbench to test complete Denise module
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.debug_utils_pkg.all;

entity tb_denise_V1_1 is
end entity;

architecture sim of tb_denise_V1_1 is

    -- Clocking
    signal clk_28mhz  : std_logic := '0';
    --constant CLK28_PERIOD : time := 35 ns;  -- ~28.6 MHz, close enough for TB
    constant CLK28_PERIOD : time := 35.6 ns;  -- ~28.6 MHz, close enough for TB

    signal clk7_en    : std_logic := '0';
    signal c1         : std_logic := '0';
    signal c3         : std_logic := '0';
    signal cck        : std_logic := '0';
    signal clk_div    : unsigned(1 downto 0) := (others => '0');

    -- Reset
    signal reset      : std_logic := '1';

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
    W_RESET,
    W_DIWSTRT,
    W_DIWSTOP,
    W_DIWHIGH,
    W_BPLCON0,
    W_COLOR00,
    W_COLOR01,
    W_BPL1DAT,
    W_DONE
);
signal wstate : write_state_t := W_RESET;

signal wr_active : std_logic := '0';
signal wr_addr   : std_logic_vector(8 downto 1) := (others => '0');
signal wr_data   : std_logic_vector(15 downto 0) := (others => '0');


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
    clkgen_proc : process(clk_28mhz)
    begin
        if rising_edge(clk_28mhz) then
            clk_div <= clk_div + 1;

            -- 7 MHz enable
            if clk_div = "00" then
                clk7_en <= '1';
            else
                clk7_en <= '0';
            end if;

            -- CCK (color clock) from clk_div(0)
            if clk_div(0) = '0' then
                cck <= '1';
            else
                cck <= '0';
            end if;

            -- c1 / c3 strobes
            if clk_div = "01" then
                c1 <= '1';
            else
                c1 <= '0';
            end if;

            if clk_div = "11" then
                c3 <= '1';
            else
                c3 <= '0';
            end if;
        end if;
    end process;

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
--    chip48_proc : process(clk_28mhz)
--        variable cnt : unsigned(7 downto 0) := (others => '0');
--    begin
--        if rising_edge(clk_28mhz) then
--            if reset = '1' then
--                cnt    := (others => '0');
--                chip48 <= (others => '0');
--            elsif clk7_en = '1' then
--                cnt := cnt + 1;
--                if cnt(0) = '0' then
--                    chip48(15 downto 0)  <= x"0000";
--                    chip48(31 downto 16) <= x"FFFF";
--                    chip48(47 downto 32) <= x"0000";
--                else
--                    chip48(15 downto 0)  <= x"FFFF";
--                    chip48(31 downto 16) <= x"0000";
--                    chip48(47 downto 32) <= x"FFFF";
--                end if;
--            end if;
--        end if;
--    end process;
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

reg_write_proc : process(clk_28mhz)
        -- local helper
        procedure write_reg(
            constant addr : in std_logic_vector(12 downto 1);
            constant val  : in std_logic_vector(15 downto 0)
          
        ) is
        begin
            wr_addr        <= addr(8 downto 1);
            wr_data        <= val;                        
        end procedure;
        
begin
    if rising_edge(clk_28mhz) then

        -- default: hold previous values
        reg_address_in <= wr_addr;
        data_in        <= wr_data;

        if reset = '1' then
            wstate         <= W_RESET;
            wr_active      <= '0';
            --wr_addr        <= (others => '0');
            --wr_data        <= (others => '0');           
            write_reg((others=>'0'), (others=>'0')); 

        elsif clk7_en = '1' then
            case wstate is

                when W_RESET =>
                    wstate <= W_DIWSTRT;

                when W_DIWSTRT =>
                    wr_active   <= '1';                   
                    write_reg(x"08E", x"2C81");                    
                    wstate      <= W_DIWSTOP;

                when W_DIWSTOP =>
                    wr_active       <= '1';
                    write_reg(x"090", x"2CC1");
                    wstate          <= W_DIWHIGH;

                when W_DIWHIGH =>                   
                    wr_active       <= '1';
                    write_reg(x"0E4", x"0000");
                    wstate          <= W_BPLCON0;

                when W_BPLCON0 =>
                    wr_active       <= '1';
                    write_reg(x"100", x"2200");
                    wstate          <= W_COLOR00;

                when W_COLOR00 =>      
                    wr_active       <= '1';            
                    write_reg(x"180", x"0000");
                    wstate          <= W_COLOR01;

                when W_COLOR01 =>      
                    wr_active       <= '1';             
                    write_reg(x"182", x"0F00");
                    wstate          <= W_DONE;

                when W_DONE =>
                    --wr_active   <= '0';
                    --wr_addr     <= (others => '0');
                    --wr_data     <= (others => '0');
                    --write_reg((others=>'0'), (others=>'0'));
                    case to_integer(tb_hpos) is

                        -- Checkerboard: alternate every 16 pixels
                        when 4 | 36 | 68 | 100 | 132 | 164 | 196 | 228 =>
                            wr_active <= '1';
                            write_reg(x"110", x"FFFF");  -- BPL1DAT
                            --wr_addr   <= x"110";      -- BPL1DAT
                            --wr_addr   <= x"10";      -- BPL1DAT
                            --wr_data   <= x"FFFF";

                        when 20 | 52 | 84 | 116 | 148 | 180 | 212 | 244 =>
                            wr_active <= '1';
                            write_reg(x"110", x"0000");
                            --wr_addr   <= x"110";
                            --wr_addr   <= x"10";
                            --wr_data   <= x"0000";

                        when others =>
                            wr_active <= '0';
                            --wr_addr   <= (others => '0');
                            --wr_data   <= (others => '0');
                            write_reg((others=>'0'), (others=>'0'));

                    end case;
                    
                
                when others =>
                    null;

            end case;
        end if;
    end if;
end process;

--dma_proc : process(clk_28mhz)
--        -- local helper
--        procedure write_reg(
--            constant addr : in std_logic_vector(12 downto 1);
--            constant val  : in std_logic_vector(15 downto 0)
          
--        ) is
--        begin
--            wr_addr        <= addr(8 downto 1);
--            wr_data        <= val;                        
--        end procedure;
--    begin
--        if rising_edge(clk_28mhz) then
--            if clk7_en = '1' then

--                -- Only after register init is done
--                if wstate = W_DONE then

--                    case to_integer(tb_hpos) is

--                        -- Checkerboard: alternate every 16 pixels
--                        when 4 | 36 | 68 | 100 | 132 | 164 | 196 | 228 =>
--                            wr_active <= '1';
--                            write_reg(x"110", x"FFFF");  -- BPL1DAT
--                            --wr_addr   <= x"110";      -- BPL1DAT
--                            --wr_addr   <= x"10";      -- BPL1DAT
--                            --wr_data   <= x"FFFF";

--                        when 20 | 52 | 84 | 116 | 148 | 180 | 212 | 244 =>
--                            wr_active <= '1';
--                            write_reg(x"110", x"0000");
--                            --wr_addr   <= x"110";
--                            --wr_addr   <= x"10";
--                            --wr_data   <= x"0000";

--                        when others =>
--                            wr_active <= '0';
--                            --wr_addr   <= (others => '0');
--                            --wr_data   <= (others => '0');
--                            write_reg((others=>'0'), (others=>'0'));

--                    end case;

--                end if;
--            end if;
--        end if;
--end process;


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

debug_report : process (clk_28mhz)
    variable cycle : integer := 0;
begin
    cycle := cycle + 1;
    
    report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," &
            "reg_address_in="   & slv_to_hex_any(reg_address_in)                & "," &
            "data_in="          & slv_to_hex_any(data_in)                       & "," &       
            "tb_hpos="          & integer'image(to_integer(tb_hpos))            & "," &                    
    "";        
    
end process;


end architecture;
