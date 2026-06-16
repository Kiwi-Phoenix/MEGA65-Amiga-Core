library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Pixel_Test_OCS is
    port (
        -- 28 MHz master clock (or whatever your board provides)
        clk_28mhz   : in std_logic;
        reset_n     : in std_logic;

        -- TB Signals
        clk_div_tb      : out unsigned(1 downto 0);  
        reset_sync_tb   : out std_logic;
        clk7_en_tb      : out std_logic;
        clk7_en_r_tb    : out std_logic;
        cck_tb          : out std_logic;
        c1_tb           : out std_logic;
        c3_tb           : out std_logic;
        chip48_tb       : out std_logic_vector(47 downto 0);
        reg_addr_tb     : out std_logic_vector(8 downto 1);
        hblank_tb       : out std_logic;
        vblank_tb       : out std_logic;
        x_hsync_tb      : out std_logic;
        x_vsync_tb      : out std_logic;
        strhor_den_tb   : out std_logic;
        strhor_paula_tb : out std_logic;
        
        address_in_tb   : out std_logic_vector(8 downto 1);
        data_in_tb      : out std_logic_vector(15 downto 0);
        chip_addr_tb    : out std_logic_vector(20 downto 1);
        data_out_tb     : out std_logic_vector(15 downto 0);
        
        hpos_tb         : out std_logic_vector(8 downto 0);
        hpos_den_tb     : out std_logic_vector(8 downto 0);
        vpos_tb         : out std_logic_vector(10 downto 0);
        hde_tb          : out std_logic;
        sol_tb          : out std_logic;
        sof_tb          : out std_logic;
        htotal_tb       : out std_logic_vector(8 downto 0);
        harddis_tb      : out std_logic;
        varbeamen_tb    : out std_logic;      
        
        aen_tb          : out std_logic;
        hwr_tb          : out std_logic;          
        lwr_tb          : out std_logic;          
               
                
        chip_preload_addr_tb : out std_logic_vector(23 downto 0);
        chip_preload_data_tb : out std_logic_vector(15 downto 0);
        chip_preload_rw_tb   : out std_logic;
        chip_preload_dma_tb  : out std_logic;
        chip_preload_l_tb    : out std_logic;
        chip_preload_u_tb    : out std_logic;

        -- Simple VGA-style outputs
        vga_r       : out std_logic_vector(7 downto 0);
        vga_g       : out std_logic_vector(7 downto 0);
        vga_b       : out std_logic_vector(7 downto 0);
        vga_hs      : out std_logic;
        vga_vs      : out std_logic
    );
end entity;

architecture rtl of Pixel_Test_OCS is

    --------------------------------------------------------------------
    -- Clocks
    --------------------------------------------------------------------
    signal clk7_en  : std_logic := '0';
    signal clk7_en_r  : std_logic := '0';
    signal cck      : std_logic := '0';
    signal c1, c3   : std_logic := '0';
    signal clk_div  : unsigned(1 downto 0) := (others => '0');

    --------------------------------------------------------------------
    -- Agnus (OCS)
    --------------------------------------------------------------------
    signal aen        : std_logic := '0';
    signal rd         : std_logic := '0';
    signal hwr        : std_logic := '0';
    signal lwr        : std_logic := '0';
    signal data_in    : std_logic_vector(15 downto 0) := (others => '0');
    signal data_out   : std_logic_vector(15 downto 0);
    signal reg_addr   : std_logic_vector(8 downto 1);
    signal address_in : std_logic_vector(8 downto 1);
    signal chip_addr  : std_logic_vector(20 downto 1);

    signal cpu_custom : std_logic := '1';
    signal dbr        : std_logic := '0';
    signal dbwe       : std_logic;

    signal x_hsync, x_vsync : std_logic;
    signal hblank, vblank   : std_logic;
    signal hde, sol, sof    : std_logic;
    signal strhor_den       : std_logic;
    signal htotal           : std_logic_vector(8 downto 0);

    --------------------------------------------------------------------
    -- Denise (OCS)
    --------------------------------------------------------------------
    signal chip48     : std_logic_vector(47 downto 0);
    signal den_red    : std_logic_vector(7 downto 0);
    signal den_green  : std_logic_vector(7 downto 0);
    signal den_blue   : std_logic_vector(7 downto 0);
    signal den_blank  : std_logic;
    signal den_data_out : std_logic_vector(15 downto 0);
    
    -- Tie-off Paula-related DMA for now
    signal audio_dmal   : std_logic_vector(3 downto 0) := (others => '0');
    signal audio_dmas   : std_logic_vector(3 downto 0) := (others => '0');
    signal disk_dmal    : std_logic := '0';
    signal disk_dmas    : std_logic := '0';
    signal floppy_speed : std_logic := '0';

    --------------------------------------------------------------------
    -- Reset
    --------------------------------------------------------------------
    signal reset_sync : std_logic := '1';
    signal reset_cnt  : integer range 0 to 15 := 0;
    
    signal clk7_en_cpu : std_logic := '0';

    -- Mode
    signal a1k, ecs, aga    : std_logic := '0';

    --------------------------------------------------------------------
    -- CPU write list (OCS registers only)
    --------------------------------------------------------------------
    --constant write_count : integer := 5;
    constant write_count : integer := 7;

    type write_array_addr_t is array(0 to write_count-1) of std_logic_vector(8 downto 1);
    type write_array_data_t is array(0 to write_count-1) of std_logic_vector(15 downto 0);

    constant write_addr : write_array_addr_t := (
         x"80"  -- BPLCON0 ($100)
        ,x"4B"  -- DMACON  ($096)
        ,x"47"  -- DIWSTRT ($08E)
        ,x"48"  -- DIWSTOP ($090)
        ,x"C0"  -- COLOR00 ($180)
        ,x"82"  -- COLOR01 ($182)
        ,x"88"  -- BPL1DAT ($110)                
    );

    constant write_data : write_array_data_t := (
        x"0200", -- BPLCON0: 1 bitplane
        x"8020", -- DMACON: DMAEN + BPLEN
--        x"2C81", -- DIWSTRT
        x"0081", -- DIWSTRT
--        x"2CC1", -- DIWSTOP
--        x"F4C1", -- DIWSTOP
        x"FEC1", -- DIWSTOP
        x"000F", -- COLOR00 = blue
        x"00F0", -- COLOR00 = green
        x"FFFF"  -- BPL1DAT = all 1s        
    );

    signal write_index : integer range 0 to write_count-1 := 0;

begin

-- Set Video mode, i.e. OCS, ECS, AGA
a1k <= '0';
ecs <= '0';
aga <= '0';

    --------------------------------------------------------------------
    reset_sync_tb <= reset_sync;
    clk_div_tb    <= clk_div;
    clk7_en_tb    <= clk7_en;  
    clk7_en_r_tb  <= clk7_en_cpu;
    cck_tb        <= cck;      
    c1_tb         <= c1;
    c3_tb         <= c3;
    chip48_tb     <= chip48;
    reg_addr_tb   <= reg_addr;
    data_out_tb   <= data_out;
    hblank_tb     <= hblank;
    vblank_tb     <= vblank;
    x_hsync_tb    <= x_hsync;
    x_vsync_tb    <= x_vsync;
    strhor_den_tb <= strhor_den;
    --strhor_paula_tb <= strhor_paula;
    
    address_in_tb <= address_in;
    data_in_tb    <= data_in;
    chip_addr_tb  <= chip_addr;
    
    hde_tb          <= hde;
    sol_tb          <= sol;
    sof_tb          <= sof;
    htotal_tb       <= htotal;
    --harddis_tb      <= harddis;
    --varbeamen_tb    <= varbeamen;        
    aen_tb          <= aen;
    hwr_tb          <= hwr;
    lwr_tb          <= hwr;
    
    --------------------------------------------------------------------
    -- Reset synchronizer
    --------------------------------------------------------------------
    rst_sync : process(clk_28mhz)
    begin
        if rising_edge(clk_28mhz) then
            if reset_n = '0' then
                reset_cnt  <= 0;
                reset_sync <= '1';
            else
                if reset_cnt < 10 then
                    reset_cnt  <= reset_cnt + 1;
                    reset_sync <= '1';
                else
                    reset_sync <= '0';
                end if;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------
    -- Clock divider (OCS)
    --------------------------------------------------------------------
clkgen_proc : process(clk_28mhz)
begin
  if rising_edge(clk_28mhz) then
    -- let clk_div free-run, even during reset_sync
    clk_div <= clk_div + 1;

    if clk_div = "00" then
      clk7_en <= '1';
    else
      clk7_en <= '0';
    end if;

    if clk_div(0) = '0' then
      cck <= '1';
    else
      cck <= '0';
    end if;

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
    -- CPU write sequencer (OCS)
    --------------------------------------------------------------------
process(clk_28mhz)
begin
    if rising_edge(clk_28mhz) then
        clk7_en_cpu <= clk7_en;
    end if;
end process;    
        
    cpu_proc : process(clk_28mhz)
    begin
        if rising_edge(clk_28mhz) then

            aen        <= '0';
            hwr        <= '0';
            lwr        <= '0';
            data_in    <= (others => '0');
            address_in <= (others => '0');

            if reset_sync = '1' then
                write_index <= 0;

            elsif clk7_en = '1' then            
            --elsif clk7_en_cpu = '1' then            
                aen        <= '1';
                hwr        <= '1';
                lwr        <= '1';
                address_in <= write_addr(write_index);
                data_in    <= write_data(write_index);

                if write_index < write_count-1 then
                    write_index <= write_index + 1;
                end if;
            end if;
        end if;
    end process;


syn_bitplane : process(clk_28mhz)
    variable cnt : unsigned(7 downto 0) := (others => '0');
begin
    if rising_edge(clk_28mhz) then 
        if reset_sync = '1' then
            cnt := (others => '0');
            chip48 <= (others => '0');
        else 
            if clk7_en = '1' then
                cnt := cnt + 1;
    
                if cnt(0) = '0' then
                    chip48(15 downto 0)   <= x"0000";
                    chip48(31 downto 16)  <= x"FFFF";
                    chip48(47 downto 32)  <= x"0000";
                else
                    chip48(15 downto 0)   <= x"FFFF";
                    chip48(31 downto 16)  <= x"0000";
                    chip48(47 downto 32)  <= x"FFFF";
                end if;
            end if;
        end if;
    end if;
    
end process;


    --------------------------------------------------------------------
    -- Agnus (OCS mode)
    --------------------------------------------------------------------
    u_agnus : entity work.agnus_wrapper_m65
        port map (
             clk             => clk_28mhz
            ,clk7_en         => clk7_en
            ,cck             => cck
            ,reset           => reset_sync
            ,aen             => aen
            ,rd              => rd
            ,hwr             => hwr
            ,lwr             => lwr
            ,data_in         => data_in
            ,data_out        => data_out
            ,address_in      => address_in
            ,address_out     => chip_addr
            ,reg_address_out => reg_addr
            ,cpu_custom      => cpu_custom
            ,dbr             => dbr
            ,dbwe            => dbwe
            ,x_hsync         => x_hsync
            ,x_vsync         => x_vsync
            ,hblank          => hblank
            ,vblank          => vblank
            ,hde             => hde
            ,sol             => sol
            ,sof             => sof
            ,strhor_denise   => strhor_den
            ,htotal          => htotal
            ,bls             => '0'
            ,ntsc            => '0'
            ,a1k             => a1k
            ,ecs             => ecs
            ,aga             => aga
            
            ,audio_dmal      => audio_dmal
            ,audio_dmas      => audio_dmas
            ,disk_dmal       => disk_dmal
            ,disk_dmas       => disk_dmas
            ,floppy_speed    => floppy_speed        
            ,vpos_tb         => vpos_tb
            ,hpos_tb         => hpos_tb                
        );

    --------------------------------------------------------------------
    -- Denise (OCS mode)
    --------------------------------------------------------------------
    den_blank <= hblank or vblank;
    --den_blank <= '0';       -- Denise handles blanking internally

    U_DENISE : entity work.denise_m65
        port map (
             clk             => clk_28mhz
            ,clk7_en         => clk7_en
            ,c1              => c1
            ,c3              => c3
            ,cck             => cck
            ,reset           => reset_sync
            ,strhor          => strhor_den
            ,reg_address_in  => reg_addr
            ,data_in         => data_out
            ,chip48          => chip48
            ,data_out        => den_data_out
            ,blank           => den_blank
            ,red             => den_red
            ,green           => den_green
            ,blue            => den_blue
            ,a1k             => a1k
            ,ecs             => ecs
            ,aga             => aga
            ,hpos_den_tb     => hpos_den_tb
        );

    --------------------------------------------------------------------
    -- VGA output
    --------------------------------------------------------------------
    vga_r <= den_red;
    vga_g <= den_green;
    vga_b <= den_blue;
    vga_hs <= x_hsync;
    vga_vs <= x_vsync;

end architecture;
