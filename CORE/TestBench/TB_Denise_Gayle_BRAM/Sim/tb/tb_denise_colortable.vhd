-- TestBench for denise colortable
--
-- March 2026   David Raynor (Kiwi)
-- Notes:
-- Although Denise uses clk = 28Mhz, writes are done off the clk7_en cycle.
-- This is to line up with the CPU and other custom chips.
-- This testing is more aggressive than what real hardware will need to perform.
--
-- This TB is for OCS/ECS Denise Colourtable.
-- uses 32 palette registers
-- 12-bit RGB (4 bits per chanlle)
-- Any reads above index 31 will return 09
-- Writes above index 31 are ignored.
--
-- In contrast to AGA Denise (separate TB tes)
-- 256 palatee registers
-- 24-bit RGB (8 bits per channel)
-- Full 0-255 range is valid
-- no "zeroing" above 21
-- 
-- Note: I have since modified this TB to regression test OCS/ECS functions with 
-- AGA enhanced version of Denise_Colortable.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Amiga_Debug_pkg.all;
use work.debug_utils_pkg.all;

entity tb_denise_colortable is
end entity;

architecture sim of tb_denise_colortable is

    constant CLK_PERIOD : time := 10 ns;
    -- Behavioural palette model
    --type palette_t is array (0 to 255) of std_logic_vector(23 downto 0);   -- AGA Denise
    type palette_t is array (0 to 31) of std_logic_vector(23 downto 0);     -- OCS/ECS Denise
    


    -- DUT signals
    signal clk           : std_logic := '0';
    signal clk7_en       : std_logic := '0';
    signal reg_address   : std_logic_vector(8 downto 0) := (others => '0');
    --signal data_in       : std_logic_vector(11 downto 0) := (others => '0');
    signal data_in       : std_logic_vector(15 downto 0) := (others => '0');
    signal selectx       : std_logic_vector(7 downto 0) := (others => '0');
    signal rgb           : std_logic_vector(23 downto 0);
    --signal expected_rgb      : std_logic_vector(23 downto 0) := (others => '0');
    signal model_palette : palette_t := (others => (others => '0'));
    signal bplxor        : std_logic_vector(7 downto 0) := (others => '0');
    signal bank          : std_logic_vector(2 downto 0) := (others => '0');
    signal loct          : std_logic := '0';
    signal ehb_en        : std_logic := '0';

    signal rdram         : std_logic := '0';

    -- Expected-value pipeline
    signal expected_rgb      : std_logic_vector(23 downto 0) := (others => '0');
    signal expected_valid    : std_logic := '0';
   
    signal model_we_d        : std_logic := '0';
    
    signal model_we      : std_logic := '0';
    signal model_idx_x     : integer := 0;
    signal model_r       : integer := 0;
    signal model_g       : integer := 0;
    signal model_b       : integer := 0;
    


    -- Constants
    constant COLORBASE : integer := 16#180#;

begin

process
begin
    -- Run the simulation for 510,000 ns
    wait for 960000 ns;
    report "TB completed" severity note;
    std.env.stop;    
end process;


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
--    uut: entity work.denise_colortable_wrapper
--        port map (
--             clk            => clk
--            ,clk7_en        => clk7_en
--            ,reg_address_in => reg_address(8 downto 1)
--            ,data_in        => data_in
--            ,rdram          => rdram
--            ,selectx        => selectx
--            ,bplxor         => bplxor
--            ,bank           => bank
--            ,loct           => loct
--            ,ehb_en         => ehb_en
--            ,rgb            => rgb
--        );
    
    uut: entity work.denise_colortable_AGA_wrapper
        port map (
             clk            => clk
            ,clk7_en        => clk7_en
            ,reg_address_in => reg_address(8 downto 1)
            ,data_in        => data_in
            ,aga            => '0'
            ,rdram          => rdram
            ,selectx        => selectx
            ,bplxor         => bplxor
            ,bank           => bank
            ,loct           => loct
            ,ehb_en         => ehb_en
            ,rgb            => rgb
        );
        

        

-- Stage 1: latch write parameters
-- This process steps replicates how the old MiSTer Denise_colortbale did.
-- The new process is for the new AGA enhanced version of Denise_colortable
--process(clk)
--begin
--    if rising_edge(clk) then
--        if clk7_en = '1' then
--            model_we <= '0';  -- default
                
--            if unsigned(reg_address) >= COLORBASE and unsigned(reg_address) < COLORBASE + 512 then
--                model_idx <= to_integer((unsigned(reg_address) - COLORBASE) / 2);

--                if loct = '1' then
--                    model_r <= to_integer(unsigned(data_in(11 downto 8)));
--                    model_g <= to_integer(unsigned(data_in(7 downto 4)));
--                    model_b <= to_integer(unsigned(data_in(3 downto 0)));
--                    model_we <= '1';
--                end if;
--            end if;
--        else
--            -- hold model_we at 0 when clk7_en = 0
--            model_we <= '0';
--        end if;
--        -- 1-cycle delayed write-enable for stage 2
--        model_we_d <= model_we;
--    end if;
--end process;


-- Stage 2: apply write one clk7_en later (matches XPM BRAM latency)
--process(clk)
---- Capture the module palette that was written to BRAM, used to later validated the Read back.
--begin
--    if rising_edge(clk) then
--        if clk7_en = '1' then
--            if model_we_d = '1' then
--                if model_idx < 32 then                  -- OCS/ECS Denise
--                    model_palette(model_idx) <=
--                        std_logic_vector(to_unsigned(model_r, 8)) &
--                        std_logic_vector(to_unsigned(model_g, 8)) &
--                        std_logic_vector(to_unsigned(model_b, 8));
--                end if;
--            end if;            
--        end if;
--    end if;
--end process;

-- Populate model_palette to test the read results against.
-- This process is for the enhanced AGA Denise_colortable module.
process(clk)
    variable r4 : std_logic_vector(3 downto 0);
    variable g4 : std_logic_vector(3 downto 0);
    variable b4 : std_logic_vector(3 downto 0);    
    variable mod_idx     : integer := 0;
begin 
    if rising_edge(clk) then
        if clk7_en = '1' then
        
            if unsigned(reg_address) >= COLORBASE and unsigned(reg_address) < COLORBASE + 512 then
                mod_idx := to_integer((unsigned(reg_address) - COLORBASE) / 2);
                if loct = '1' then                                                
                    -- extract 4-bit channels
                    r4 := data_in(11 downto 8);
                    g4 := data_in(7 downto 4);
                    b4 := data_in(3 downto 0);
                end if;
                    
                if mod_idx < 32 then        
                    -- expand 4->8 by replication
                    model_palette(mod_idx) <= r4 & r4 & g4 & g4 & b4 & b4;
                end if;
            end if;
        end if;
    end if;
end process;

    --------------------------------------------------------------------
    -- Checker
    --------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then        
--            report "DBG: reg_address=" & slv_to_hex_any(reg_address)  & "," &
--                            "data_in=" & slv_to_hex_any(data_in)      &  "," &
--                            "selectx=" & slv_to_hex_any(selectx)      &  "," &
--                            "rgb="     & slv_to_hex_any(rgb)          &  "," &
--                       "expected_rgb=" & slv_to_hex_any(expected_rgb) & "," &
--                   ""; 
              
            if expected_valid = '1' then
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
        variable idx      : integer;
        variable idx5     : integer;
        variable r,g,b    : integer;        
        variable wr_idx   : integer;
        variable rd_idx   : integer;
        variable wr_color : integer;
        variable delay    : integer;
    begin
        wait for 100 ns;
                        
        loct <= '1'; -- use 12-bit palette mode

        report "Starting 32 palette entries test" severity note;
        ----------------------------------------------------------------
        -- Directed test: write first 32 palette entries
        ----------------------------------------------------------------
        for idx in 0 to 31 loop
            reg_address <= std_logic_vector(to_unsigned(COLORBASE + (idx * 2), 9));
            data_in(11 downto 0)     <= std_logic_vector(to_unsigned(idx, 12));
            wait until rising_edge(clk) and clk7_en = '1';
        end loop;

        ----------------------------------------------------------------
        -- Lookup test
        ----------------------------------------------------------------
        for idx in 0 to 31 loop
            selectx <= std_logic_vector(to_unsigned(idx, 8));
            
            wait until rising_edge(clk) and clk7_en = '1';          -- Allow selectx_d to update
            
            if to_integer(unsigned(selectx)) < 32 then        
                expected_rgb <= model_palette(to_integer(unsigned(selectx)));
                expected_valid <= '1';
            else
                expected_rgb <= (others => '0');
            end if;

            wait until rising_edge(clk);
        end loop;

        expected_valid <= '0';
        report "Starting 32 palette entries test completed" severity note;

        ----------------------------------------------------------------
        -- Random stress test
        ----------------------------------------------------------------
    report "Starting Random stress test" severity note;        
    for idx in 0 to 5000 loop    
        reg_address <= std_logic_vector(to_unsigned(COLORBASE + ((idx mod 256) * 2), 9));
        data_in(11 downto 0)     <= std_logic_vector(to_unsigned(idx mod 4096, 12));
        wait until rising_edge(clk) and clk7_en = '1';      -- write captured
    end loop;
       
    -- Random reads with checks (no writes)    
    for idx in 0 to 5000 loop
        -- choose index (you can keep idx mod 256 or use a PRNG)
        selectx <= std_logic_vector(to_unsigned(idx mod 256, 8));
        
        -- wait for BRAM read latency
        wait until rising_edge(clk) and clk7_en = '1';
        
        -- This bit is for the AGA enhanced denise_colortable
        idx5 := to_integer(unsigned(selectx(4 downto 0)));      -- wrap 0..31
        expected_rgb    <= model_palette(idx5);
        expected_valid  <= '1';
        
--        if to_integer(unsigned(selectx)) < 32 then
--            -- sample expected from model (no concurrent writes now)
--            expected_rgb <= model_palette(to_integer(unsigned(selectx)));
--            expected_valid <= '1';
--        else    
--            expected_rgb <= (others => '0');
--        end if;
        
        -- compare on next clk
        wait until rising_edge(clk);
    end loop;        
    
    expected_valid <= '0';

    report "Starting Random stress test completed" severity note;

----------------------------------------------------------------
-- Real-world random palette test (OCS/ECS: 32 entries)
-- Simulates CPU writes + Denise reads with realistic timing
----------------------------------------------------------------

    -- Randomize seed if desired
    -- uniform(seed1, seed2, ...)

    report "Starting real-world random palette test" severity note;

    for idx in 0 to 5000 loop

        ------------------------------------------------------------
        -- 1) Random CPU-style write
        ------------------------------------------------------------
        wr_idx   := (idx * 37) mod 32;
        wr_color := (idx * 37) mod 4096;  -- deterministic pseudo-random 12-bit value

        reg_address <= std_logic_vector(to_unsigned(COLORBASE + (wr_idx * 2), 9));
        data_in(11 downto 0)     <= std_logic_vector(to_unsigned(wr_color, 12));

        wait until rising_edge(clk) and clk7_en = '1';  -- CPU write captured

        ------------------------------------------------------------
        -- 2) Random idle time (0-10 cycles)
        --    Simulates CPU doing other things
        ------------------------------------------------------------
        delay := (idx * 13) mod 10;
        for d in 0 to delay loop
            wait until rising_edge(clk) and clk7_en = '1';
        end loop;

        ------------------------------------------------------------
        -- 3) Random Denise-style read
        ------------------------------------------------------------
        rd_idx := (idx * 23) mod 32;  -- 0..31

        selectx <= std_logic_vector(to_unsigned(rd_idx, 8));

        wait until rising_edge(clk) and clk7_en = '1';  -- BRAM read latency

        ------------------------------------------------------------
        -- 4) Expected value from model
        ------------------------------------------------------------
        idx5 := to_integer(unsigned(selectx(4 downto 0)));      -- wrap 0..31
        --expected_rgb   <= model_palette(rd_idx);
        expected_rgb   <= model_palette(idx5);
        expected_valid <= '1';

        wait until rising_edge(clk);  -- compare on next clk

        expected_valid <= '0';

    end loop;

    report "Real-world random palette test completed" severity note;



        report "denise_colortable TB completed successfully" severity note;
        wait;
    end process;

end architecture;
