-- TestBench for denise colortable
--
-- Notes:
-- Although Denise uses clk = 28Mhz, writes are done off the clk7_en cycle.
-- This is to line up with the CPU and other custom chips.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Amiga_Debug_pkg.all;
use work.debug_utils_pkg.all;

entity tb_denise_colortable_v1_2 is
end entity;

architecture sim of tb_denise_colortable_v1_2 is

    constant CLK_PERIOD : time := 10 ns;
    -- Behavioural palette model
    type palette_t is array (0 to 255) of std_logic_vector(23 downto 0);
    --signal model_palette : palette_t := (others => (others => '0'));


    -- DUT signals
    signal clk           : std_logic := '0';
    signal clk7_en       : std_logic := '0';
    signal reg_address   : std_logic_vector(8 downto 0) := (others => '0');
    signal data_in       : std_logic_vector(11 downto 0) := (others => '0');
    signal selectx       : std_logic_vector(7 downto 0) := (others => '0');
    signal rgb           : std_logic_vector(23 downto 0);
    signal expected_rgb      : std_logic_vector(23 downto 0) := (others => '0');
    signal model_palette : palette_t := (others => (others => '0'));
    signal bplxor        : std_logic_vector(7 downto 0) := (others => '0');
    signal bank          : std_logic_vector(2 downto 0) := (others => '0');
    signal loct          : std_logic := '0';
    signal ehb_en        : std_logic := '0';

    signal rdram         : std_logic := '0';



    -- Expected-value pipeline
    --signal expected_rgb      : std_logic_vector(23 downto 0) := (others => '0');
    signal expected_rgb_d    : std_logic_vector(23 downto 0) := (others => '0');
    signal expected_valid    : std_logic := '0';
    signal expected_valid_d  : std_logic := '0';
    
    --signal expected_rgb_d2   : std_logic_vector(23 downto 0) := (others => '0');
    --signal expected_valid_d2 : std_logic := '0';
    
    signal model_we_d        : std_logic := '0';
    
    --signal selectx_d         : std_logic_vector(7 downto 0);

signal model_we      : std_logic := '0';
signal model_idx     : integer := 0;
signal model_r       : integer := 0;
signal model_g       : integer := 0;
signal model_b       : integer := 0;

    -- Constants
    constant COLORBASE : integer := 16#180#;

begin

    --------------------------------------------------------------------
    -- Clock generation
    --------------------------------------------------------------------
    clk <= not clk after CLK_PERIOD/2;

    process(clk)
    begin
        if rising_edge(clk) then
            clk7_en <= not clk7_en;
        end if;
    end process;

    --------------------------------------------------------------------
    -- DUT instantiation
    --------------------------------------------------------------------
    uut: entity work.denise_colortable_wrapper
        port map (
            clk            => clk,
            clk7_en        => clk7_en,
            reg_address_in => reg_address(8 downto 1),
            data_in        => data_in,
            rdram          => rdram,
            selectx        => selectx,
--            selectx        => selectx_d,
            bplxor         => bplxor,
            bank           => bank,
            loct           => loct,
            ehb_en         => ehb_en,
            rgb            => rgb
        );
        
--process
--begin
--    -- Run the simulation for 100,000 ns
--    wait for 205000 ns;
--    report "TB completed" severity note;
--    std.env.stop;    
--end process;
        
    --------------------------------------------------------------------
    -- Behavioural palette model update
    --------------------------------------------------------------------
--    process(clk)
--        variable idx : integer;
--        variable r,g,b : integer;
--    begin
--        if rising_edge(clk) then
--            -- CPU write to palette register
--            if clk7_en = '1' then
--                if unsigned(reg_address) >= COLORBASE and unsigned(reg_address) < COLORBASE + 512 then
--                    idx := to_integer((unsigned(reg_address) - COLORBASE) / 2);

--                    if loct = '1' then
----                        -- 12-bit colour expanded to 24-bit
----                        r := to_integer(unsigned(data_in(11 downto 8))) * 17;
----                        g := to_integer(unsigned(data_in(7 downto 4))) * 17;
----                        b := to_integer(unsigned(data_in(3 downto 0))) * 17;
----                        model_palette(idx) <= std_logic_vector(to_unsigned(r,8)) &
----                                              std_logic_vector(to_unsigned(g,8)) &
----                                              std_logic_vector(to_unsigned(b,8));

--                        -- 12-bit colour stored as raw 4-bit values in low nibble
--                        r := to_integer(unsigned(data_in(11 downto 8)));
--                        g := to_integer(unsigned(data_in(7 downto 4)));
--                        b := to_integer(unsigned(data_in(3 downto 0)));
                    
--                        model_palette(idx) <= 
--                            std_logic_vector(to_unsigned(r, 8)) &
--                            std_logic_vector(to_unsigned(g, 8)) &
--                            std_logic_vector(to_unsigned(b, 8));
--                    else
--                        -- AGA 24-bit mode (upper bits unused in Minimig)
--                        model_palette(idx) <= (others => '0'); -- simplified for now
--                    end if;
--                end if;
--            end if;
--        end if;
--    end process;
--------------------------------------------------------------------
-- Behavioural palette model update (cycle-accurate to Denise)
--------------------------------------------------------------------
-- Stage 1: capture write request on clk7_en


-- Stage 1: latch write parameters
process(clk)
begin
    if rising_edge(clk) then
        if clk7_en = '1' then
            model_we <= '0';  -- default
                
            if unsigned(reg_address) >= COLORBASE and unsigned(reg_address) < COLORBASE + 512 then
                model_idx <= to_integer((unsigned(reg_address) - COLORBASE) / 2);

                if loct = '1' then
                    model_r <= to_integer(unsigned(data_in(11 downto 8)));
                    model_g <= to_integer(unsigned(data_in(7 downto 4)));
                    model_b <= to_integer(unsigned(data_in(3 downto 0)));
                    model_we <= '1';
                end if;
            end if;
        else
            -- hold model_we at 0 when clk7_en = 0
            model_we <= '0';
        end if;
        -- 1-cycle delayed write-enable for stage 2
        model_we_d <= model_we;
    end if;
end process;

-- Stage 2: apply write one clk7_en later (matches XPM BRAM latency)
process(clk)
-- Capture the module palette that was written to BRAM, used to later validated the Read back.
begin
    if rising_edge(clk) then
        if clk7_en = '1' then
            --if model_we = '1' then
            if model_we_d = '1' then
                model_palette(model_idx) <=
                    std_logic_vector(to_unsigned(model_r, 8)) &
                    std_logic_vector(to_unsigned(model_g, 8)) &
                    std_logic_vector(to_unsigned(model_b, 8));
            end if;            
        end if;
    end if;
end process;
    --------------------------------------------------------------------
    -- Expected-value pipeline (1-cycle latency)
    --------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            -- Stage 1: delay expected_rgb by 1 cycle
            expected_rgb_d   <= expected_rgb;
            expected_valid_d <= expected_valid;
--            selectx_d        <= selectx; 
            
            -- Stage 2: delay again to match model write latency
            --expected_rgb_d2     <= expected_rgb_d;
            --expected_valid_d2   <= expected_valid_d;            
        end if;
    end process;

    --------------------------------------------------------------------
    -- Checker
    --------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
        
            report "DBG: reg_address=" & slv_to_hex_any(reg_address) & "," &
                            "data_in=" & slv_to_hex_any(data_in) &  "," &
                            "selectx=" & slv_to_hex_any(selectx) &  "," &
--                          "selectx_d=" & slv_to_hex_any(selectx_d) &  "," &
                            "rgb="     & slv_to_hex_any(rgb)     &  "," &
                       "expected_rgb=" & slv_to_hex_any(expected_rgb) & "," &
                     "expected_rgb_d=" & slv_to_hex_any(expected_rgb_d) & "," &
                   ""; 
        
        
            if expected_valid = '1' then
            --if expected_valid_d = '1' then
            --if expected_valid_d2 = '1' then
                assert rgb = expected_rgb
                    report "Mismatch: expected " & slv_to_hex_any(expected_rgb) &
                           " got " & slv_to_hex_any(rgb)
                    severity error;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    -- Stimulus
    --------------------------------------------------------------------
    stim: process
        variable idx : integer;
        variable r,g,b : integer;
    begin
        wait for 100 ns;
                        
        loct <= '1'; -- use 12-bit palette mode

        ----------------------------------------------------------------
        -- Directed test: write first 32 palette entries
        ----------------------------------------------------------------
--        for idx in 0 to 31 loop
--            reg_address <= std_logic_vector(to_unsigned(COLORBASE + (idx * 2), 9));
--            data_in     <= std_logic_vector(to_unsigned(idx, 12));
--            --data_in <= x"F00";      -- pure red
--            --data_in <= x"0F0";      -- pure green
--            --data_in <= x"00F";      -- pure blue
--            wait until rising_edge(clk) and clk7_en = '1';
--        end loop;

--        ----------------------------------------------------------------
--        -- Lookup test
--        ----------------------------------------------------------------
--        for idx in 0 to 31 loop
--            selectx <= std_logic_vector(to_unsigned(idx, 8));
            
--            --wait until rising_edge(clk) and clk7_en = '1';          -- Allow selectx_d to update
--            --expected_rgb <= x"0F0000";  -- R=0x0F, G=0, B=0 (RGB)
      
--            expected_rgb <= model_palette(idx);
--            expected_valid <= '1';

--            wait until rising_edge(clk) and clk7_en = '1';
--        end loop;

        --expected_valid <= '0';

        ----------------------------------------------------------------
        -- Random stress test
        ----------------------------------------------------------------
--        --for idx in 0 to 5000 loop
--        for idx in 0 to 256 loop
--            -- random write           
--            reg_address <= std_logic_vector(to_unsigned(COLORBASE + ((idx mod 256) * 2), 9));            
--            data_in     <= std_logic_vector(to_unsigned(idx mod 4096, 12));
--            --wait until rising_edge(clk) and clk7_en = '1';
--            --wait until rising_edge(clk) and clk7_en = '1';
            
--            -- expected value from model
--            expected_rgb <= model_palette(idx mod 256);
--            expected_valid <= '1';
            
--            -- extra cycle so model_palette sees the updated value
--            wait until rising_edge(clk) and clk7_en = '1';
--            --wait until rising_edge(clk) and clk7_en = '1';

--            -- random lookup
--            selectx <= std_logic_vector(to_unsigned(idx mod 256, 8));
--            wait until rising_edge(clk) and clk7_en = '1';
--            wait until rising_edge(clk) and clk7_en = '1';

----            -- expected value from model
----            expected_rgb <= model_palette(idx mod 256);
----            expected_valid <= '1';

--            wait until rising_edge(clk) and clk7_en = '1';
--        end loop;

--        expected_valid <= '0';


    -- Randomize / scramble palette contents
    -- Randomize the palette (writes only)
    --for idx in 0 to 5000 loop
    for idx in 0 to 512 loop
        reg_address <= std_logic_vector(to_unsigned(COLORBASE + ((idx mod 256) * 2), 9));
        data_in     <= std_logic_vector(to_unsigned(idx mod 4096, 12));
        wait until rising_edge(clk) and clk7_en = '1';      -- write captured
    end loop;
    
    -- Give model + DUT time to settle
    for idx in 0 to 3 loop
        wait until rising_edge(clk) and clk7_en = '1';                
    end loop;
    
    -- Random reads with checks (no writes)
    --for idx in 0 to 5000 loop
    for idx in 0 to 512 loop
        -- choose index (you can keep idx mod 256 or use a PRNG)
        selectx <= std_logic_vector(to_unsigned(idx mod 256, 8));
        
        -- wait for BRAM read latency
        wait until rising_edge(clk) and clk7_en = '1';
        
        -- sample expected from model (no concurrent writes now)
        --expected_rgb <= model_palette(idx mod 256);
        expected_rgb <= model_palette(to_integer(unsigned(selectx)));
        expected_valid <= '1';
        
        -- compare on next clk
        wait until rising_edge(clk);
    end loop;        



        report "denise_colortable TB completed successfully" severity note;
        wait;
    end process;

end architecture;
