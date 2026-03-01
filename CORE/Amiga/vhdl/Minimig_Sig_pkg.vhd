-- Minimig Module Signal Record tpes

library ieee;
use ieee.std_logic_1164.all;

package Minimig_Sig_pkg is
    attribute description : string;
    
    type IP_MINIMIG_TYPE is record
        --m68k pins
        cpu_address     : std_logic_vector(23 downto 1);            -- m68k address bus
        cpudata_in      : std_logic_vector(15 downto 0);            -- m68k data in   
        x_cpu_as        : std_logic;                                -- m68k address strobe
        x_cpu_uds       : std_logic;                                -- m68k upper data strobe
        x_cpu_lds       : std_logic;                                -- m68k lower data strobe
        cpu_r_w         : std_logic;                                -- m68k read / write  
        x_cpu_reset_in  : std_logic;                                -- m68k reset in
        nmi_addr        : std_logic_vector(31 downto 0);            -- m68k NMI address             
        -- ram pins
        ramdata_in      : std_logic_vector(15 downto 0);            -- ram data bus in      
        chip48          : std_logic_vector(47 downto 0);            -- big chipram read
        -- System pins
        rst_ext         : std_logic;                                -- reset from ctrl block     
        clk             : std_logic;                                -- 28.37516 MHz clock
        clk7_en         : std_logic;                                -- 7MHz clock enable
        clk7n_en        : std_logic;                                -- 7MHz negedge / falling_edge clock enable
        c1              : std_logic;                                -- clock enable signal
        c3              : std_logic;                                -- clock enable signal
        cck             : std_logic;                                -- colour clock enable
        eclk            : std_logic_vector(9 downto 0);             -- ECLK enable (1/10th of CLK)     
        -- rs232 pins
        rxd             : std_logic;                                -- rs232 receive     
        cts             : std_logic;                                -- rs232 clear to send   
        dsr             : std_logic;                                -- rs232 Data Set Ready
        cd              : std_logic;                                -- rs232 Carrier Detect
        ri              : std_logic;                                -- rs232 Ring Indicator          
        -- I/O
        x_joy1           : std_logic_vector(15 downto 0);            -- joystick 1 [fire2,fire,up,down,left,right] (default mouse port)
        x_joy2           : std_logic_vector(15 downto 0);            -- joystick 2 [fire2,fire,up,down,left,right] (default joystick port)
        x_joy3           : std_logic_vector(15 downto 0);            -- joystick 3 [fire2,fire,up,down,left,right]
        x_joy4           : std_logic_vector(15 downto 0);            -- joystick 4 [fire2,fire,up,down,left,right]
        joya1            : std_logic_vector(15 downto 0);    
        joya2            : std_logic_vector(15 downto 0);
        mouse_btn        : std_logic_vector(2 downto 0);             -- mouse buttons
        kms_level        : std_logic;
        kbd_mouse_type   : std_logic_vector(1 downto 0);
        kbd_mouse_data   : std_logic_vector(7 downto 0);
        rtc              : std_logic_vector(64 downto 0);            
        -- Host Controller Interface (SPI)
        IO_UIO           : std_logic;
        IO_FPGA          : std_logic;
        IO_STROBE        : std_logic;
        IO_DIN           : std_logic_vector(15 downto 0);       
        -- Toccata Audio
        toccata_ena      : std_logic;
        toccata_base     : std_logic_vector(7 downto 0);          
        -- User I/O
        ide_ext_irq      : std_logic;
        ide_address      : std_logic_vector(4 downto 0);
        ide_write        : std_logic;
        ide_writedata    : std_logic_vector(15 downto 0);
        ide_read         : std_logic;                                       
    end record;
    
    type OP_MINIMIG_TYPE is record
        --m68k pins
        cpu_data        : std_logic_vector(15 downto 0);            -- m68k data bus
        x_cpu_ipl       : std_logic_vector(2 downto 0);             -- m68k interrupt request
        x_cpu_dtack     : std_logic;                                -- m68k data acknowledge
        x_cpu_reset     : std_logic;                                -- m68k reset
        ovr             : std_logic;                                -- NMI address decoding override
        -- ram pins
        ram_data        : std_logic_vector(15 downto 0);            -- sram data bus
        ram_address     : std_logic_vector(23 downto 1);            -- sram address bus
        x_ram_bhe       : std_logic;                                -- sram upper byte select
        x_ram_ble       : std_logic;                                -- sram lower byte select
        x_ram_we        : std_logic;                                -- sram write enable
        x_ram_oe        : std_logic;                                -- sram output enable
        chipDMA         : std_logic;
        chipRW          : std_logic;
        chipU           : std_logic;
        chipL           : std_logic;
        -- System pins
        rst_out         : std_logic;                                -- minimig reset status
        -- rs232 pins
        txd             : std_logic;                                -- rs232 send
        rts             : std_logic;                                -- rs232 request to send
        dtr             : std_logic;                                -- rs232 Data Terminal Ready       
        -- I/O
        pwr_led         : std_logic;
        fdd_led         : std_logic;
        hdd_led         : std_logic;
        -- Host Controller Interface (SPI)
        IO_WAIT         : std_logic;
        IO_DOUT         : std_logic_vector(15 downto 0);      
        -- Video
        x_hsync          : std_logic;                                -- horizontal sync
        x_vsync          : std_logic;                                -- vertical sync
        x_csync          : std_logic;                                -- composite sync
        field1           : std_logic;
        lace             : std_logic;
        hblank           : std_logic;
        vblank           : std_logic;
        red              : std_logic_vector(7 downto 0);
        green            : std_logic_vector(7 downto 0);
        blue             : std_logic_vector(7 downto 0);
        ar               : std_logic_vector(1 downto 0);
        scanline         : std_logic_vector(2 downto 0);
        ce_pix           : std_logic;
        res              : std_logic_vector(1 downto 0);
        ntsc             : std_logic;
        -- Audio
        ldata            : std_logic_vector(14 downto 0);            -- left DAC data
        rdata            : std_logic_vector(14 downto 0);            -- right DAC data
        ldata_okk        : std_logic_vector(8 downto 0);             -- left DAC data  (PWM volume)
        rdata_okk        : std_logic_vector(8 downto 0);             -- right DAC data (PWM volume)
        aud_mix          : std_logic_vector(1 downto 0);  
        -- Toccata Audio   
        toccata_aud_left  : std_logic_vector(15 downto 0);
        toccata_aud_right : std_logic_vector(15 downto 0);          
        -- User I/O
        cpucfg            : std_logic_vector(1 downto 0);
        cachecfg          : std_logic_vector(2 downto 0);
        memcfg            : std_logic_vector(6 downto 0);
        bootrom           : std_logic;                            -- enable bootrom magic in gary.v
        ide_ena           : std_logic;
        ide_fast          : std_logic;
        ide_req           : std_logic_vector(5 downto 0);
        ide_readdata      : std_logic_vector(15 downto 0);                                                    
    end record;
    
    type DATA_BUS_TYPE is record
             cpu_data_in      : std_logic_vector(15 downto 0);        -- cpu data bus in
             cpu_data_out     : std_logic_vector(15 downto 0);        -- cpu data bus out
             --ram_data_in      : std_logic_vector(15 downto 0);        -- ram data bus in  - Gary's output
             ram_data_out     : std_logic_vector(15 downto 0);        -- ram data bus out
             custom_data_in   : std_logic_vector(15 downto 0);        -- custom chips data bus in
             custom_data_out  : std_logic_vector(15 downto 0);        -- custom chips data bus out    
             agnus_data_out   : std_logic_vector(15 downto 0);        -- agnus data out
             paula_data_out   : std_logic_vector(15 downto 0);        -- paula data bus out
             denise_data_out  : std_logic_vector(15 downto 0);        -- denise data bus out
             user_data_out    : std_logic_vector(15 downto 0);        -- user IO data out
             gary_data_out    : std_logic_vector(15 downto 0);        -- data out from memory bus multiplexer
             gayle_data_out   : std_logic_vector(15 downto 0);        -- Gayle data out
             cia_data_out     : std_logic_vector(15 downto 0);        -- cia A+B data bus out
             ar3_data_out     : std_logic_vector(15 downto 0);        -- Action Replay data out - Not used !!!
    end record;    
    attribute description of DATA_BUS_TYPE : type is "Data Bus Signals use by MiniMig";
    
    type CPU_ADDRESS_TYPE is record
         -- Note: Somewhere cpu address get expanded to 28:1
         -- and dma/chip expands to 24:1 in size.
         -- Not sure what this means for dma address size as 20:1 limits it to 1MB of addresses for CHIP RAM
         -- when some Amiga models can go up to 2MB in CHIP RAM
         -- Need to check what else is going on!!!
         cpu_address_out  : std_logic_vector(23 downto 1);        -- cpu address out
         dma_address_out  : std_logic_vector(20 downto 1);        -- agnus address out
         ram_address_out  : std_logic_vector(23 downto 1);        -- ram address out
    end record;         
    attribute description of CPU_ADDRESS_TYPE : type is "Signals for CPU address";
        
    type CTRL_BUS_TYPE is record
         ram_rd           : std_logic;                            -- ram read enable
         ram_hwr          : std_logic;                            -- ram high byte write enable
         ram_lwr          : std_logic;                            -- ram low byte write enable
         cpu_rd           : std_logic;                            -- cpu read enable
         rd_cyc           : std_logic;
         cpu_hwr          : std_logic;                            -- cpu high byte write enable
         cpu_lwr          : std_logic;                            -- cpu low byte write enable        
    end record;
    attribute description of CTRL_BUS_TYPE : type is "Local signals for control bus";    
    
    type FLOPPY_TYPE is record
        -- local floppy signals (CIA<-->Paula)
         x_step           : std_logic;                            -- step heads of disk
         direc            : std_logic;                            -- step heads direction
         x_sel            : std_logic_vector(3 downto 0);         -- disk select
         x_sel0           : std_logic;                            -- disk0 select
         x_sel1           : std_logic;                            -- disk1 select
         x_sel2           : std_logic;                            -- disk2 select
         x_sel3           : std_logic;                            -- disk3 select
         side             : std_logic;                            -- upper/lower disk head
         x_motor          : std_logic;                            -- disk motor control
         x_track0         : std_logic;                            -- track zero detect
         x_change         : std_logic;                            -- disk has been removed from drive
         x_ready          : std_logic;                            -- disk is ready
         x_wprot          : std_logic;                            -- disk is write-protected
         -- fifo / track display
         -- Note: must tack a look at this as it could be useful info to display / overlay on screen for the user.
         floppy_fwr       : std_logic;                      -- Signal not connected, maybe a placeholder                     
         floppy_frd       : std_logic;                      -- Signal not connected, maybe a placeholder
         trackdisp        : std_logic_vector(7 downto 0);    -- Signal not connected, maybe a placeholder                           
         secdisp          : std_logic_vector(13 downto 0);    -- Signal not connected, maybe a placeholder                           

    end record;
    attribute description of FLOPPY_TYPE : type is "Local signals for Floppy drives";

    type VIDEO_TYPE is record
         blver            : std_logic_vector(1 downto 0);
         hbl              : std_logic;
         hde              : std_logic;     
         blank            : std_logic;     
         hblank           : std_logic;     
         vblank           : std_logic;     
         x_hsync          : std_logic;     
         x_vsync          : std_logic;     
         x_csync          : std_logic;     
         sol              : std_logic;                            -- start of video line
         sof              : std_logic;                            -- start of video frame
         vbl_int          : std_logic;                            -- vertical blanking interrupt
         strhor_denise    : std_logic;                            -- horizontal strobe for Denise
         strhor_paula     : std_logic;                            -- horizontal strobe for Paula
         htotal           : std_logic_vector(8 downto 0);         -- video line length (140ns units) - Signal is Not used ?? - Placeholder so module can "connect" to something.
         harddis          : std_logic;                          -- Signal is Not used ?? - Placeholder so module can "connect" to something.
         varbeamen        : std_logic;                          -- Signal Not used ?? - Placeholder so module can "connect" to something.       
    end record;
    attribute description of VIDEO_TYPE : type is "Local signals for Floppy drives";        
    
    type HOST_TYPE is record
    -- Host interface
         host_cs          : std_logic;
         host_adr         : std_logic_vector(23 downto 0);
         host_we          : std_logic;
         host_bs          : std_logic_vector(1 downto 0);
         host_wdat        : std_logic_vector(15 downto 0);
         host_rdat        : std_logic_vector(15 downto 0);
         host_ack         : std_logic;    
    end record;
    attribute description of HOST_TYPE : type is "Local signals for Host Interface";

    type IDE_TYPE is record
        ide_fast                    : std_logic;
        ide_ena                     : std_logic;
        ide_req                     : std_logic_vector(5 downto 0);
        ide_readdata                : std_logic_vector(15 downto 0);
        sel_ide                     : std_logic;                            -- select IDE drive registers
        -- These ports are IN Ports for the module.  Assigned direct to the relevant modules.
--        ide_address                 : std_logic;
--        ide_write                   : std_logic;
--        ide_writedata               : std_logic;
--        ide_read                    : std_logic;        
    end record;
    attribute description of IDE_TYPE : type is "Local signals for IDE Interface";

    type RESET_TYPE is record
        -- Reset Signals.
        sys_reset        : std_logic;                            -- reset output from minimig_syscontrol.v
        reset            : std_logic;                            -- Global Reset 
        cpurst           : std_logic;                            -- Global Reset 
        usrrst           : std_logic;                            -- user reset from osd interface
        mrst             : std_logic;                            -- master/user reset input
    end record;
    attribute description of RESET_TYPE : type is "Local signals for Reset";    

    type MIG_AUDIO_TYPE is record
        sel_toccata         : std_logic;
        toccata_out         : std_logic_vector(15 downto 0);
        int6_toccata        : std_logic;
        toccata_aud_left    : std_logic_vector(15 downto 0);
        toccata_aud_right   : std_logic_vector(15 downto 0);
        audio_dmal          : std_logic_vector(3 downto 0);         -- audio dma data transfer request from Paula to Agnus    
        audio_dmas          : std_logic_vector(3 downto 0);         -- audio dma location pointer restart from Paula to Agnus
    end record;
    attribute description of MIG_AUDIO_TYPE : type is "Local signals for Audio";

    type CONFIGURATION_TYPE is record
         memory_config    : std_logic_vector(7 downto 0);         -- memory configuration
         floppy_config    : std_logic_vector(3 downto 0);         -- floppy drives configuration (drive number and speed)
         chipset_config   : std_logic_vector(4 downto 0);         -- chipset features selection
         ide_config       : std_logic_vector(5 downto 0);         -- HDD & HDC config: bit #0 enables Gayle, bit #1 enables Master drive, bit #2 enables Slave drive
         scanline         : std_logic_vector(2 downto 0);
         cpucfg           : std_logic_vector(1 downto 0);         -- CPU Configuration  
         cachecfg_pre     : std_logic_vector(2 downto 0);
         cachecfg         : std_logic_vector(2 downto 0);
         memcfg           : std_logic_vector(6 downto 0);
         ar               : std_logic_vector(1 downto 0);
         aud_mix          : std_logic_vector(1 downto 0);
         
         --sel_chip         : std_logic_vector(3 downto 0);         -- chip ram select    
         --sel_slow         : std_logic_vector(3 downto 0);         -- slow ram select    
         --sel_kick         : std_logic;                            -- rom select    
         --sel_kick1mb      : std_logic;                            -- 1MB upper rom select    
         --sel_kick256kmirror : std_logic;                          -- mirror f8-fb to fc-ff in a1k mode
         bootrom          : std_logic;                          -- bootrom
    end record;
    attribute description of CONFIGURATION_TYPE : type is "User / System Configuration Signals";

    type CIA_TYPE is record
         -- For CIAA
         porta_in         : std_logic_vector(7 downto 2);
         portb_in         : std_logic_vector(7 downto 0);
         porta_out        : std_logic_vector(3 downto 0);
         wr               : std_logic;                          -- write enable
         irq              : std_logic;
         freeze           : std_logic;                          -- Action Replay freeze button
         
         -- For CIAB
         porta_in_b       : std_logic_vector(5 downto 0);
         porta_out_b      : std_logic_vector(7 downto 6);
         portb_out_b      : std_logic_vector(7 downto 0);        
         irq_int6         : std_logic;                             
    end record;
    attribute description of CIA_TYPE : type is "Signals for CIAA and CIAB";

    type LED_TYPE is record
       -- LED light signals.
       -- Note: M65 only has one LED for the drive light.  Will need to combine combine the FDD abd HDD signals 
       -- at some point.  Perhaps using different coloured lights to show the difference activity.
       pwr_led          : std_logic;                -- Power LED
       fdd_led          : std_logic;                -- Floppy Disk Drive LED
       hdd_led          : std_logic;                -- Hard Disk Drive LED
       led              : std_logic;                -- temp internal signal for power led.
    end record;
    attribute description of LED_TYPE : type is "Signals for LEDs";

    type MIG_JOY_MOUSE_KEYBOARD_TYPE is record
     x_fire0          : std_logic;                            -- joystick 1 fire signal to cia A    
     x_fire1          : std_logic;                            -- joystick 2 fire signal to cia A    
     x_fire0_dat      : std_logic;
     x_fire1_dat      : std_logic;
    end record;
    attribute description of MIG_JOY_MOUSE_KEYBOARD_TYPE : type is "Signals for MiniMig Joy, Mouse and Keyboard";

    type USERIO_TYPE is record
        IO_WAIT_OSD      : std_logic;     
        cpuhlt           : std_logic;
    end record;
    attribute description of USERIO_TYPE : type is "Signals from USER IO";
    
    type PAULA_TYPE is record
        IO_WAIT_PAULA    : std_logic;
        IO_DOUT_PAULA    : std_logic_vector(15 downto 0);
        x_ipl            : std_logic_vector(2 downto 0);                -- interrupt request lines from Paula
        index            : std_logic;                                   -- disk index pulse
    end record;
    attribute description of PAULA_TYPE : type is "Signals from PAULA";

    type AGNUS_TYPE is record
        reg_address : std_logic_vector(8 downto 1);
        cpu_custom  : std_logic;
        dbr         : std_logic;                -- data bus request, Agnus tells CPU that she is using the bus
        dbwe        : std_logic;                -- data bus write enable, Agnus tells the RAM it's writing data
        int3        : std_logic;
    end record;
    attribute description of AGNUS_TYPE : type is "Signals from AGNUS";
    
    type DENISE_TYPE is record
        red         : std_logic_vector(7 downto 0);         -- red componenent video out   
        green       : std_logic_vector(7 downto 0);         -- red componenent video out   
        blue        : std_logic_vector(7 downto 0);         -- red componenent video out 
        hires       : std_logic;                            -- hires signal from Denise for interpolation filter enable in Amber
        shres       : std_logic;                            -- shres
    end record;
    attribute description of DENISE_TYPE : type is "Signals from DENISE";
    
    type BRIDGE_TYPE is record
        bls         : std_logic;                            -- blitter slowdown, tells the blitter that CPU wants the bus
        
    end record;
    attribute description of BRIDGE_TYPE : type is "Signals from M68K Bridge";
    
    type CART_TYPE is record
        int7        : std_logic;                            -- int7 interrupt request from Action Replay
        sel_cart    : std_logic;                            -- Action Replay RAM select
        cart_data_out : std_logic_vector(15 downto 0);
    end record;
    attribute description of CART_TYPE : type is "Signals from Cart";
    
    type GARY_TYPE is record
        ram_address_out     : std_logic_vector(23 downto 1);    -- full ram address output to make memory mapping easier
        ram_data_in         : std_logic_vector(15 downto 0);
        dbs                 : std_logic;                        -- data bus slow down
        xbs                 : std_logic;                        -- cross bridge access (memory and custom registers), active dbr prevents access
        sel_chip            : std_logic_vector(3 downto 0);     -- chip ram select
        sel_slow            : std_logic_vector(3 downto 0);     -- slow ram select
        sel_kick            : std_logic;                        -- rom select
        sel_kick1mb         : std_logic;                        -- 1MB upper rom select
        sel_kick256kmirror  : std_logic;                        -- mirror f8-fb to fc-ff in a1k mode
        sel_cia             : std_logic;                        -- select CIA space
        sel_reg             : std_logic;                        -- select chip register bank
        sel_cia_a           : std_logic;                        -- select cia A
        sel_cia_b           : std_logic;                        -- select cia B
        sel_gayle           : std_logic;                        -- select $DExxxx
        sel_rtc             : std_logic;                        -- select $DCxxxx
        rom_readonly        : std_logic;                        -- when zero allows to write to $fc-$ff, blocks effect of kick256kmirror.  writeprotect $f8-ff in gary.v
    end record;
    attribute description of GARY_TYPE : type is "Signals from Gary";
    
    type GAYLE_TYPE is record
        irq             : std_logic;        
        nrdy            : std_logic;                        -- HDD fifo is not ready for reading   
    end record;
    attribute description of GAYLE_TYPE : type is "Signals from Gayle";
    
    type RTC_TYPE is record
        rtc_out     : std_logic_vector(15 downto 0);
    end record;
    attribute description of RTC_TYPE : type is "Signals from RTC";
    
end package;
