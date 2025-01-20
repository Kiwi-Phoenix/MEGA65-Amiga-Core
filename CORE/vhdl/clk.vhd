-------------------------------------------------------------------------------------------------------------
-- MiSTer2MEGA65 Framework  
--
-- Clock Generator using the Xilinx specific MMCME2_ADV:
--
--
--  DJR - Update clocks for Amiga Core
--  MiSTer's Amiga expects:
--  Input  clk_28   - 28 MHz output clock (28.375160MHz)
--  Output clk7_en  - 7  MHz output clock enable (on 28MHz clock domain)
--  Output clk7n_en - 7  MHz negedge output clock enable (on 28MHz clock domain)
--  Output c1       - clk28m clock domain signal synchronous with clk signal
--  Output c3       - clk28m clock domain signal synchronous with clk signal delayed by 90 degrees
--  Output cck      - colour clock output (3.54 MHz)   clk_29 / 8
--  Output eclk     - 0.709379 MHz enable output (clk domain pulse)
--
--
--  Amiga Clock Freq
--  PAL  -  28.37516 MHzm CPU clock - 7.09 MHz
--  NTSC -  28.63636 MHz, CPU clock - 7.16 MHz
--
--  Two clocks are used:
--  PAL:     clk_114 = 113.50064 MHz
--           clk_sys =  28.37516 MHz
-- 
--  NTSC:    clk_114 = 114.54544 MHz
--           clk_sys =  28.63636 MHz
--    
--  There appears to be a Port on Agnus for NTSC, suggesting a possibility to have NTSC capabilities.
-- 
--
--
-- MiSTer2MEGA65 done by sy2002 and MJoergen in 2022 and licensed under GPL v3
-------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library xpm;
use xpm.vcomponents.all;

entity clk is
   port (
      sys_clk_i       : in  std_logic;   -- expects 100 MHz

      main_clk_o      : out std_logic;   -- main's 28.37516  MHz main clock   expected by the MiSTer Core
      main_rst_o      : out std_logic    -- main's reset, synchronized
   );
end entity clk;

architecture rtl of clk is

signal clkfb1             : std_logic;
signal clkfb1_mmcm        : std_logic;
signal clkfb2             : std_logic;
signal clkfb2_mmcm        : std_logic;
signal clkfb3             : std_logic;
signal clkfb3_mmcm        : std_logic;
signal main_clk_mmcm      : std_logic;

signal main_locked        : std_logic;

begin

   -------------------------------------------------------------------------------------
   -- Generate Amiga clock
   -------------------------------------------------------------------------------------

   i_clk_main : MMCME2_ADV
      generic map (
         BANDWIDTH            => "OPTIMIZED",
         CLKOUT4_CASCADE      => FALSE,
         COMPENSATION         => "ZHOLD",
         STARTUP_WAIT         => FALSE,
         CLKIN1_PERIOD        => 10.0,       -- INPUT @ 100 MHz
         REF_JITTER1          => 0.010,
         DIVCLK_DIVIDE        => 1,
         CLKFBOUT_MULT_F      => 1.1350064,      -- 113.50064 MHz
         CLKFBOUT_PHASE       => 0.000,
         CLKFBOUT_USE_FINE_PS => FALSE,
         CLKOUT0_DIVIDE_F     => 4.00,           -- 28.375160 MHz
         CLKOUT0_PHASE        => 0.000,
         CLKOUT0_DUTY_CYCLE   => 0.500,
         CLKOUT0_USE_FINE_PS  => FALSE
      )
      port map (
         -- Output clocks
         CLKFBOUT            => clkfb3_mmcm,
         CLKOUT0             => main_clk_mmcm,
         -- Input clock control
         CLKFBIN             => clkfb3,
         CLKIN1              => sys_clk_i,
         CLKIN2              => '0',
         -- Tied to always select the primary input clock
         CLKINSEL            => '1',
         -- Ports for dynamic reconfiguration
         DADDR               => (others => '0'),
         DCLK                => '0',
         DEN                 => '0',
         DI                  => (others => '0'),
         DO                  => open,
         DRDY                => open,
         DWE                 => '0',
         -- Ports for dynamic phase shift
         PSCLK               => '0',
         PSEN                => '0',
         PSINCDEC            => '0',
         PSDONE              => open,
         -- Other control and status signals
         LOCKED              => main_locked,
         CLKINSTOPPED        => open,
         CLKFBSTOPPED        => open,
         PWRDWN              => '0',
         RST                 => '0'
      ); -- i_clk_main

   -------------------------------------------------------------------------------------
   -- Output buffering
   -------------------------------------------------------------------------------------

   clkfb3_bufg : BUFG
      port map (
         I => clkfb3_mmcm,
         O => clkfb3
      );

   main_clk_bufg : BUFG
      port map (
         I => main_clk_mmcm,
         O => main_clk_o
      );

   -------------------------------------
   -- Reset generation
   -------------------------------------

   i_xpm_cdc_async_rst_main : xpm_cdc_async_rst
      generic map (
         RST_ACTIVE_HIGH => 1,
         DEST_SYNC_FF    => 6
      )
      port map (
         src_arst  => not main_locked,   -- 1-bit input: Source reset signal.
         dest_clk  => main_clk_o,        -- 1-bit input: Destination clock.
         dest_arst => main_rst_o         -- 1-bit output: src_rst synchronized to the destination clock domain.
                                         -- This output is registered.
      );

end architecture rtl;

