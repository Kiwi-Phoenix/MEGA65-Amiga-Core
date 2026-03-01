-- Combine Audio
--
-- Process code ported over from original MiSTer Amiga Core EMU module
--
-- June 2025    - David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity combaud is
    port (
        clk_audio         : in std_logic;
        aud_l             : in std_logic_vector(15 downto 0);
        aud_r             : in std_logic_vector(15 downto 0);
        toccata_aud_left  : in std_logic_vector(15 downto 0);
        toccata_aud_right : in std_logic_vector(15 downto 0);   
        cdda_l            : in std_logic_vector(15 downto 0);
        cdda_r            : in std_logic_vector(15 downto 0);
          
        audio_s           : out std_logic;
        audio_l           : out std_logic_vector(15 downto 0);
        audio_r           : out std_logic_vector(15 downto 0)                             
    );
end combaud;


architecture combaud_RTL of combaud is
    signal out_l             : std_logic_vector(15 downto 0);
    signal out_r             : std_logic_vector(15 downto 0);
begin

comb_aud : process (clk_audio)
    variable tmp_l, tmp_r    : signed(16 downto 0);
       
begin
    if rising_edge(clk_audio) then
        -- Accumulate audio sources
        tmp_l := resize(signed(aud_l), 17) + resize(signed(toccata_aud_left), 17) + resize(signed(cdda_l), 17);
        tmp_r := resize(signed(aud_r), 17) + resize(signed(toccata_aud_right), 17) + resize(signed(cdda_r), 17);
        
        -- Clamp the output
        if tmp_l(16) /= tmp_l(15) then
            out_l <= (others => tmp_l(15));     -- Extend sign bit across all bits
        else
            out_l <= std_logic_vector(tmp_l(15 downto 0));        -- Take lower 16 bits directly
        end if;
        
        if tmp_r(16) /= tmp_r(15) then
            out_r <= (others => tmp_r(15));
        else 
            out_r <= std_logic_vector(tmp_r(15 downto 0)); 
        end if;
    end if;


end process;

audio_s <= '1';
audio_l <= std_logic_vector(out_l);
audio_r <= std_logic_vector(out_r);

end combaud_RTL;

 