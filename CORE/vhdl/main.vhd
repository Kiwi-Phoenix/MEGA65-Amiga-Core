----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- MiSTer2MEGA65 Framework
--
-- Wrapper for the MiSTer core that runs exclusively in the core's clock domanin
--
-- MiSTer2MEGA65 done by sy2002 and MJoergen in 2022 and licensed under GPL v3
--
--  Changes:
--  Jan 2025   Kiwi   Add in the Amiga Core
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

library work;
use work.video_modes_pkg.all;

entity main is
   generic (
      G_BOARD                 : string;                     -- Which platform are we running on.
      G_VDNUM                 : natural                     -- amount of virtual drives
   );
   port (
      clk_main_i              : in  std_logic;
      main_clk114_i           : in  std_logic;
      reset_soft_i            : in  std_logic;
      reset_hard_i            : in  std_logic;
      pause_i                 : in  std_logic;
      clk_reset_i             : in  std_logic;

      -- MiSTer core main clock speed:
      -- Make sure you pass very exact numbers here, because they are used for avoiding clock drift at derived clocks
-- DJR cannot define a port with type natural.  May not need this port for the Amiga.  If required, use a different method to pass the value.
<<<<<<< HEAD
      --clk_main_speed_i        : in  natural;
--      clk_main_speed_i        : in  std_logic_signed;   -- Input to this is likely to be from a constant

      -- RTC
      main_rtc_i              : in std_logic_vector(64 downto 0);
=======
      clk_main_speed_i        : in  natural;
>>>>>>> a617983d162547832bda3efc9ff83d367a3d3f6c

      -- Video output
      video_ce_o              : out std_logic;
      video_ce_ovl_o          : out std_logic;
      video_red_o             : out std_logic_vector(7 downto 0);
      video_green_o           : out std_logic_vector(7 downto 0);
      video_blue_o            : out std_logic_vector(7 downto 0);
      video_vs_o              : out std_logic;
      video_hs_o              : out std_logic;
      video_hblank_o          : out std_logic;
      video_vblank_o          : out std_logic;

      -- Audio output (Signed PCM)
      audio_left_o            : out signed(15 downto 0);
      audio_right_o           : out signed(15 downto 0);

      -- M2M Keyboard interface
-- DJR Doesn't like Integer as type for port.  Need to find another way.      
      kb_key_num_i            : in  integer range 0 to 79;    -- cycles through all MEGA65 keys
      kb_key_pressed_n_i      : in  std_logic;                -- low active: debounced feedback: is kb_key_num_i pressed right now?

      -- MEGA65 joysticks and paddles/mouse/potentiometers
      joy_1_up_n_i            : in  std_logic;
      joy_1_down_n_i          : in  std_logic;
      joy_1_left_n_i          : in  std_logic;
      joy_1_right_n_i         : in  std_logic;
      joy_1_fire_n_i          : in  std_logic;

      joy_2_up_n_i            : in  std_logic;
      joy_2_down_n_i          : in  std_logic;
      joy_2_left_n_i          : in  std_logic;
      joy_2_right_n_i         : in  std_logic;
      joy_2_fire_n_i          : in  std_logic;

      pot1_x_i                : in  std_logic_vector(7 downto 0);
      pot1_y_i                : in  std_logic_vector(7 downto 0);
      pot2_x_i                : in  std_logic_vector(7 downto 0);
      pot2_y_i                : in  std_logic_vector(7 downto 0);
      
      -- LEDS
      main_power_led_o        : out std_logic;
      main_fdd_led_o          : out std_logic;
      main_hdd_led_o          : out std_logic
      
   );
end entity main;

architecture synthesis of main is

-- @TODO: Remove these demo core signals
--signal keyboard_n          : std_logic_vector(79 downto 0);


<<<<<<< HEAD
-- CPU Wrapper Signals

signal wrap_reset_out       : std_logic;
signal wrap_chip_addr       : std_logic_vector(23 downto 1);
signal wrap_chip_addr0      : std_logic_vector(0 downto 0) := "1";
signal wrap_chip_din        : std_logic_vector(15 downto 0);
signal wrap_chip_as         : std_logic;
signal wrap_chip_uds        : std_logic;
signal wrap_chip_lds        : std_logic;
signal wrap_chip_rw         : std_logic;
signal wrap_fastchip_sel    : std_logic;
signal wrap_fastchip_lds    : std_logic;
signal wrap_fastchip_uds    : std_logic;
signal wrap_fastchip_rnw    : std_logic;
signal wrap_fastchip_lw     : std_logic;
--signal wrap_ramsel          : std_logic;
signal wrap_ramaddr         : std_logic_vector(28 downto 1);
signal wrap_ramdin          : std_logic_vector(15 downto 0);
signal wrap_ramlds          : std_logic;
signal wrap_ramuds          : std_logic;
signal wrap_ramshared       : std_logic;
signal wrap_toccata_ena     : std_logic;
signal wrap_toccata_base    : std_logic_vector(7 downto 0);
signal wrap_cpustate        : std_logic_vector(1 downto 0);
signal wrap_cacr            : std_logic_vector(3 downto 0);
signal wrap_nmi_addr        : std_logic_vector(31 downto 0);

-- In placeholders -- to be change to source references
signal wrap_ph1             : std_logic;
signal wrap_ph2             : std_logic;
signal wrap_ramdout         : std_logic_vector(15 downto 0);
signal wrap_ramready        : std_logic;


-- Minimig
signal mini_cpu_data        : std_logic_vector(15 downto 0);
signal mini_ami_cpu_ipl     : std_logic_vector(2 downto 0);
signal mini_ami_cpu_dtack   : std_logic;
signal mini_ami_cpu_reset   : std_logic;
signal mini_ovr             : std_logic;
signal mini_ram_data        : std_logic_vector(15 downto 0);
--signal mini_ram_address     : std_logic_vector(23 downto 1);
signal mini_ram_address     : std_logic_vector(24 downto 1);
signal mini_ami_ram_bhe     : std_logic;
signal mini_ami_ram_ble     : std_logic;
signal mini_ami_ram_we      : std_logic;
signal mini_ami_ram_oe      : std_logic;
signal mini_rst_out         : std_logic;
signal mini_IO_WAIT         : std_logic;
signal mini_IO_DOUT         : std_logic_vector(15 downto 0);
--signal mini_ami_hsync       : std_logic;
--signal mini_ami_vsync       : std_logic;
signal mini_ami_csync       : std_logic;
signal mini_field1          : std_logic;
signal mini_lace            : std_logic;
--signal mini_hblank          : std_logic;
--signal mini_vblank          : std_logic;
--signal mini_red             : std_logic_vector(7 downto 0);
--signal mini_green           : std_logic_vector(7 downto 0);
--signal mini_blue            : std_logic_vector(7 downto 0);
signal mini_ar              : std_logic_vector(1 downto 0);
signal mini_scanline        : std_logic_vector(2 downto 0);
signal mini_ce_pix          : std_logic;
signal mini_res             : std_logic_vector(1 downto 0);
signal mini_ntsc            : std_logic;
signal mini_ldata           : std_logic_vector(14 downto 0);
signal mini_rdata           : std_logic_vector(14 downto 0);
signal mini_ldata_okk       : std_logic_vector(8 downto 0);
signal mini_rdata_okk       : std_logic_vector(8 downto 0);
signal mini_aud_mix         : std_logic_vector(1 downto 0);
signal mini_toccata_aud_left : std_logic_vector(15 downto 0);
signal mini_toccata_aud_right : std_logic_vector(15 downto 0);
signal mini_cpucfg          : std_logic_vector(1 downto 0);
signal mini_cachecfg        : std_logic_vector(2 downto 0);
signal mini_memcfg          : std_logic_vector(6 downto 0);
signal mini_bootrom         : std_logic;
signal mini_ide_ena         : std_logic;
signal mini_ide_fast        : std_logic;
signal mini_ide_req         : std_logic_vector(5 downto 0);
signal mini_ide_readdata    : std_logic_vector(15 downto 0);
-- Minimiog -- Placeholders
signal mini_IO_UIO          : std_logic;
signal mini_IO_FPGA         : std_logic;
signal mini_IO_STROBE       : std_logic;
signal mini_IO_DIN          : std_logic_vector(15 downto 0);


-- Amiga Clock Signals
signal ac_clk7_en           : std_logic;
signal ac_clk7n_en          : std_logic;
signal ac_c1                : std_logic;
signal ac_c3                : std_logic;
signal ac_cck               : std_logic;
signal ac_eclk              : std_logic_vector(9 downto 0);


-- sdram ctrl
signal sdc_sd_addr          : std_logic_vector(12 downto 0);
signal sdc_sd_ba            : std_logic_vector(1 downto 0);
signal sdc_sd_cs            : std_logic;
signal sdc_sd_we            : std_logic;
signal sdc_ras              : std_logic;
signal sdc_sd_cas           : std_logic;
signal sdc_sd_dqm           : std_logic_vector(1 downto 0);
signal sdc_sd_data          : std_logic_vector(15 downto 0);
signal sdc_sd_clk           : std_logic;
signal sdc_cke              : std_logic;
signal sdc_chipRD           : std_logic_vector(15 downto 0);
signal sdc_chip48           : std_logic_vector(47 downto 0);
signal sdc_cpuRD            : std_logic_vector(15 downto 0);
signal sdc_ramready         : std_logic;
-- sdram Placeholders
signal sdc_cache_inhibit    : std_logic;
signal sdc_cpuCS            : std_logic;


-- ddram ctrl
signal ddc_DDRAM_CLK         : std_logic;
signal ddc_DDRAM_BURSTCNT    : std_logic_vector(7 downto 0);
signal ddc_DDRAM_ADDR        : std_logic_vector(28 downto 0);
signal ddc_DDRAM_RD          : std_logic;
signal ddc_DDRAM_DIN         : std_logic_vector(63 downto 0);
signal ddc_DDRAM_BE          : std_logic_vector(7 downto 0);
signal ddc_DDRAM_WE          : std_logic;
signal ddc_cpuRD             : std_logic_vector(15 downto 0);
signal ddc_ramready          : std_logic;
-- ddram placeholders
signal ddc_cache_inhibit     : std_logic;
signal ddc_DDRAM_BUSY        : std_logic;
signal ddc_DDRAM_DOUT        : std_logic_vector(63 downto 0);
signal ddc_DDRAM_DOUT_READY  : std_logic;
signal ddc_cpuCS             : std_logic;

-- Fastchip
signal fc_sel_ack           : std_logic;
signal fc_ready             : std_logic;
signal fc_dout              : std_logic_vector(15 downto 0);
signal fc_ena               : std_logic;
signal fc_rtg_hsize         : std_logic_vector(11 downto 0);
signal fc_rtg_vsize         : std_logic_vector(11 downto 0);
signal fc_rtg_format        : std_logic_vector(4 downto 0);
signal fc_rtg_base          : std_logic_vector(31 downto 0);
signal fc_rtg_stride        : std_logic_vector(13 downto 0);
signal fc_rtg_pal_clk       : std_logic;
signal fc_rtg_pal_dw        : std_logic_vector(23 downto 0);
signal fc_rtg_pal_a         : std_logic_vector(7 downto 0);
signal fc_rtg_pal_wr        : std_logic;           
signal fc_ide_irq           : std_logic;
signal fc_ide_req           : std_logic_vector(5 downto 0);
signal fc_ide_readdata      : std_logic_vector(15 downto 0);
signal fc_ide_led           : std_logic;
-- Fastchip -- placeholders
signal fc_cyc               : std_logic;
signal fc_reset             : std_logic;
signal fc_rtg_pal_dr        : std_logic_vector(23 downto 0);


-- CDDA
signal cdda_WRITE_REQ       : std_logic;
signal cdda_AUDIO_CE        : std_logic;
signal cdda_AUDIO_L         : std_logic_vector(15 downto 0);
signal cdda_AUDIO_R         : std_logic_vector(15 downto 0);


-- Video Mixer
signal vdm_CE_PIXEL         : std_logic;
signal vdm_gamma_bus        : std_logic_vector(12 downto 0);
signal vdm_freeze_sync      : std_logic;
signal vdm_VGA_R            : std_logic_vector(7 downto 0);
signal vdm_VGA_G            : std_logic_vector(7 downto 0);
signal vdm_VGA_B            : std_logic_vector(7 downto 0);
signal vdm_VGA_VS           : std_logic;
signal vdm_VGA_HS           : std_logic;
signal vdm_VGA_DE           : std_logic;

-- Video Freak
signal vdk_VGA_DE           : std_logic;
signal vdk_VIDEO_ARX        : std_logic_vector(12 downto 0);
signal vdk_VIDEO_ARY        : std_logic_vector(12 downto 0);

-- Video Freezer
signal vdf_sync             : std_logic;
signal vdf_hs_out           : std_logic;
signal vdf_vs_out           : std_logic;
signal vdf_hbl_out          : std_logic;
signal vdf_vbl_out          : std_logic;

-- Joysick Mapping / logic
signal joy_ami_joy1         : std_logic_vector(15 downto 0);
signal joy_ami_joy2         : std_logic_vector(15 downto 0);
signal joy_ami_joy3         : std_logic_vector(15 downto 0);
signal joy_ami_joy4         : std_logic_vector(15 downto 0);
signal joy_joya1            : std_logic_vector(15 downto 0);
signal joy_joya2            : std_logic_vector(15 downto 0);
signal joy_mouse_btn        : std_logic_vector(2 downto 0);
signal joy_kbd_mouse_type   : std_logic_vector(1 downto 0);
signal joy_kbd_mouse_data   : std_logic_vector(7 downto 0);
signal joy_kms_level        : std_logic;

-- UART
-- Placeholder for In
signal uart_rxd                  : std_logic;
signal uart_cts                  : std_logic;
signal uart_dsr                  : std_logic;
signal uart_cd                   : std_logic;
signal uart_ri                   : std_logic;

-- OUT
signal uart_txd                  : std_logic;
signal uart_rts                  : std_logic;
signal uart_dtr                  : std_logic;


-- IDE
-- Placeholders for IN
-- Minimig has these coming from hps_ext
signal ide_ide_address          : std_logic_vector(4 downto 0);
signal ide_ide_write            : std_logic;
signal ide_ide_writedata        : std_logic_vector(15 downto 0);
signal ide_ide_read             : std_logic;

-- IIR Filter lpf3275
signal lpf3_output_l        : std_logic_vector(15 downto 0);
signal lpf3_output_r        : std_logic_vector(15 downto 0);

-- IIR Filter lpf4400
signal lpf4_output_l        : std_logic_vector(15 downto 0);
signal lpf4_output_r        : std_logic_vector(15 downto 0);

-- IIR_Filter
signal iir_ce                   : std_logic;
signal iir_cx                   : std_logic_vector(39 downto 0);
signal iir_cx0                  : std_logic_vector(7 downto 0);
signal iir_cx1                  : std_logic_vector(7 downto 0);
signal iir_cx2                  : std_logic_vector(7 downto 0);
signal iir_cy0                  : std_logic_vector(23 downto 0);
signal iir_cy1                  : std_logic_vector(23 downto 0);
signal iir_cy2                  : std_logic_vector(23 downto 0);
signal iir_input_l              : std_logic_vector(15 downto 0);
signal iir_input_r              : std_logic_vector(15 downto 0);
=======
>>>>>>> a617983d162547832bda3efc9ff83d367a3d3f6c



begin

   -- @TODO: Add the actual MiSTer core here
   -- The demo core's purpose is to show a test image and to make sure, that the MiSTer2MEGA65 framework
   -- can be synthesized and run stand-alone without an actual MiSTer core being there, yet
   
   -- DJR Lots more work to be done here !!!!
   
   
   amiga_clk : entity work.amiga_clk
        port map (
            clk_28      => clk_main_i,
<<<<<<< HEAD
            reset_n     => not clk_reset_i,
            
            clk7_en     => ac_clk7_en,
            clk7n_en    => ac_clk7n_en,
            c1          => ac_c1,
            c3          => ac_c3,
            cck         => ac_cck,
            eclk        => ac_eclk              
=======
            reset_n     => reset_hard_i               
>>>>>>> a617983d162547832bda3efc9ff83d367a3d3f6c
        );  -- amiga_clk
   
   
   
<<<<<<< HEAD
   cpu_wrapper : entity work.cpu_wrapper
        port map (
        -- In Ports
              clk               => clk_main_i,                 
              reset             => mini_ami_cpu_reset,
              ph1               => wrap_ph1,
              ph2               => wrap_ph2,
              cpucfg            => mini_cpucfg,
              fastramcfg        => mini_memcfg(6 downto 4),
              cachecfg          => mini_cachecfg,
              bootrom           => mini_bootrom,              
              chip_dout         => mini_cpu_data,  
              chip_dtack        => mini_ami_cpu_dtack,        
              chip_ipl          => mini_ami_cpu_ipl,
              fastchip_dout     => fc_dout,       
              fastchip_selack   => fc_sel_ack,         
              fastchip_ready    => fc_ready, 
              ramdout           => wrap_ramdout,
              ramready          => wrap_ramready,
              
        -- Out Ports              
              reset_out         => wrap_reset_out,
              chip_addr         => wrap_chip_addr,
              chip_din          => wrap_chip_din,
              chip_as           => wrap_chip_as,
              chip_uds          => wrap_chip_uds,
              chip_lds          => wrap_chip_lds,
              chip_rw           => wrap_chip_rw,
              fastchip_sel      => wrap_fastchip_sel,
              fastchip_lds      => wrap_fastchip_lds,
              fastchip_uds      => wrap_fastchip_uds,
              fastchip_rnw      => wrap_fastchip_rnw,
              fastchip_lw       => wrap_fastchip_lw,
              --ramsel            => wrap_ramsel,                   -- DJR Doesn't appear to be used.
              ramaddr           => wrap_ramaddr,
              ramdin            => wrap_ramdin,
              ramlds            => wrap_ramlds,
              ramuds            => wrap_ramuds,
              ramshared         => wrap_ramshared,
              toccata_ena       => wrap_toccata_ena,
              toccata_base      => wrap_toccata_base,
              cpustate          => wrap_cpustate,
              cacr              => wrap_cacr,
              nmi_addr          => wrap_nmi_addr                                                                                                           
        );  -- cpu_wrapper
  
-- DJR:    Needs looking into.  A section that does IDE uses a component that is supplied with Quartus.
--  Need to validate if this is necessary or what are the alternatives.  But first understand what the outcome it.
   
                 
     minimig_wrapper : entity work.Minimig_wrapper
        port map (                
                cpu_address         => wrap_chip_addr,          -- DJR Needs some logic as these is also a signal from fastchip.addr
                cpudata_in          => wrap_chip_din,           -- DJR also a signal from fastchip.din
                ami_cpu_as          => wrap_chip_as,
                ami_cpu_uds         => wrap_chip_uds,
                ami_cpu_lds         => wrap_chip_lds,
                cpu_r_w             => wrap_chip_rw,
                ami_cpu_reset_in    => wrap_reset_out,          -- DJR - TBC might also need to combine another signal
                nmi_addr            => wrap_nmi_addr,
                ramdata_in          => sdc_chipRD,
                chip48              => sdc_chip48,        
                rst_ext             => clk_reset_i,
                clk                 => clk_main_i,
                clk7_en             => ac_clk7_en,
                clk7n_en            => ac_clk7n_en,
                c1                  => ac_c1,
                c3                  => ac_c3,
                cck                 => ac_cck,
                eclk                => ac_eclk,            
                rxd                 => uart_rxd,
                cts                 => uart_cts,
                dsr                 => uart_dsr,
                cd                  => uart_cd,
                ri                  => uart_ri,
                ami_joy1            => joy_ami_joy1,
                ami_joy2            => joy_ami_joy2,
                ami_joy3            => joy_ami_joy3,
                ami_joy4            => joy_ami_joy4,
                joya1               => joy_joya1,
                joya2               => joy_joya2,
                mouse_btn           => joy_mouse_btn,
                kms_level           => joy_kms_level,
                kbd_mouse_type      => joy_kbd_mouse_type,
                kbd_mouse_data      => joy_kbd_mouse_data,
                rtc                 => main_rtc_i,
                IO_UIO              => mini_IO_UIO,               -- DJR TBC as to what this is connected to.
                IO_FPGA             => mini_IO_FPGA,              -- DJR TBC as to what this is connected to.
                IO_STROBE           => mini_IO_STROBE,            -- DJR TBC as to what this is connected to.
                IO_DIN              => mini_IO_DIN,               -- DJR TBC as to what this is connected to.
                toccata_ena         => wrap_toccata_ena,
                toccata_base        => wrap_toccata_base,
                ide_ext_irq         => fc_ide_irq,
                ide_address         => ide_ide_address,
                ide_write           => ide_ide_write,
                ide_writedata       => ide_ide_writedata,
                ide_read            => ide_ide_read,
                                                          
        
                cpu_data            => mini_cpu_data,
                ami_cpu_ipl         => mini_ami_cpu_ipl,
                ami_cpu_dtack       => mini_ami_cpu_dtack,
                ami_cpu_reset       => mini_ami_cpu_reset,
                --ovr                 => mini_ovr,                  -- DJR Doesn't seem to be used. 
                ram_data            => mini_ram_data,
                ram_address         => mini_ram_address(23 downto 1),   -- DJR Need to re-check this.
                ami_ram_bhe         => mini_ami_ram_bhe,
                ami_ram_ble         => mini_ami_ram_ble,
                ami_ram_we          => mini_ami_ram_we,
                --ami_ram_oe          => mini_ami_ram_oe,           -- DJR TBC as to where this is connected to
                --rst_out             => mini_rst_out,              -- DJR TBC as to where this is connected to
                txd                 => uart_txd,                 
                rts                 => uart_rts,
                dtr                 => uart_dtr,
                pwr_led             => main_power_led_o,
                fdd_led             => main_fdd_led_o,
                hdd_led             => main_hdd_led_o,
                --IO_WAIT             => mini_IO_WAIT,              -- DJR TBC as to where this is connected to ??
                --IO_DOUT             => mini_IO_DOUT,              -- DJR TBC as to whete this is connected to ??
                ami_hsync           => video_hs_o,
                ami_vsync           => video_vs_o,
                --ami_csync           => mini_ami_csync,            -- DJR TBC as to where this is connected to ??
                --field1              => mini_field1,               -- DJR TBC as to where this is connected to ??
                --lace                => mini_lace,                 -- DJR TBC as to where this is connected to ??
                hblank              => video_vblank_o,
                vblank              => video_hblank_o,
                red                 => video_red_o,
                green               => video_green_o,
                blue                => video_blue_o,
                --ar                  => mini_ar,                   -- DJR TBC as to where this is connected to??
                --scanline            => mini_scanline,             -- DJR TBC as to where this is connected to??
                --ce_pix              => mini_ce_pix,               -- DJR TBC as to where this is connected to??
                --res                 => mini_res,                  -- DJR TBC as to where this is connected to??
                --ntsc                => mini_ntsc,                 -- DJR Connected to a CLK which has not been set up yet, changes the clk when ntsc config is invoked.
                ldata               => mini_ldata,
                rdata               => mini_rdata,
                ldata_okk           => mini_ldata_okk,            -- DJR To be mapped
                rdata_okk           => mini_rdata_okk,            -- DJR TO be mapped
                --aud_mix             => mini_aud_mix,              -- DJR TBC as to where this is connected to?
                toccata_aud_left    => mini_toccata_aud_left,
                toccata_aud_right   => mini_toccata_aud_right,
                cpucfg              => mini_cpucfg,
                cachecfg            => mini_cachecfg,
                memcfg              => mini_memcfg,
                bootrom             => mini_bootrom,
                ide_ena             => mini_ide_ena,
                ide_fast            => mini_ide_fast,               -- DJR TBC as to where this is connected to??
                ide_req             => mini_ide_req,                -- DJR TBC as to where this is connected to??
                ide_readdata        => mini_ide_readdata            -- DJR TBC as to where this is connected to??                                                                        
        ); -- minimig_wrapper
 
      fastchip : entity work.fastchip
            port map (
                    clk             => main_clk114_i,
                    cyc             => fc_cyc,                      -- DJR TBC as to where this comes from or the logic to apply.              
                    clk_sys         => clk_main_i,
                    reset           => fc_reset,                   -- DJR TBC - requires some logic to connect. I.e. two pins to the one.
                    sel             => wrap_fastchip_sel,
                    addr(23 downto 1)   => wrap_chip_addr,
                    addr(0)         => wrap_chip_addr0,                  
                    din             => wrap_chip_din,
                    lds             => wrap_fastchip_lds,
                    uds             => wrap_fastchip_uds,
                    rnw             => wrap_fastchip_rnw,
                    longword        => wrap_fastchip_lw,
                    rtg_pal_dr      => fc_rtg_pal_dr,                                   -- DJR TBC as to where this is connected to.  Minimig has this comming from the main board, is there a framework alternative?
                    ide_ena         => mini_ide_ena,
                    ide_address     => ide_ide_address,                            -- DJR TBC as to where this is connected to.  Minimig has this coming from hps_ext, is there a framework alternative?
                    ide_write       => ide_ide_write,                              -- DJR TBC as to where this is connected to.  Minimig has this coming from hps_ext, is there a framework alternative?
                    ide_writedata   => ide_ide_writedata,                          -- DJR TBC as to where this is connected to.  Minimig has this coming from hps_ext, is there a framework alternative?
                    ide_read        => ide_ide_read,
                    
                    sel_ack         => fc_sel_ack,
                    ready           => fc_ready,
                    dout            => fc_dout,
                    rtg_ena         => fc_ena,
                    rtg_hsize       => fc_rtg_hsize,
                    rtg_vsize       => fc_rtg_vsize,
                    rtg_format      => fc_rtg_format,
                    rtg_base        => fc_rtg_base,
                    rtg_stride      => fc_rtg_stride,
                    rtg_pal_clk     => fc_rtg_pal_clk,
                    rtg_pal_dw      => fc_rtg_pal_dw,
                    rtg_pal_a       => fc_rtg_pal_a,
                    rtg_pal_wr      => fc_rtg_pal_wr,
                    ide_irq         => fc_ide_irq,
                    ide_req         => fc_ide_req,
                    ide_readdata    => fc_ide_readdata,
                    ide_led         => fc_ide_led
                                
            ); -- fastchip
--            wrap_chip_addr0 <= "1";
                  
    sdram_ctrl : entity work.sdram_ctrl
            port map (
                    sysclk                 => main_clk114_i,
                    c_7m                   => ac_c1,
                    reset_n                => clk_reset_i,
                    cache_rst              => mini_ami_cpu_reset,
                    cache_inhibit          => sdc_cache_inhibit,            -- DJR Not actually used by minimig
                    cpu_cache_ctrl         => wrap_cacr,
                    chipAddr               => mini_ram_address(24 downto 1),  -- DJR needs to be re-checked
                    chipL                  => mini_ami_ram_ble,
                    chipU                  => mini_ami_ram_bhe,
                    chipRW                 => mini_ami_ram_we,
                    chipDMA                => mini_ami_ram_oe,
                    chipWR                 => mini_ram_data,
                    cpuAddr                => wrap_ramaddr(24 downto 1),                  -- DJR Note: this is also split to cpuCS, need to some logic to do this.
                    cpuCS                  => sdc_cpuCS,                     -- DJR needs logic to be applied.
                    cpustate               => wrap_cpustate,
                    cpuL                   => wrap_ramlds,
                    cpuU                   => wrap_ramuds,
                    cpuWR                  => wrap_ramdin,
                    
                    sd_addr                => sdc_sd_addr,
                    sd_ba                  => sdc_sd_ba,
                    sd_cs                  => sdc_sd_cs,
                    sd_we                  => sdc_sd_we,
                    sd_ras                 => sdc_ras,
                    sd_cas                 => sdc_sd_cas,
                    sd_dqm                 => sdc_sd_dqm,
                    sd_data                => sdc_sd_data,
                    sd_clk                 => sdc_sd_clk,
                    sd_cke                 => sdc_cke,
                    chipRD                 => sdc_chipRD,
                    chip48                 => sdc_chip48,
                    cpuRD                  => sdc_cpuRD,
                    ramready               => sdc_ramready 
                    
            ); -- sdram_ctrl            

    ddram_ctrl  : entity work.ddram_ctrl
            port map (
                    sysclk                  => main_clk114_i,
                    reset_n                 => clk_reset_i,
                    cache_rst               => mini_ami_cpu_reset,
                    cache_inhibit           => ddc_cache_inhibit,            -- DJR Not actually used by minimig
                    cpu_cache_ctrl          => wrap_cacr,
                    DDRAM_BUSY              => ddc_DDRAM_BUSY,               -- DJR minimig source is from another level, need to find the source.
                    DDRAM_DOUT              => ddc_DDRAM_DOUT,               -- DJR minimig source is from another level, need to find the source.
                    DDRAM_DOUT_READY        => ddc_DDRAM_DOUT_READY,         -- DJR minimig source is from another level, need to find the source.
                    cpuAddr                 => wrap_ramaddr,                 -- DJR Note there is a split to cpuCS.  Need some logic here
                    cpuCS                   => ddc_cpuCS,                    -- DJR need to apply some logic for this.
                    cpustate                => wrap_cpustate,
                    cpuL                    => wrap_ramlds,
                    cpuU                    => wrap_ramuds,
                    cpuWR                   => wrap_ramdin,
                    ramshared               => wrap_ramshared,
                    
                    DDRAM_CLK               => ddc_DDRAM_CLK,               -- DJR - NOTE connects to the minimig board, need to find the framework alternative.
                    DDRAM_BURSTCNT          => ddc_DDRAM_BURSTCNT,          -- DJR - NOTE connects to the minimig board, need to find the framework alternative.
                    DDRAM_ADDR              => ddc_DDRAM_ADDR,              -- DJR - NOTE connects to the minimig board, need to find the framework alternative.
                    DDRAM_RD                => ddc_DDRAM_RD,                -- DJR - NOTE connects to the minimig board, need to find the framework alternative.
                    DDRAM_DIN               => ddc_DDRAM_DIN,               -- DJR - NOTE connects to the minimig board, need to find the framework alternative.
                    DDRAM_BE                => ddc_DDRAM_BE,                -- DJR - NOTE connects to the minimig board, need to find the framework alternative.
                    DDRAM_WE                => ddc_DDRAM_WE,                -- DJR - NOTE connects to the minimig board, need to find the framework alternative.
                    cpuRD                   => ddc_cpuRD,                   
                    ramready                => ddc_ramready                                            
            ); -- ddram_ctrl

                                  
-- DJR Not too sure this.....  should sound put be mapped to the framewotk instead of using filters first???
                
--        lpf4400 : entity work.iir_filter
--                port map (
--                        clk                   => clk_main_i,
--                        reset                 => clk_reset_i,
--                        --ce                    => iir_ce,                    -- DJR TODO - Some combine logic needs to defined for this.
--                        ce                    => ac_clk7_en or ac_clk7n_en,
--                        sample_ce             => '1',
--                        cx                    => iir_cx,                    
----                        cx0         => '1',
--                        cx0                   => iir_cx0,
--                        cx1                   => iir_cx1,
--                        cx2                   => iir_cx2,
--                        cy0                   => iir_cy0,
--                        cy1                   => iir_cy1,
--                        cy2                   => iir_cy2,
--                        input_l               => iir_input_l,
--                        input_r               => iir_input_r,
--
--                        output_l                => lpf4_output_l,
--                        output_r                => lpf4_output_r                
--                ); -- lpf440 iir_filter
-- 
--         lpf3275 : entity work.iir_filter
--                port map (
--                        clk                     => clk_main_i,
--                        reset                   => clk_reset_i,
--                        --ce                      => iir_ce,                  -- DJR TODO - Some combine logic needs to defined for this.
--                        ce                      => ac_clk7_en or ac_clk7n_en,
--                        sample_ce               => '1',
--                        cx                      => iir_cx,
--                        cx0                     => iir_cx0,
--                        cx1                     => iir_cx1,
--                        cx2                     => iir_cx2,
--                        cy0                     => iir_cy0,
--                        cy1                     => iir_cy1,
--                        cy2                     => iir_cy2,
--                        input_l                 => iir_input_l,
--                        input_r                 => iir_input_r,
--                        
--                        output_l                => lpf3_output_l,
--                        output_r                => lpf3_output_r                                                                                       
--                ); -- lpf3275 iir_filter               

=======
--   cpu_wrapper : entity work.cpu_wrapper
--        port map (
--            reset       => reset_hard_i,
--            clk         => clk_main_i                 --- TBC                            
--        );  -- cpu_wrapper
   
-- DJR:    Needs looking into.  A section that does IDE uses a component that is supplied with Quartus.
--  Need to validate if this is necessary or what are the alternatives.  But first understand what the outcome it.
--   fastchip : entity work.fastchip
--        port map (
--        ); -- fastchip   
   


--    IRR_filter : entity work.irr_filter
--        port map (
--        ); -- irr_filter   
        
        
   
--   minimig : entity work.minimig
--     port map (
--      ); -- minimig
>>>>>>> a617983d162547832bda3efc9ff83d367a3d3f6c

   -- On video_ce_o and video_ce_ovl_o: You have an important @TODO when porting a core:
   -- video_ce_o: You need to make sure that video_ce_o divides clk_main_i such that it transforms clk_main_i
   --             into the pixelclock of the core (means: the core's native output resolution pre-scandoubler)
   -- video_ce_ovl_o: Clock enable for the OSM overlay and for sampling the core's (retro) output in a way that
   --             it is displayed correctly on a "modern" analog input device: Make sure that video_ce_ovl_o
   --             transforms clk_main_o into the post-scandoubler pixelclock that is valid for the target
   --             resolution specified by VGA_DX/VGA_DY (globals.vhd)
   -- video_retro15kHz_o: '1', if the output from the core (post-scandoubler) in the retro 15 kHz analog RGB mode.
   --             Hint: Scandoubler off does not automatically mean retro 15 kHz on.
-- DJR Need to do something here!!!   
--   video_ce_ovl_o <= video_ce_o;

   -- @TODO: Keyboard mapping and keyboard behavior
   -- Each core is treating the keyboard in a different way: Some need low-active "matrices", some
   -- might need small high-active keyboard memories, etc. This is why the MiSTer2MEGA65 framework
   -- lets you define literally everything and only provides a minimal abstraction layer to the keyboard.
   -- You need to adjust keyboard.vhd to your needs
--   i_keyboard : entity work.keyboard
--      port map (
--         clk_main_i           => clk_main_i,

         -- Interface to the MEGA65 keyboard
-- DJR Need another way to do this.         
--         key_num_i            => kb_key_num_i,
--         key_pressed_n_i      => kb_key_pressed_n_i,

         -- @TODO: Create the kind of keyboard output that your core needs
         -- "example_n_o" is a low active register and used by the demo core:
         --    bit 0: Space
         --    bit 1: Return
         --    bit 2: Run/Stop
--         example_n_o          => keyboard_n
--      ); -- i_keyboard

end architecture synthesis;

