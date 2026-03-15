-- TestBench for denise colortable
--
-- March 2026   David Raynor (Kiwi)
-- Notes:
-- Although Denise uses clk = 28Mhz, writes are done off the clk7_en cycle.
-- This is to line up with the CPU and other custom chips.
-- This testing is more aggressive than what real hardware will need to perform.
--
-- This TB is for AGA Denise Colourtable.
-- 256 palatee registers
-- 24-bit RGB (8 bits per channel)
-- Full 0-255 range is valid
-- no "zeroing" above 21
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Amiga_Debug_pkg.all;
use work.debug_utils_pkg.all;

entity tb_denise_colortable_AGA is
end entity;

architecture sim of tb_denise_colortable_AGA is

    constant CLK_PERIOD : time := 10 ns;
    -- Behavioural palette model
    type palette_t is array (0 to 255) of std_logic_vector(23 downto 0);   -- AGA Denise
    --type palette_t is array (0 to 31) of std_logic_vector(23 downto 0);     -- OCS/ECS Denise
    


    -- DUT signals
    signal clk           : std_logic := '0';
    signal clk7_en       : std_logic := '0';
    signal reg_address   : std_logic_vector(8 downto 0) := (others => '0');
    --signal data_in       : std_logic_vector(11 downto 0) := (others => '0');
    signal data_in       : std_logic_vector(15 downto 0) := (others => '0');
    signal aga           : std_logic := '1';
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
   
--    signal model_we_d        : std_logic := '0';
    
--    signal model_we      : std_logic := '0';
--    signal model_idx     : integer := 0;
--    signal model_r       : integer := 0;
--    signal model_g       : integer := 0;
--    signal model_b       : integer := 0;
    


    -- Constants
    constant COLORBASE : integer := 16#180#;

procedure aga_write_model (
    signal pal        : inout palette_t;
           idx        : in integer;
           comp       : in integer;        -- 0=B, 1=R, 2=G
           value      : in std_logic_vector(7 downto 0)    
    ) is
    variable tmp : std_logic_vector(23 downto 0);        
begin
    tmp := pal(idx);
    case comp is
        when 0 => tmp(7  downto 0) := value;
        when 1 => tmp(23 downto 16):= value;
        when 2 => tmp(15 downto 8) := value;
        when others => null;
    end case;
    pal(idx) <= tmp;
end procedure;



begin

--process
--begin
--    -- Run the simulation for 510,000 ns
--    wait for 510000 ns;
--    report "TB completed" severity note;
--    std.env.stop;    
--end process;

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
    uut: entity work.denise_colortable_AGA_wrapper
        port map (
             clk            => clk
            ,clk7_en        => clk7_en
            ,reg_address_in => reg_address(8 downto 1)
            ,data_in        => data_in
            ,aga            => aga
            ,rdram          => rdram
            ,selectx        => selectx
            ,bplxor         => bplxor
            ,bank           => bank
            ,loct           => loct
            ,ehb_en         => ehb_en
            ,rgb            => rgb
        );
        

        

-- Stage 1: latch write parameters
--process(clk)
--begin
--    if rising_edge(clk) then
--        if clk7_en = '1' then
--            model_we <= '0';  -- default
                
--            if unsigned(reg_address) >= COLORBASE and unsigned(reg_address) < COLORBASE + 512 then
--                model_idx <= to_integer((unsigned(reg_address) - COLORBASE) / 2);

--                if loct = '1' then
----                    model_r <= to_integer(unsigned(data_in(11 downto 8)));
----                    model_g <= to_integer(unsigned(data_in(7 downto 4)));
----                    model_b <= to_integer(unsigned(data_in(3 downto 0)));
--                    model_r <= to_integer(unsigned(data_in(23 downto 16)));
--                    model_g <= to_integer(unsigned(data_in(15 downto 8)));
--                    model_b <= to_integer(unsigned(data_in(7 downto 0)));
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

---- Stage 2: apply write one clk7_en later (matches XPM BRAM latency)
--process(clk)
---- Capture the module palette that was written to BRAM, used to later validated the Read back.
--begin
--    if rising_edge(clk) then
--        if clk7_en = '1' then
--            if model_we_d = '1' then
--                if model_idx < 256 then                  -- AGA Denise
--                    model_palette(model_idx) <=
--                        std_logic_vector(to_unsigned(model_r, 8)) &
--                        std_logic_vector(to_unsigned(model_g, 8)) &
--                        std_logic_vector(to_unsigned(model_b, 8));
--                end if;
--            end if;            
--        end if;
--    end if;
--end process;

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
--            report "model_palette(" & model_idx'image(model_idx) &  ")=" & slv_to_hex_any(model_palette(model_idx));
                                  
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
        variable comp     : integer;
        variable color_r  : integer;
        variable color_g  : integer;
        variable color_b  : integer;
        variable reg_idx  : integer;
    begin
        -- settle
        wait for 100 ns;

        ----------------------------------------------------------------
        -- Phase 1: write all 256 AGA entries with a deterministic pattern
        ----------------------------------------------------------------
        for idx in 0 to 255 loop
            color_r := (idx * 5) mod 256;
            color_g := (idx * 7) mod 256;
            color_b := (idx * 11) mod 256;

            -- COLORxx   (blue)
            --reg_idx      := COLORBASE + (idx * 3) + 0;
            reg_idx      := COLORBASE + (idx * 6) + 0;
            --reg_address  <= std_logic_vector(to_unsigned(reg_idx, 9));
            reg_address  <= std_logic_vector(to_unsigned(reg_idx/2, 9));
            data_in      <= (15 downto 8 => '0') & std_logic_vector(to_unsigned(color_b, 8));
            aga_write_model(model_palette, idx, 0, std_logic_vector(to_unsigned(color_b, 8)));
            wait until rising_edge(clk) and clk7_en = '1';

            -- COLORxx+1 (red)
            --reg_idx      := COLORBASE + (idx * 3) + 1;
            reg_idx      := COLORBASE + (idx * 6) + 2;
            --reg_address  <= std_logic_vector(to_unsigned(reg_idx, 9));
            reg_address  <= std_logic_vector(to_unsigned(reg_idx/2, 9));
            data_in      <= (15 downto 8 => '0') & std_logic_vector(to_unsigned(color_r, 8));
            aga_write_model(model_palette, idx, 1, std_logic_vector(to_unsigned(color_r, 8)));
            wait until rising_edge(clk) and clk7_en = '1';

            -- COLORxx+2 (green)
            --reg_idx      := COLORBASE + (idx * 3) + 2;
            reg_idx      := COLORBASE + (idx * 6) + 4;
            --reg_address  <= std_logic_vector(to_unsigned(reg_idx, 9));
            reg_address  <= std_logic_vector(to_unsigned(reg_idx/2, 9));
            data_in      <= (15 downto 8 => '0') & std_logic_vector(to_unsigned(color_g, 8));
            aga_write_model(model_palette, idx, 2, std_logic_vector(to_unsigned(color_g, 8)));
            wait until rising_edge(clk) and clk7_en = '1';
        end loop;

        -- idle a bit
        for idx in 0 to 10 loop
            wait until rising_edge(clk) and clk7_en = '1';
        end loop;

        ----------------------------------------------------------------
        -- Phase 2: read back all 256 entries and compare
        ----------------------------------------------------------------
        for idx in 0 to 255 loop
            selectx <= std_logic_vector(to_unsigned(idx, 8));

            wait until rising_edge(clk) and clk7_en = '1';  -- BRAM latency

            expected_rgb   <= model_palette(idx);
            expected_valid <= '1';

            wait until rising_edge(clk);  -- compare on next clk

            expected_valid <= '0';
        end loop;

        report "AGA palette TB completed successfully" severity note;
        wait;
    end process;

end architecture;
