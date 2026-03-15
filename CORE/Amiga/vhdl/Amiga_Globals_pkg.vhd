-- Globals for the Amiga Core
--
-- July 2025    David Raynor (Kiwi)

library ieee;
use ieee.std_logic_1164.all;

package Amiga_Globals is

    attribute description : string;


-- Turn on Debug.
-- Triggers the inclusion of code / options speficically for debugging purposes.
-- Set these to false for "production" builds.
--constant DEBUG      : boolean := true;          -- Sets the DONT_TOUCH attribute;
--constant DEBUG_ENA  : boolean := true;          -- Controlls the generation of code for debugging purposes.
--constant DEBUG_ENA  : boolean := false;          -- Controlls the generation of code for debugging purposes.
                                                
end package Amiga_Globals;

package build_id is
-- TODO: place in a separate auto-generated package / file.
    constant BUILD_DATE : string := "2026-03-04";
end package;

package build_ver is
    constant BUILD_VER : string := "BETA V0.05";
end package;

package DocPkg is
    attribute description : string;
    alias     desc is description;
end package DocPkg;                                                                                                                                                                                         
