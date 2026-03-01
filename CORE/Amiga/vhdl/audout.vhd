-- Audio out process
--
-- Process code ported over from original MiSTer Amiga Core EMU module
--
-- June 2025    - David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;

entity audout is
    port (
        clk_audio       : in std_logic;
        flt_en          : in std_logic;
        lpf3275_l       : in std_logic_vector(15 downto 0);
        lpf3275_r       : in std_logic_vector(15 downto 0);        
        audm_l          : in std_logic_vector(15 downto 0);
        audm_r          : in std_logic_vector(15 downto 0);        
        
        aud_l           : out std_logic_vector(15 downto 0);
        aud_r           : out std_logic_vector(15 downto 0)        
    ); 
end entity;


architecture RTL of audout is
    signal old_l0, old_l1, old_r0, old_r1 : std_logic_vector(15 downto 0);

begin

aud_output : process (clk_audio)
begin
    if rising_edge(clk_audio) then
        -- Capture previous sample based on 'flt_en'
        if flt_en = '1' then
            old_l0 <= lpf3275_l;
            old_r0 <= lpf3275_r;
        else 
            old_l0 <= audm_l;
            old_r0 <= audm_r; 
        end if;
        
        -- Delay previous sample
        old_l1 <= old_l0;
        old_r1 <= old_r0;
        
        -- Only upidate 'aud_l' and 'aud_r' when stable
        if (old_l0 = old_l1) then
            aud_l <= old_l1; 
        end if;
        
        if (old_r0 = old_r1) then
            aud_r <= old_r1; 
        end if;                         
    end if;
end process;


end architecture;
