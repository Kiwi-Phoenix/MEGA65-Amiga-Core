-- Instatiate the Amiga Core
-- Instatiate the Amiga Core
-- Instatiate the Amiga Core
-- This is a VHDL version of the verilog code.
-- Doing it in VHDL as it maybe a little easier to using the Vivado debugging tools.
-- Initial re-done using Verilig to presever the logic without going too deep as to what it does.
-- But now worth the effort to transalate this to VHDL for the structure, etc.
--
-- A stripped down version of the MiSTer Minimig Core EMU module
--
-- June 2025    - David Raynor (Kiwi)
-- Tidying up a bit and moving he processes to their own separate entity.  Should make it easier to see
-- what is going on with each smaller processes ater sysnthesis.  Plus makes it easier to show in the block
-- diagram that I am using for documenting the design, as well as help to reduce the code and complexity for this entity :-) 
--
-- Notes:
-- Check how the status signal is populated as this drives the ce_pix signal freq
-- Status comes from hps_IO, which also uses CONF_STR.  Check to see what it does with it and how status is populated.
-- That CONF_STR maybe important.


-- Jul 2025 Tidy up the signal groups by using record types.
--


 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 
 use work.AmigaM65_Sig_pkg.all;
 use work.globals.all;
 use work.Amiga_Globals.all;
 use work.DocPkg.all;
 use work.build_id.all;
 use work.Amiga_Debug_pkg.all;
 use work.Amiga_Debug_Sig_pkg.all;
 
 
  
library unisim;
use unisim.vcomponents.all;
 
entity AmigaM65 is
    generic (
        DATA_WIDTH  : integer := 16;
--        ENABLE_DONT_TOUCH : boolean := true;
--        DATA_WIDTH  : integer := 64;        
        ADDR_WIDTH  : integer := 29
    );
    port (
        -- Clocks
        main_clk_114        : in std_logic;
        main_clk_sys        : in std_logic;
        main_clk_locked     : in std_logic;
        main_rst            : in std_logic;
        CLK_AUDIO           : in std_logic;     -- Audio Clock @ 24.576 MHz
        
        -- Reset
        RESET               : in  std_logic;        
              
        -- LEDs
        LED_USER            : out std_logic;
--        LED_POWER           : out std_logic_vector(1 downto 0);
        LED_POWER           : out std_logic_vector(0 downto 0);        
        LED_DISK            : out std_logic_vector(1 downto 0);
        
        -- Audio
        AUDIO_L             : out std_logic_vector(15 downto 0);
        AUDIO_R             : out std_logic_vector(15 downto 0);
        AUDIO_S             : out std_logic;                        -- 1 - signed audio samples, 0 - unsigned
        AUDIO_MIX           : out std_logic_vector(1 downto 0);     -- 0 - no mix, 1 - 25%, 2 - 50%, 3 - 100% (mono)
        
        -- UART
        UART_CTS            : in  std_logic;
        UART_RTS            : out std_logic;
        UART_RXD            : in  std_logic;
        UART_TXD            : out std_logic;
        UART_DTR            : out std_logic;
        UART_DSR            : in  std_logic;
        
        -- Video Output
        VGA_R               : out std_logic_vector(7 downto 0);
        VGA_G               : out std_logic_vector(7 downto 0);
        VGA_B               : out std_logic_vector(7 downto 0);
        VGA_HS              : out std_logic;                        -- Horizontal 
        VGA_VS              : out std_logic;                        -- Vertical
        VIDEO_HBLANK        : out std_logic; 
        VIDEO_VBLANK        : out std_logic;
        CE_PIXEL            : out std_logic;                        -- Clock enable
        CLK_VIDEO           : out std_logic;                        -- Video Clock
        VGA_DE              : out std_logic;                        -- = ~(VBlank or HBlank)
        VGA_F1              : out std_logic;                        -- Not used in M2M framework
        VGA_SL              : out std_logic_vector(1 downto 0);     -- Not used in M2M
        VGA_SCALER          : out std_logic;                        -- Not sure if this is used???
        VGA_DISABLE         : out std_logic;                        -- analog out is off
        HDMI_FREEZE         : out std_logic ;                       -- Not sure is this is used / needed in M2M
        
        -- Keyboad Input
        kbd_mouse_type      : in std_logic_vector(1 downto 0);
        kbd_mouse_data      : in std_logic_vector(7 downto 0);
                                   
        -- User Config
        io_uio              : in  std_logic;                        -- Enable signal for USERIO
        io_strobe           : in  std_logic;  
        io_din              : in  std_logic_vector(15 downto 0);    -- Data for USERIO
        io_wait             : out std_logic;
        io_fpga             : in  std_logic;                        -- Enable signal for Paula
        io_fpga_dout        : out std_logic_vector(15 downto 0)     -- Data for Paula         
                               
    );    
      
    -- Apply descriptons to the ports.
    attribute description of VGA_HS                 : signal is "VGA Horizontal Sync";
    attribute description of VGA_VS                 : signal is "VGA Vertical Sync";
    attribute description of AUDIO_S                : signal is "1 - signed audio samples, 0 - unsigned";
    attribute description of AUDIO_MIX              : signal is "0 - no mix, 1 - 25%, 2 - 50%, 3 - 100% (mono)";
    attribute description of CLK_AUDIO              : signal is "Audio Clock @ 24.576 MHz";    
           
 end entity;
 
architecture RTL of AmigaM65 is
-- Set up Debug
-- Note: requires the constamt DEBUG which is set int eh Amiga_Globals package.
-- Force Synthesis not to remove / change signals, port, etc.

-- Note: debug_Amiga package contains the set up for DONT_TOUCH
-- DONT_TOUCH attribute stop synthesis from removing them.
-- It will do this if there are no inputs/outputs to the module.
attribute DONT_TOUCH of MiniMig         : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of reset_sig       : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of amiga_clk       : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of compute_ram_cs  : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of cpu_wrapper     : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of RAM_CTRL        : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of FastChip        : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of Power_LED       : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of Pixel_clk       : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of video_mixer     : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of HS_VS_Timing    : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of lpf4000         : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of lpf3275         : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of aud_out         : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of cdda            : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of comb_audio      : label is c_dont_touch(DEBUG);


    -- Config String from original MiSTer EMU module.
    -- TODO: include the auto generation of the build_date.  For now it is hard coded a package in the Amiga_Globals.vhd file.
    -- Note: this constant is used in the hps_io (not included in this build).  Need to recheck if I need to include the same
    --       logic to apply configuration settings.
    --  MAY NOT BE NEEDED!!!
    
    constant CONF_STR : string := 
            "Minimig;UART115200,MIDI;" &
            "J,Red(Fire),Blue,Yellow,Green,RT,LT,Pause;" &
            "jn,A,B,X,Y,R,L,Start;" &
            "jp,B,A,X,Y,R,L,Start;" &
            "-;" &
            "I," &
            "MT32-pi: SoundFont #0," &
            "MT32-pi: SoundFont #1," &
            "MT32-pi: SoundFont #2," &
            "MT32-pi: SoundFont #3," &
            "MT32-pi: SoundFont #4," &
            "MT32-pi: SoundFont #5," &
            "MT32-pi: SoundFont #6," &
            "MT32-pi: SoundFont #7," &
            "MT32-pi: MT-32 v1," &
            "MT32-pi: MT-32 v2," &
            "MT32-pi: CM-32L," &
            "MT32-pi: Unknown mode;" &
            "V,v" & BUILD_DATE;

    -- Signals ------------------------------------------------------------------------------------------
    -- The Record Type for the signals are declared in AmigaM65_Sig_pkg.vhd
       
    -- Modules Output signals
    signal ip           : IP_TYPE;                          -- IN Ports
    signal op           : OP_TYPE;                          -- OUT Ports
    signal miniout      : MINIMIG_SIG_TYPE;
    signal jmk          : JOY_MOUSE_KEYBOARD_TYPE;
    signal cpuwrap      : CPU_WRAPPER_TYPE;
    signal fast         : FASTCHIP_TYPE;
    signal video        : VIDEO_MIXER_TYPE;
    signal hsvs         : HSVS_TIMING_TYPE;
    signal audio        : AUDIO_TYPE;
    signal amiclk       : AMIGA_CLK_TYPE;
    signal ram          : RAM_CTRL_TYPE;
    
                
    -- IDE
    -- Placeholders until the disk drives are connected.
    signal ide_din          : std_logic_vector(15 downto 0);
    signal ide_dout         : std_logic_vector(15 downto 0);
    signal ide_addr         : std_logic_vector(4 downto 0);
    signal ide_rd           : std_logic;
    signal ide_wr           : std_logic;
    signal ide_req          : std_logic_vector(5 downto 0);
      
    -- Placeholders until I work out what to do with them.   I.e. connect them up, etc.
--    signal JOY0             : std_logic_vector(15 downto 0);
--    signal JOY1             : std_logic_vector(15 downto 0);         
--    signal JOY2             : std_logic_vector(15 downto 0);                          
--    signal JOY3             : std_logic_vector(15 downto 0);
--    signal JOYA0            : std_logic_vector(15 downto 0);
--    signal JOYA1            : std_logic_vector(15 downto 0);
--    signal kbd_mouse_data   : std_logic_vector(7 downto 0);
--    signal kbd_mouse_level  : std_logic;
--    signal kbd_mouse_type   : std_logic_vector(1 downto 0);
--    signal mouse_buttons    : std_logic_vector(2 downto 0);
--    signal X_joy1           : std_logic_vector(15 downto 0);
--    signal X_joy2           : std_logic_vector(15 downto 0);
--    signal X_joy3           : std_logic_vector(15 downto 0);  
--    signal X_joy4           : std_logic_vector(15 downto 0);
    
    signal RTC              : std_logic_vector(64 downto 0);        -- Real Time Clock
    signal gamma_bus        : std_logic_vector(21 downto 0);        -- Comes from HPS_IO.  Not sure how important this signal is.  May need to find a way to generate it.
             
    -- RAM 1
    signal cpuCS            : std_logic;
    signal cache_inhibit    : std_logic;
    signal sdram_clk_buf    : std_logic;
        
    -- RAM 1 Used to connect to the SD RAM.  SD Ram has been replaced by Chip ram.  Signals still required.
--    signal DDRAM_ADDR       : std_logic_vector(ADDR_WIDTH - 1 downto 0);
--    signal DDRAM_DOUT       : std_logic_vector(DATA_WIDTH - 1 downto 0);
--    signal DDRAM_DIN        : std_logic_vector(DATA_WIDTH - 1 downto 0);        
--    signal DDRAM_BE         : std_logic_vector(DATA_WIDTH/8 - 1 downto 0);
                    
    -- Fastchip
    signal reset_fc         : std_logic;
    signal lds              : std_logic;
    signal uds              : std_logic;
    signal ide_ena_fc       : std_logic;        
    
    -- Placeholder for the RTG framebuffer control
    -- Not sure if I need this or can use it
    signal FB_PAL_DIN       : std_logic_vector(23 downto 0);
               
    -- CPU Wrapper            
    signal cpu_type         : std_logic;
    signal cpu_ph1          : std_logic;
    signal cpu_ph2          : std_logic;
    
    signal cyc              : std_logic;
    
    signal zram_sel         : std_logic;
    signal ram_dout         : std_logic_vector(15 downto 0);
    signal ram_ready        : std_logic;
    signal ram_cs           : std_logic;
    
    
    -- Video Mixer
    signal forced_scandoubler   : std_logic;
    signal scandoubler      : std_logic;
--    signal R,G,B            : std_logic_vector(7 downto 0);
    signal vblank           : std_logic;
    signal fvb : std_logic;
    signal hbl              : std_logic;
    signal vde              : std_logic; 
    signal ce_out           : std_logic := '0';
    signal hq2x_sig         : std_logic;
    signal nhs              : std_logic;
    signal nvs              : std_logic;
    signal nhde             : std_logic;
    signal nvde             : std_logic;
              
  -- Reset signals    
  signal reset_i          : std_logic;
  signal reset_d          : std_logic;
  signal reset_n          : std_logic;
  signal reset_nd         : std_logic;
    
  -- UART
  signal uart_mode                                   : std_logic_vector(7 downto 0);
  signal xuart_cts, xuart_dsr  : std_logic;
  signal xuart_tx, xuart_rx                          : std_logic;
  signal hps_mpu                                     : std_logic; 
  signal midi_rx, mt32_use                           : std_logic;

  -- Audio Filters
  signal paula_smp_l, paula_smp_r   : std_logic_vector(15 downto 0);
  signal flt_en                     : std_logic;
  signal aud_1200                   : std_logic;
  signal paula_pwm                  : std_logic;
  signal ce                         : std_logic;
        
  --Original value: 4304835800 (40-bit)
  constant cx_high                  : unsigned(19 downto 0) := to_unsigned(430483, 20);
  constant cx_low                   : unsigned(19 downto 0) := to_unsigned(5800, 20);
  signal cx                         : unsigned(39 downto 0);
  
  signal audm_l, audm_r             : std_logic_vector(15 downto 0);
  constant cx2                      : unsigned(39 downto 0) := to_unsigned(8536629, 40);
                           
  -- CDDA
  signal cdda_dout          : std_logic_vector(15 downto 0);
  signal cdda_wr            : std_logic;
                         
    -- Other
    -- Status is populated from HPS_IO which is not being used in this port.
    --  Need to populate this from another source, or set the values directly.  Depending on what it is used for.
  signal status              : std_logic_vector(64 downto 0);


begin     

-- Map IN Ports
ip.main_clk_114         <= main_clk_114;
ip.main_clk_sys         <= main_clk_sys;
ip.main_clk_locked      <= main_clk_locked;
ip.main_rst             <= main_rst;
ip.CLK_AUDIO            <= CLK_AUDIO;
ip.RESET                <= RESET;
ip.UART_CTS             <= UART_CTS;
ip.UART_RXD             <= UART_RXD;
ip.UART_DSR             <= UART_DSR;
ip.kbd_mouse_type       <= kbd_mouse_type;
ip.kbd_mouse_data       <= kbd_mouse_data;
ip.io_uio               <= io_uio;
ip.io_strobe            <= io_strobe;
ip.io_din               <= io_din;
ip.io_fpga              <= io_fpga;

-- Map OUT Ports
LED_USER            <= op.LED_USER;
LED_POWER           <= op.LED_POWER;
LED_DISK            <= op.LED_DISK;
AUDIO_L             <= op.AUDIO_L;
AUDIO_R             <= op.AUDIO_R;
AUDIO_S             <= op.AUDIO_S;
AUDIO_MIX           <= op.AUDIO_MIX;
UART_RTS            <= op.UART_RTS;
UART_TXD            <= op.UART_TXD;
UART_DTR            <= op.UART_DTR;
VGA_R               <= op.VGA_R;
VGA_G               <= op.VGA_G;
VGA_B               <= op.VGA_B;
VGA_HS              <= op.VGA_HS;
VGA_VS              <= op.VGA_VS;
VIDEO_HBLANK        <= op.VIDEO_HBLANK;
VIDEO_VBLANK        <= op.VIDEO_VBLANK;
CE_PIXEL            <= op.CE_PIXEL;
--CLK_VIDEO           <= op.CLK_VIDEO;
CLK_VIDEO           <= ip.main_clk_sys;
VGA_DE              <= op.VGA_DE;
VGA_F1              <= op.VGA_F1;
VGA_SL              <= op.VGA_SL;
VGA_SCALER          <= op.VGA_SCALER;
VGA_DISABLE         <= op.VGA_DISABLE;
HDMI_FREEZE         <= op.HDMI_FREEZE;
io_wait             <= op.io_wait;
io_fpga_dout        <= op.io_fpga_dout;                               
             
    -- Map the Video outputs to the output Ports.
    -- Using the mappings instead of going direct so that the signals can be connected to the debugger module.
    op.CE_PIXEL    <= video.ce_pixel;
    op.VGA_R       <= video.vga_r;
    op.VGA_G       <= video.vga_g;
    op.VGA_B       <= video.vga_b;
    op.VGA_HS      <= video.vga_hs;
    op.VGA_VS      <= video.vga_vs;
    op.VGA_DE      <= video.vga_de;
    
    -- Map the Audio outputs to the output Ports.
    op.AUDIO_S     <= audio.audio_s;
    op.AUDIO_L     <= audio.audio_l;
    op.AUDIO_R     <= audio.audio_r;
         

    -- Set the status - DJR - Will come back to this!!!!
    status      <= (others => '0');
    
    -- Assignment of signals
    -- Clocks
    --clk_114     <= ip.main_clk_114;
    --clk_sys     <= ip.main_clk_sys;
    --locked      <= ip.main_clk_locked;
    
        
    -- LED
    op.LED_DISK(1) <= '0';
    op.LED_DISK(0) <= fast.ide_f_led when miniout.ide_fast = '1' else miniout.ide_c_led;
    
    -- CPU Wrapper 

    cpu_type    <= miniout.cpucfg(1);

    -- Video Mixer
    scandoubler <= (miniout.fx(2) or miniout.fx(1) or miniout.fx(0) or forced_scandoubler) and (not miniout.lace);
    op.CLK_VIDEO   <= ip.main_clk_114;
    
    vblank          <= miniout.vbl or (not miniout.vs);
    hbl             <= hsvs.fhbl or hsvs.shbl or (not miniout.hs);
    vde             <= not (hsvs.fvbl or hsvs.svbl);
    hq2x_sig        <= '1' when miniout.fx = "001" else '0';
    nhs             <= not miniout.hs;
    nvs             <= not miniout.vs;
    nhde            <= not hsvs.hde;
    nvde            <= not vde;
    op.VIDEO_HBLANK  <= nhde;
    op.VIDEO_VBLANK  <= nvde;
        
    -- Reset
    reset_i       <= (not ip.main_clk_locked) or ip.RESET;
    reset_n       <= not reset_i;
    reset_nd      <= not reset_d;
        
    -- RAM1
    cpuCS              <= (not zram_sel) and ram_cs;
    
    -- FastChip
    reset_fc    <= (not miniout.cpu_rst) or (not cpuwrap.cpu_nrst_out);
    lds         <= not cpuwrap.fastchip_lds;
    uds         <= not cpuwrap.fastchip_uds;
    ide_ena_fc  <= miniout.ide_ena and miniout.ide_fast;
    
    -- Minimig I/O
    jmk.X_joy1      <= not jmk.joy0;
    jmk.X_joy2      <= not jmk.joy1;
    jmk.X_joy3      <= not jmk.joy2;
    jmk.X_joy4      <= not jmk.joy3;        
    
    -- UART assignments
    -- Can't use these at the moment until there is a replacement for the HPS or input for UART
    hps_mpu        <= '1' when to_integer(unsigned(uart_mode)) >= 3 else '0';
    op.UART_RTS    <= (not hps_mpu) and miniout.xuart_rts;
    op.UART_DTR    <= (not hps_mpu) and miniout.xuart_dtr;
    xuart_cts      <= (not hps_mpu) and ip.UART_CTS;
    xuart_dsr      <= (not hps_mpu) and ip.UART_DSR;
    xuart_rx       <= ip.UART_RXD when to_integer(unsigned(uart_mode)) /= 0 else midi_rx;
    op.UART_TXD    <= (hps_mpu and mt32_use) or xuart_tx;
    
    -- Audio Filters
    flt_en      <= miniout.pwr_led when not (status(48) = '1') else status(47);
    aud_1200    <= status(49);
    paula_pwm   <= status(50);
    ce          <= amiclk.clk7_en or amiclk.clk7n_en;
    cx          <= cx_high & cx_low;        -- Combine parts into full 40-bit value;
    paula_smp_l <= miniout.ldata_okk(8 downto 0) & (6 downto 0 => '0') when paula_pwm = '1' else miniout.ldata(14 downto 0) & '0';
    paula_smp_r <= miniout.rdata_okk(8 downto 0) & (6 downto 0 => '0') when paula_pwm = '1' else miniout.rdata(14 downto 0) & '0';
    
    audm_l      <= paula_smp_l when aud_1200 = '1' else audio.lpf4400_l;
    audm_r      <= paula_smp_r when aud_1200 = '1' else audio.lpf4400_r;
    
               
-- A wrapper is required as the original verilog module prefixed some port names with a underscore "_".
-- This is not allowed in VHDL, therefore wrapped in another verilog module to rename the ports.
-- for use in VHDL.    
--MiniMig : entity work.minimig_wrapper
MiniMig : entity work.minimig
    port map (
        -- m68k pins
        cpu_address     => cpuwrap.chip_addr            --// M68K address bus
       ,cpu_data        => miniout.chip_dout            --// M68K data bus                          -- out
       ,cpudata_in      => cpuwrap.chip_din             --// M68K data in
       ,X_cpu_ipl       => miniout.chip_ipl             --// M68K interrupt request                 -- out
       ,X_cpu_as        => cpuwrap.chip_as              --// M68K address strobe
       ,X_cpu_uds       => cpuwrap.chip_uds             --// M68K upper data strobe
       ,X_cpu_lds       => cpuwrap.chip_lds             --// M68K lower data strobe
       ,cpu_r_w         => cpuwrap.chip_rw              --// M68K read / write
       ,X_cpu_dtack     => miniout.chip_dtack           --// M68K data acknowledge                  -- out
       ,X_cpu_reset     => miniout.cpu_rst              --// M68K reset                             -- out
       ,X_cpu_reset_in  => cpuwrap.cpu_nrst_out         --// M68K reset out
       ,nmi_addr        => cpuwrap.cpu_nmi_addr         --// M68K NMI address
       
       -- sram pins
       ,ram_data        => miniout.ram_data             --// SRAM data bus                      -- out
       ,ramdata_in      => ram.ramdata_in           --// SRAM data bus in
--       ,ram_address     => ram_address          --// SRAM address bus
       ,ram_address     => miniout.ram_address(23 downto 1)          --// SRAM address bus      -- out     
       --,X_ram_bhe       => miniout.X_ram_bhe            --// SRAM upper byte select             -- out
       --,X_ram_ble       => miniout.X_ram_ble            --// SRAM lower byte select             -- out
       --,X_ram_we        => miniout.X_ram_we             --// SRAM write enable                  -- out
       --,X_ram_oe        => miniout.X_ram_oe             --// SRAM output enable                 -- out
       ,chipDMA         => miniout.chipDMA
       ,chipRW          => miniout.chipRW
       ,chipU           => miniout.chipU
       ,chipL           => miniout.chipL
       ,chip48          => ram.chip48               --// big chipram read
              
       -- system pins
       ,rst_ext         => reset_d              --// reset from ctrl block
       ,rst_out         => miniout.rst_out              --// minimig reset status     -- Doesn't go anywhere!!! -- out
       ,clk             => ip.main_clk_sys              --// output clock c1 ( 28.687500MHz)
       ,clk7_en         => amiclk.clk7_en              --// 7MHz clock enable
       ,clk7n_en        => amiclk.clk7n_en             --// 7MHz negedge clock enable
       ,c1              => amiclk.c1                   --// clk28m clock domain signal synchronous with clk signal
       ,c3              => amiclk.c3                   --// clk28m clock domain signal synchronous with clk signal delayed by 90 degrees
       ,cck             => amiclk.cck                  -- // colour clock output (3.54 MHz)
       ,eclk            => amiclk.eclk                 --// 0.709379 MHz clock enable output (clk domain pulse)
       
       -- rs232 pins
       ,rxd             => xuart_rx                 -- out
       ,txd             => xuart_tx
       ,cts             => xuart_cts
       ,rts             => miniout.xuart_rts                -- out
       ,dtr             => miniout.xuart_dtr                -- out
       ,dsr             => xuart_dsr
       ,cd              => xuart_dsr
       ,ri              => '1'
       
       -- I/O
       ,X_joy1          => jmk.X_joy1               --// joystick 1 [fire4,fire3,fire2,fire,up,down,left,right] (default mouse port)
       ,X_joy2          => jmk.X_joy2               --// joystick 2 [fire4,fire3,fire2,fire,up,down,left,right] (default joystick port)
       ,X_joy3          => jmk.X_joy3               --// joystick 1 [fire4,fire3,fire2,fire,up,down,left,right]
       ,X_joy4          => jmk.x_joy4               --// joystick 2 [fire4,fire3,fire2,fire,up,down,left,right]
       ,joya1           => jmk.joya0
       ,joya2           => jmk.joya1
       ,mouse_btn       => jmk.mouse_buttons        --// mouse buttons
       ,kbd_mouse_data  => ip.kbd_mouse_data           --// mouse direction data, keycodes - from main IN Port
       ,kbd_mouse_type  => ip.kbd_mouse_type           --// type of data - From main IN Port
       ,kms_level       => jmk.kbd_mouse_level
       ,pwr_led         => miniout.pwr_led              --// power led              -- out
       ,fdd_led         => op.led_user                                         -- out
       ,hdd_led         => miniout.ide_c_led                                        -- out
       ,rtc             => rtc
       
       -- Host control interface (SPI)
       -- Used by USERIO and seems to control a lot of the user config options
       ,io_uio          => ip.io_uio             --// enable for the USRIO
       ,io_fpga         => ip.io_fpga            --// Enable for the Paula config
       ,io_strobe       => ip.io_strobe
       ,io_wait         => op.io_wait              --// Send a wait signal for config
       ,io_din          => ip.io_din
       ,io_dout         => op.io_fpga_dout                                       -- out
       
       -- Video
       ,X_hsync             => miniout.hs                   --// horizontal sync        -- out
       ,X_vsync             => miniout.vs                   --// vertical sync          -- out
--       ,x_csync             => ????                                           -- out
       ,field1              => miniout.field1                                           -- out
       ,lace                => miniout.lace                                             -- out
       ,red                 => miniout.R
       ,green               => miniout.G
       ,blue                => miniout.B
       ,hblank              => miniout.hblank                                           -- out
       ,vblank              => miniout.vbl                                              -- out
       ,ar                  => miniout.ar                                               -- out
       ,scanline            => miniout.fx                                               -- out
--       ,ce_pix              => ???                                            -- out
       ,res                 => miniout.res                                              -- out
       ,ntsc                => miniout.ntsc                                             -- out
       
       -- Audio
       ,ldata               => miniout.ldata            --// left DAC data              -- out
       ,rdata               => miniout.rdata            --// right DAC data             -- out
       ,ldata_okk           => miniout.ldata_okk        --// 9bit                       -- out
       ,rdata_okk           => miniout.rdata_okk        --// 9bit                       -- out
       ,aud_mix             => op.audio_mix                                        -- out
       
       -- Toccata soundcard
       ,toccata_ena         => cpuwrap.toccata_ena
       ,toccata_base        => cpuwrap.toccata_base
       ,toccata_aud_left    => miniout.toccata_aud_left                                 -- out
       ,toccata_aud_right   => miniout.toccata_aud_right                                -- out
       
       -- User I/O
       ,cpucfg              => miniout.cpucfg           --// CPU config                 -- out
       ,cachecfg            => miniout.cachecfg         --// Cache config               -- out
       ,memcfg              => miniout.memcfg           --// memory config              -- out
       ,bootrom             => miniout.bootrom          --// bootrom mode. Needed here to tell tg68k to also mirror the 256k Kickstart    -- out 
       
       ,ide_fast            => miniout.ide_fast                                         -- out
       ,ide_ext_irq         => fast.ide_f_irq
       ,ide_ena             => miniout.ide_ena                                          -- out
       ,ide_req             => miniout.ide_c_req                                        -- out
       ,ide_address         => ide_addr
       ,ide_write           => ide_wr
       ,ide_writedata       => ide_dout
       ,ide_read            => ide_rd
       ,ide_readdata        => miniout.ide_c_readdata                                   -- out
       
    );
    
reset_sig : entity work.reset_sig
    port map (
        clk_sys     => ip.main_clk_sys
       ,reset_i     => reset_i
       ,reset_d     => reset_d
    );
   
--Note: The outpur signals are not clock signals as such, they are Strobe signals.
--      Not to be used as clock signals.
amiga_clk : entity work.amiga_clk
    port map (
        clk_28          => ip.main_clk_sys                  --// input clock c1 (28.687500MHz)
       ,clk7_en         => amiclk.clk7_en                   --// output clock 7 enable (on 28MHz clock domain)                      -- Out
       ,clk7n_en        => amiclk.clk7n_en                  --// 7 MHz negedge output clock enable (on 28MHz clock domain)          -- Out   
       ,c1              => amiclk.c1                        --// clk28m clock domain signal synchronous with clk signal             -- Out
       ,c3              => amiclk.c3                        --// clk28m clock domain signal synchronous with clk signal delayed by 90 degrees  -- Out
       ,cck             => amiclk.cck                       --// colour clock output (3.54 MHz)                                     -- Out
       ,eclk            => amiclk.eclk                      --// 0.709379 <Hz clock enable output (clk domain pulse)                -- Out    
       ,reset_n         => reset_n
    );    
    
       
       
compute_ram_cs : entity work.compute_ram_cs
    port map (
        --clk_114     => ip.main_clk_114
        clk_114     => ip.main_clk_sys
       ,c1          => amiclk.c1
       ,cpu_rst     => miniout.cpu_rst
       ,ram_ready   => ram_ready
       ,cpu_type    => cpu_type
       ,ram_sel     => cpuwrap.ram_sel
       ,cyc         => cyc
       ,cpu_ph1     => cpu_ph1
       ,cpu_ph2     => cpu_ph2
       ,ram_cs      => ram_cs
    );

cpu_wrapper : entity work.cpu_wrapper
    port map (
         reset              => miniout.cpu_rst
        ,reset_out          => cpuwrap.cpu_nrst_out                         -- Out
        ,clk                => ip.main_clk_sys
        ,ph1                => cpu_ph1
        ,ph2                => cpu_ph2
        
        ,chip_addr          => cpuwrap.chip_addr                            -- Out
        ,chip_dout          => miniout.chip_dout
        ,chip_din           => cpuwrap.chip_din                             -- Out
        ,chip_as            => cpuwrap.chip_as                              -- Out
        ,chip_uds           => cpuwrap.chip_uds                             -- Out
        ,chip_lds           => cpuwrap.chip_lds                             -- Out    
        ,chip_rw            => cpuwrap.chip_rw                              -- Out
        ,chip_dtack         => miniout.chip_dtack
        ,chip_ipl           => miniout.chip_ipl
        
        ,fastchip_dout      => fast.fastchip_dout
        ,fastchip_sel       => cpuwrap.fastchip_sel                         -- Out
        ,fastchip_lds       => cpuwrap.fastchip_lds                         -- Out
        ,fastchip_uds       => cpuwrap.fastchip_uds                         -- Out
        ,fastchip_rnw       => cpuwrap.fastchip_rnw                         -- Out
        ,fastchip_selack    => fast.fastchip_selack
        ,fastchip_ready     => fast.fastchip_ready
        ,fastchip_lw        => cpuwrap.fastchip_lw                          -- Out
        
        ,cpucfg             => miniout.cpucfg
        ,cachecfg           => miniout.cachecfg
        ,fastramcfg         => miniout.memcfg(6 downto 4)
        ,bootrom            => miniout.bootrom
        
        ,toccata_ena        => cpuwrap.toccata_ena                          -- Out
        ,toccata_base       => cpuwrap.toccata_base                         -- Out
        
        ,ramsel             => cpuwrap.ram_sel                              -- Out
        ,ramaddr            => cpuwrap.ram_addr                             -- Out
        ,ramlds             => cpuwrap.ram_lds                              -- Out
        ,ramuds             => cpuwrap.ram_uds                              -- Out
        ,ramdout            => ram_dout
        ,ramdin             => cpuwrap.ram_din                              -- Out
        ,ramready           => ram_ready
        ,ramshared          => cpuwrap.ramshared                            -- Out
        
        -- Custom CPU signals
        ,cpustate           => cpuwrap.cpu_state                            -- Out
        ,cacr               => cpuwrap.cpu_cacr                             -- Out
        ,nmi_addr           => cpuwrap.cpu_nmi_addr                         -- Out                                             
    );

RAM_CTRL : entity work.ram_frontend_unified 
    port map (
        -- System / cache
        --sysclk              => ip.main_clk_114
        sysclk              => ip.main_clk_sys
       ,reset_n             => reset_nd
       ,cache_rst           => miniout.cpu_rst
       ,cache_inhibit_ext   => cache_inhibit
       ,cpu_cache_ctrl      => cpuwrap.cpu_cacr
       
       -- CPU RAM bus (from cpu_wrapper)
       --,ramsel          => cpuwrap.ram_sel
       ,cpuCS               => ram_cs              --- TODO: TBC
       ,cpuAddr             => cpuwrap.ram_addr
       ,cpuL                => cpuwrap.ram_lds
       ,cpuU                => cpuwrap.ram_uds
       ,cpuWR               => cpuwrap.ram_din
       --,ramshared       => cpuwrap.ramshared
       ,cpustate            => cpuwrap.cpu_state
       
       ,cpuRD               => ram_dout             -- unified output
       ,ramready            => ram_ready            -- unified ready  ie. cpu_ack
       
       -- Chip RAM bus (Minimig side)
       ,chipAddr            => miniout.ram_address
       --,chipL               => miniout.X_ram_ble
       ,chipL               => miniout.chipL
       --,chipU               => miniout.X_ram_bhe
       ,chipU               => miniout.chipU
       --,chipRW              => miniout.X_ram_we
       ,chipRW              => miniout.chipRW
       --,chipDMA             => miniout.X_ram_oe
       ,chipDMA             => miniout.chipDMA
       ,chipWR              => miniout.ram_data
       
       ,chipRD              => ram.ramdata_in
       ,chip48              => ram.chip48
       ,chipBurstLen        => "000"
            
    );

FastChip : entity work.fastchip
    port map (
        --clk             => ip.main_clk_114
        clk             => ip.main_clk_sys
       ,cyc             => cyc
       ,clk_sys         => ip.main_clk_sys
       
       ,reset           => reset_fc
       ,sel             => cpuwrap.fastchip_sel
       ,sel_ack         => fast.fastchip_selack                      -- Out
       ,ready           => fast.fastchip_ready                       -- Out
       
       ,addr            => cpuwrap.chip_addr        -- NB: orig concta 1'b0 on the end, but as these are defined the same size, there is not point in trying to pad it out
       ,din             => cpuwrap.chip_din
       ,dout            => fast.fastchip_dout                        -- Out
       ,lds             => lds
       ,uds             => uds
       ,rnw             => cpuwrap.fastchip_rnw
       ,longword        => cpuwrap.fastchip_lw
       
       -- RTG frame buffer control
       ,rtg_ena         => fast.fb_en                                -- Out
       ,rtg_hsize       => fast.fb_width                             -- Out
       ,rtg_vsize       => fast.fb_height                            -- Out
       ,rtg_format      => fast.fb_format                            -- Out
       ,rtg_base        => fast.fb_base                              -- Out
       ,rtg_stride      => fast.fb_stride                            -- Out
       ,rtg_pal_clk     => fast.fb_pal_clk                           -- Out
       ,rtg_pal_dw      => fast.fb_pal_dout                          -- Out
       ,rtg_pal_dr      => fb_pal_din
       ,rtg_pal_a       => fast.fb_pal_addr                          -- Out
       ,rtg_pal_wr      => fast.fb_pal_wr                            -- Out
       
       ,ide_ena         => ide_ena_fc
       ,ide_irq         => fast.ide_f_irq                            -- Out
       ,ide_req         => fast.ide_f_req                            -- Out
       ,ide_address     => ide_addr
       ,ide_write       => ide_wr
       ,ide_writedata   => ide_dout
       ,ide_read        => ide_rd
       ,ide_readdata    => fast.ide_f_readdata                       -- Out
       ,ide_led         => fast.ide_f_led                            -- Out
    );         

Power_LED : entity work.power_led
    port map (
        clk_sys     => ip.main_clk_sys
       ,pwr_led     => miniout.pwr_led
       ,led_power   => op.led_power        
    );
        
Pixel_clk : entity work.pixelclk 
    port map (
        clk         => ip.main_clk_sys
--        clk         => ip.main_clk_114
       ,hblank      => miniout.hblank
       ,vblank      => vblank
       ,res         => miniout.res 
       ,vs          => miniout.vs
       ,status      => status
       ,scandoubler => scandoubler
       ,ce_out      => ce_out
    );
-- ce_pix was used in the minimig module was in the orig code it was commented out.
-- May not be required.
--ce_pix  <= ce_out;    

-- Video Mixer
-- Note: need to take a good look at this to ensure all the ports are explicitly mapped.

-- DJR Turning off the GAMMA option.  If on it uses the GAMMA_BUS which is sourced from the HPSIO module.
-- This module is removed and the Gamma_bus signal will need to be replaced some how to use this option correctly.
-- Also commented out the LINE_LENGTH option as it causes an "interest" video colour scrolling pattern on screen.
-- Could be the sizing that simply needs adjusting, but so far the default setting seems to work.

-- fx is populated from minimig.scanline
-- May need to include mmodule mt32 as it does something with video.  But need to check the inputs for it.

video_mixer : entity work.video_mixer
    generic map (
--        LINE_LENGTH     => 2000
--         LINE_LENGTH     => 1280
         HALF_DEPTH      => 0
--       ,GAMMA           => 0
    )
    port map (
        -- Input
        hq2x            => hq2x_sig
       ,ce_pix          => ce_out                   
       ,gamma_bus       => open
       ,R               => miniout.R
       ,G               => miniout.G
       ,B               => miniout.B
       ,HSync           => nhs
       ,VSync           => nvs
       ,HBlank          => nhde
       ,VBlank          => nvde
       --,CLK_VIDEO       => ip.main_clk_114                  --// should be multiple by (ce_pix*4)         
       ,CLK_VIDEO       => ip.main_clk_sys                  --// should be multiple by (ce_pix*4)         
--       ,CLK_VIDEO       => clk_vid
       
       ,scandoubler     => scandoubler       
       ,HDMI_FREEZE     => '0'        
       -- Output
       ,CE_PIXEL        => video.CE_PIXEL                --// output pixel clock enable -- out to port
       ,VGA_R           => video.VGA_R                    -- out
       ,VGA_G           => video.VGA_G                    -- out
       ,VGA_B           => video.VGA_B                    -- out
       ,VGA_HS          => video.VGA_HS                   -- out
       ,VGA_VS          => video.VGA_VS                   -- out
       ,VGA_DE          => video.VGA_DE                   -- out                               
    );

HS_VS_Timing : entity work.hsvstiming
    port map (
        clk_sys         => ip.main_clk_sys
--        clk_sys         => ip.main_clk_114        
       ,hs              => miniout.hs
       ,hblank          => miniout.hblank
       ,field1          => miniout.field1
       ,hbl             => hbl
       ,shbl            => hsvs.shbl                     -- out
       ,fhbl            => hsvs.fhbl                     -- out
       ,hde             => hsvs.hde                      -- out
       
       ,vs              => miniout.vs
       ,vblank          => vblank
       ,lace            => miniout.lace
       ,svbl            => hsvs.svbl                     -- out
       ,fvbl            => hsvs.fvbl                     -- out
    );

-- Audio Filters
-- DJR Note: This also requires the Status signal to be set.  Need to map what these are and how they are set.

-- LPF 4400Hz, 1st order, 6db/oct
lpf4000 : entity work.IIR_Filter
    port map (
        clk         => ip.main_clk_sys
       ,reset       => ip.reset
       ,ce          => ce
       ,sample_ce   => 1
           
       ,cx          => cx
       ,cx0         => 1
       ,cx1         => 0
       ,cx2         => 0
       ,cy0         => -2088941
       ,cy1         => 0
       ,cy2         => 0
       
       ,input_l     => paula_smp_l
       ,input_r     => paula_smp_r
       ,output_l    => audio.lpf4400_l
       ,output_r    => audio.lpf4400_r       
    );
        
-- LPF 3000Hz 1st + 3400Hz 1st
lpf3275 : entity work.IIR_Filter
    port map (
        clk         => ip.main_clk_sys
       ,reset       => ip.reset
       ,ce          => ce
       ,sample_ce   => 1
       
       ,cx          => cx2
       ,cx0         => 2
       ,cx1         => 1
       ,cx2         => 0
       ,cy0         => -4182432
       ,cy1         => 2085297
       ,cy2         => 0
       
       ,input_l     => audm_l
       ,input_r     => audm_r
       ,output_l    => audio.lpf3275_l
       ,output_r    => audio.lpf3275_r             
    );       

aud_out : entity work.audout
    port map (
        clk_audio       => ip.clk_audio
       ,flt_en          => flt_en
       ,lpf3275_l       => audio.lpf3275_l
       ,lpf3275_r       => audio.lpf3275_r
       ,audm_l          => audm_l
       ,audm_r          => audm_r
       ,aud_l           => audio.aud_l
       ,aud_r           => audio.aud_r       
    );

-- CDDA
-- DJR Need to check how some of these input signals are / should be populated.
-- may come from the FDD / CD vertical disks, once they are connecred up.  TBC
cdda : entity work.cdda
    generic map (
        CLK_RATE        => 28375160 
    )
    port map (
        clk             => ip.main_clk_sys
       ,nRESET          => reset_n
       ,WRITE_REQ       => audio.cdda_req
       ,WRITE           => cdda_wr
       ,DIN             => cdda_dout
       ,AUDIO_L         => audio.cdda_l
       ,AUDIO_R         => audio.cdda_r
    );

comb_audio : entity work.combaud
    port map (
        clk_audio           => ip.clk_audio
       ,aud_l               => audio.aud_l
       ,aud_r               => audio.aud_r
       ,toccata_aud_left    => miniout.toccata_aud_left
       ,toccata_aud_right   => miniout.toccata_aud_right
       ,cdda_l              => audio.cdda_l
       ,cdda_r              => audio.cdda_r
       
       ,audio_s             => audio.audio_s
       ,audio_l             => audio.audio_l
       ,audio_r             => audio.audio_r
    );
                          
end architecture;
