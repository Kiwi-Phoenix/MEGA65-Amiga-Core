--
-- Reset signal process for the Amiga Entity / Component.
--
-- Logic originally from the MiSTer Minimig emu module.
--
-- June 2026   - David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;

entity reset_sig is
    port (
         clk_sys        : in std_logic;
         reset_i        : in std_logic;
         reset_d        : out std_logic
    );
end entity;

architecture RTL of reset_sig is
    
begin
    reset_process : process (clk_sys, reset_i)
        variable reset_s    : std_logic_vector(7 downto 0);
        variable rs         : std_logic;
    begin
        if reset_i = '1' then
            reset_s := (others => '1');
        elsif rising_edge(clk_sys) then 
            reset_s := reset_s(6 downto 0) & '0';       -- Shift left by 1
            rs      := reset_s(7);                      -- Assign MSB
            reset_d <= rs;                              -- Update reset_d
        end if;    
    end process;

end architecture;
