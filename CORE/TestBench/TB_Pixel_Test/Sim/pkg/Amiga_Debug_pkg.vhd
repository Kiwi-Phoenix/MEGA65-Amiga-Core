-- Package to help with debugging the Core.
-- Works with the ILAs tools.
-- July 2025    David Raynor    (Kiwi)

library ieee;
use ieee.std_logic_1164.all;


package Amiga_Debug_pkg is
-- TODO: CCombine the use of the Debug Constants.


    -- Use in RAM Controller
    constant DBG_NONE       : integer := 0;
    constant DBG_SUMMARY    : integer := 1;
    constant DBG_VERBOSE    : integer := 2;
    
    -- Set this per build
    --constant DEBUG_LEVEL    : integer := DBG_VERBOSE;
    constant DEBUG_LEVEL    : integer := DBG_NONE;


-- Turn on Debug.
-- Triggers the inclusion of code / options speficically for debugging purposes.
-- Set these to false for "production" builds.
constant DEBUG      : boolean := true;          -- Sets the DONT_TOUCH attribute;
constant DEBUG_ENA  : boolean := true;          -- Controlls the generation of code for debugging purposes.
--constant DEBUG_CLK  : boolean := true;          -- Controlls the generation of code for debugging clock generation.
constant DEBUG_CLK  : boolean := false;          -- Controlls the generation of code for debugging clock generation.
constant DEBUG_RAMU : boolean := true;          -- Controlls the generation of code for debugging RAM generation.



--constant DEBUG_RAMA : boolean := true;          -- Controlls the generation of code for debugging RAM1 generation.
constant DEBUG_RAMA : boolean := false;          -- Controlls the generation of code for debugging RAM1 generation.
--constant DEBUG_RAMAA : boolean := true;          -- Controlls the generation of code for debugging RAM1 generation.
constant DEBUG_RAMAA : boolean := false;          -- Controlls the generation of code for debugging RAM1 generation.
--constant DEBUG_RAMB : boolean := true;          -- Controlls the generation of code for debugging RAM1 generation.
constant DEBUG_RAMB : boolean := false;          -- Controlls the generation of code for debugging RAM1 generation.
--constant DEBUG_RAMBA : boolean := true;          -- Controlls the generation of code for debugging RAM1 generation.
constant DEBUG_RAMBA : boolean := false;          -- Controlls the generation of code for debugging RAM1 generation.

--constant DEBUG_ENA  : boolean := false;          -- Controlls the generation of code for debugging purposes.

attribute MARK_DEBUG    : string;
attribute DONT_TOUCH    : string;
subtype t_string1 is string(1 to 4);
type t_dont_touch_array is array(boolean) of t_string1;
constant c_dont_touch : t_dont_touch_array := (false => "    ", true => "TRUE");

                                                
end package;

library ieee;
use ieee.std_logic_1164.all;

package clk_attr_pkg is
    -- Used to tag clock signals as being a clk and then scripted in constraints to auto generate the clock and ste the false path.
    attribute IS_CLK : boolean;
end package clk_attr_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package debug_utils_pkg is
     
     function time_to_str(t : time) return string;
     
    -- Normalize any SLV to (length-1 downto 0)
    function normalize_slv(v : std_logic_vector) return std_logic_vector;
    
    -- Convert any SLV to hex (auto width)
    function slv_to_hex_any(v : std_logic_vector) return string;
   
    -- Convert std_logic_vector to string (portable across all VHDL versions)
    function slv_to_str(slv : std_logic_vector) return string;
    
    -- Concert std_logic_vector to hex
    function slv_to_hex(slv : std_logic_vector) return string;
    
    -- Convert unsigned to string
    function u_to_string(u : unsigned) return string;
    
    -- Convert signed to string
    function s_to_string(s : signed) return string;
    
    -- Convert std_logic to string
    function sl_to_str(s : std_logic) return string;

    -- Fixed-width helpers
    function slv_to_hex16(v : std_logic_vector) return string;
    function slv_to_hex32(v : std_logic_vector) return string;
    function slv_to_hex64(v : std_logic_vector) return string;
    
    function int_img(i : integer) return string;

   -- Generic debug print helper
    procedure dbg(
        tag  : in string;
        n1   : in string; v1 : in std_logic;
        n2   : in string; v2 : in std_logic_vector;
        n3   : in string; v3 : in std_logic
    );
end package;

package body debug_utils_pkg is

    function time_to_str(t : time) return string is
    begin
        return integer'image(integer(t / 1 ns)) & " ns";
    end function;
    --------------------------------------------------------------------
    -- Convert std_logic_vector → string
    -- Works in VHDL-93, 2002, 2008, and all simulators
    --------------------------------------------------------------------
    -- Normalize vector to (N-1 downto 0)
    function normalize_slv(v : std_logic_vector) return std_logic_vector is
    begin
        return std_logic_vector(resize(unsigned(v), v'length));
    end function;
    
        -- Convert 4-bit nibble to hex char
    function hex_digit(n : std_logic_vector(3 downto 0)) return character is
        variable val : integer := to_integer(unsigned(n));
    begin
        if val < 10 then
            return character'val(character'pos('0') + val);
        else
            return character'val(character'pos('A') + (val - 10));
        end if;
    end function;

    -- Convert any SLV to hex string
    function slv_to_hex_any(v : std_logic_vector) return string is
        variable norm : std_logic_vector(v'length-1 downto 0);
        constant nibbles : integer := (v'length + 3) / 4;
        variable padded : std_logic_vector(nibbles*4-1 downto 0);
        variable result : string(1 to nibbles);
    begin
        norm := normalize_slv(v);

        -- pad MSBs with zeros
        padded := (others => '0');
        padded(norm'length-1 downto 0) := norm;

        for i in 0 to nibbles-1 loop
            result(i+1) := hex_digit(padded((nibbles-1-i)*4+3 downto (nibbles-1-i)*4));
        end loop;

        return result;
    end function;
          
    function slv_to_str(slv : std_logic_vector) return string is
        variable result : string(1 to slv'length);
        variable idx    : integer := 1;
        variable img    : string(1 to 3);
    begin
        for i in slv'range loop
            img := std_logic'image(slv(i));  -- "'0'" or "'1'"
            result(idx) := img(2);           -- take the middle character
            idx := idx + 1;
        end loop;
        return result;
    end function;

-- Convert to Hex
function slv_to_hex(slv : std_logic_vector) return string is
        variable result : string(1 to (slv'length+3)/4);
        variable nibble : std_logic_vector(3 downto 0);
        variable idx    : integer := 1;
    begin
        for i in slv'range loop
            if (i mod 4) = 3 then
                nibble := slv(i downto i-3);
                case nibble is
                    when "0000" => result(idx) := '0';
                    when "0001" => result(idx) := '1';
                    when "0010" => result(idx) := '2';
                    when "0011" => result(idx) := '3';
                    when "0100" => result(idx) := '4';
                    when "0101" => result(idx) := '5';
                    when "0110" => result(idx) := '6';
                    when "0111" => result(idx) := '7';
                    when "1000" => result(idx) := '8';
                    when "1001" => result(idx) := '9';
                    when "1010" => result(idx) := 'A';
                    when "1011" => result(idx) := 'B';
                    when "1100" => result(idx) := 'C';
                    when "1101" => result(idx) := 'D';
                    when "1110" => result(idx) := 'E';
                    when "1111" => result(idx) := 'F';
                    when others => result(idx) := '?';
                end case;
                idx := idx + 1;
            end if;
        end loop;
        return result;
    end function;

    --------------------------------------------------------------------
    -- Convert unsigned → string
    --------------------------------------------------------------------
    function u_to_string(u : unsigned) return string is
    begin
        return integer'image(to_integer(u));
    end function;

    --------------------------------------------------------------------
    -- Convert signed → string
    --------------------------------------------------------------------
    function s_to_string(s : signed) return string is
    begin
        return integer'image(to_integer(s));
    end function;
    
    -- Convert std_logic to string
    function sl_to_str(s : std_logic) return string is
    begin
        return std_logic'image(s);
    end function;

    -- Fixed-width helpers
    function slv_to_hex16(v : std_logic_vector) return string is
        variable norm : std_logic_vector(15 downto 0);
    begin
        norm := std_logic_vector(resize(unsigned(v), 16));
        return slv_to_hex_any(norm);
    end function;

    function slv_to_hex32(v : std_logic_vector) return string is
        variable norm : std_logic_vector(31 downto 0);
    begin
        norm := std_logic_vector(resize(unsigned(v), 32));
        return slv_to_hex_any(norm);
    end function;

    function slv_to_hex64(v : std_logic_vector) return string is
        variable norm : std_logic_vector(63 downto 0);
    begin
        norm := std_logic_vector(resize(unsigned(v), 64));
        return slv_to_hex_any(norm);
    end function;
    
    function int_img(i : integer) return string is
    begin
        return integer'image(i);
    end;
    
    procedure dbg(
        tag  : in string;
        n1   : in string; v1 : in std_logic;
        n2   : in string; v2 : in std_logic_vector;
        n3   : in string; v3 : in std_logic
    ) is
    begin
        report tag & ": "
            & n1 & "=" & sl_to_str(v1) & "  "
            & n2 & "=" & slv_to_str(v2) & "  "
--            & n2 & "=" & slv_to_hex(normalize_slv(v2)) & "  "
            & n3 & "=" & sl_to_str(v3)
            severity note;
    end procedure;

end package body;





library ieee;
use ieee.std_logic_1164.all;

package Amiga_Debug_Sig_pkg is

--    type DEBUG_BUS_TYPE is record 
--          -- USERIO Config Signals - Out
--          memory_config     : std_logic_vector(7 downto 0);
--          chipset_config    : std_logic_vector(4 downto 0);
--          floppy_config     : std_logic_vector(3 downto 0);
--          ide_config        : std_logic_vector(5 downto 0);
--          cpu_config        : std_logic_vector(1 downto 0);
--          cache_config      : std_logic_vector(2 downto 0);
--          scanline          : std_logic_vector(2 downto 0);       
--    end record; 
    
    type USERIO_DEBUG_TYPE is record
          memory_config     : std_logic_vector(7 downto 0);
          chipset_config    : std_logic_vector(4 downto 0);
          floppy_config     : std_logic_vector(3 downto 0);
          ide_config        : std_logic_vector(5 downto 0);
          cpu_config        : std_logic_vector(1 downto 0);
          cache_config      : std_logic_vector(2 downto 0);
          scanline          : std_logic_vector(2 downto 0);
          ar                : std_logic_vector(1 downto 0);                                    
          blver             : std_logic_vector(1 downto 0);             
          cpuhlt            : std_logic;
          cpurst            : std_logic;
          usrrst            : std_logic;
          aud_mix           : std_logic_vector(1 downto 0);      
          reset             : std_logic;        
          reset_core        : std_logic;
          bootrom           : std_logic;
          host_adr          : std_logic_vector(23 downto 0);
          host_wdat         : std_logic_vector(15 downto 0);
          host_bs           : std_logic_vector(1 downto 0);
          host_cs           : std_logic;
          host_we           : std_logic;
          host_ack          : std_logic;        
    end record;
    
    type USERIO_IN_DEBUG_TYPE is record
        io_strobe           : std_logic;
                
    end record;
    
    type DEBUG_SPI_IO_TYPE is record
        -- Debug Signals for SPI_IO
        io_uio              : std_logic;
        io_fpga             : std_logic;
        io_strobe           : std_logic;
        io_wait             : std_logic;
        io_din              : std_logic_vector(15 downto 0);
        io_dout             : std_logic_vector(15 downto 0);              
    end record;
    
    type DEBUG_VIDEO_TYPE is record
        -- Debug video signals
        -- Output Signals - Video_Mixer
        vga_b               : std_logic_vector(7 downto 0);
        vga_g               : std_logic_vector(7 downto 0);
        vga_r               : std_logic_vector(7 downto 0);
        ce_pixel            : std_logic;
        vga_de              : std_logic;
        vga_hs              : std_logic;
        vga_vs              : std_logic;
        
        -- Input Signals - Video_Mixer
        B                   : std_logic_vector(7 downto 0);
        G                   : std_logic_vector(7 downto 0);
        R                   : std_logic_vector(7 downto 0);
        clk_video           : std_logic;                               
        HBlank              : std_logic;                               
        HSync               : std_logic;                               
        VBlank              : std_logic;                               
        VSync               : std_logic;                               
        ce_pix              : std_logic;                               
        scandoubler         : std_logic;                               
        hq2x                : std_logic;                               
    end record;
    
    type DEBUG_DENISE_TYPE is record
        -- Denise Input signals
        clk                 : std_logic;
        clk7_en             : std_logic;
        aga                 : std_logic;
        a1k                 : std_logic;
        blank               : std_logic;
        cck                 : std_logic;
        chip48              : std_logic_vector(47 downto 0);
        c1                  : std_logic;
        c3                  : std_logic;
        data_in             : std_logic_vector(15 downto 0);
        ecs                 : std_logic;
        reg_address_in      : std_logic_vector(8 downto 1);
        reset               : std_logic;
        strhor              : std_logic;
        
        -- Denise Output signals
        blue                : std_logic_vector(7 downto 0);
        green               : std_logic_vector(7 downto 0);
        red                 : std_logic_vector(7 downto 0);
        data_out            : std_logic_vector(15 downto 0);
        hires               : std_logic;
        shres               : std_logic;                               
    end record;
      
    
    type PROBE_TYPE is record
        debug_clk           : std_logic;
--        debug_clk_114       : std_logic;           
--        debug_clk_sys       : std_logic;           
        reset               : std_logic_vector(0 downto 0);       
    end record;
    
--    type PROBE_CLK_TYPE is record
--        debug_clk           : std_logic;
--        debug_clk_114       : std_logic;       
--    end record;
    
    type DEBUG_CLOCK_TYPE is record
        debug_clk           : std_logic;
        debug_clk_114       : std_logic;           
        debug_clk_sys       : std_logic;
        debug_clk_video     : std_logic;
        debug_clk_audio     : std_logic;
        debug_clk_locked    : std_logic;
    end record;
    
    type DEBUG_AMIGA_CLOCK_TYPE is record
        debug_clk_28        : std_logic;
        debug_clk7_en       : std_logic;
        debug_clk7n_en      : std_logic;
        debug_c1            : std_logic;
        debug_c3            : std_logic;
        debug_cck           : std_logic;
        debug_eclk          : std_logic_vector(9 downto 0);
    end record;
    
    
    type DEBUG_SD_RAM_TYPE is record
        -- RAM1
        -- In ports
        sd_addr             : std_logic_vector(12 downto 0);
        sd_ba               : std_logic_vector(1 downto 0);
        sd_cas              : std_logic;
        sd_cke              : std_logic;
        sd_clk              : std_logic;
        sd_cs               : std_logic;
        sd_data_in          : std_logic_vector(15 downto 0);
        sd_dqm              : std_logic_vector(1 downto 0);
        sd_ras              : std_logic;
        sd_we               : std_logic;
        
        -- Out ports
        sd_data_out         : std_logic_vector(15 downto 0);
        
        -- SDRAM_ctrl
        -- Only the ports that do not duplicate the above as they are connected.
        -- In ports
        c_7m                : std_logic;
        cache_inhibit       : std_logic;
        cache_rst           : std_logic;
        chipAddr            : std_logic_vector(24 downto 0);
        chipDMA             : std_logic;
        chipL               : std_logic;
        chipRW              : std_logic;
        chipU               : std_logic;
        chipWR              : std_logic_vector(15 downto 0);
        cpuAddr             : std_logic_vector(24 downto 0);
        cpuCS               : std_logic;
        cpuL                : std_logic;
        cpuU                : std_logic;
        cpuWR               : std_logic_vector(15 downto 0);
        cpu_cache_ctrl      : std_logic_vector(3 downto 0);
        cpuState            : std_logic_vector(1 downto 0);
        reset_n             : std_logic;
        sd_data             : std_logic_vector(15 downto 0);
        sysclk              : std_logic;
        
        -- Out Ports
        chipRD              : std_logic_vector(15 downto 0);
        chip48              : std_logic_vector(47 downto 0);
        cpuRD               : std_logic_vector(15 downto 0);
        ramready            : std_logic;                      
    end record;
    
    type DEBUG_SD_RAM1A_TYPE is record
        sysclk              : std_logic;    
        c_7m                : std_logic;    
        reset_n             : std_logic;    
        cache_rst           : std_logic;
        cache_inhibit       : std_logic;
        cpu_cache_ctrl      : std_logic_vector(3 downto 0);

        chipAddr            : std_logic_vector(24 downto 0);
        chipL               : std_logic;
        chipU               : std_logic;        
        chipRW              : std_logic;
        chipDMA             : std_logic;
        chipWR              : std_logic_vector(15 downto 0);
        chipRD              : std_logic_vector(15 downto 0);                                
        chip48              : std_logic_vector(47 downto 0);

        cpuAddr             : std_logic_vector(24 downto 0);
        cpuCS               : std_logic;
        cpuState            : std_logic_vector(1 downto 0);
        cpuL                : std_logic;
        cpuU                : std_logic;
        cpuWR               : std_logic_vector(15 downto 0);
        cpuRD               : std_logic_vector(15 downto 0);                                        
        ramready            : std_logic;                                      
    end record;    
    
    
    
    type DEBUG_DD_RAM_TYPE is record
        -- RAM2
        -- In Ports
        ddram_addr          : std_logic_vector(28 downto 0);
        ddram_be            : std_logic_vector(1 downto 0);
        ddram_burstcnt      : std_logic_vector(7 downto 0);
        ddram_din           : std_logic_vector(15 downto 0);
        ddram_rd            : std_logic;
        ddram_we            : std_logic;
        
        -- Out Ports
        ddram_busy          : std_logic;
        ddram_dout          : std_logic_vector(15 downto 0);
        ddram_dout_ready    : std_logic;
        
        -- DDRAM_ctrl
        -- Only the ports that do not duplicate the above as they are connected.
        -- In ports
        cache_inhibit       : std_logic;
        cache_rst           : std_logic;
        cpuAddr             : std_logic_vector(28 downto 0);
        cpuCS               : std_logic;
        cpuL                : std_logic;
        cpuU                : std_logic;
        cpuWR               : std_logic_vector(15 downto 0);
        cpu_cache_ctrl      : std_logic_vector(3 downto 0);
        cpuState            : std_logic_vector(1 downto 0);
        ramshared           : std_logic;
        reset_n             : std_logic;
        sysclk              : std_logic;
        
        -- Out Ports
        cpuRD               : std_logic_vector(15 downto 0);
        ddram_clk           : std_logic;
        ramready            : std_logic;                        
    end record;
    
    type DEBUG_DD_RAM2A_TYPE is record
        sysclk              : std_logic;
        reset_n             : std_logic;
        cache_n             : std_logic;
        cache_rst           : std_logic;
        cache_inhibit       : std_logic;
        cpu_cache_ctrl      : std_logic_vector(3 downto 0);
        
        cpuAddr             : std_logic_vector(28 downto 0);
        cpuCS               : std_logic;
        cpuState            : std_logic_vector(1 downto 0);
        cpuL                : std_logic;
        cpuU                : std_logic;
        cpuWR               : std_logic_vector(15 downto 0);
        cpuRD               : std_logic_vector(15 downto 0);
        ramshared           : std_logic;
        ramready            : std_logic;
    end record;
    
    
    type DEBUG_RAM_TYPE is record
        sysclk              : std_logic;
        reset_n             : std_logic;
        cache_rst           : std_logic;
        cache_inhibit       : std_logic;
        cpu_cache_ctrl      : std_logic_vector(3 downto 0);
        
        ramsel              : std_logic;
        ramaddr             : std_logic_vector(28 downto 1);
        ramlds              : std_logic;
        ramuds              : std_logic;
        ramin               : std_logic_vector(15 downto 0);
        ramshared           : std_logic;
        cpustate            : std_logic_vector(1 downto 0);
        
        ramdout             : std_logic_vector(15 downto 0);
        ramready            : std_logic;
        
        chipAddr            : std_logic_vector(24 downto 1);
        ChipL               : std_logic;
        ChipU               : std_logic;
        ChipRW              : std_logic;
        ChipDMA             : std_logic;
        ChipWR              : std_logic_vector(15 downto 0);
        
        ChipRD              : std_logic_vector(15 downto 0);
        Chip48              : std_logic_vector(47 downto 0);
        
        cpuRD               : std_logic_vector(15 downto 0);                                
    end record;
    
end package;

package body Amiga_Debug_Sig_pkg is
end package body;
