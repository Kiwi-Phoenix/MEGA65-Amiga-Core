library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Pixel_Test_V1_1 is
    port (
        -- 28 MHz master clock (or whatever your board provides)
        clk_28mhz   : in  std_logic;
        reset_n     : in  std_logic;

        -- Simple VGA-style outputs
        vga_r       : out std_logic_vector(7 downto 0);
        vga_g       : out std_logic_vector(7 downto 0);
        vga_b       : out std_logic_vector(7 downto 0);
        vga_hs      : out std_logic;
        vga_vs      : out std_logic
    );
end entity;

architecture rtl of Pixel_Test_V1_1 is

    --------------------------------------------------------------------
    -- Clocks / enables
    --------------------------------------------------------------------
    signal reset        : std_logic;
    signal clk7_en      : std_logic := '0';
    signal cck          : std_logic := '0';
    signal c1, c3       : std_logic := '0';

    -- Simple clock divider from 28 MHz -> 7 MHz enable, CCK, c1/c3
    signal clk_div      : unsigned(1 downto 0) := (others => '0');

    --------------------------------------------------------------------
    -- Agnus wrapper signals
    --------------------------------------------------------------------
    signal aen          : std_logic := '0';
    signal rd           : std_logic := '0';
    signal hwr          : std_logic := '0';
    signal lwr          : std_logic := '0';
    signal data_in      : std_logic_vector(15 downto 0) := (others => '0');
    signal data_out     : std_logic_vector(15 downto 0);
    signal reg_addr     : std_logic_vector(8 downto 1);
    signal chip_addr    : std_logic_vector(20 downto 1);
    signal cpu_custom   : std_logic;
    signal dbr          : std_logic;
    signal dbwe         : std_logic;

    signal x_hsync      : std_logic;
    signal x_vsync      : std_logic;
    signal x_csync      : std_logic;
    signal field1       : std_logic;
    signal lace         : std_logic;
    signal hblank       : std_logic;
    signal vblank       : std_logic;
    signal hde          : std_logic;
    signal sol          : std_logic;
    signal sof          : std_logic;
    signal vbl_int      : std_logic;
    signal strhor_den   : std_logic;
    signal strhor_paul  : std_logic;
    signal htotal       : std_logic_vector(8 downto 0);
    signal harddis      : std_logic;
    signal varbeamen    : std_logic;
    signal int3         : std_logic;

    -- Tie-off Paula-related DMA for now
    signal audio_dmal   : std_logic_vector(3 downto 0) := (others => '0');
    signal audio_dmas   : std_logic_vector(3 downto 0) := (others => '0');
    signal disk_dmal    : std_logic := '0';
    signal disk_dmas    : std_logic := '0';

    -- Config
    signal ntsc         : std_logic := '0'; -- PAL for now
    signal a1k          : std_logic := '0';
    signal ecs          : std_logic := '1';
    signal aga          : std_logic := '1';
    signal floppy_speed : std_logic := '0';

    --------------------------------------------------------------------
    -- Denise signals
    --------------------------------------------------------------------
    signal den_data_in  : std_logic_vector(15 downto 0) := (others => '0');
    signal den_data_out : std_logic_vector(15 downto 0);
    signal den_reg_addr : std_logic_vector(9-1 downto 1);

    signal chip48       : std_logic_vector(47 downto 0);

    signal den_red      : std_logic_vector(7 downto 0);
    signal den_green    : std_logic_vector(7 downto 0);
    signal den_blue     : std_logic_vector(7 downto 0);

    signal den_blank    : std_logic;

begin

    --------------------------------------------------------------------
    -- Reset
    --------------------------------------------------------------------
    reset <= not reset_n;

    --------------------------------------------------------------------
    -- Simple clock enable generation from 28 MHz
    -- clk_div: 00,01,10,11 -> repeat
    --------------------------------------------------------------------
    process(clk_28mhz, reset)
    begin
        if reset = '1' then
            clk_div <= (others => '0');
            clk7_en <= '0';
            cck     <= '0';
            c1      <= '0';
            c3      <= '0';
        elsif rising_edge(clk_28mhz) then
            clk_div <= clk_div + 1;

            -- 7 MHz enable: one tick every 4 cycles
            if clk_div = "00" then
                clk7_en <= '1';
            else
                clk7_en <= '0';
            end if;

            -- CCK: 3.5 MHz-ish, toggle every 2 cycles
            if clk_div(0) = '0' then
                cck <= '1';
            else
                cck <= '0';
            end if;

            -- crude c1/c3 strobes (you can refine later)
            --c1 <= '1' when clk_div = "01" else '0';
            --c3 <= '1' when clk_div = "11" else '0';
--            case clk_div is
--                when "01" =>
--                    c1 <= '1';
--                    c3 <= '0';
                
--                when "11" =>
--                    c1 <= '0';
--                    c3 <= '1';
                
--                when others =>
--                    c1 <= '0';
--                    c3 <= '0';
--            end case;
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
    -- Agnus wrapper instance
    --------------------------------------------------------------------
    u_agnus : entity work.agnus_wrapper
        port map (
            clk             => clk_28mhz,
            clk7_en         => clk7_en,
            cck             => cck,
            reset           => reset,
            aen             => aen,
            rd              => rd,
            hwr             => hwr,
            lwr             => lwr,
            data_in         => data_in,
            data_out        => data_out,
            address_in      => reg_addr,
            address_out     => chip_addr,
            reg_address_out => reg_addr,
            cpu_custom      => cpu_custom,
            dbr             => dbr,
            dbwe            => dbwe,
            x_hsync         => x_hsync,
            x_vsync         => x_vsync,
            x_csync         => x_csync,
            field1          => field1,
            lace            => lace,
            hblank          => hblank,
            vblank          => vblank,
            hde             => hde,
            sol             => sol,
            sof             => sof,
            vbl_int         => vbl_int,
            strhor_denise   => strhor_den,
            strhor_paula    => strhor_paul,
            htotal          => htotal,
            harddis         => harddis,
            varbeamen       => varbeamen,
            int3            => int3,
            audio_dmal      => audio_dmal,
            audio_dmas      => audio_dmas,
            disk_dmal       => disk_dmal,
            disk_dmas       => disk_dmas,
            bls             => '0',
            ntsc            => ntsc,
            a1k             => a1k,
            ecs             => ecs,
            aga             => aga,
            floppy_speed    => floppy_speed
        );

    --------------------------------------------------------------------
    -- Simple synthetic chip48 pattern generator
    -- For now: horizontal gradient based on some bits of chip_addr
    --------------------------------------------------------------------
    process(clk_28mhz, reset)
        variable cnt : unsigned(7 downto 0) := (others => '0');
    begin
        if reset = '1' then
            cnt := (others => '0');
            chip48 <= (others => '0');
        elsif rising_edge(clk_28mhz) then
            if clk7_en = '1' then
                cnt := cnt + 1;

                -- Very crude: replicate cnt into three 16-bit words
                chip48(15 downto 0)   <= std_logic_vector(cnt) & std_logic_vector(cnt(7 downto 0));
                chip48(31 downto 16)  <= std_logic_vector(cnt) & std_logic_vector(not cnt);
                chip48(47 downto 32)  <= std_logic_vector(not cnt) & std_logic_vector(cnt);
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    -- Denise instance
    --------------------------------------------------------------------
    den_blank <= hblank or vblank;

    u_denise : entity work.denise
        port map (
            clk             => clk_28mhz,
            clk7_en         => clk7_en,
            c1              => c1,
            c3              => c3,
            cck             => cck,
            reset           => reset,
            strhor          => strhor_den,
            reg_address_in  => den_reg_addr,
            data_in         => den_data_in,
            chip48          => chip48,
            data_out        => den_data_out,
            blank           => den_blank,
            red             => den_red,
            green           => den_green,
            blue            => den_blue,
            a1k             => a1k,
            ecs             => ecs,
            aga             => aga,
            hires           => open,
            shres           => open
        );

    --------------------------------------------------------------------
    -- VGA output mapping
    --------------------------------------------------------------------
    vga_r  <= den_red;
    vga_g  <= den_green;
    vga_b  <= den_blue;
    vga_hs <= x_hsync;
    vga_vs <= x_vsync;

end architecture;