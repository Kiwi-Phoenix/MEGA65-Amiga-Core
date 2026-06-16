library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.debug_utils_pkg.all;

entity pixel_test_tb is
end entity;

architecture sim of pixel_test_tb is

    --------------------------------------------------------------------
    -- DUT signals
    --------------------------------------------------------------------
    signal clk_28mhz : std_logic := '0';
    signal reset_n   : std_logic := '0';
        
    signal clk_div      : unsigned(1 downto 0) := (others => '0');
    signal reset_sync   : std_logic;
    signal clk7_en      : std_logic := '0';
    signal clk7_en_r    : std_logic := '0';
    signal cck          : std_logic := '0';
    signal c1           : std_logic := '0';
    signal c3           : std_logic := '0';
    signal chip48       : std_logic_vector(47 downto 0);
    signal reg_addr     : std_logic_vector(8 downto 1);
    signal hblank       : std_logic;
    signal vblank       : std_logic;
    signal x_hsync      : std_logic;
    signal x_vsync      : std_logic;
    signal strhor_den   : std_logic;
--    signal strhor_paula : std_logic;
    
    signal hpos         : std_logic_vector(8 downto 0);
    signal hpos_den_tb  : std_logic_vector(8 downto 0);
    signal vpos         : std_logic_vector(10 downto 0);
    signal hde          : std_logic;
    signal sol          : std_logic;
    signal sof          : std_logic;
    signal htotal       : std_logic_vector(8 downto 0);
--    signal harddis      : std_logic;
--    signal varbeamen    : std_logic;
    
    signal address_in   : std_logic_vector(8 downto 1);
    signal data_in      : std_logic_vector(15 downto 0);
    signal chip_addr    : std_logic_vector(20 downto 1);
    signal data_out     : std_logic_vector(15 downto 0);    
    
    signal aen          : std_logic;
    signal hwr, lwr     : std_logic;
    
    signal chip_preload_addr : std_logic_vector(23 downto 0);
    signal chip_preload_data : std_logic_vector(15 downto 0);
    signal chip_preload_rw   : std_logic;
    signal chip_preload_dma  : std_logic;
    signal chip_preload_l    : std_logic;
    signal chip_preload_u    : std_logic;
    

    signal vga_r     : std_logic_vector(7 downto 0);
    signal vga_g     : std_logic_vector(7 downto 0);
    signal vga_b     : std_logic_vector(7 downto 0);
    signal vga_hs    : std_logic;
    signal vga_vs    : std_logic;

begin

    --------------------------------------------------------------------
    -- Clock generation: 28 MHz
    -- Period = 35.714 ns (approx)
    --------------------------------------------------------------------
    clk_process : process
    begin
        clk_28mhz <= '0';
        wait for 17.857 ns;
        clk_28mhz <= '1';
        wait for 17.857 ns;
    end process;

    --------------------------------------------------------------------
    -- Reset pulse
    --------------------------------------------------------------------
    reset_process : process
    begin
        reset_n <= '0';
        wait for 200 ns;
        reset_n <= '1';
        wait;
    end process;

    --------------------------------------------------------------------
    -- Instantiate the Device Under Test (DUT)
    --------------------------------------------------------------------
    --DUT : entity work.Pixel_Test
    DUT : entity work.Pixel_Test_OCS
        port map (
             clk_28mhz => clk_28mhz
            ,reset_n   => reset_n
            ,vga_r     => vga_r
            ,vga_g     => vga_g
            ,vga_b     => vga_b
            ,vga_hs    => vga_hs
            ,vga_vs    => vga_vs
            
            -- TB Signals
            ,reset_sync_tb => reset_sync
            ,clk_div_tb  => clk_div
            ,clk7_en_tb  => clk7_en
            ,clk7_en_r_tb  => clk7_en_r
            ,cck_tb      => cck
            ,c1_tb       => c1
            ,c3_tb       => c3
            ,chip48_tb   => chip48
            ,reg_addr_tb    => reg_addr    
            ,hblank_tb      => hblank
            ,vblank_tb      => vblank
            ,x_hsync_tb     => x_hsync
            ,x_vsync_tb     => x_vsync
            ,strhor_den_tb  => strhor_den
--            ,strhor_paula_tb  => strhor_paula
            
            ,address_in_tb  => address_in
            ,chip_addr_tb   => chip_addr      
            ,data_in_tb     => data_in
            ,data_out_tb    => data_out            
                        
            ,chip_preload_addr_tb    => chip_preload_addr
            ,chip_preload_data_tb    => chip_preload_data
            ,chip_preload_rw_tb      => chip_preload_rw
            ,chip_preload_dma_tb     => chip_preload_dma
            ,chip_preload_l_tb       => chip_preload_l
            ,chip_preload_u_tb       => chip_preload_u
            
            ,hpos_tb        => hpos
            ,hpos_den_tb    => hpos_den_tb
            ,vpos_tb        => vpos
            ,hde_tb         => hde
            ,sol_tb         => sol
            ,sof_tb         => sof
            ,htotal_tb      => htotal
--            ,harddis_tb     => harddis
--            ,varbeamen_tb   => varbeamen            
            ,aen_tb         => aen
            ,hwr_tb         => hwr                        
            ,lwr_tb         => lwr                                                            
        );

    --------------------------------------------------------------------
    -- Simulation control
    --------------------------------------------------------------------
    sim_end : process
    begin
        -- Run long enough to see several frames
        wait for 40 ms;
        assert false report "Simulation finished." severity failure;
    end process;

debug_report : process (clk_28mhz)
variable cycle : integer := 0;
begin
    cycle := cycle + 1;
--    report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," &
--           "PIXEL: "                    & "," &
--           "reset_n=" & sl_to_str(reset_n) & "," &
--           "reset_sync=" & sl_to_str(reset_sync) & "," &
--           "clk_div=" & integer'image(to_integer(clk_div)) & "," &
--           "clk7_en=" & sl_to_str(clk7_en) & "," &
--           "clk7_en_r=" & sl_to_str(clk7_en_r) & "," &
--           "cck="     & sl_to_str(cck)      & "," &
--           "c1="      & sl_to_str(c1)       & "," &
--           "c3="      & sl_to_str(c3)       & "," &
--           "chip48="  & slv_to_hex_any(chip48) & "," &
--           --"chip48="  & slv_to_str(chip48) & "," &
--           "reg_addr=" & slv_to_hex_any(reg_addr) & "," &
--           "hblank="   & sl_to_str(hblank)         & "," &
--           "vblank="   & sl_to_str(vblank)         & "," &
--           "strhor_den=" & sl_to_str(strhor_den)   & "," &
--           "address_in=" & slv_to_hex_any(address_in) & "," &
--           "Chip_Addr=" & slv_to_hex_any(Chip_Addr) & "," &
--           "data_in=    " & slv_to_hex_any(data_in) & "," &
--           "data_out=" & slv_to_hex_any(data_out) & "," &
           
--           "hpos="     & slv_to_hex_any(hpos)        & "," &                  
--           "vpos="     & slv_to_hex_any(vpos)        & "," &        
--           "hde="      & sl_to_str(hde)              & "," &   
--           "sol="      & sl_to_str(sol)              & "," &   
--           "sof="      & sl_to_str(sof)              & "," &   
--           "htotal="   & slv_to_hex_any(htotal)      & "," &   
----           "harddis="  & sl_to_str(harddis)          & "," &
----           "varbeamen="  & sl_to_str(varbeamen)      & "," &

----           "chip_preload_addr=" & slv_to_hex_any(chip_preload_addr) & "," &
----           "chip_preload_data=" & slv_to_hex_any(chip_preload_data) & "," &
----           "chip_preload_rw=" & sl_to_str(chip_preload_rw) & "," &
----           "chip_preload_dma=" & sl_to_str(chip_preload_dma) & "," &
----           "chip_preload_l=" & sl_to_str(chip_preload_l) & "," &
----           "chip_preload_u=" & sl_to_str(chip_preload_u) & "," &
           
--           --"vga_r=" & slv_to_hex_any(vga_r)            & "," &
--           --"vga_g=" & slv_to_hex_any(vga_g)            & "," &
--           --"vga_b=" & slv_to_hex_any(vga_b)            & "," &
--           "vga_r=" & slv_to_str(vga_r)            & "," &
--           "vga_g=" & slv_to_str(vga_g)            & "," &
--           "vga_b=" & slv_to_str(vga_b)            & "," &           
--           "vga_hs=" & sl_to_str(vga_hs)               & "," &
--           "vga_vs=" & sl_to_str(vga_vs)               & "," &
--        "";
-- Trying to keep the log small
--    report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," &
--           "PIXEL: "                    & "," &

--           "reset_sync=" & sl_to_str(reset_sync) & "," &
--           "clk_div=" & integer'image(to_integer(clk_div)) & "," &
--           "clk7_en=" & sl_to_str(clk7_en) & "," &
--           "cck="     & sl_to_str(cck)      & "," &
----           "hpos="     & slv_to_hex_any(hpos)        & "," &                  
--           "hpos="     & slv_to_str(hpos)        & "," &                  
----           "vpos="     & slv_to_hex_any(vpos)        & "," &
--           "vpos="     & slv_to_str(vpos)        & "," &
--           "hblank="   & sl_to_str(hblank)         & "," &
--           "vblank="   & sl_to_str(vblank)         & "," &
--           "hde="      & sl_to_str(hde)              & "," &                      

--           "strhor_den=" & sl_to_str(strhor_den)   & "," &
--           "x_hsync=" & sl_to_str(x_hsync)         & "," &
--           "x_vsync=" & sl_to_str(x_vsync)         & "," &
--           "vga_r=" & slv_to_str(vga_r)            & "," &
--           "vga_g=" & slv_to_str(vga_g)            & "," &
--           "vga_b=" & slv_to_str(vga_b)            & "," &
          
--        "";

    report "[CYCLE " & integer'image(cycle) & " Time=" & time_to_str(now) & "]" & "," &
           "PIXEL: "                    & "," &
           "reset_n=" & sl_to_str(reset_n) & "," &
           "reset_sync=" & sl_to_str(reset_sync) & "," &
           "clk_div=" & integer'image(to_integer(clk_div)) & "," &
           "clk7_en=" & sl_to_str(clk7_en) & "," &
           "clk7_en_r=" & sl_to_str(clk7_en_r) & "," &
           "cck="     & sl_to_str(cck)      & "," &
           "c1="      & sl_to_str(c1)       & "," &
           "c3="      & sl_to_str(c3)       & "," &
           
           
           "address_in=" & slv_to_hex_any(address_in) & "," &
           "data_in=    " & slv_to_hex_any(data_in) & "," &
           "aen="      & sl_to_str(aen)       & "," &
           "hwr="      & sl_to_str(hwr)       & "," &
           "lwr="      & sl_to_str(lwr)       & "," &
           "reg_addr=" & slv_to_hex_any(reg_addr) & "," &
           "data_out=" & slv_to_hex_any(data_out) & "," &
           "hde="      & sl_to_str(hde)              & "," &   
           "sol="      & sl_to_str(sol)              & "," &   
           "sof="      & sl_to_str(sof)              & "," &   
           "htotal="   & slv_to_hex_any(htotal)      & "," &
           "hpos="     & slv_to_hex_any(hpos)        & "," &                  
           "vpos="     & slv_to_hex_any(vpos)        & "," &           
           "vga_r=" & slv_to_str(vga_r)            & "," &
           "vga_g=" & slv_to_str(vga_g)            & "," &
           "vga_b=" & slv_to_str(vga_b)            & "," &
           
           
                      
--           "chip48="  & slv_to_hex_any(chip48) & "," &
--           --"chip48="  & slv_to_str(chip48) & "," &
           
--           "hblank="   & sl_to_str(hblank)         & "," &
--           "vblank="   & sl_to_str(vblank)         & "," &
--           "strhor_den=" & sl_to_str(strhor_den)   & "," &
           
--           "Chip_Addr=" & slv_to_hex_any(Chip_Addr) & "," &                              
        
              
----           "harddis="  & sl_to_str(harddis)          & "," &
----           "varbeamen="  & sl_to_str(varbeamen)      & "," &

----           "chip_preload_addr=" & slv_to_hex_any(chip_preload_addr) & "," &
----           "chip_preload_data=" & slv_to_hex_any(chip_preload_data) & "," &
----           "chip_preload_rw=" & sl_to_str(chip_preload_rw) & "," &
----           "chip_preload_dma=" & sl_to_str(chip_preload_dma) & "," &
----           "chip_preload_l=" & sl_to_str(chip_preload_l) & "," &
----           "chip_preload_u=" & sl_to_str(chip_preload_u) & "," &
           
--           --"vga_r=" & slv_to_hex_any(vga_r)            & "," &
--           --"vga_g=" & slv_to_hex_any(vga_g)            & "," &
--           --"vga_b=" & slv_to_hex_any(vga_b)            & "," &
           
--           "vga_hs=" & sl_to_str(vga_hs)               & "," &
--           "vga_vs=" & sl_to_str(vga_vs)               & "," &
        "";
end process;



end architecture;
