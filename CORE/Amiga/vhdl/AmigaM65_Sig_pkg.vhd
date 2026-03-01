-- AmigaM65 Module Signal Record types

library ieee;
use ieee.std_logic_1164.all;

package AmigaM65_Sig_pkg is
    attribute description : string;
    
    type IP_TYPE is record
        main_clk_114        : std_logic;
        main_clk_sys        : std_logic;
        main_clk_locked     : std_logic;
        main_rst            : std_logic;
        CLK_AUDIO           : std_logic;     -- Audio Clock @ 24.576 MHz
        RESET               : std_logic;       
        -- UART
        UART_CTS            : std_logic;
        UART_RXD            : std_logic;
        UART_DSR            : std_logic;
        -- Keyboad Input
        kbd_mouse_type      : std_logic_vector(1 downto 0);
        kbd_mouse_data      : std_logic_vector(7 downto 0);
        -- User Config
        io_uio              : std_logic;                        -- Enable signal for USERIO
        io_strobe           : std_logic;  
        io_din              : std_logic_vector(15 downto 0);    -- Data for USERIO
        io_fpga             : std_logic;                        -- Enable signal for Paula
    end record;
    attribute description of IP_TYPE : type is "IN Ports for AmigaM65 module";
    
    type OP_TYPE is record
        -- LEDs
        LED_USER            : std_logic;     
        LED_POWER           : std_logic_vector(0 downto 0);        
        LED_DISK            : std_logic_vector(1 downto 0);   
        -- Audio
        AUDIO_L             : std_logic_vector(15 downto 0);
        AUDIO_R             : std_logic_vector(15 downto 0);
        AUDIO_S             : std_logic;                        -- 1 - signed audio samples, 0 - unsigned
        AUDIO_MIX           : std_logic_vector(1 downto 0);     -- 0 - no mix, 1 - 25%, 2 - 50%, 3 - 100% (mono)
        -- UART
        UART_RTS            : std_logic;
        UART_TXD            : std_logic;
        UART_DTR            : std_logic;  
        -- Video Output
        VGA_R               : std_logic_vector(7 downto 0);
        VGA_G               : std_logic_vector(7 downto 0);
        VGA_B               : std_logic_vector(7 downto 0);
        VGA_HS              : std_logic;                        -- Horizontal 
        VGA_VS              : std_logic;                        -- Vertical
        VIDEO_HBLANK        : std_logic; 
        VIDEO_VBLANK        : std_logic;
        CE_PIXEL            : std_logic;                        -- Clock enable
        CLK_VIDEO           : std_logic;                        -- Video Clock
        VGA_DE              : std_logic;                        -- = ~(VBlank or HBlank)
        VGA_F1              : std_logic;                        -- Not used in M2M framework
        VGA_SL              : std_logic_vector(1 downto 0);     -- Not used in M2M
        VGA_SCALER          : std_logic;                        -- Not sure if this is used???
        VGA_DISABLE         : std_logic;                        -- analog out is off
        HDMI_FREEZE         : std_logic ;                       -- Not sure is this is used / needed in M2M           
        -- User Config
        io_wait             : std_logic;   
        io_fpga_dout        : std_logic_vector(15 downto 0);    -- Data for Paula
    end record;
    attribute description of OP_TYPE : type is "OUT Ports for AmigaM65 module";
    
    type MINIMIG_SIG_TYPE is record
        chip_dout           : std_logic_vector(15 downto 0);      
        chip_ipl            : std_logic_vector(2 downto 0);
        chip_dtack          : std_logic;  
        cpu_rst             : std_logic;
        ram_data            : std_logic_vector(15 downto 0);        --// sram data bus   
        ram_address         : std_logic_vector(24 downto 1);        --// sram address bus   
        X_ram_bhe           : std_logic;                            --// sram upper byte select        
        X_ram_ble           : std_logic;                            --// sram lower byte select
        X_ram_we            : std_logic;                            --// sram write enable
        X_ram_oe            : std_logic;                            --// sram output enable
        chipDMA             : std_logic;
        chipRW              : std_logic;
        chipU               : std_logic;
        chipL               : std_logic;    
        rst_out             : std_logic;
        xuart_rts           : std_logic;
        xuart_dtr           : std_logic;
        pwr_led             : std_logic;
        ide_c_led           : std_logic;
        hs                  : std_logic;                            -- Horizontal signal
        vs                  : std_logic;                            -- Vertical signal
        R                   : std_logic_vector(7 downto 0);         -- Red Video Signal
        G                   : std_logic_vector(7 downto 0);         -- Green Video Signal
        B                   : std_logic_vector(7 downto 0);         -- Blue Video Signal
        field1              : std_logic;                        -- Not a very descriptive signal name!!!
        lace                : std_logic;
        hblank              : std_logic;
        vbl                 : std_logic;
        ar                  : std_logic_vector(1 downto 0); 
        fx                  : std_logic_vector(2 downto 0);     -- Output from scanline
        res                 : std_logic_vector(1 downto 0);
        ntsc                : std_logic;
        ldata               : std_logic_vector(14 downto 0);        --// left DAC data
        rdata               : std_logic_vector(14 downto 0);        --// right DAC data
        ldata_okk           : std_logic_vector(8 downto 0);         --// left DAC data  (PWM vol version)
        rdata_okk           : std_logic_vector(8 downto 0);         --// right DAC data (PWM vol version)
        toccata_aud_left    : std_logic_vector(15 downto 0);
        toccata_aud_right   : std_logic_vector(15 downto 0);           
        cpucfg              : std_logic_vector(1 downto 0);
        cachecfg            : std_logic_vector(2 downto 0);
        memcfg              : std_logic_vector(6 downto 0);
        bootrom             : std_logic;
        ide_fast            : std_logic;
        ide_ena             : std_logic;
        ide_c_req           : std_logic_vector(5 downto 0);
        ide_c_readdata      : std_logic_vector(15 downto 0);
    end record;
    attribute description of MINIMIG_SIG_TYPE : type is "Output signals from MiniMig Entity";
    
    type JOY_MOUSE_KEYBOARD_TYPE is record
      -- Note: May not need these as they are input port signals for the module. 
     JOY0             : std_logic_vector(15 downto 0);
     JOY1             : std_logic_vector(15 downto 0);         
     JOY2             : std_logic_vector(15 downto 0);                          
     JOY3             : std_logic_vector(15 downto 0);
     JOYA0            : std_logic_vector(15 downto 0);
     JOYA1            : std_logic_vector(15 downto 0);
     X_joy1           : std_logic_vector(15 downto 0);
     X_joy2           : std_logic_vector(15 downto 0);
     X_joy3           : std_logic_vector(15 downto 0);
     X_joy4           : std_logic_vector(15 downto 0);
     kbd_mouse_level  : std_logic;
--     kbd_mouse_data   : std_logic_vector(7 downto 0);
--     kbd_mouse_type   : std_logic_vector(1 downto 0);
     mouse_buttons    : std_logic_vector(2 downto 0);          
    end record;
    attribute description of JOY_MOUSE_KEYBOARD_TYPE : type is "Signals for Joystick, Mouse and Keyboard";

    type CPU_WRAPPER_TYPE is record
        cpu_nrst_out        : std_logic;
        chip_addr           : std_logic_vector(23 downto 1);
        chip_din            : std_logic_vector(15 downto 0);
        chip_as             : std_logic;
        chip_uds            : std_logic;
        chip_lds            : std_logic;
        chip_rw             : std_logic;
        fastchip_sel        : std_logic;
        fastchip_lds        : std_logic;
        fastchip_uds        : std_logic;
        fastchip_rnw        : std_logic;
        fastchip_lw         : std_logic;
        ram_sel             : std_logic;
        ram_addr            : std_logic_vector(28 downto 1);
        ram_din             : std_logic_vector(15 downto 0);
        ram_lds             : std_logic;
        ram_uds             : std_logic;
        ramshared           : std_logic;
        toccata_ena         : std_logic;
        toccata_base        : std_logic_vector(7 downto 0);
        cpu_state           : std_logic_vector(1 downto 0);
        cpu_cacr            : std_logic_vector(3 downto 0);
        cpu_nmi_addr        : std_logic_vector(31 downto 0);                       
    end record;
    attribute description of CPU_WRAPPER_TYPE : type is "Outputs from CPU Wrapper entity";    

    type FASTCHIP_TYPE is record
        fastchip_selack         : std_logic;
        fastchip_ready          : std_logic;
        fastchip_dout           : std_logic_vector(15 downto 0);
        fb_en                   : std_logic;
        fb_width                : std_logic_vector(11 downto 0);
        fb_height               : std_logic_vector(11 downto 0);
        fb_format               : std_logic_vector(4 downto 0);
        fb_base                 : std_logic_vector(31 downto 0);
        fb_stride               : std_logic_vector(13 downto 0);
        fb_pal_clk              : std_logic;
        fb_pal_dout             : std_logic_vector(23 downto 0);
        fb_pal_addr             : std_logic_vector(7 downto 0);
        fb_pal_wr               : std_logic;
        ide_f_irq               : std_logic;
        ide_f_req               : std_logic_vector(5 downto 0);
        ide_f_readdata          : std_logic_vector(15 downto 0);
        ide_f_led               : std_logic;                
    end record;
    attribute description of FASTCHIP_TYPE : type is "Outputs from FastChip Entity";

    type VIDEO_MIXER_TYPE is record
        ce_pixel    : std_logic;
        vga_r       : std_logic_vector(7 downto 0);
        vga_g       : std_logic_vector(7 downto 0);
        vga_b       : std_logic_vector(7 downto 0);
        vga_hs      : std_logic;
        vga_vs      : std_logic;
        vga_de      : std_logic;        
    end record;
    attribute description of VIDEO_MIXER_TYPE : type is "Outputs from Video Mixer Entity";
    
    type HSVS_TIMING_TYPE is record
        shbl        : std_logic;
        fhbl        : std_logic;
        hde         : std_logic;
        svbl        : std_logic;
        fvbl        : std_logic;                
    end record;
    attribute description of HSVS_TIMING_TYPE : type is "Outputs frm HSVS Timing Entity";           

    type AUDIO_TYPE is record
        -- IIR Filters
        lpf4400_l       : std_logic_vector(15 downto 0);
        lpf4400_r       : std_logic_vector(15 downto 0);
        lpf3275_l       : std_logic_vector(15 downto 0);        
        lpf3275_r       : std_logic_vector(15 downto 0);
        aud_l           : std_logic_vector(15 downto 0);
        aud_r           : std_logic_vector(15 downto 0);
        
        -- CDDA
        cdda_req        : std_logic;
        audio_ce        : std_logic;
        cdda_l          : std_logic_vector(15 downto 0); 
        cdda_r          : std_logic_vector(15 downto 0); 
        
        -- Combined Audio
        audio_s           : std_logic;
        audio_l           : std_logic_vector(15 downto 0);
        audio_r           : std_logic_vector(15 downto 0);   
        
    end record;
    attribute description of AUDIO_TYPE : type is "Pins for Amiga Audio Filters";             

    type AMIGA_CLK_TYPE is record
         clk7_en          : std_logic;
         clk7n_en         : std_logic;
         c1               : std_logic;
         c3               : std_logic;
         cck              : std_logic;
         eclk             : std_logic_vector(9 downto 0);            
    end record;
    attribute description of AMIGA_CLK_TYPE : type is "Output Amiga clock signals";

    type RAM_CTRL_TYPE is record
        ramdata_in      : std_logic_vector(15 downto 0);
        chip48          : std_logic_vector(47 downto 0);   
    end record;    

end package;