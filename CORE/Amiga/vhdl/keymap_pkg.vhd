-- Mega65 to Amiga keyboard code mappings.
-- Transalate between the incoming M65 key codes to send Amiga key codes to the Amiga Core.
--
--
-- Aug 2025     David Raynor (Kiwi)
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.M65_Keycode_pkg.all;


package keymap_pkg is
    constant KEY_WIDTH       : natural := 8;
    constant MIN_INSTRUCTION : integer := 0;
    constant MAX_INSTRUCTION : integer := 255;

subtype byte_t is std_logic_vector(7 downto 0);

function amiga_keycode (i :  integer) return byte_t;


end package keymap_pkg;


package body keymap_pkg is 
    function amiga_keycode ( i : integer)
        return byte_t is
      begin
      if i < MIN_INSTRUCTION or i > MAX_INSTRUCTION then
        return (others => '0');
      end if;
      
      -- Mapping M65 Key codes to Amiga Key codes
      case i is
                        
        when m65_1              => return x"01";
        when m65_2              => return x"02";
        when m65_3              => return x"03";
        when m65_4              => return x"04";                              
        when m65_5              => return x"05";    
        when m65_6              => return x"06";
        when m65_7              => return x"07";
        when m65_8              => return x"08";
        when m65_9              => return x"09";
        when m65_0              => return x"0A";   -- Zero

        when m65_plus           => return x"5E";                     
        when m65_minus          => return x"4A";
        when m65_asterisk       => return x"5D";                
        when m65_slash          => return x"3A";    
        when m65_equal          => return x"0C";                           

        when m65_a              => return x"20";
        when m65_b              => return x"35";
        when m65_c              => return x"33";
        when m65_d              => return x"22";
        when m65_e              => return x"12";        
        when m65_f              => return x"23";
        when m65_g              => return x"24";        
        when m65_h              => return x"25";
        when m65_i              => return x"17";      
        when m65_j              => return x"26";                
        when m65_k              => return x"27";
        when m65_l              => return x"28";
        when m65_m              => return x"37";
        when m65_n              => return x"36";
        when m65_o              => return x"18";
        when m65_p              => return x"19";
        when m65_q              => return x"10";                                                                          
        when m65_r              => return x"13";      
        when m65_s              => return x"21";        
        when m65_t              => return x"14";
        when m65_u              => return x"16";
        when m65_v              => return x"34";
        when m65_w              => return x"11";                     
        when m65_x              => return x"32";            
        when m65_y              => return x"15";      
        when m65_z              => return x"31";      

        when m65_space          => return x"40";                                                               
        when m65_dot            => return x"3C";                     
        when m65_comma          => return x"38";
        when m65_colon          => return x"6E";   -- Needs to be Shift ';" Semicolon Key.  ?? Undefined                    
        when m65_at             => return x"6D";   -- Needs to be Shift "2" key  ???  Undefined                 
        when m65_semicolon      => return x"29";   -- Note: the Shift char is different on the Amiga keyboard                              
        when m65_gbp            => return x"6B";   -- Undefined                      

        when m65_return         => return x"44";                                  
        when m65_tab            => return x"42";
        when m65_left_shift     => return x"60";
        when m65_right_shift    => return x"61";        
        when m65_capslock       => return x"62";                                 
        when m65_ctrl           => return x"63";
        when m65_alt            => return x"64";   -- Left Alt Key        
        when m65_f13            => return x"65";   -- Right Alt Key
        when m65_mega           => return x"66";   -- Amiga Left key
        when m65_f11            => return x"67";   -- Amiga Right Key                                                                      

        when m65_up_crsr        => return x"4C";   -- Up Arrow Cursor                         
        when m65_vert_crsr      => return x"4D";   -- Down Arrow Cursor
        when m65_horz_crsr      => return x"4E";   -- Forward Arrow Cursor
        when m65_left_crsr      => return x"4F";   -- Backward Arrow Cursor        

--        when m65_clr_home       => return x"6C";   -- Undefined
        when m65_clr_home       => return x"41";   -- Back Space
        when m65_ins_del        => return x"46";   -- Del
        when m65_arrow_left     => return x"00";   -- Tilda                 

--        when m65_run_stop       => return x"6D";   -- Undefined  -- Map to ESC key - easy to hit by accident when ESC is intended
        when m65_run_stop       => return x"45";   -- Map to ESC key - easy to hit by accident when ESC is intended, otherwise not needed.
        when m65_esc            => return x"45";        
        when m65_no_scrl        => return x"6E";   -- Undefined
                                                
        when m65_f1             => return x"50";   -- F2 = x"51"  Mega is on Shift     
        when m65_f3             => return x"52";   -- F4 = x"53"
        when m65_f5             => return x"54";   -- F6 = x"55"
        when m65_f7             => return x"56";   -- F8 = x"57"
        when m65_f9             => return x"58";   -- F10 = "x59"                         
--        when m65_f11            => return x"6F";   -- Undefined                         
--        when m65_f13            => return x"70";   -- Undefined     
        when m65_help           => return x"5F";    -- Currently get intercepted by the M2M OSM.  May need to change M2M.       
                                                
        when m65_restore        => return x"71";   -- Undefined - however M2M will use this to display OSM    
--        when m65_arrow_up       => return x"72";   -- Undefinded  -- Arrow up key not cursor up key                                             
        when m65_arrow_up       => return x"0D";   -- Forward slash                                             
                                                                        
        when others             => return (others => '0');
      end case;      
    end function;
end package body keymap_pkg;

