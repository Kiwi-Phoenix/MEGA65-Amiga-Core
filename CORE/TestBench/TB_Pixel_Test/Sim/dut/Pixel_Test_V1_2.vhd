library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Pixel_Test_v1_2 is
    port (
        -- 28 MHz master clock (or whatever your board provides)
        clk_28mhz   : in std_logic;
        reset_n     : in std_logic;

        -- TB Signals
        clk_div_tb  : out unsigned(1 downto 0);  
        reset_sync_tb : out std_logic;
        clk7_en_tb  : out std_logic;
        cck_tb      : out std_logic;
        c1_tb       : out std_logic;
        c3_tb       : out std_logic;
        chip48_tb   : out std_logic_vector(47 downto 0);
        reg_addr_tb : out std_logic_vector(8 downto 1);
        data_out_tb : out std_logic_vector(15 downto 0);
        hblank_tb   : out std_logic;
        vblank_tb   : out std_logic;
        x_hsync_tb  : out std_logic;
        x_vsync_tb  : out std_logic;
        strhor_den_tb   : out std_logic;
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

architecture rtl of Pixel_Test_V1_2 is

    --------------------------------------------------------------------
    -- Clocks / enables
    --------------------------------------------------------------------
--    signal reset        : std_logic;
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
    signal address_in   : std_logic_vector(8 downto 1);
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


    --------------------------------------------------------------------
    -- Misc
    --------------------------------------------------------------------   
    signal chipAddr            : std_logic_vector(24 downto 1);
    signal chipRW              : std_logic;
    signal chipL               : std_logic;
    signal chipU               : std_logic;   


-----------------------------------------------------------
-- Setting up the Copper list 
-----------------------------------------------------------

type copper_array_t is array (0 to 7) of std_logic_vector(15 downto 0);

constant copper_list : copper_array_t := (
    0 => x"0180",  -- COLOR00
    1 => x"0F00",
    2 => x"0182",  -- COLOR01
    3 => x"00F0",
    4 => x"0184",  -- COLOR02
    5 => x"000F",
    6 => x"FFFF",  -- END
    7 => x"FFFE"
);

signal chip_preload_addr : std_logic_vector(23 downto 0);
signal chip_preload_data : std_logic_vector(15 downto 0);
signal chip_preload_rw   : std_logic;
signal chip_preload_dma  : std_logic;
signal chip_preload_l    : std_logic;
signal chip_preload_u    : std_logic;

signal reset_sync : std_logic := '1';
signal reset_sync_n : std_logic;
signal reset_cnt  : integer range 0 to 15 := 0;

type cpu_state_t is (CPU_IDLE, CPU_DMACON, CPU_DIWSTRT, CPU_DIWSTOP, CPU_COLOR00, CPU_DONE);
signal cpu_state : cpu_state_t := CPU_IDLE;
signal cpu_delay : integer := 0;


begin

    --------------------------------------------------------------------
    -- Reset
    --------------------------------------------------------------------
--    reset <= not reset_n;
     
    
    --------------------------------------------------------------------
    chipAddr    <= std_logic_vector(resize(unsigned(reg_addr), 24));    
    chipRW      <= not dbwe;    
    chipL       <= not lwr;
    chipU       <= not hwr;
    
    --------------------------------------------------------------------
    reset_sync_tb <= reset_sync;
    clk_div_tb    <= clk_div;
    clk7_en_tb    <= clk7_en;  
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
    chip_preload_addr_tb    <= chip_preload_addr;
    chip_preload_data_tb    <= chip_preload_data;
    chip_preload_rw_tb      <= chip_preload_rw;   
    chip_preload_dma_tb     <= chip_preload_dma;
    chip_preload_l_tb       <= chip_preload_l;
    chip_preload_u_tb       <= chip_preload_u;
    
-- For this experiment only:
--den_blank   <= '0';
--strhor_den  <= '0';
--reg_addr    <= (others => '0');
--data_out    <= (others => '0');
--chip48      <= (others => '0');
--clk7_en     <= '0';
--cck         <= '0';
--c1          <= '0';
--c3          <= '0';



-- keep chip48 driven by syn_bitplane as you already do

rst_sync: process(clk_28mhz)
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
    
--reset_sync <= '1';  -- comment out the counter logic and just tie it high    
--reset_sync <= '0';  -- comment out the counter logic and just tie it high    
    
--------------------------------------------------------------------
-- Preload chip RAM with Copper list at reset
--------------------------------------------------------------------
preload_proc : process(clk_28mhz)
    variable idx : integer := 0;
begin
    if rising_edge(clk_28mhz) then
        if reset_sync = '1' then
            idx := 0;
    
            -- Default inactive
            chip_preload_dma  <= '0';
            chip_preload_rw   <= '0';
            chip_preload_l    <= '1';
            chip_preload_u    <= '1';
            chip_preload_addr <= (others => '0');
            chip_preload_data <= (others => '0');
            
            --hblank  <= '0';
            --vblank  <= '0';
        else
            if idx < copper_list'length then
                -- Drive write cycle
                chip_preload_dma  <= '1';         -- pretend Agnus DMA
                chip_preload_rw   <= '1';         -- write
                chip_preload_l    <= '0';         -- write both bytes
                chip_preload_u    <= '0';
                chip_preload_addr <= std_logic_vector(to_unsigned(idx, 24));
                chip_preload_data <= copper_list(idx);
    
                idx := idx + 1;
    
                else
                -- Stop writing
                chip_preload_dma  <= '0';
                chip_preload_rw   <= '0';
                chip_preload_l    <= '1';
                chip_preload_u    <= '1';
            end if;
        end if;
    end if;
    
end process;    
    
    
    --------------------------------------------------------------------
    -- Simple clock enable generation from 28 MHz
    -- clk_div: 00,01,10,11 -> repeat
    --------------------------------------------------------------------
--clkgen_proc : process(clk_28mhz, reset_sync)
--begin
--    if reset_sync = '1' then
--        clk_div <= (others => '0');
--        clk7_en <= '0';
--        cck     <= '0';
--        c1      <= '0';
--        c3      <= '0';

--    elsif rising_edge(clk_28mhz) then

--        -- increment divider
--        clk_div <= clk_div + 1;

--        -- clk7_en = 1 only when clk_div = "00"
--        if clk_div = "00" then
--            clk7_en <= '1';
--        else
--            clk7_en <= '0';
--        end if;

--        -- cck = 1 when clk_div(0) = '0'
--        if clk_div(0) = '0' then
--            cck <= '1';
--        else
--            cck <= '0';
--        end if;

--        -- c1 = 1 when clk_div = "01"
--        if clk_div = "01" then
--            c1 <= '1';
--        else
--            c1 <= '0';
--        end if;

--        -- c3 = 1 when clk_div = "11"
--        if clk_div = "11" then
--            c3 <= '1';
--        else
--            c3 <= '0';
--        end if;

--    end if;
--end process;

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
-- Fake CPU write sequencer
--------------------------------------------------------------------

cpu_proc : process(clk_28mhz)
begin
  if rising_edge(clk_28mhz) then
    if reset_sync = '1' then
      aen       <= '0';
      rd        <= '0';
      hwr       <= '0';
      lwr       <= '0';
      data_in   <= (others => '0');
      address_in<= (others => '0');
      cpu_state <= CPU_IDLE;
      cpu_delay <= 0;
    elsif clk7_en = '1' then
      -- defaults for this 7 MHz cycle
      aen       <= '0';
      rd        <= '0';
      hwr       <= '0';
      lwr       <= '0';
      data_in   <= (others => '0');
      address_in<= (others => '0');

      case cpu_state is
        when CPU_IDLE =>
          if cpu_delay < 20 then
            cpu_delay <= cpu_delay + 1;
          else
            cpu_state <= CPU_DMACON;
          end if;

        when CPU_DMACON =>
          aen       <= '1';
          hwr       <= '1';
          address_in<= x"4B";
          data_in   <= x"83E0";
          cpu_state <= CPU_DIWSTRT;

        when CPU_DIWSTRT =>
          aen       <= '1';
          hwr       <= '1';
          address_in<= x"47";
          data_in   <= x"2C81";
          cpu_state <= CPU_DIWSTOP;

        when CPU_DIWSTOP =>
          aen       <= '1';
          hwr       <= '1';
          address_in<= x"48";
          data_in   <= x"2CC1";
          cpu_state <= CPU_COLOR00;

        when CPU_COLOR00 =>
          aen       <= '1';
          hwr       <= '1';
          address_in<= x"C0";
          data_in   <= x"000F";
          cpu_state <= CPU_DONE;

        when CPU_DONE =>
          null;
      end case;
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
            --reset           => reset,
            reset           => reset_sync,
            aen             => aen,
            --aen             => '0',
            rd              => rd,
            --rd              => '0',
            hwr             => hwr,
            --hwr             => '0',
            lwr             => lwr,
            --lwr             => '0',
            data_in         => data_in,
            --data_in         => (others => '0'),
            data_out        => data_out,
            --address_in      => reg_addr,
            --address_in      => (others => '0'),
            address_in      => address_in,
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


reset_sync_n <= not reset_sync;

--U_RAM : entity work.ram_frontend_unified
--    port map (
--        sysclk      => clk_28mhz,
--        --reset_n     => reset_n,
--        reset_n     => reset_sync_n,
--        cache_rst   => '1',
--        cache_inhibit_ext => '0',
--        cpu_cache_ctrl => (others => '0'),

--        -- CPU side unused
--        cpuCS       => '0',
--        cpuAddr     => (others => '0'),
--        cpustate    => "01",
--        cpuL        => '1',
--        cpuU        => '1',
--        cpuWR       => (others => '0'),
--        cpuRD       => open,
--        cpu_ack     => open,
--        ramready    => open,

--        -- CHIP side (Agnus)
----        chipAddr    => chipAddr,
----        chipL       => chipL,     -- Agnus low byte write
----        chipU       => chipU,     -- Agnus high byte write
----        chipRW      => chipRW, -- 1=write, 0=read (RAM expects opposite)
----        chipDMA     => dbr,
----        chipWR      => data_out,
        
--        chipAddr => chip_preload_addr,
--        chipL    => chip_preload_l,
--        chipU    => chip_preload_u,
--        chipRW   => chip_preload_rw,
--        chipDMA  => chip_preload_dma,
--        chipWR   => chip_preload_data,


--        chipRD      => data_in,
--        chip48      => chip48,
--        chip48_1    => open,
--        chip48_2    => open,
--        chip48_3    => open,

--        chipBurstLen => "001",
--        chip_rd_done => open,
--        dma_wr_done  => open
--    );




    --------------------------------------------------------------------
    -- Denise instance
    --------------------------------------------------------------------
    den_blank <= hblank or vblank;
    

U_DENISE : entity work.denise_m65
    port map (
        clk             => clk_28mhz,
        clk7_en         => clk7_en,
        c1              => c1,
        c3              => c3,
        cck             => cck,
        --reset           => reset,
        reset           => reset_sync,

        strhor          => strhor_den,
        reg_address_in  => reg_addr,
        data_in         => data_out,
        chip48          => chip48,

        --data_out        => open,
        data_out        => den_data_out,
        blank           => den_blank,

        red             => den_red,
        green           => den_green,
        blue            => den_blue,

        a1k             => '0',
        ecs             => '1',
        aga             => '1',

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