-- Package containing the Mega 65 Keyboard codes.
-- Sourced from the M2M Framework.
--
-- Aug 2025 David Raynor (Kiwi)
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package M65_Keycode_pkg is

    constant m65_ins_del       : integer := 0;
    constant m65_return        : integer := 1;
    constant m65_horz_crsr     : integer := 2;   -- means cursor right in C64 terminology
    constant m65_f7            : integer := 3;
    constant m65_f1            : integer := 4;
    constant m65_f3            : integer := 5;
    constant m65_f5            : integer := 6;
    constant m65_vert_crsr     : integer := 7;   -- means cursor down in C64 terminology
    constant m65_3             : integer := 8;
    constant m65_w             : integer := 9;
    constant m65_a             : integer := 10;
    constant m65_4             : integer := 11;
    constant m65_z             : integer := 12;
    constant m65_s             : integer := 13;
    constant m65_e             : integer := 14;
    constant m65_left_shift    : integer := 15;
    constant m65_5             : integer := 16;
    constant m65_r             : integer := 17;
    constant m65_d             : integer := 18;
    constant m65_6             : integer := 19;
    constant m65_c             : integer := 20;
    constant m65_f             : integer := 21;
    constant m65_t             : integer := 22;
    constant m65_x             : integer := 23;
    constant m65_7             : integer := 24;
    constant m65_y             : integer := 25;
    constant m65_g             : integer := 26;
    constant m65_8             : integer := 27;
    constant m65_b             : integer := 28;
    constant m65_h             : integer := 29;
    constant m65_u             : integer := 30;
    constant m65_v             : integer := 31;
    constant m65_9             : integer := 32;
    constant m65_i             : integer := 33;
    constant m65_j             : integer := 34;
    constant m65_0             : integer := 35;
    constant m65_m             : integer := 36;
    constant m65_k             : integer := 37;
    constant m65_o             : integer := 38;
    constant m65_n             : integer := 39;
    constant m65_plus          : integer := 40;
    constant m65_p             : integer := 41; 
    constant m65_l             : integer := 42;
    constant m65_minus         : integer := 43;
    constant m65_dot           : integer := 44;
    constant m65_colon         : integer := 45;
    constant m65_at            : integer := 46;
    constant m65_comma         : integer := 47;
    constant m65_gbp           : integer := 48;
    constant m65_asterisk      : integer := 49;
    constant m65_semicolon     : integer := 50;
    constant m65_clr_home      : integer := 51;
    constant m65_right_shift   : integer := 52;
    constant m65_equal         : integer := 53;
    constant m65_arrow_up      : integer := 54;  -- symbol, not cursor
    constant m65_slash         : integer := 55;
    constant m65_1             : integer := 56;
    constant m65_arrow_left    : integer := 57;  -- symbol, not cursor
    constant m65_ctrl          : integer := 58;
    constant m65_2             : integer := 59;
    constant m65_space         : integer := 60;
    constant m65_mega          : integer := 61;
    constant m65_q             : integer := 62;
    constant m65_run_stop      : integer := 63;
    constant m65_no_scrl       : integer := 64;
    constant m65_tab           : integer := 65;
    constant m65_alt           : integer := 66;
    constant m65_help          : integer := 67;
    constant m65_f9            : integer := 68;
    constant m65_f11           : integer := 69;
    constant m65_f13           : integer := 70;
    constant m65_esc           : integer := 71;
    constant m65_capslock      : integer := 72;
    constant m65_up_crsr       : integer := 73;  -- cursor up
    constant m65_left_crsr     : integer := 74;  -- cursor left
    constant m65_restore       : integer := 75;

end package M65_Keycode_pkg;