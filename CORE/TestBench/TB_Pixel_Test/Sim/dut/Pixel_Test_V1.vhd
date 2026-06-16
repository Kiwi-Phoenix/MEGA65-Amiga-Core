-- Module to allow for the testing of Agnus and Denise
-- The output is to be able to gnerate a pixel test on screen.
-- Once passed though Testbench, then test by running on actual FPGA hardware.
--
-- March 2026       David Raynor (Kiwi)
--
--



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Pixel_Test_V1 is
    port (
        clk28      : in  std_logic;   -- 28 MHz master clock
        reset_n    : in  std_logic;

        -- VGA output
        vga_r      : out std_logic_vector(7 downto 0);
        vga_g      : out std_logic_vector(7 downto 0);
        vga_b      : out std_logic_vector(7 downto 0);
        vga_hs     : out std_logic;
        vga_vs     : out std_logic
    );
end entity;

architecture rtl of Pixel_Test_V1 is

    --------------------------------------------------------------------
    -- Clock enables
    --------------------------------------------------------------------
    signal clk7_en   : std_logic := '0';
    signal cck       : std_logic := '0';  -- colour clock enable

    --------------------------------------------------------------------
    -- Agnus <-> RAM <-> Denise signals
    --------------------------------------------------------------------
    signal ag_addr_out     : std_logic_vector(20 downto 1);
    signal ag_reg_addr     : std_logic_vector(8 downto 1);
    signal ag_data_out     : std_logic_vector(15 downto 0);
    signal ag_data_in      : std_logic_vector(15 downto 0);
    signal ag_dbr          : std_logic;
    signal ag_dbwe         : std_logic;

    signal chip48          : std_logic_vector(47 downto 0);

    --------------------------------------------------------------------
    -- Denise outputs
    --------------------------------------------------------------------
    signal den_r, den_g, den_b : std_logic_vector(7 downto 0);
    signal hblank, vblank      : std_logic;
    signal hsync, vsync        : std_logic;
    
    --------------------------------------------------------------------
    -- Misc
    --------------------------------------------------------------------    
    signal reset               : std_logic;
    signal chipAddr            : std_logic_vector(24 downto 1);
    signal chipRW              : std_logic;
    signal blank               : std_logic;



begin

    --------------------------------------------------------------------
    -- Clock enable generation (placeholder)
    --------------------------------------------------------------------
    -- You will replace this with your real clocking logic.
    clk7_en <= '1' when rising_edge(clk28) else '0';
    cck     <= clk7_en;  -- simple placeholder

    --------------------------------------------------------------------
    reset <= not reset_n;    
    chipAddr    <= std_logic_vector(resize(unsigned(ag_addr_out), 24));    
    chipRW      <= not ag_dbwe;    
    blank       <= hblank or vblank;

    --------------------------------------------------------------------
    -- Instantiate Agnus wrapper
    --------------------------------------------------------------------
    U_AGNUS : entity work.agnus_wrapper
        port map (
            clk             => clk28,
            clk7_en         => clk7_en,
            cck             => cck,
            --reset           => not reset_n,
            reset           => reset,

            -- No CPU yet
            aen             => '0',
            rd              => '0',
            hwr             => '0',
            lwr             => '0',
            data_in         => (others => '0'),
            data_out        => ag_data_out,
            address_in      => (others => '0'),

            address_out     => ag_addr_out,
            reg_address_out => ag_reg_addr,
            cpu_custom      => open,
            dbr             => ag_dbr,
            dbwe            => ag_dbwe,

            x_hsync         => hsync,
            x_vsync         => vsync,
            x_csync         => open,
            field1          => open,
            lace            => open,
            hblank          => hblank,
            vblank          => vblank,
            hde             => open,
            sol             => open,
            sof             => open,
            vbl_int         => open,
            strhor_denise   => open,
            strhor_paula    => open,
            htotal          => open,
            harddis         => open,
            varbeamen       => open,
            int3            => open,

            audio_dmal      => (others => '0'),
            audio_dmas      => (others => '0'),
            disk_dmal       => '0',
            disk_dmas       => '0',
            bls             => '0',
            ntsc            => '0',
            a1k             => '0',
            ecs             => '0',
            aga             => '0',
            floppy_speed    => '0'
        );

    --------------------------------------------------------------------
    -- Instantiate RAM frontend
    --------------------------------------------------------------------
    U_RAM : entity work.ram_frontend_unified
        port map (
            sysclk      => clk28,
            reset_n     => reset_n,
            cache_rst   => '1',
            cache_inhibit_ext => '0',
            cpu_cache_ctrl => (others => '0'),

            -- CPU side unused
            cpuCS       => '0',
            cpuAddr     => (others => '0'),
            cpustate    => "01",
            cpuL        => '1',
            cpuU        => '1',
            cpuWR       => (others => '0'),
            cpuRD       => open,
            cpu_ack     => open,
            ramready    => open,

            -- CHIP side (Agnus)
            --chipAddr    => std_logic_vector(resize(unsigned(ag_addr_out), 24)),
            chipAddr    => chipAddr,
            chipL       => '0',
            chipU       => '0',
            --chipRW      => not ag_dbwe,
            chipRW      => chipRW,
            chipDMA     => ag_dbr,
            chipWR      => ag_data_out,

            chipRD      => ag_data_in,
            chip48      => chip48,
            chip48_1    => open,
            chip48_2    => open,
            chip48_3    => open,

            chipBurstLen => "001",
            chip_rd_done => open,
            dma_wr_done  => open
        );

    --------------------------------------------------------------------
    -- Instantiate Denise
    --------------------------------------------------------------------
    U_DENISE : entity work.denise
        port map (
            clk             => clk28,
            clk7_en         => clk7_en,
            c1              => '0',
            c3              => '0',
            cck             => cck,
            --reset           => not reset_n,
            reset           => reset,

            strhor          => '0',  -- we will wire this properly soon
            reg_address_in  => ag_reg_addr,
            data_in         => ag_data_out,
            chip48          => chip48,

            data_out        => open,
            --blank           => hblank or vblank,
            blank           => blank,

            red             => den_r,
            green           => den_g,
            blue            => den_b,

            a1k             => '0',
            ecs             => '0',
            aga             => '0',

            hires           => open,
            shres           => open
        );

    --------------------------------------------------------------------
    -- VGA output mapping
    --------------------------------------------------------------------
    vga_r <= den_r;
    vga_g <= den_g;
    vga_b <= den_b;
    vga_hs <= hsync;
    vga_vs <= vsync;

end architecture;