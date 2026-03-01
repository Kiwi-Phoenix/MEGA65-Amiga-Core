-- Compute the RAM_CS signal.
--
-- Original logic sourced fromthe MiSTER MiniMIg / Amiga CORE EMU mondule.
-- Adapated for the Mega65 Port.
--
-- This will output 4 signals which are then used for RAM and the cpu_wrapper.
--
-- June 2025    - David Raynor (Kiwi)
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity compute_ram_cs is
    port (
        clk_114         : in std_logic;
        c1              : in std_logic;
        cpu_rst         : in std_logic;
        ram_ready       : in std_logic;
        cpu_type        : in std_logic;
        ram_sel         : in std_logic;
        cyc             : out std_logic;
        cpu_ph1         : out std_logic; 
        cpu_ph2         : out std_logic; 
        ram_cs          : out std_logic
    );
end entity;


---- One example of how to do this using two processes
architecture RTL of compute_ram_cs is
    signal div_reg, div_next : unsigned(3 downto 0) := (others => '0');
    signal c1d_reg, c1d_next : std_logic := '0';
    signal cyc_i             : std_logic := '0';

begin

-- Combinational next-state
comb_proc : process(div_reg, c1, c1d_reg)
begin
    c1d_next <= c1;
    -- default increment
    div_next <= div_reg + 1;
    if (c1d_reg = '0' and c1 = '1') then
        div_next <= "0011"; 
    end if;
end process;

-- clocked registers + output logic
seq_proc : process(clk_114)
begin
    if rising_edge(clk_114) then
        c1d_reg <= c1d_next;
        div_reg <= div_next;
        
        if cpu_rst = '0' then
            cyc_i   <= '0';
            cpu_ph1 <= '0';
            cpu_ph2 <= '0';
        else
            cyc_i <= not (div_reg(1) or div_reg(0));
            if (div_reg(1) = '1' and div_reg(0) = '0') then
                 case div_reg(3 downto 2) is
                    when "00"   => cpu_ph2 <= '1';
                    when "10"   => cpu_ph1 <= '1';
                    when others => null; 
                 end case;
            end if; 
        end if;
        
        cyc     <= cyc_i;
        ram_cs  <= not (ram_ready and cyc_i and cpu_type) and ram_sel;         
    end if;
end process;

end architecture;

