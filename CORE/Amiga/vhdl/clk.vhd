-------------------------------------------------------------------------------------------------------------
-- Amiga Core clock generation.
-- Modified from the MiSTer2MEGA65 Framework  
--
-- Clock Generator
--
-- Generates three clocks:
-- clk_114      -- Output: 113.55932 MHz / (Orig Core 113.50575 MHz
-- clk_sys      -- Output 28.38985 MHz   / (Orig) 28.37644 MHz
-- clk_audio    -- Output 24.54212 MHz / (Orig) 24.576 MHz
--

-- April 2025 - David Raynor (Kiwi)
-- Change to bring in line with current VHDL standards.
-------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library xpm;
use xpm.vcomponents.all;

entity clk is
   port (
      sys_clk            : in  std_logic;   -- expects 100 MHz
      
      main_clk_audio     : out std_logic;    
      main_clk_114       : out std_logic;   
      main_clk_sys       : out std_logic;   
      main_rst           : out std_logic;   
      main_clk_locked    : out std_logic             
   );
end entity;

architecture RTL of clk is

type op_type is record
    main_clk_audio  : std_logic;        -- Audio out clock 24.57606 MHz  / 24.61538 MHz (close as it can get)!!
    main_clk_114    : std_logic;        -- Amiga out clock 113.5009MHz  / 113.67673 MHz (close as it can get)!!
    main_clk_sys    : std_logic;        -- Amiga out clock 28.37523 MHz / 28.38137 MHz  (close as it can get)!!
    main_rst        : std_logic;        -- main's reset, synchronized
    main_clk_locked : std_logic;        -- Clock Locked signal.
end record;

signal op : op_type;

signal clkfb1             : std_logic;
signal clkfb1_mmcm        : std_logic;
signal clkfb2             : std_logic;
signal clkfb2_mmcm        : std_logic;
signal clkfb3             : std_logic;
signal clkfb3_mmcm        : std_logic;
signal clkfb4             : std_logic;
signal clkfb4_mmcm        : std_logic;
signal main_clk1_mmcm     : std_logic;
signal main_clk2_mmcm     : std_logic;
signal main_clk3_mmcm     : std_logic;
signal main_clk4_mmcm     : std_logic;

signal main_clk_ibufg      : std_logic;
signal main_clk1_bufg      : std_logic;
signal main_clk2_bufg    : std_logic;

signal clk_audio_locked   : std_logic;
signal clk_114_locked     : std_logic;
signal clk_sys_locked     : std_logic;
signal src_arst           : std_logic;

begin
-- Map to Out Ports
main_clk_audio  <= op.main_clk_audio;
main_clk_114    <= op.main_clk_114;
main_clk_sys    <= op.main_clk_sys;
main_clk_locked <= op.main_clk_locked;
main_rst        <= op.main_rst;


op.main_clk_locked <= clk_114_locked and clk_sys_locked and clk_audio_locked;

   -------------------------------------------------------------------------------------
   -- Generate QNICE and HyperRAM clock
   -------------------------------------------------------------------------------------
   
-- Generate clock signal for clk_114 (clock net) and defined in Contraints CORE.XDC 
   i_clk_main_114 : MMCME2_ADV
      generic map (
          BANDWIDTH            => "OPTIMIZED"
         ,COMPENSATION         => "ZHOLD"
         ,STARTUP_WAIT         => FALSE
         ,IS_CLKINSEL_INVERTED => '0'
         ,IS_PSEN_INVERTED     => '0'
         ,IS_PSINCDEC_INVERTED => '0'
         ,IS_PWRDWN_INVERTED   => '0'
         ,IS_RST_INVERTED      => '0'
         ,SS_EN                => "FALSE"
         ,SS_MODE              => "CENTER_HIGH"
         ,SS_MOD_PERIOD        => 10000         
         ,CLKIN1_PERIOD        => 10.0       -- INPUT @ 100 MHz
         ,CLKIN2_PERIOD        => 0.00
         ,REF_JITTER1          => 0.010
         ,REF_JITTER2          => 0.010
         ,DIVCLK_DIVIDE        => 1
         ,CLKFBOUT_MULT_F      => 8.375      
         ,CLKFBOUT_PHASE       => 0.000
         ,CLKFBOUT_USE_FINE_PS => FALSE
         ,CLKOUT0_DIVIDE_F     => 07.3750      -- Output  113.55932 MHz / (Orig Core 113.50575 MHz
         ,CLKOUT0_PHASE        => 0.000
         ,CLKOUT0_DUTY_CYCLE   => 0.500
         ,CLKOUT0_USE_FINE_PS  => FALSE                           
      )
      port map (
         -- Output clocks
          CLKFBOUT            => clkfb1_mmcm
         ,CLKOUT0             => main_clk1_mmcm
         -- Input clock control
         ,CLKFBIN             => clkfb1
         ,CLKIN1              => sys_clk
         ,CLKIN2              => '0'
         -- Tied to always select the primary input clock
         ,CLKINSEL            => '1'
         -- Ports for dynamic reconfiguration
         ,DADDR               => (others => '0')
         ,DCLK                => '0'
         ,DEN                 => '0'
         ,DI                  => (others => '0')
         ,DO                  => open
         ,DRDY                => open
         ,DWE                 => '0'
         -- Ports for dynamic phase shift
         ,PSCLK               => '0'
         ,PSEN                => '0'
         ,PSINCDEC            => '0'
         ,PSDONE              => open
         -- Other control and status signals
         ,LOCKED              => clk_114_locked
         ,CLKINSTOPPED        => open
         ,CLKFBSTOPPED        => open
         ,PWRDWN              => '0'
         ,RST                 => '0'
      ); 
      
-- Adding in a little extra time delay to resolve a neg slack issue
    BUFGCTRL_inst : BUFGCTRL
        generic map (init_out => 1)
        port map (
            I0      => clkfb1_mmcm
           ,I1      => '0'
           ,S0      => '1'
           ,S1      => '0'
           ,CE0     => '1'
           ,CE1     => '1'
           ,IGNORE0 => '0'
           ,IGNORE1 => '0'
           ,O       => clkfb1
        );       
   
   
-- Generate clock signal for clk_ys (clock net) and defined in Contraints CORE.XDC   
      i_clk_main_sys : MMCME2_ADV
      generic map (
          BANDWIDTH            => "OPTIMIZED"
         ,COMPENSATION         => "ZHOLD"
         ,STARTUP_WAIT         => FALSE
         ,IS_CLKINSEL_INVERTED => '0'
         ,IS_PSEN_INVERTED     => '0'
         ,IS_PSINCDEC_INVERTED => '0'
         ,IS_PWRDWN_INVERTED   => '0'
         ,IS_RST_INVERTED      => '0'
         ,SS_EN                => "FALSE"
         ,SS_MODE              => "CENTER_HIGH"
         ,SS_MOD_PERIOD        => 10000         
         ,CLKIN1_PERIOD        => 10.0       -- INPUT @ 100 MHz
         ,CLKIN2_PERIOD        => 0.00
         ,REF_JITTER1          => 0.010
         ,REF_JITTER2          => 0.010
         ,DIVCLK_DIVIDE        => 1
         ,CLKFBOUT_MULT_F      => 8.375      
         ,CLKFBOUT_PHASE       => 0.000
         ,CLKFBOUT_USE_FINE_PS => FALSE
         ,CLKOUT0_DIVIDE_F     => 29.5000      -- Output 28.38985 MHz / (Orig) 28.37644 MHz
         ,CLKOUT0_PHASE        => 0.000
         ,CLKOUT0_DUTY_CYCLE   => 0.500
         ,CLKOUT0_USE_FINE_PS  => FALSE                                    
      )
      port map (
         -- Output clocks
          CLKFBOUT            => clkfb2_mmcm
         ,CLKOUT0             => main_clk2_mmcm
         -- Input clock control
         ,CLKFBIN             => clkfb2
         ,CLKIN1              => sys_clk
         ,CLKIN2              => '0'
         -- Tied to always select the primary input clock
         ,CLKINSEL            => '1'
         -- Ports for dynamic reconfiguration
         ,DADDR               => (others => '0')
         ,DCLK                => '0'
         ,DEN                 => '0'
         ,DI                  => (others => '0')
         ,DO                  => open
         ,DRDY                => open
         ,DWE                 => '0'
         -- Ports for dynamic phase shift
         ,PSCLK               => '0'
         ,PSEN                => '0'
         ,PSINCDEC            => '0'
         ,PSDONE              => open
         -- Other control and status signals
         ,LOCKED              => clk_sys_locked
         ,CLKINSTOPPED        => open
         ,CLKFBSTOPPED        => open
         ,PWRDWN              => '0'
         ,RST                 => '0'
      ); 

clkfb2_bufg          : BUFG port map (I => clkfb2_mmcm    ,O => clkfb2);

-- Generate clock signal for clk_audio (clock net) and defined in Contraints CORE.XDC      
      i_clk_main_audio : MMCME2_ADV
      generic map (
          BANDWIDTH            => "OPTIMIZED"
         ,COMPENSATION         => "ZHOLD"
         ,STARTUP_WAIT         => FALSE
         ,IS_CLKINSEL_INVERTED => '0'
         ,IS_PSEN_INVERTED     => '0'
         ,IS_PSINCDEC_INVERTED => '0'
         ,IS_PWRDWN_INVERTED   => '0'
         ,IS_RST_INVERTED      => '0'
         ,SS_EN                => "FALSE"
         ,SS_MODE              => "CENTER_HIGH"
         ,SS_MOD_PERIOD        => 10000         
         ,CLKIN1_PERIOD        => 10.0       -- INPUT @ 100 MHz
         ,CLKIN2_PERIOD        => 0.00
         ,REF_JITTER1          => 0.010
         ,REF_JITTER2          => 0.010
         ,DIVCLK_DIVIDE        => 1
         ,CLKFBOUT_MULT_F      => 8.375      
         ,CLKFBOUT_PHASE       => 0.000
         ,CLKFBOUT_USE_FINE_PS => FALSE
         ,CLKOUT0_DIVIDE_F     => 34.125      -- Output 24.54212 MHz / (Orig) 24.576 MHz
         ,CLKOUT0_PHASE        => 0.000
         ,CLKOUT0_DUTY_CYCLE   => 0.500
         ,CLKOUT0_USE_FINE_PS  => FALSE                                    
      )
      port map (
         -- Output clocks
          CLKFBOUT            => clkfb3_mmcm
         ,CLKOUT0             => main_clk3_mmcm
         -- Input clock control
         ,CLKFBIN             => clkfb3
         ,CLKIN1              => sys_clk       
         ,CLKIN2              => '0'
         -- Tied to always select the primary input clock
         ,CLKINSEL            => '1'
         -- Ports for dynamic reconfiguration
         ,DADDR               => (others => '0')
         ,DCLK                => '0'
         ,DEN                 => '0'
         ,DI                  => (others => '0')
         ,DO                  => open
         ,DRDY                => open
         ,DWE                 => '0'
         -- Ports for dynamic phase shift
         ,PSCLK               => '0'
         ,PSEN                => '0'
         ,PSINCDEC            => '0'
         ,PSDONE              => open
         -- Other control and status signals
         ,LOCKED              => clk_audio_locked
         ,CLKINSTOPPED        => open
         ,CLKFBSTOPPED        => open
         ,PWRDWN              => '0'
         ,RST                 => '0'
      );      
      
clkfb3_bufg          : BUFG port map (I => clkfb3_mmcm    ,O => clkfb3);   
   
   -------------------------------------------------------------------------------------
   -- Output buffering
   -- Note: All clocks must go through a buffer from its source before than can be use.   
   -------------------------------------------------------------------------------------
                                                       
   main_clk_114_bufg    : BUFG port map (I => main_clk1_mmcm ,O => op.main_clk_114  );      
   main_clk_sys_bufg    : BUFG port map (I => main_clk2_mmcm ,O => op.main_clk_sys  );
   main_clk_audio_bufg  : BUFG port map (I => main_clk3_mmcm ,O => op.main_clk_audio);            

   -------------------------------------
   -- Reset generation
   -------------------------------------
 src_arst <= not op.main_clk_locked;
 -- DJR: Not sure is I have this right??
   i_xpm_cdc_async_rst_main : xpm_cdc_async_rst
      generic map (
          RST_ACTIVE_HIGH => 1
         ,DEST_SYNC_FF    => 6
      )
      port map (
          --src_arst  => not (clk_114_locked and clk_sys_locked and clk_audio_locked) -- 1-bit input: Source reset signal.
          src_arst  => src_arst
         ,dest_clk  => main_clk1_bufg         
         ,dest_arst => op.main_rst         -- 1-bit output: src_rst synchronized to the destination clock domain.
                                         -- This output is registered.                                                 
      );
      
     


end architecture RTL;

