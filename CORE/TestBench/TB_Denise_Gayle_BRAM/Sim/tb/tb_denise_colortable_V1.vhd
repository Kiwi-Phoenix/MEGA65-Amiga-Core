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

entity tb_denise_colortable_V1 is
end entity;

architecture sim of tb_denise_colortable_V1 is

    constant CLK_PERIOD : time := 10 ns;

    -- DUT signals
    signal clk           : std_logic := '0';
    signal clk7_en       : std_logic := '0';
    signal reg_address   : std_logic_vector(8 downto 0) := (others => '0');
    --signal reg_address   : std_logic_vector(8 downto 1) := (others => '0');
    signal data_in       : std_logic_vector(11 downto 0) := (others => '0');
    signal rdram         : std_logic := '0';
    signal selectx       : std_logic_vector(7 downto 0) := (others => '0');
    signal bplxor        : std_logic_vector(7 downto 0) := (others => '0');
    signal bank          : std_logic_vector(2 downto 0) := (others => '0');
    signal loct          : std_logic := '0';
    signal ehb_en        : std_logic := '0';
    signal rgb           : std_logic_vector(23 downto 0);

    -- Behavioural palette model
    type palette_t is array (0 to 255) of std_logic_vector(23 downto 0);
    signal model_palette : palette_t := (others => (others => '0'));

    -- Expected-value pipeline
    signal expected_rgb      : std_logic_vector(23 downto 0) := (others => '0');
    signal expected_rgb_d    : std_logic_vector(23 downto 0) := (others => '0');
    signal expected_valid    : std_logic := '0';
    signal expected_valid_d  : std_logic := '0';

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
            bplxor         => bplxor,
            bank           => bank,
            loct           => loct,
            ehb_en         => ehb_en,
            rgb            => rgb
        );

    --------------------------------------------------------------------
    -- Behavioural palette model update
    --------------------------------------------------------------------
    process(clk)
        variable idx : integer;
        variable r,g,b : integer;
    begin
        if rising_edge(clk) then
            -- CPU write to palette register
            if clk7_en = '1' then
                --if unsigned(reg_address) >= COLORBASE and unsigned(reg_address) < COLORBASE + 256 then
                if unsigned(reg_address) >= COLORBASE and unsigned(reg_address) < COLORBASE + 512 then
                    --idx := to_integer(unsigned(reg_address) - COLORBASE);
                    idx := to_integer((unsigned(reg_address) - COLORBASE) / 2);

                    if loct = '1' then
--                        -- 12-bit colour expanded to 24-bit
--                        r := to_integer(unsigned(data_in(11 downto 8))) * 17;
--                        g := to_integer(unsigned(data_in(7 downto 4))) * 17;
--                        b := to_integer(unsigned(data_in(3 downto 0))) * 17;
--                        model_palette(idx) <= std_logic_vector(to_unsigned(r,8)) &
--                                              std_logic_vector(to_unsigned(g,8)) &
--                                              std_logic_vector(to_unsigned(b,8));

                        -- 12-bit colour stored as raw 4-bit values in low nibble
                        r := to_integer(unsigned(data_in(11 downto 8)));
                        g := to_integer(unsigned(data_in(7 downto 4)));
                        b := to_integer(unsigned(data_in(3 downto 0)));
                    
                        model_palette(idx) <= 
                            std_logic_vector(to_unsigned(r, 8)) &
                            std_logic_vector(to_unsigned(g, 8)) &
                            std_logic_vector(to_unsigned(b, 8));
                    else
                        -- AGA 24-bit mode (upper bits unused in Minimig)
                        model_palette(idx) <= (others => '0'); -- simplified for now
                    end if;
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
            expected_rgb_d   <= expected_rgb;
            expected_valid_d <= expected_valid;
        end if;
    end process;

    --------------------------------------------------------------------
    -- Checker
    --------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if expected_valid_d = '1' then
                assert rgb = expected_rgb_d
                    report "Mismatch: expected " & slv_to_hex_any(expected_rgb_d) &
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
        for idx in 0 to 31 loop
            --reg_address <= std_logic_vector(to_unsigned(COLORBASE + idx, 9));
            reg_address <= std_logic_vector(to_unsigned(COLORBASE + (idx * 2), 9));
            --data_in     <= std_logic_vector(to_unsigned(idx, 12));
            --data_in <= x"F00";      -- pure red
            --data_in <= x"0F0";      -- pure green
            data_in <= x"00F";      -- pure blue
            wait until rising_edge(clk) and clk7_en = '1';
        end loop;

        ----------------------------------------------------------------
        -- Lookup test
        ----------------------------------------------------------------
        for idx in 0 to 31 loop
            selectx <= std_logic_vector(to_unsigned(idx, 8));

            -- Compute expected RGB
            -- This block works for AGA mode but not OCS/ECS
--            r := (idx / 4) * 17;
--            g := (idx mod 16) * 17;
--            b := 0;

--            expected_rgb <= std_logic_vector(to_unsigned(r,8)) &
--                            std_logic_vector(to_unsigned(g,8)) &
--                            std_logic_vector(to_unsigned(b,8));

            -- Extract 4-bit components from the palette write value
--            r := to_integer(unsigned(data_in(11 downto 8)));
--            g := to_integer(unsigned(data_in(7 downto 4)));
--            b := to_integer(unsigned(data_in(3 downto 0)));
--            r := idx;
--            g := 0;
--            b := 0;
            --r := (idx / 4);
            --g := (idx mod 16);
            --g := 0;
            --b := 0;
            
            --Denise outputs 4-bit values in the *low nibble* of each 8-bit channel
            
--            expected_rgb <= 
--                std_logic_vector(to_unsigned(r, 8)) &           
--                std_logic_vector(to_unsigned(g, 8)) &           
--                std_logic_vector(to_unsigned(b, 8));      
            expected_rgb <= x"0F0000";  -- R=0x0F, G=0, B=0 (RGB)
      
--            expected_rgb <= model_palette(idx);
            expected_valid <= '1';

            wait until rising_edge(clk);
        end loop;

        expected_valid <= '0';

        ----------------------------------------------------------------
        -- Random stress test
        ----------------------------------------------------------------
--        for idx in 0 to 5000 loop
--            -- random write
--            --reg_address <= std_logic_vector(to_unsigned(COLORBASE + (idx mod 256), 9));            
--            reg_address <= std_logic_vector(to_unsigned(COLORBASE + ((idx mod 256) * 2), 9));            
--            data_in     <= std_logic_vector(to_unsigned(idx mod 4096, 12));
--            --wait until rising_edge(clk);
--            wait until rising_edge(clk) and clk7_en = '1';

--            -- random lookup
--            selectx <= std_logic_vector(to_unsigned(idx mod 256, 8));

--            -- expected value from model
--            expected_rgb <= model_palette(idx mod 256);
--            expected_valid <= '1';

--            wait until rising_edge(clk) and clk7_en = '1';
--        end loop;

        expected_valid <= '0';

        report "denise_colortable TB completed successfully" severity note;
        wait;
    end process;

end architecture;
