-- Port of the MiSTer MiniMig module to VHDL
-- Converting so that the various Vivado Debug functions can be used.
-- This module / entity is about instatating other module.  Very little logic / processes are included.
-- Also separated out what process there are into sepatate modules for clarity.
--
-- July 2025    David Raynor (Kiwi)
--
-- TODO: Check the sizing of the cpu &  dma address widths, I'm not sure how the size gets
--       coverage for the memory addresses.  Is there some additional banking going on??? 
--
--       Reveiw the use it minimig_bank_manager and minimig_sram_bridge, likely not requiired or
--       a new version is required to work with the new BRAM Controller.
--       Initial look appears that it is mapping memory the to MiSTer SDRAM blocks, for whihc we do 
--       not need to do.
--       NOT REQUIRED - REMOVE!!!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.DocPkg.all;
use work.Amiga_Debug_pkg.all;
use work.Minimig_Sig_pkg.all;

entity minimig is
    port (    
        --m68k pins
        cpu_address     : in  std_logic_vector(23 downto 1);            -- m68k address bus
        cpu_data        : out std_logic_vector(15 downto 0);            -- m68k data bus
        cpudata_in      : in  std_logic_vector(15 downto 0);            -- m68k data in
        x_cpu_ipl       : out std_logic_vector(2 downto 0);             -- m68k interrupt request     
        x_cpu_as        : in  std_logic;                                -- m68k address strobe
        x_cpu_uds       : in  std_logic;                                -- m68k upper data strobe
        x_cpu_lds       : in  std_logic;                                -- m68k lower data strobe
        cpu_r_w         : in  std_logic;                                -- m68k read / write
        x_cpu_dtack     : out std_logic;                                -- m68k data acknowledge
        x_cpu_reset     : out std_logic;                                -- m68k reset
        x_cpu_reset_in  : in  std_logic;                                -- m68k reset in
        nmi_addr        : in  std_logic_vector(31 downto 0);            -- m68k NMI address
        ovr             : out std_logic;                                -- NMI address decoding override
        
        -- ram pins
        ram_data        : out std_logic_vector(15 downto 0);            -- sram data bus
        ramdata_in      : in  std_logic_vector(15 downto 0);            -- sram data bus in
        ram_address     : out std_logic_vector(23 downto 1);            -- sram address bus
        --x_ram_bhe       : out std_logic;                                -- sram upper byte select
        --x_ram_ble       : out std_logic;                                -- sram lower byte select
        --x_ram_we        : out std_logic;                                -- sram write enable
        --x_ram_oe        : out std_logic;                                -- sram output enable
        chipDMA         : out std_logic;
        chipRW          : out std_logic;
        chipU           : out std_logic;
        chipL           : out std_logic;
        chip48          : in  std_logic_vector(47 downto 0);            -- big chipram read
        
        -- System pins
        rst_ext         : in  std_logic;                                -- reset from ctrl block
        rst_out         : out std_logic;                                -- minimig reset status
        clk             : in  std_logic;                                -- 28.37516 MHz clock
        clk7_en         : in  std_logic;                                -- 7MHz clock enable
        clk7n_en        : in  std_logic;                                -- 7MHz negedge / falling_edge clock enable
        c1              : in  std_logic;                                -- clock enable signal
        c3              : in  std_logic;                                -- clock enable signal
        cck             : in  std_logic;                                -- colour clock enable
        eclk            : in  std_logic_vector(9 downto 0);             -- ECLK enable (1/10th of CLK)
        
        -- rs232 pins
       rxd              : in  std_logic;                                -- rs232 receive
       txd              : out std_logic;                                -- rs232 send
       cts              : in  std_logic;                                -- rs232 clear to send
       rts              : out std_logic;                                -- rs232 request to send
       dtr              : out std_logic;                                -- rs232 Data Terminal Ready
       dsr              : in  std_logic;                                -- rs232 Data Set Ready
       cd               : in  std_logic;                                -- rs232 Carrier Detect
       ri               : in  std_logic;                                -- rs232 Ring Indicator
       
       -- I/O
       x_joy1           : in  std_logic_vector(15 downto 0);            -- joystick 1 [fire2,fire,up,down,left,right] (default mouse port)
       x_joy2           : in  std_logic_vector(15 downto 0);            -- joystick 2 [fire2,fire,up,down,left,right] (default joystick port)
       x_joy3           : in  std_logic_vector(15 downto 0);            -- joystick 3 [fire2,fire,up,down,left,right]
       x_joy4           : in  std_logic_vector(15 downto 0);            -- joystick 4 [fire2,fire,up,down,left,right]
       joya1            : in  std_logic_vector(15 downto 0);    
       joya2            : in  std_logic_vector(15 downto 0);
       mouse_btn        : in  std_logic_vector(2 downto 0);             -- mouse buttons
       kms_level        : in  std_logic;
       kbd_mouse_type   : in  std_logic_vector(1 downto 0);
       kbd_mouse_data   : in  std_logic_vector(7 downto 0);
       rtc              : in  std_logic_vector(64 downto 0);
       pwr_led          : out std_logic;
       fdd_led          : out std_logic;
       hdd_led          : out std_logic;
       
       -- Host Controller Interface (SPI)
       IO_UIO           : in  std_logic;
       IO_FPGA          : in  std_logic;
       IO_STROBE        : in  std_logic;
       IO_DIN           : in  std_logic_vector(15 downto 0);
       IO_WAIT          : out std_logic;
       IO_DOUT          : out std_logic_vector(15 downto 0);
       
       -- Video
       x_hsync          : out std_logic;                                -- horizontal sync
       x_vsync          : out std_logic;                                -- vertical sync
       x_csync          : out std_logic;                                -- composite sync
       field1           : out std_logic;
       lace             : out std_logic;
       hblank           : out std_logic;
       vblank           : out std_logic;
       red              : out std_logic_vector(7 downto 0);
       green            : out std_logic_vector(7 downto 0);
       blue             : out std_logic_vector(7 downto 0);
       ar               : out std_logic_vector(1 downto 0);
       scanline         : out std_logic_vector(2 downto 0);
       ce_pix           : out std_logic;
       res              : out std_logic_vector(1 downto 0);
       ntsc             : out std_logic;
       
       -- Audio
       ldata            : out std_logic_vector(14 downto 0);            -- left DAC data
       rdata            : out std_logic_vector(14 downto 0);            -- right DAC data
       ldata_okk        : out std_logic_vector(8 downto 0);             -- left DAC data  (PWM volume)
       rdata_okk        : out std_logic_vector(8 downto 0);             -- right DAC data (PWM volume)
       aud_mix          : out std_logic_vector(1 downto 0);
       
       -- Toccata Audio
       toccata_ena          : in  std_logic;
       toccata_base         : in  std_logic_vector(7 downto 0);
       toccata_aud_left     : out std_logic_vector(15 downto 0);
       toccata_aud_right    : out std_logic_vector(15 downto 0);
       
      
       -- User I/O
       cpucfg               : out std_logic_vector(1 downto 0);
       cachecfg             : out std_logic_vector(2 downto 0);
       memcfg               : out std_logic_vector(6 downto 0);
       bootrom              : out std_logic;                            -- enable bootrom magic in gary.v
       ide_ena              : out std_logic;
       ide_fast             : out std_logic;
       ide_ext_irq          : in  std_logic;
       ide_req              : out std_logic_vector(5 downto 0);
       ide_address          : in  std_logic_vector(4 downto 0);
       ide_write            : in  std_logic;
       ide_writedata        : in  std_logic_vector(15 downto 0);
       ide_read             : in  std_logic;
       ide_readdata         : out std_logic_vector(15 downto 0)       
    );
    -- Apply descriptons to the ports.
    attribute description of cpu_address            : signal is "m68k address bus";
    attribute description of cpu_data               : signal is "m68k data bus";
    attribute description of cpudata_in             : signal is "m68k data in";
    attribute description of x_cpu_ipl              : signal is "m68k interrupt request";
    attribute description of x_cpu_as               : signal is "m68k address strobe";
    attribute description of x_cpu_uds              : signal is "m68k upper data strobe";
    attribute description of x_cpu_lds              : signal is "m68k lower data strobe";
    attribute description of cpu_r_w                : signal is "m68k read / write";
    attribute description of x_cpu_dtack            : signal is "m68k data acknowledge";
    attribute description of x_cpu_reset            : signal is "m68k reset";
    attribute description of x_cpu_reset_in         : signal is "m68k reset in";
    attribute description of nmi_addr               : signal is "m68k NMI address";
    attribute description of ovr                    : signal is "NMI address decoding override";
    
    attribute description of ram_data               : signal is "sram data bus";
    attribute description of ramdata_in             : signal is "sram data bus in";
    attribute description of ram_address            : signal is "sram address bus";
--    attribute description of x_ram_bhe              : signal is "sram upper byte select";
--    attribute description of x_ram_ble              : signal is "sram lower byte select";
--    attribute description of x_ram_we               : signal is "sram write enable";
--    attribute description of x_ram_oe               : signal is "sram output enable";
    attribute description of chip48                 : signal is "big chipram read";
    
    attribute description of rst_ext                : signal is "reset from ctrl block";
    attribute description of rst_out                : signal is "reset from ctrl block";
    attribute description of clk                    : signal is "28.37516 MHz clock";
    attribute description of clk7_en                : signal is "7MHz clock enable";
    attribute description of clk7n_en               : signal is "7MHz negedge clock enable";
    attribute description of c1                     : signal is "clock enable signal";
    attribute description of c3                     : signal is "clock enable signal";
    attribute description of cck                    : signal is "colour clock enable";
    attribute description of eclk                   : signal is "ECLK enable (1/10th of CLK)";
    
    attribute description of rxd                    : signal is "rs232 receive";
    attribute description of txd                    : signal is "rs232 send";
    attribute description of cts                    : signal is "rs232 clear to send";
    attribute description of rts                    : signal is "rs232 request to send";
    attribute description of dtr                    : signal is "rs232 Data Terminal Ready";
    attribute description of dsr                    : signal is "rs232 Data Set Ready";
    attribute description of cd                     : signal is "rs232 Carrier Detect";
    attribute description of ri                     : signal is "rs232 Ring Indicator";
    
    attribute description of x_joy1                 : signal is "joystick 1 [fire2,fire,up,down,left,right] (default mouse port)";
    attribute description of x_joy2                 : signal is "joystick 2 [fire2,fire,up,down,left,right] (default joystick port)";
    attribute description of x_joy3                 : signal is "joystick 3 [fire2,fire,up,down,left,right]";
    attribute description of x_joy4                 : signal is "joystick 4 [fire2,fire,up,down,left,right]";
    attribute description of joya1                  : signal is "joystick 1 analogue";
    attribute description of joya2                  : signal is "joystick 2 analogue";
    attribute description of mouse_btn              : signal is "mouse buttons (3)";
    attribute description of kms_level              : signal is "keyboard / mouse level";
    attribute description of kbd_mouse_type         : signal is "keyboard / mouse type";
    attribute description of kbd_mouse_data         : signal is "keyboard / mouse data";
    attribute description of pwr_led                : signal is "power led";
    attribute description of fdd_led                : signal is "disk activity LED, active when DMA is on";
    attribute description of hdd_led                : signal is "hartd disk activity LED";
    attribute description of rtc                    : signal is "real time clock";
    
    attribute description of x_hsync                : signal is "horizontal sync";
    attribute description of x_vsync                : signal is "vertical sync";
    attribute description of hblank                 : signal is "horizontal video blanking";
    attribute description of vblank                 : signal is "vertical video blanking";
    attribute description of red                    : signal is "red component video out";
    attribute description of green                  : signal is "green component video out";
    attribute description of blue                   : signal is "blue component video out";
    attribute description of ar                     : signal is "";
    attribute description of scanline               : signal is "enable scanline lines";
    attribute description of ce_pix                 : signal is "pixel clock enable";
    attribute description of res                    : signal is "resolution";
    attribute description of ntsc                   : signal is "ntsc enabled / disabled";
    
    attribute description of ldata                  : signal is "left DAC data";
    attribute description of rdata                  : signal is "right DAC data";
    attribute description of ldata_okk              : signal is "left DAC data  (PWM volume)";
    attribute description of rdata_okk              : signal is "right DAC data (PWM volume)";
    attribute description of aud_mix                : signal is "audio mix";
    
    attribute description of bootrom                : signal is "enable bootrom magic in gary.v";
                    
end entity;

architecture RTL of minimig is
     -- Note: The signal record types are defined in Minimig_Sig_pkg                                     
    signal ip           : IP_MINIMIG_TYPE;              -- IN Port signals        
    signal op           : OP_MINIMIG_TYPE;              -- OUT Port signals          
    signal data_bus     : DATA_BUS_TYPE;                -- Local signals for data bus                  
    signal cpu_out      : CPU_ADDRESS_TYPE;             -- Local signals for address bus                
    signal ctrl_bus     : CTRL_BUS_TYPE;                -- Local signals for control bus
    signal video        : VIDEO_TYPE;                   -- Local video signals    
    signal floppy       : FLOPPY_TYPE;                  -- local floppy signals (CIA<-->Paula)
    signal usrio        : USERIO_TYPE;                  -- Local User IO signals.
    signal paula        : PAULA_TYPE;                   -- Out signals from PAULA
    signal agnus        : AGNUS_TYPE;                   -- Out signals from Agnus
    signal denise       : DENISE_TYPE;                  -- Out signals from Denise
    signal gary         : GARY_TYPE;                    -- Out signals from Gary
    signal gayle        : GAYLE_TYPE;                   -- Out signals from Gayle
    signal bridge       : BRIDGE_TYPE;                  -- Out signals from M68k Bridge
    signal cart         : CART_TYPE;                    -- Out signals from Cart
    signal rtc_i        : RTC_TYPE;                     -- Out signals from RTC
    signal host         : HOST_TYPE;                    -- Host interface

    signal disk_dmal        : std_logic;                            -- disk dma data transfer request from Paula to Agnus    
    signal disk_dmas        : std_logic;                            -- disk dma special request from Paula to Agnus    

    attribute description of disk_dmal              : signal is "disk dma data transfer request from Paula to Agnus";
    attribute description of disk_dmas              : signal is "disk dma special request from Paula to Agnus";    
   
--    signal bank             : std_logic_vector(7 downto 0);         -- memory bank select
    --attribute description of bank                   : signal is "memory bank select";

    signal ovl              : std_logic;                            -- kickstart overlay enable   
    attribute description of ovl                : signal is "kickstart overlay enable";
                            
    signal pot_cnt_en       : std_logic;
    signal ecs              : std_logic;
    
    -- For Paula
    signal int2_int         : std_logic;
    signal int6_int         : std_logic;
           
    -- For minimig_m68k_bridge
    signal nrdy             : std_logic;
        
    -- For Gary
    signal hdc_ena          : std_logic;
    attribute description of hdc_ena          : signal is "enables hdd interface";
                
    -- For reset
    signal r        : std_logic := '0';
    signal x_rst    : std_logic := '0';
    signal rst      : RESET_TYPE;
        
    -- Misc signals
    signal ovr_x            : std_logic;
    signal x_cpu_reset_x    : std_logic;
    signal x_cpu_reset_x_n  : std_logic;    
    
    signal ide      : IDE_TYPE;
    signal migaud   : MIG_AUDIO_TYPE;
    signal cia      : CIA_TYPE;
    signal config   : CONFIGURATION_TYPE;
    signal leds     : LED_TYPE;
    signal jmk      : MIG_JOY_MOUSE_KEYBOARD_TYPE;
        

--------------------------------------------------------------------------------------------------
-- Set up Debug
--------------------------------------------------------------------------------------------------
-- Note: requires the constamt DEBUG which is set int eh Amiga_Globals package.
-- Force Synthesis not to remove / change signals, port, etc.

-- Note: debug_Amiga package contains the set up for DONT_TOUCH

attribute DONT_TOUCH of USERIO01       : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of AGNUS1         : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of PAULA1         : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of DENISE1        : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of CIAA1          : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of CIAB1          : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of CPU1           : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of CART1          : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of GARY1          : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of GAYLE1         : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of CONTROL1       : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of RTC1           : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of TOCCATA1       : label is c_dont_touch(DEBUG);


begin
   -- Map the IN Ports
   ip.cpu_address       <= cpu_address;
   ip.cpudata_in        <= cpudata_in;
   ip.x_cpu_as          <= x_cpu_as;
   ip.x_cpu_uds         <= x_cpu_uds;
   ip.x_cpu_lds         <= x_cpu_lds;
   ip.cpu_r_w           <= cpu_r_w;
   ip.x_cpu_reset_in    <= x_cpu_reset_in;
   ip.nmi_addr          <= nmi_addr;
   ip.ramdata_in        <= ramdata_in;
   ip.chip48            <= chip48;
   ip.rst_ext           <= rst_ext;
   ip.clk               <= clk;
   ip.clk7_en           <= clk7_en;
   ip.clk7n_en          <= clk7n_en;
   ip.c1                <= c1;
   ip.c3                <= c3;
   ip.cck               <= cck;
   ip.eclk              <= eclk;
   ip.rxd               <= rxd;
   ip.cts               <= cts;
   ip.dsr               <= dsr;
   ip.cd                <= cd;
   ip.ri                <= ri;
   ip.x_joy1            <= x_joy1;
   ip.x_joy2            <= x_joy2;
   ip.x_joy3            <= x_joy3;
   ip.x_joy4            <= x_joy4;
   ip.joya1             <= joya1;
   ip.joya2             <= joya2;
   ip.mouse_btn         <= mouse_btn;
   ip.kms_level         <= kms_level;
   ip.kbd_mouse_type    <= kbd_mouse_type;
   ip.kbd_mouse_data    <= kbd_mouse_data;   
   ip.rtc               <= rtc;
   ip.IO_UIO            <= IO_UIO;
   ip.IO_FPGA           <= IO_FPGA;
   ip.IO_STROBE         <= IO_STROBE;
   ip.IO_DIN            <= IO_DIN;
   ip.toccata_ena       <= toccata_ena;
   ip.toccata_base      <= toccata_base;
   ip.ide_ext_irq       <= ide_ext_irq;
   ip.ide_address       <= ide_address;
   ip.ide_write         <= ide_write;
   ip.ide_writedata     <= ide_writedata;
   ip.ide_read          <= ide_read;

   --Map the OUT Ports
   cpu_data             <= op.cpu_data;
   x_cpu_ipl            <= op.x_cpu_ipl;
   x_cpu_dtack          <= op.x_cpu_dtack;
   x_cpu_reset          <= op.x_cpu_reset;
   ovr                  <= op.ovr;
   ram_data             <= op.ram_data;
   ram_address          <= op.ram_address;
--   x_ram_bhe            <= op.x_ram_bhe;
--   x_ram_ble            <= op.x_ram_ble;
--   x_ram_we             <= op.x_ram_we;
--   x_ram_oe             <= op.x_ram_oe;
   chipDMA              <= op.chipDMA;
   chipRW               <= op.chipRW;
   chipU                <= op.chipU;
   chipL                <= op.chipL;
   rst_out              <= op.rst_out;
   txd                  <= op.txd;
   rts                  <= op.rts;
   dtr                  <= op.dtr;
   pwr_led              <= op.pwr_led;
   fdd_led              <= op.fdd_led;
   hdd_led              <= op.hdd_led;
   IO_WAIT              <= op.IO_WAIT;
   IO_DOUT              <= op.IO_DOUT;
   x_hsync              <= op.x_hsync;
   x_vsync              <= op.x_vsync;
   x_csync              <= op.x_csync;
   field1               <= op.field1;
   lace                 <= op.lace;
   hblank               <= op.hblank;
   vblank               <= op.vblank;
   red                  <= op.red;
   green                <= op.green;
   blue                 <= op.blue;
   ar                   <= op.ar;
   scanline             <= op.scanline;
   ce_pix               <= op.ce_pix;
   res                  <= op.res;
   ntsc                 <= op.ntsc;
   ldata                <= op.ldata;
   rdata                <= op.rdata;
   ldata_okk            <= op.ldata_okk;
   rdata_okk            <= op.rdata_okk;
   aud_mix              <= op.aud_mix;
   toccata_aud_left     <= op.toccata_aud_left;
   toccata_aud_right    <= op.toccata_aud_right;
   cpucfg               <= op.cpucfg;
   cachecfg             <= op.cachecfg;
   memcfg               <= op.memcfg;
   bootrom              <= op.bootrom;
   ide_ena              <= op.ide_ena;
   ide_fast             <= op.ide_fast;
   ide_req              <= op.ide_req;
   ide_readdata         <= op.ide_readdata;    

   
    -- Map internal signals to output Ports of Entity.
    -- Useful for attaching to a debugger the internal signals destined for output.
    op.hblank              <= video.hblank;
    op.ide_ena             <= ide.ide_ena;
    op.ide_req             <= ide.ide_req;
    op.ide_fast            <= ide.ide_fast;
    op.ide_readdata        <= ide.ide_readdata;
    op.x_hsync             <= video.x_hsync;
    op.x_vsync             <= video.x_vsync;
    op.x_csync             <= video.x_csync;
    op.vblank              <= video.vblank;
    op.toccata_aud_left    <= migaud.toccata_aud_left;
    op.toccata_aud_right   <= migaud.toccata_aud_right;
    
    op.pwr_led             <= leds.pwr_led;
    op.fdd_led             <= leds.fdd_led;
    op.hdd_led             <= leds.hdd_led;
    
    op.blue                <= denise.blue;
    op.red                 <= denise.red;
    op.green               <= denise.green;
                   
    op.cpucfg              <= config.cpucfg;
    op.cachecfg            <= config.cachecfg;    
    op.memcfg              <= config.memcfg;
    op.bootrom             <= config.bootrom;
    
    op.ar                  <= config.ar;
    op.aud_mix             <= config.aud_mix;
    
    op.IO_DOUT             <= paula.IO_DOUT_PAULA;
    op.IO_WAIT             <= paula.IO_WAIT_PAULA or usrio.IO_WAIT_OSD;

    op.ce_pix              <= (denise.shres and (config.chipset_config(4) or config.chipset_config(3))) or (denise.hires and ip.clk7n_en) or ip.clk7_en;
    op.res                 <= (denise.shres and (config.chipset_config(4) or config.chipset_config(3))) & denise.hires;
    op.scanline            <= config.scanline;    
    
    op.rst_out             <= rst.reset;
    
    op.ram_address         <= gary.ram_address_out;
    op.ram_data            <= gary.ram_data_in;
    op.chipRW              <= op.chipU and op.chipL;
    
    rst.reset           <= rst.sys_reset or (not ip.x_cpu_reset_in);                   -- both tg68k and minimig_syscontrol hold the reset signal for some clicks
    leds.pwr_led        <= not leds.led;
    config.memcfg       <= config.memory_config(7) & config.memory_config(5 downto 0);
    config.cachecfg     <= config.cachecfg_pre(2) & not ovl & not ovl;    
    
    video.hblank        <= not video.hde when video.blver /= "00" else video.hbl;    
    video.blank         <= (not video.x_hsync) or video.vblank;

    ide.ide_ena         <= config.ide_config(0);    
    ide.ide_fast        <= (not config.ide_config(5)) and config.cpucfg(1);
    
    pot_cnt_en          <= video.sol and (not ip.c1) and (not ip.c3);
    ecs                 <= config.chipset_config(4) or config.chipset_config(3);
        
    int2_int            <= cia.irq or ip.ide_ext_irq when ide.ide_fast = '1' else cia.irq or gayle.irq;    
    int6_int            <= cia.irq_int6 or migaud.int6_toccata;
    floppy.x_sel        <= floppy.x_sel3 & floppy.x_sel2 & floppy.x_sel1 & floppy.x_sel0;
                   
    jmk.x_fire1_dat     <= cia.porta_out(3);
    jmk.x_fire0_dat     <= cia.porta_out(2);
    leds.led            <= cia.porta_out(1);
    
    cia.wr              <= ctrl_bus.cpu_lwr or ctrl_bus.cpu_hwr;
    
    cia.porta_in        <= jmk.x_fire1 & jmk.x_fire0 & floppy.x_ready & floppy.x_track0 & floppy.x_wprot & floppy.x_change;
    cia.portb_in        <= ip.x_joy4(0) & ip.x_joy4(1) & ip.x_joy4(2) & ip.x_joy4(3) & ip.x_joy3(0) & ip.x_joy3(1) & ip.x_joy3(2) & ip.x_joy3(3);       
    cia.porta_in_b      <= ip.cd & ip.cts & ip.dsr & (ip.ri and ip.x_joy3(4)) & '1' & ip.x_joy4(4);

    nrdy                <= gayle.nrdy and ctrl_bus.rd_cyc;     
   
    hdc_ena             <= ide.ide_ena and (not ide.ide_fast);  
    
    rst.mrst            <= rst.usrrst or ip.rst_ext;
    -- Part of the reset Process: reset_pro
    x_cpu_reset_x       <= x_rst;
    x_cpu_reset_x_n     <= not x_cpu_reset_x;
       

    -- Data Multiplexer
    data_bus.cpu_data_in <= data_bus.gary_data_out
                or data_bus.cia_data_out
                or data_bus.gayle_data_out
                or cart.cart_data_out
                or rtc_i.rtc_out
                or migaud.toccata_out
                ;
              
    data_bus.custom_data_out <= data_bus.agnus_data_out
                    or data_bus.paula_data_out
                    or data_bus.denise_data_out
                    or data_bus.user_data_out
                    ;                                  

-- NTSC/PAL switching is controlled by OSD menu, chnage requires reset to take effect
ntsc_pal : process(ip.clk)
begin
    if rising_edge(ip.clk) then
        if ip.clk7_en = '1' and rst.reset = '1' then
            op.ntsc <= config.chipset_config(1);
        end if;
        -- otherwise ntsc holds its previous value
    end if;
end process;

 -- Kickstart overlay
kick_ovr : process(ip.clk)    
begin
    if rising_edge(ip.clk) then
        if ( x_cpu_reset_x = '0' ) or (ip.x_cpu_reset_in = '0') then
            ovl <= '1';
            elsif gary.sel_cia_a = '1'  and (ctrl_bus.cpu_lwr = '1' or ctrl_bus.cpu_hwr = '1') then
                ovl <= '0';
        end if;
    end if;
end process;

-- Reset
reset_pro : process(ip.clk)
begin
    if rising_edge(ip.clk) then
        r <= not (rst.cpurst or rst.sys_reset);
        x_rst <= r;
    end if;
end process;

USERIO01 : entity work.userio
    port map (
        -- Input Pins
        clk             => ip.clk
       ,clk7_en         => ip.clk7_en
       ,reset           => rst.reset
       ,reg_address_in  => agnus.reg_address
       ,data_in         => data_bus.custom_data_in
       ,pot_cnt_en      => pot_cnt_en
       ,x_fire0_dat     => jmk.x_fire0_dat
       ,x_fire1_dat     => jmk.x_fire1_dat
       ,x_joy1          => ip.x_joy1
       ,x_joy2          => ip.x_joy2
       ,joy_ana1        => ip.joya1
       ,joy_ana2        => ip.joya2
       ,mouse_btn       => ip.mouse_btn
       ,kbd_mouse_type  => ip.kbd_mouse_type
       ,kms_level       => ip.kms_level
       ,kbd_mouse_data  => ip.kbd_mouse_data
       ,host_rdat       => host.host_rdat
       ,host_ack        => host.host_ack
       ,IO_ENA          => ip.IO_UIO
       ,IO_STROBE       => ip.IO_STROBE
       ,IO_DIN          => ip.IO_DIN       
       -- Output Pins
       ,IO_WAIT         => usrio.IO_WAIT_OSD
       ,data_out        => data_bus.user_data_out
       ,x_fire0         => jmk.x_fire0
       ,x_fire1         => jmk.x_fire1
       ,aud_mix         => config.aud_mix
       ,memory_config   => config.memory_config
       ,chipset_config  => config.chipset_config
       ,floppy_config   => config.floppy_config
       ,scanline        => config.scanline
       ,ar              => config.ar 
       ,blver           => video.blver
       ,ide_config      => config.ide_config
       ,cpu_config      => config.cpucfg
       ,cache_config    => config.cachecfg_pre
       ,usrrst          => rst.usrrst
       ,cpurst          => rst.cpurst 
       ,cpuhlt          => usrio.cpuhlt
       ,bootrom         => config.bootrom
       ,host_cs         => host.host_cs
       ,host_adr        => host.host_adr
       ,host_we         => host.host_we
       ,host_bs         => host.host_bs
       ,host_wdat       => host.host_wdat                             
    );

AGNUS1 : entity work.agnus_wrapper
    port map (
        clk             => ip.clk                                   -- clock
       ,clk7_en         => ip.clk7_en
       ,cck             => ip.cck                                   -- colour clock enable, active whenever hpos[0] is high (odd dma slots used by chipset)
       ,reset           => rst.reset                                -- reset
       ,aen             => gary.sel_reg                             -- bus adress enable (register bank)
       ,rd              => ctrl_bus.cpu_rd                          -- bus read
       ,hwr             => ctrl_bus.cpu_hwr                         -- bus high write
       ,lwr             => ctrl_bus.cpu_lwr                         -- bus low write
       ,data_in         => data_bus.custom_data_in                  -- data bus in
       ,data_out        => data_bus.agnus_data_out                  -- data bus out
       ,address_in      => cpu_out.cpu_address_out(8 downto 1)      -- 256 words (512 bytes) adress input,
       ,address_out     => cpu_out.dma_address_out                  -- chip address output
       ,reg_address_out => agnus.reg_address                        -- 256 words (512 bytes) register address out
       ,cpu_custom      => agnus.cpu_custom                         -- CPU has access to custom chipset (registers and chipRAM / slowRAM)
       ,dbr             => agnus.dbr                                -- agnus requests data bus
       ,dbwe            => agnus.dbwe                               -- agnus does a memory write cycle (only disk and blitter dma channels may do this)
       ,x_hsync         => video.x_hsync                            -- horizontal sync
       ,x_vsync         => video.x_vsync                            -- vertical sync
       ,x_csync         => video.x_csync                            -- composite sync
       ,hde             => video.hde                                -- video horizontal data enable
       ,field1          => op.field1
       ,lace            => op.lace
       ,hblank          => video.hbl                                -- video blanking
       ,vblank          => video.vblank                             -- video blanking
       ,sol             => video.sol                                -- start of video line (active during last pixel of previous line)
       ,sof             => video.sof                                -- start of video frame (active during last pixel of previous frame)
       ,vbl_int         => video.vbl_int                            -- vertical blanking interrupt request for Paula
       ,strhor_denise   => video.strhor_denise                      -- horizontal strobe for Denise (due to not cycle exact implementation of Denise it must be delayed by one CCK)
       ,strhor_paula    => video.strhor_paula                       -- horizontal strobe for Paula
       ,htotal          => video.htotal                             -- video line length
       ,harddis         => video.harddis
       ,varbeamen       => video.varbeamen
       ,int3            => agnus.int3                               -- blitter finished interrupt (to Paula)
       ,audio_dmal      => migaud.audio_dmal                        -- audio dma data transfer request (from Paula)
       ,audio_dmas      => migaud.audio_dmas                        -- audio dma location pointer restart (from Paula)
       ,disk_dmal       => disk_dmal                                -- disk dma data transfer request (from Paula)
       ,disk_dmas       => disk_dmas                                -- disk dma special request (from Paula)
       ,bls             => bridge.bls                               -- blitter slowdown
       ,ntsc            => config.chipset_config(1)                 -- chip is NTSC
       ,a1k             => config.chipset_config(2)                 -- enable A1000 OCS features    
       ,ecs             => ecs                                      -- enable ECS features
       ,aga             => config.chipset_config(4)                 -- enables AGA features
       ,floppy_speed    => config.floppy_config(0)                  -- allocates refresh slots for disk DMA                     
    );
    
PAULA1 : entity work.paula_wrapper
    port map (
        clk             => ip.clk                              -- 28 MHz system clock
       ,clk7_en         => ip.clk7_en
       ,clk7n_en        => ip.clk7n_en
       ,cck             => ip.cck                              -- colour clock enable
       ,reset           => rst.reset                           -- reset
       ,reg_address_in  => agnus.reg_address                   -- register address inputs
       ,data_in         => data_bus.custom_data_in             -- bus data in
       ,data_out        => data_bus.paula_data_out             -- bus data out
       ,txd             => op.txd                              -- serial port transmitted data
       ,rxd             => ip.rxd                              -- serial port received data
       ,ntsc            => config.chipset_config(1)            -- PAL/NTSC mode
       ,sof             => video.sof                           -- start of vertical frame
       ,strhor          => video.strhor_paula                  -- start of video line (latches audio DMA requests)
       ,vblint          => video.vbl_int                       -- vertical blanking interrupt trigger
       ,int2            => int2_int                            -- level 2 interrupt
       ,int3            => agnus.int3                          -- level 3 interrupt
       ,int6            => int6_int                            -- level 6 interrupt
       ,x_ipl           => paula.x_ipl                         -- m68k interrupt request
       ,audio_dmal      => migaud.audio_dmal                   -- audio dma data transfer request (to Agnus)
       ,audio_dmas      => migaud.audio_dmas                   -- audio dma location pointer restart (to Agnus)
       ,disk_dmal       => disk_dmal                           -- disk dma data transfer request (to Agnus)
       ,disk_dmas       => disk_dmas                           -- disk dma special request (to Agnus)
       ,x_step          => floppy.x_step                       -- step heads of disk
       ,direc           => floppy.direc                        -- step heads direction
       ,x_sel           => floppy.x_sel                        -- disk select
       ,side            => floppy.side                         -- upper/lower disk head
       ,x_motor         => floppy.x_motor                      -- disk motor control
       ,x_track0        => floppy.x_track0                     -- track zero detect
       ,x_change        => floppy.x_change                     -- disk has been removed from drive
       ,x_ready         => floppy.x_ready                      -- disk is ready
       ,x_wprot         => floppy.x_wprot                      -- disk is write-protected
       ,index           => paula.index                         -- disk index pulse
       ,fdd_led         => leds.fdd_led                        -- disk activity LED, active when DMA is on
       ,IO_ENA          => ip.IO_FPGA
       ,IO_STROBE       => ip.IO_STROBE
       ,IO_WAIT         => paula.IO_WAIT_PAULA
       ,IO_DIN          => ip.IO_DIN
       ,IO_DOUT         => paula.IO_DOUT_PAULA
       ,ldata           => op.ldata                            -- left DAC data
       ,rdata           => op.rdata                            -- right DAC data
       ,ldata_okk       => op.ldata_okk                        -- left DAC data (PWM volume)
       ,rdata_okk       => op.rdata_okk                        -- right DAC data (PWM volume)
       ,floppy_drives   => config.floppy_config(3 downto 2)    -- number of extra floppy drives   
       ,trackdisp       => floppy.trackdisp
       ,secdisp         => floppy.secdisp
       ,floppy_fwr      => floppy.floppy_fwr
       ,floppy_frd      => floppy.floppy_frd                       
    );
    
DENISE1 : entity work.denise 
    port map (
        clk                 => ip.clk                              -- 28MHz clock
       ,clk7_en             => ip.clk7_en                          -- 7MHz clock enable
       ,c1                  => ip.c1                               -- 35ns clock enable signals (for synchronization with clk)
       ,c3                  => ip.c3
       ,cck                 => ip.cck                              -- colour clock enable   --!!! Not used in the module, the port is there but not used for anything
       ,reset               => rst.reset                           -- reset
       ,strhor              => video.strhor_denise                 -- horizontal strobe
       ,reg_address_in      => agnus.reg_address                   -- register adress inputs
       ,data_in             => data_bus.custom_data_in             -- bus data in
       ,chip48              => ip.chip48                           -- big chipram read
       ,blank               => video.blank                         -- blanking input
       ,a1k                 => config.chipset_config(2)            -- control EHB chipset feature
       ,ecs                 => ecs                                 -- enables ECS chipset features
       ,aga                 => config.chipset_config(4)            -- enables AGA features
       ,data_out            => data_bus.denise_data_out            -- bus data out
       ,red                 => denise.red                          -- red componenent video out
       ,green               => denise.green                        -- green component video out
       ,blue                => denise.blue                         -- blue component video out
       ,hires               => denise.hires                        -- hires
       ,shres               => denise.shres                        -- shres
    );

CIAA1 : entity work.ciaa
    port map (
        clk                 => ip.clk                               -- clock
       ,clk7_en             => ip.clk7_en
       ,clk7n_en            => ip.clk7n_en
       ,aen                 => gary.sel_cia_a                       -- adress enable
       ,rd                  => ctrl_bus.cpu_rd                      -- read enable
       ,wr                  => cia.wr                               -- write enable
       ,reset               => rst.reset                            -- reset
       ,rs                  => cpu_out.cpu_address_out(11 downto 8) -- register select (address)
       ,data_in             => data_bus.cpu_data_out(7 downto 0)    -- bus data in
       ,tick                => video.x_vsync                        -- tick (counter input for TOD timer)
       ,eclk                => ip.eclk(8)                           -- eclk (counter input for timer A/B)
       ,porta_in            => cia.porta_in                         -- porta in
       ,portb_in            => cia.portb_in                         -- portb in
       ,kbd_mouse_type      => ip.kbd_mouse_type
       ,kms_level           => ip.kms_level
       ,kbd_mouse_data      => ip.kbd_mouse_data
       ,hrtmon_en           => config.memory_config(6)
       ,data_out            => data_bus.cia_data_out(7 downto 0)
       ,irq                 => cia.irq                              -- interrupt request out
       ,porta_out           => cia.porta_out                        -- porta out
       ,freeze              => cia.freeze                           -- Action Replay freeze key
    );       

CIAB1 : entity work.ciab
    port map (
        clk                 => ip.clk                                    -- clock
       ,clk7_en             => ip.clk7_en
       ,aen                 => gary.sel_cia_b                            -- adress enable
       ,rd                  => ctrl_bus.cpu_rd                           -- read enable
       ,wr                  => cia.wr                                    -- write enable
       ,reset               => rst.reset                                 -- reset
       ,rs                  => cpu_out.cpu_address_out(11 downto 8)      -- register select (address)
       ,data_in             => data_bus.cpu_data_out(15 downto 8)        -- bus data in
       ,tick                => video.x_hsync                             -- tick (counter input for TOD timer)
       ,eclk                => ip.eclk(8)                                -- eclk (counter input for timer A/B)
       ,flag                => paula.index                               -- flag (set FLG bit in ICR register)
       ,porta_in            => cia.porta_in_b                            -- input port
       ,data_out            => data_bus.cia_data_out(15 downto 8)        -- bus data out
       ,irq                 => cia.irq_int6                              -- interrupt request out
       ,porta_out(7)        => op.dtr
       ,porta_out(6)        => op.rts
       ,portb_out(7)        => floppy.x_motor
       ,portb_out(6)        => floppy.x_sel3
       ,portb_out(5)        => floppy.x_sel2
       ,portb_out(4)        => floppy.x_sel1
       ,portb_out(3)        => floppy.x_sel0
       ,portb_out(2)        => floppy.side
       ,portb_out(1)        => floppy.direc
       ,portb_out(0)        => floppy.x_step      
    );
    
CPU1 : entity work.minimig_m68k_bridge_wrapper
    port map (
        clk                 => ip.clk                              -- 28 MHz system clock
       ,clk7_en             => ip.clk7_en
       ,clk7n_en            => ip.clk7n_en
       ,c1                  => ip.c1                               -- clock enable signal
       ,c3                  => ip.c3                               -- clock enable signal
       ,cck                 => ip.cck                              -- colour clock enable, active when dma can access the memory bus
       ,eclk                => ip.eclk                             -- ECLK enable signal
       ,vpa                 => gary.sel_cia                        -- valid peripheral address (CIAs)
       ,dbr                 => agnus.dbr                           -- data bus request, Gary keeps CPU off the bus (custom chips transfer data)
       ,dbs                 => gary.dbs                            -- data bus slowdown (access to chip ram or custom registers)
       ,xbs                 => gary.xbs                            -- cross bridge access (active dbr holds off CPU access)
       ,nrdy                => nrdy                                -- target device is not ready
       ,bls                 => bridge.bls                          -- blitter slowdown, tells the blitter that CPU wants the bus
       ,memory_config       => config.memory_config(3 downto 0)    -- system memory config    
       ,x_as                => ip.x_cpu_as                         -- m68k adress strobe
       ,x_lds               => ip.x_cpu_lds                        -- m68k lower data strobe d0-d7
       ,x_uds               => ip.x_cpu_uds                        -- m68k upper data strobe d8-d15
       ,r_w                 => ip.cpu_r_w                          -- m68k read / write
       ,x_dtack             => op.x_cpu_dtack                      -- m68k data acknowledge to cpu
       ,rd                  => ctrl_bus.cpu_rd                     -- bus read
       ,rd_cyc              => ctrl_bus.rd_cyc                     -- early rd signal can be used to delay DTACK
       ,hwr                 => ctrl_bus.cpu_hwr                    -- bus high write
       ,lwr                 => ctrl_bus.cpu_lwr                    -- bus low write
       ,address             => ip.cpu_address                      -- external cpu address bus
       ,address_out         => cpu_out.cpu_address_out             -- internal cpu address bus output
       ,cpudatain           => ip.cpudata_in
       ,data                => op.cpu_data                         -- external cpu data bus
       ,data_out            => data_bus.cpu_data_out               -- internal data bus output
       ,data_in             => data_bus.cpu_data_in                -- internal data bus input
       ,x_cpu_reset         => op.x_cpu_reset
       ,cpu_halt            => usrio.cpuhlt
       ,host_cs             => host.host_cs
       ,host_adr            => host.host_adr(23 downto 1)
       ,host_we             => host.host_we
       ,host_bs             => host.host_bs
       ,host_wdat           => host.host_wdat
       ,host_rdat           => host.host_rdat
       ,host_ack            => host.host_ack      
    );    

CART1 : entity work.cart_wrapper
    port map (
        clk                 => ip.clk
       ,clk7_en             => ip.clk7_en
       ,clk7n_en            => ip.clk7n_en            -- port is mapped but not used in the module!!!!
       ,cpu_rst             => x_cpu_reset_x_n               
       ,cpu_address_in      => cpu_out.cpu_address_out
       ,x_cpu_as            => ip.x_cpu_as
       ,cpu_rd              => ctrl_bus.cpu_rd
       ,cpu_hwr             => ctrl_bus.cpu_hwr       -- port is mapped but not used in the module!!!!
       ,cpu_lwr             => ctrl_bus.cpu_lwr       -- port is mapped but not used in the module!!!!
       ,nmi_addr            => ip.nmi_addr
       ,reg_address_in      => agnus.reg_address
       ,reg_data_in         => data_bus.custom_data_in
       ,dbr                 => agnus.dbr
       ,ovl                 => ovl
       ,freeze              => cia.freeze
       ,cart_data_out       => cart.cart_data_out
       ,int7                => cart.int7
       --,sel_cart            => cart.sel_cart        -- Maps to removed module bankmapper
       ,sel_cart            => open
       ,ovr                 => op.ovr
       ,cpuhlt              => usrio.cpuhlt             
    );

GARY1 : entity work.gary
    port map (
        cpu_address_in      => cpu_out.cpu_address_out                  -- cpu address bus input
       ,dma_address_in      => cpu_out.dma_address_out                  -- agnus dma memory address input
       ,ram_address_out     => gary.ram_address_out                     -- full ram address output to make memory mapping easier
       ,cpu_data_out        => data_bus.cpu_data_out
       ,cpu_data_in         => data_bus.gary_data_out
       ,custom_data_out     => data_bus.custom_data_out
       ,custom_data_in      => data_bus.custom_data_in
       ,ram_data_out        => data_bus.ram_data_out
       ,ram_data_in         => gary.ram_data_in
       ,cpu_rd              => ctrl_bus.cpu_rd                          -- cpu read
       ,cpu_hwr             => ctrl_bus.cpu_hwr                         -- cpu high write
       ,cpu_lwr             => ctrl_bus.cpu_lwr                         -- cpu low write
       ,cpu_hlt             => usrio.cpuhlt
       ,ovl                 => ovl                                      -- overlay kickstart rom over chipram
       ,dbr                 => agnus.dbr                                -- Agnus takes the bus
       ,dbwe                => agnus.dbwe                               -- Agnus does a write cycle
       ,dbs                 => gary.dbs                                 -- data bus slow down
       ,xbs                 => gary.xbs                                 -- cross bridge select, active dbr prevents access
       ,memory_config       => config.memory_config(3 downto 0)         -- selected memory configuration
       ,hdc_ena             => hdc_ena                                  -- enables hdd interface
       ,toccata_ena         => ip.toccata_ena
       ,toccata_base        => ip.toccata_base
       --,ram_rd              => ctrl_bus.ram_rd                          -- bus read
       ,ram_rd              => op.chipDMA
       --,ram_hwr             => ctrl_bus.ram_hwr                         -- bus high write
       ,ram_hwr             => op.chipU
       --,ram_lwr             => ctrl_bus.ram_lwr                         -- bus low write
       ,ram_lwr             => op.chipL
       ,ecs                 => ecs                                      -- ECS chipset enable
       ,a1k                 => config.chipset_config(2)       
       --,sel_chip            => gary.sel_chip                                 -- select chip memory
       --,sel_slow            => gary.sel_slow(2 downto 0)                     -- select slowfast memory ($C0000)
       --,sel_kick            => gary.sel_kick                                 -- select kickstart rom
       --,sel_kick1mb         => gary.sel_kick1mb                              -- 1MB kickstart rom 'upper' half       
       --,sel_kick256kmirror  => gary.sel_kick256kmirror                       -- mirror $fc-$ff to $f8, when rom_readonly and bootrom       
       -- The now open out signal mapped directly to the now removed bankmapper module
       ,sel_chip            => open
       ,sel_slow            => open
       ,sel_kick            => open
       ,sel_kick1mb         => open
       ,sel_kick256kmirror  => open
       ,sel_cia             => gary.sel_cia                                 -- select CIA space
       ,sel_reg             => gary.sel_reg                                 -- select chip register bank
       ,sel_cia_a           => gary.sel_cia_a                               -- select cia A
       ,sel_cia_b           => gary.sel_cia_b                               -- select cia B
       ,sel_ide             => ide.sel_ide                                  -- select $DAxxxx
       ,sel_gayle           => gary.sel_gayle                               -- select $DExxxx
       ,sel_rtc             => gary.sel_rtc                                 --select $DCxxxx
       ,sel_toccata         => migaud.sel_toccata                           -- select $E9xxxx (or whatever's specified by toccata_base)
       ,reset               => rst.reset                                    -- global reset signal
       ,clk                 => ip.clk
       ,rom_readonly        => gary.rom_readonly                            -- when zero allows to write to $fc-$ff, blocks effect of kick256kmirror.
       ,bootrom             => config.bootrom                               -- do the A1000 bootrom magic
       
    );
    
GAYLE1 : entity work.gayle
    port map (
        clk                     => ip.clk
       ,reset                   => rst.reset
       ,addr                    => cpu_out.cpu_address_out
       ,data_in                 => data_bus.cpu_data_out
       ,data_out                => data_bus.gayle_data_out
       ,rd                      => ctrl_bus.cpu_rd
       ,wr                      => ctrl_bus.cpu_hwr
       ,sel_ide                 => ide.sel_ide                           -- $DAxxxx
       ,sel_gayle               => gary.sel_gayle                         -- $DExxxx
       ,irq                     => gayle.irq
       ,nrdy                    => gayle.nrdy                             -- fifo is not ready for reading
       ,ide_req                 => ide.ide_req
       ,ide_address             => ip.ide_address
       ,ide_write               => ip.ide_write
       ,ide_writedata           => ip.ide_writedata
       ,ide_read                => ip.ide_read
       ,ide_readdata            => ide.ide_readdata
       ,led                     => leds.hdd_led
       ,longword                => '0'
    );

-- INstantiate system control
CONTROL1 : entity minimig_syscontrol
    port map (
        clk         => ip.clk                       -- bus clock
       ,clk7_en     => ip.clk7_en
       ,cnt         => video.sof                    -- pulses for counting
       ,mrst        => rst.mrst                     -- master/user reset input
       ,reset       => rst.sys_reset                -- global synchronous system reset
    );

RTC1 : entity work.rtc
    port map (
        clk                 => ip.clk
       ,rtc                 => ip.rtc
       ,sel_rtc             => gary.sel_rtc
       ,cpu_rd              => ctrl_bus.cpu_rd
       ,cpu_address_out     => cpu_out.cpu_address_out
       ,rtc_out             => rtc_i.rtc_out
    );

-- Toccata soundcard
TOCCATA1 : entity work.toccata
    generic map (
        CLK_FREQUENCY => 28_359_380
    )
    port map (
        clk         => ip.clk
       ,rst         => rst.reset
       ,hsync       => video.x_hsync 
       ,data_in     => data_bus.cpu_data_out
       ,data_out    => migaud.toccata_out
       ,addr        => cpu_out.cpu_address_out(15 downto 1)
       ,rd          => ctrl_bus.cpu_rd
       ,hwr         => ctrl_bus.cpu_hwr
       ,lwr         => ctrl_bus.cpu_lwr
       ,sel         => migaud.sel_toccata
       ,toc_int     => migaud.int6_toccata
       ,out_left    => migaud.toccata_aud_left
       ,out_right   => migaud.toccata_aud_right        
    );

end architecture;    
