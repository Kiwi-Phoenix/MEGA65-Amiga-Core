-- Signals record types for Main module

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Main_Sig_pkg is
    attribute description : string;
    
    -- IN Ports
    type IP_REC_TYPE is record
        clk_main              : std_logic;
        reset_soft            : std_logic;
        reset_hard            : std_logic;
        pause                 : std_logic;
        
        clk_main_speed        : natural;
        main_clk_sys          : std_logic;
        main_clk_video        : std_logic;
        main_clk_audio        : std_logic;      
        main_clk_locked       : std_logic;
        main_rst              : std_logic;        
        
        main_osm_control      : std_logic_vector(255 downto 0);
    
        kb_key_num            : integer range 0 to 79;   
        kb_key_pressed_n      : std_logic;   
    
        -- MEGA65 joysticks and paddles/mouse/potentiometers
        joy_1_up_n            : std_logic;
        joy_1_down_n          : std_logic;
        joy_1_left_n          : std_logic;
        joy_1_right_n         : std_logic;
        joy_1_fire_n          : std_logic;
    
        joy_2_up_n            : std_logic;
        joy_2_down_n          : std_logic;
        joy_2_left_n          : std_logic;
        joy_2_right_n         : std_logic;
        joy_2_fire_n          : std_logic;
    
        pot1_x                : std_logic_vector(7 downto 0);
        pot1_y                : std_logic_vector(7 downto 0);
        pot2_x                : std_logic_vector(7 downto 0);
        pot2_y                : std_logic_vector(7 downto 0);          
    end record;
    
    -- OUT Ports
    type OP_REC_TYPE is record
          -- Video output
          video_ce              : std_logic;
          video_ce_ovl          : std_logic;
          video_red             : std_logic_vector(7 downto 0);
          video_green           : std_logic_vector(7 downto 0);
          video_blue            : std_logic_vector(7 downto 0);
          video_vs              : std_logic;
          video_hs              : std_logic;
          video_hblank          : std_logic;
          video_vblank          : std_logic;
    
          -- Audio output (Signed PCM)
          audio_left            : signed(15 downto 0);
          audio_right           : signed(15 downto 0);
          
          config_col              : std_logic_vector(1 downto 0);
          power_led               : std_logic;
    end record;
    
    -- Keyboard
    type KBD_REC_TYPE is record
        keyboard_n          : std_logic_vector(79 downto 0);
        kbd_mouse_type      : std_logic_vector(1 downto 0);
        kbd_mouse_data      : std_logic_vector(7 downto 0);
    end record;
    
    type IO_REC_TYPE is record
    -- User Configuration / Config Manager
      io_uio            : std_logic;                        -- Enable signal for USERIO
      io_strobe         : std_logic;  
      io_din            : std_logic_vector(15 downto 0);    -- Data for USERIO
      io_wait           : std_logic;
      io_fpga           : std_logic;                        -- Enable signal for Paula
      io_fpga_dout      : std_logic_vector(15 downto 0);     -- Data for Paula  
    end record;    
            
    
end package;