----------------------------------------------------------------------------------
-- MiSTer2MEGA65 Framework
--
-- Wrapper for the MiSTer core that runs exclusively in the core's clock domanin
--
-- MiSTer2MEGA65 done by sy2002 and MJoergen in 2022 and licensed under GPL v3
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Main_Sig_pkg.all;
use work.video_modes_pkg.all;
use work.Amiga_Debug_pkg.all;
use work.Amiga_Debug_Sig_pkg.all;

entity main is
   generic (
      G_VDNUM                 : natural                     -- amount of virtual drives
   );
   port (
      --clk_main_i              : in  std_logic;
      reset_soft_i            : in  std_logic;
      reset_hard_i            : in  std_logic;
      pause_i                 : in  std_logic;

      -- MiSTer core main clock speed:
      -- Make sure you pass very exact numbers here, because they are used for avoiding clock drift at derived clocks
      clk_main_speed_i        : in  natural;
      main_clk_114_i          : in std_logic;
      main_clk_sys_i          : in std_logic;
      main_clk_video_i        : in std_logic;
      main_clk_audio_i        : in std_logic;      
      main_clk_locked_i       : in std_logic;
      main_rst_i              : in std_logic;
      
      main_osm_control_i      : in  std_logic_vector(255 downto 0);

      -- Video output
      video_ce_o              : out std_logic;
      video_ce_ovl_o          : out std_logic;
      video_red_o             : out std_logic_vector(7 downto 0);
      video_green_o           : out std_logic_vector(7 downto 0);
      video_blue_o            : out std_logic_vector(7 downto 0);
      video_vs_o              : out std_logic;
      video_hs_o              : out std_logic;
      video_hblank_o          : out std_logic;
      video_vblank_o          : out std_logic;
      video_clk_o             : out std_logic;      

      -- Audio output (Signed PCM)
      audio_left_o            : out signed(15 downto 0);
      audio_right_o           : out signed(15 downto 0);

      -- M2M Keyboard interface
      kb_key_num_i            : in  integer range 0 to 79;    -- cycles through all MEGA65 keys
      kb_key_pressed_n_i      : in  std_logic;                -- low active: debounced feedback: is kb_key_num_i pressed right now?

      -- MEGA65 joysticks and paddles/mouse/potentiometers
      joy_1_up_n_i            : in  std_logic;
      joy_1_down_n_i          : in  std_logic;
      joy_1_left_n_i          : in  std_logic;
      joy_1_right_n_i         : in  std_logic;
      joy_1_fire_n_i          : in  std_logic;

      joy_2_up_n_i            : in  std_logic;
      joy_2_down_n_i          : in  std_logic;
      joy_2_left_n_i          : in  std_logic;
      joy_2_right_n_i         : in  std_logic;
      joy_2_fire_n_i          : in  std_logic;

      pot1_x_i                : in  std_logic_vector(7 downto 0);
      pot1_y_i                : in  std_logic_vector(7 downto 0);
      pot2_x_i                : in  std_logic_vector(7 downto 0);
      pot2_y_i                : in  std_logic_vector(7 downto 0);
      
      -- LEDs
      config_col              : out std_logic_vector(1 downto 0);
      power_led_o             : out std_logic
      
   );
end entity main;

architecture RTL of main is
-- The signals types are declared in Main_Sig_pkg.vhd
signal ip   : IP_REC_TYPE;
signal op   : OP_REC_TYPE;
signal kbd  : KBD_REC_TYPE;
signal io   : IO_REC_TYPE;

signal rst_n    : std_logic;

-- Keyboard
signal keyboard_n          : std_logic_vector(79 downto 0);
signal kbd_mouse_type      : std_logic_vector(1 downto 0);
signal kbd_mouse_data      : std_logic_vector(7 downto 0);
    
-- Video
signal video_ce            : std_logic;
    
-- Audio
signal audio_left       : std_logic_vector(15 downto 0);
signal audio_right      : std_logic_vector(15 downto 0);
signal audio_s          : std_logic;



begin

-- IN Ports Mapping
--ip.clk_main             <= clk_main_i;
ip.reset_soft           <= reset_soft_i;
ip.reset_hard           <= reset_hard_i;
ip.pause                <= pause_i;

ip.clk_main_speed       <= clk_main_speed_i;
ip.main_clk_sys         <= main_clk_sys_i;
ip.main_clk_114         <= main_clk_114_i;
ip.main_clk_video       <= main_clk_video_i;
ip.main_clk_audio       <= main_clk_audio_i;
ip.main_clk_locked      <= main_clk_locked_i;
ip.main_rst             <= main_rst_i;

ip.main_osm_control     <= main_osm_control_i;

ip.kb_key_num           <= kb_key_num_i;
ip.kb_key_pressed_n     <= kb_key_pressed_n_i;

ip.joy_1_up_n           <= joy_1_up_n_i;
ip.joy_1_down_n         <= joy_1_down_n_i;
ip.joy_1_left_n         <= joy_1_left_n_i;
ip.joy_1_right_n        <= joy_1_right_n_i;
ip.joy_1_fire_n         <= joy_1_fire_n_i;

ip.joy_2_up_n           <= joy_2_up_n_i;
ip.joy_2_down_n         <= joy_2_down_n_i;
ip.joy_2_left_n         <= joy_2_left_n_i;
ip.joy_2_right_n        <= joy_2_right_n_i;
ip.joy_2_fire_n         <= joy_2_fire_n_i;

ip.pot1_x               <= pot1_x_i;
ip.pot1_y               <= pot1_y_i;
ip.pot2_x               <= pot2_x_i;
ip.pot2_y               <= pot2_y_i;

-- OUT Ports Mapping
video_ce_o              <= op.video_ce;
video_ce_ovl_o          <= op.video_ce_ovl;
video_red_o             <= op.video_red;
video_green_o           <= op.video_green;
video_blue_o            <= op.video_blue;
video_vs_o              <= op.video_vs;
video_hs_o              <= op.video_hs;
video_hblank_o          <= op.video_hblank;
video_vblank_o          <= op.video_vblank;
audio_left_o            <= op.audio_left;
audio_right_o           <= op.audio_right;
config_col              <= op.config_col;
power_led_o             <= op.power_led;

op.audio_left           <= signed(audio_left);
op.audio_right          <= signed(audio_right);


-----------------------------------------------------------------------
rst_n       <= not ip.reset_soft;

   -- On video_ce_o and video_ce_ovl_o: You have an important @TODO when porting a core:
   -- video_ce_o: You need to make sure that video_ce_o divides clk_main_i such that it transforms clk_main_i
   --             into the pixelclock of the core (means: the core's native output resolution pre-scandoubler)
   -- video_ce_ovl_o: Clock enable for the OSM overlay and for sampling the core's (retro) output in a way that
   --             it is displayed correctly on a "modern" analog input device: Make sure that video_ce_ovl_o
   --             transforms clk_main_o into the post-scandoubler pixelclock that is valid for the target
   --             resolution specified by VGA_DX/VGA_DY (globals.vhd)
   -- video_retro15kHz_o: '1', if the output from the core (post-scandoubler) in the retro 15 kHz analog RGB mode.
   --             Hint: Scandoubler off does not automatically mean retro 15 kHz on.
   video_ce_ovl_o <= video_ce_o;

---------------------------------------------------------------------------------------------------------
-- Apply the Configuration
Config_CORE : entity work.Config_Manager 
    port map (
--        clk                 => clk_main_i
        clk                 => ip.main_clk_sys               -- Needs to be the same clk as Minimig, i.e. 28 (clk_sys)
       ,reset_n               => rst_n
--       ,start_all           => '1'
       ,main_osm_control_i  => ip.main_osm_control
       ,io_wait             => io.io_wait
       ,io_ena              => io.io_uio
       ,io_strobe           => io.io_strobe
       ,io_din              => io.io_din
       ,config_col          => op.config_col
    );

   Amiga_keyboard : entity work.keyboard
      port map (
         clk                  => ip.main_clk_sys

         -- Interface to the MEGA65 keyboard
        ,key_num              => ip.kb_key_num
        ,key_pressed_n        => ip.kb_key_pressed_n
        ,kbd_mouse_type       => kbd.kbd_mouse_type
        ,kbd_mouse_data       => kbd.kbd_mouse_data          
      ); 

Amiga : entity work.AmigaM65
    port map (
        -- Input Clocks
        main_clk_114        => ip.main_clk_114
       ,main_clk_sys        => ip.main_clk_sys
       ,clk_audio           => ip.main_clk_audio
       ,main_clk_locked     => ip.main_clk_locked
       ,main_rst            => ip.main_rst
       ,reset               => ip.reset_soft
             
       -- Input UART
       -- Null input
       ,uart_cts            => '0'
       ,uart_rxd            => '0'
       ,uart_dsr            => '0'
       
       -- Video output
       ,vga_r               => video_red_o
       ,vga_g               => video_green_o
       ,vga_b               => video_blue_o
       ,vga_hs              => video_hs_o
       ,vga_vs              => video_vs_o
       ,ce_pixel            => video_ce       
       ,video_hblank        => video_hblank_o
       ,video_vblank        => video_vblank_o
       ,clk_video           => video_clk_o
            
       -- Audio output
       ,audio_l             => audio_left
       ,audio_r             => audio_right
       ,audio_s             => audio_s
       
       -- Keyboard Input
       ,kbd_mouse_type      => kbd.kbd_mouse_type
       ,kbd_mouse_data      => kbd.kbd_mouse_data 
       
       -- User Config
       ,io_uio              => io.io_uio
       ,io_strobe           => io.io_strobe
       ,io_din              => io.io_din
       ,io_wait             => io.io_wait
       ,io_fpga             => io.io_fpga       
       
       -- LEDs
       ,led_power(0)        => op.power_led
                                             
    );

end architecture;

