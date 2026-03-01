--  Set the Power LED
--  Logic sourced from the Original MiSTer Core EMU module.
--
-- June 2025        - David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity power_led is
    port (
        clk_sys     : in std_logic;
        pwr_led     : in std_logic;
        
        led_power   : out std_logic_vector(0 downto 0)       
    );
end entity;

architecture RTL of power_led is

    function or_reduce(v : std_logic_vector) return std_logic is
    begin
      for i in v'range loop
        if v(i) = '1' then
          return '1';
        end if;
      end loop;
      return '0';
    end function;

    signal led_cnt  : std_logic_vector(5 downto 0);
    signal led_dim  : std_logic;

begin

led : process (clk_sys)
begin
    if rising_edge(clk_sys) then
        led_cnt <= std_logic_vector(unsigned(led_cnt) + 1);
        led_dim <= or_reduce(led_cnt(5 downto 2));
    end if;
end process;    

led_power(0)    <= pwr_led or (not led_dim);   

end architecture;