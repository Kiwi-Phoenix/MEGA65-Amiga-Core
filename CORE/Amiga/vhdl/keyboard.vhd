---------------------------------------------------------------------------------------------------------
-- MiSTer2MEGA65 Framework  
--
-- Custom keyboard controller for Amiga Core
--
-- Runs in the clock domain of the core.
--
-- This is how MiSTer2MEGA65 provides access to the MEGA65 keyboard: 
--
-- Each core is treating the keyboard in a different way: Some need low-active "matrices", some
-- might need small high-active keyboard memories, etc. This is why the MiSTer2MEGA65 framework
-- lets you define literally everything and only provides a minimal abstraction layer to the keyboard.
-- You need to adjust this module to your needs.
--
-- MiSTer2MEGA65 provides a very simple and generic interface to the MEGA65 keyboard:
-- kb_key_num_i is running through the key numbers 0 to 79 with a frequency of 1 kHz, i.e. the whole
-- keyboard is scanned 1000 times per second. kb_key_pressed_n_i is already debounced and signals
-- low active, if a certain key is being pressed right now.
-- 
-- MiSTer2MEGA65 done by sy2002 and MJoergen in 2022 and licensed under GPL v3
--
-- Updates
-- Aug 2025 David Raynor (Kiwi)
--
-- Notes:
-- Two main signals used to send keyboard data to teh Amiga Core:
-- kbd_mouse_type and kbd_mouse_data
-- kbd_mouse_type values:
--     00 = ???
--     01 = Mouse (int 1)
--     10 = Keyboard (int 2) 
--     11 = OSD  (int 3) - shouldn't need to set ths one
--
-- kbd_mouse_data : contans the Amiga key code for the key being presses.
-- This module will call a function to perform the translation.
-- In the Amiga Core, this data is sent to CIAA and USERIO.  USERIO because it also does someting with the mouse, but not keyboard.
--
-- TODO:
-- Need to capture that the shift key is being held down and one of the 5 M65 functions keys.  I.e. F1-F9
-- Then send the Amiga key code for the "Shifted" function key.
-- The Amiga does not have Shift-Function Key, therefore we need to send the Amiga equalivamt for M65 Shift-Function key.
-- Might need to do this as a state machine.
-- Check for the Shift key.  Retain this value and check for the next key press.
-- If the next key is one of the function keys, then send the appropriate value.
-- Otherwise send normal.
-- Will mean the shift keys effectively become "sticky" until the selection function key is pressed.
-- Something like that. 
---------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.keymap_pkg.all;
use work.M65_keycode_pkg.all;

entity keyboard is
   port (
      clk                  : in std_logic;               -- core clock
         
      -- Interface to the MEGA65 keyboard
      key_num            : in integer range 0 to 79;   -- cycles through all MEGA65 keys
      key_pressed_n      : in std_logic;               -- low active: debounced feedback: is kb_key_num_i pressed right now?
        
      kbd_mouse_type       : out std_logic_vector(1 downto 0);
      kbd_mouse_data       : out std_logic_vector(7 downto 0)            
   );
end entity;

architecture rtl of keyboard is

type IP_REC_TYPE is record
      key_num            : integer range 0 to 79; 
      key_pressed_n      : std_logic;             
end record;

type OP_REC_TYPE is record
    kbd_mouse_type      : std_logic_vector(1 downto 0);
    kbd_mouse_data      : std_logic_vector(7 downto 0);
end record;

signal ip   : IP_REC_TYPE;
signal op   : OP_REC_TYPE;

constant MEGA65_RIGHT_SHIFT_KEY : integer := m65_right_shift;    
constant MEGA65_LEFT_SHIFT_KEY  : integer := m65_left_shift;
constant MEGA65_F1_KEY          : integer := m65_f1;
constant MEGA65_F3_KEY          : integer := m65_f3;
constant MEGA65_F5_KEY          : integer := m65_f5;
constant MEGA65_F7_KEY          : integer := m65_f7;
constant MEGA65_F9_KEY          : integer := m65_f9;

constant AMIGA_F2               : std_logic_vector(7 downto 0) := x"51";
constant AMIGA_F4               : std_logic_vector(7 downto 0) := x"53";
constant AMIGA_F6               : std_logic_vector(7 downto 0) := x"55";
constant AMIGA_F8               : std_logic_vector(7 downto 0) := x"57";
constant AMIGA_F10              : std_logic_vector(7 downto 0) := x"59";
   
signal shift_down               : std_logic := '0';
signal amiga_code               : std_logic_vector(7 downto 0);

begin

-- IN Ports Mapping
ip.key_num          <= key_num;
ip.key_pressed_n    <= key_pressed_n;

-- OUT Ports Mapping
kbd_mouse_type      <= op.kbd_mouse_type;
kbd_mouse_data      <= op.kbd_mouse_data;


--kbd_mouse_type <= "10";         -- Identfy as Keyboard data
op.kbd_mouse_data <= amiga_code;   -- Amiga key code data.
   
   keyboard_state : process(clk)
   begin
      if rising_edge(clk) then 
      
        -- 1) Track shift key state
        if (ip.key_num = MEGA65_RIGHT_SHIFT_KEY)
            or (ip.key_num = MEGA65_LEFT_SHIFT_KEY) then
            if ip.key_pressed_n = '0' then
                shift_down <= '1';
            else 
                shift_down <= '0';
            end if;             
        end if;
      
        -- 2) Do the mmappng
        if ip.key_pressed_n = '0' then
            if shift_down = '1' then
                case ip.key_num is
                    when MEGA65_F1_KEY => amiga_code <= AMIGA_F2;  
                    when MEGA65_F3_KEY => amiga_code <= AMIGA_F4;  
                    when MEGA65_F5_KEY => amiga_code <= AMIGA_F6;  
                    when MEGA65_F7_KEY => amiga_code <= AMIGA_F8;  
                    when MEGA65_F9_KEY => amiga_code <= AMIGA_F10;
                    when others => amiga_code <= amiga_keycode(ip.key_num);  
                end case;
             else 
                amiga_code <= amiga_keycode(ip.key_num);     
            end if;     
            op.kbd_mouse_type <= "10";         -- Identfy as Keyboard data   
        end if;                             
      end if;
   end process;

end architecture;
