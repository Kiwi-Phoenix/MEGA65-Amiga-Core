-- MEGA65 Amiga CORE Configuration Manager
--
-- Managers sending user configuration to the MiniMig / Amiga Core.
-- Also sends the ROM to the Core using the same configuration process in the Core.
--
-- There are two parts to applying the Configuraitons:
-- 1) User / Core Configurations, e.g. Memory sie, CPU type, ChipSets, etc.
-- 2) Loading the Amiga ROMs.
--
-- Configuraiton is only applied on Reset of the core.
--
--
-- July 2025 - David Raynor (Kiwi)
-- Sept 2025 - Combine config modules, e.g Command Module and ROM Data Module
--
-- TODO: A lot more work is required with regards to configuration!!!!

library ieee;
use ieee.std_logic_1164.all;

library work;
--use work.globals.all;
use work.Amiga_Globals.all;
use work.Amiga_debug_pkg.all;

library xpm;
use xpm.vcomponents.all;


entity Config_manager is
    generic (
        ADDR_WIDTH      : integer := 24;
        DATA_WIDTH      : integer := 16;
        ROM_DEPTH       : integer := 4102;
        INIT_FILE_NAME  : string  := "AA_Sim_Boot.mem"        
    );
    port (
        clk                 : in  std_logic;
        reset_n             : in  std_logic;
--        start_all           : in  std_logic;        -- pulse to begin sequence
        
        -- Config Inputs
        main_osm_control_i  : in  std_logic_vector(255 downto 0);
        
        -- Shared SPI interface
        io_wait             : in  std_logic;
        io_ena              : out std_logic;
        io_strobe           : out std_logic;
        io_din              : out std_logic_vector(15 downto 0);
        
        -- M2M Qnice RAM Interface (readt only) 
--        qnice_dev_id_i      : in  std_logic_vector(15 downto 0);
--        qnice_dev_addr_i    : in  std_logic_vector(27 downto 0);
--        qnice_dev_data_i    : in  std_logic_vector(15 downto 0);
        
        
        cmd_start_o         : out std_logic;
        cmd_done_o          : out std_logic;
        rom_start_o         : out std_logic;
        rom_done_o          : out std_logic;              

        rom_addr            : out std_logic_vector(ADDR_WIDTH-1 downto 0);
--        rom_addr1           : out std_logic_vector(ADDR_WIDTH-1 downto 0);

        host_addr            : out std_logic_vector(ADDR_WIDTH-1 downto 0);
        rom_data            : out std_logic_vector(DATA_WIDTH-1 downto 0);
        state_o             : out integer range 1 to 13;
        dat1                : out std_logic_vector(15 downto 0);
        
        
        config_col          : out std_logic_vector(1 downto 0) := "00";
        done_all            : out std_logic                         
    );
end entity Config_Manager;

architecture RTL of Config_Manager is
--- DJR TEMP signals for testing until I connect the ports up 
signal qnice_dev_id_i      : std_logic_vector(15 downto 0);
signal qnice_dev_addr_i    : std_logic_vector(27 downto 0);
--signal qnice_dev_addr_i    : std_logic_vector(15 downto 0);
signal qnice_dev_data_i    : std_logic_vector(15 downto 0);

type OP_REC_TYPE is record
    cmd_start    : std_logic;
    cmd_done     : std_logic;
    rom_start    : std_logic;
    rom_done     : std_logic;
end record;

signal op   : OP_REC_TYPE;  


    -- Debugging setup, Compile attributes.
    attribute DONT_TOUCH : string;
    subtype t_string1 is string(1 to 4);
    type t_dont_touch_array is array(boolean) of t_string1;
    constant c_dont_touch : t_dont_touch_array := (false => "    ", true => "TRUE");

    attribute DONT_TOUCH of Config_CORE    : label is c_dont_touch(DEBUG);
--    attribute DONT_TOUCH of KS_ROM         : label is c_dont_touch(DEBUG);
    

      
    --- Overrides -----------------------------------------------------------------------------------------
    -- For testing purposes we can over ride the incoming M2M OSM Configurations.
    -- Re-point the signal when no longer need to override.
   -- OSM Signals to apply over-rides.  Useful for testing purposes.   
    signal main_osm_control0 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control1 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control2 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control3 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control4 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control5 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control6 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control7 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control8 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_control9 : std_logic_vector(7 downto 0) := (others => '0');
    signal main_osm_controla : std_logic_vector(255 downto 80) := (others => '0');
    -- OSM Control Signal
    signal main_osm_control     : std_logic_vector(255 downto 0);        
        
-- FSM States
type state_t is (
    IDLE
   ,START_CMD
   ,WAIT_CMD
   ,START_ROM
   ,WAIT_ROM
   ,DONE
); 

signal state        : state_t := IDLE;
signal start_pulse  : std_logic;        -- helper to generate one-cycle pulses

signal finished     : std_logic;    

   
     
signal io_ena_cm       : std_logic;
signal io_ena_ks       : std_logic;
signal io_strobe_cm    : std_logic;
signal io_strobe_ks    : std_logic;
signal io_din_cm       : std_logic_vector(15 downto 0);
signal io_din_ks       : std_logic_vector(15 downto 0);

signal rom_addr2 : std_logic_vector(23 downto 0);

begin

-- Map to OUT Ports
cmd_start_o <= op.cmd_start;
cmd_done_o  <= op.cmd_done;
rom_start_o <= op.rom_start;
rom_done_o  <= op.rom_done;    

rom_addr <= qnice_dev_addr_i(23 downto 0);
rom_data <= qnice_dev_data_i;
--rom_addr1 <= rom_addr2;

io_ena      <= io_ena_cm    or io_ena_ks;
io_strobe   <= io_strobe_cm or io_strobe_ks;
io_din      <= io_din_cm    or io_din_ks;




-- 0); // A_A_A_A B,B,... || write system memory, A - 32 bit memory address, B - variable number of bytes
-- 1); // XXXXHRBC || reset control   | H - CPU halt, R - reset, B - reset to bootloader, C - reset control block
-- 2);
-- 3); // XXXGEANT || chipset config  | G - AGA, E - ECS, A - OCS A1000, N - NTSC, T - turbo
-- 4); // XXXXKCTT || cpu config      | K - fast kickstart enable, C - CPU cache enable, TT - CPU type (00=68k, 01=68k10, 10=68k20)
-- 5); // XHFFSSCC || memory config   | H - HRTmon, FF - fast, SS - slow, CC - chip
-- 6); // DDHHLLSS || video config    | DD - dither, HH - hires interp. filter, LL - lowres interp. filter, SS - scanline mode
-- 7); // XXXXXFFS || floppy config   | FF - drive number, S - floppy speed
-- 8); // XXXXXSMC || harddisk config | S - enable slave HDD, M - enable master HDD, C - enable HDD controler
-- 9); // XXXXSMMX || joystick config | S - swap joysticks, MM - dig/analog/cd32
-- M2M OSM Control
-- Apply some overrides if required.  Otherwise comment them out.
-- Useful to development / testing purposes.
    main_osm_control0  <= "00000000";         -- Memory Write
    main_osm_control1  <= "00000000";         -- reset_ctrl_sel
    main_osm_control2  <= "00000001";         -- Aud_sel

    main_osm_control3  <= "00000100";         -- chip_cfg_sel - OCS
--    main_osm_control3  <= "00001000";         -- chip_cfg_sel - ECS    
--    main_osm_control3  <= "00010000";         -- chip_cfg_sel - AGA

--    main_osm_control4  <= "00000000";         -- cpu_cfg_sel - 68000
    main_osm_control4  <= "00000100";         -- cpu_cfg_sel - 68000 - Enable CPU Cache
--    main_osm_control4  <= "00000010";         -- cpu_cfg_sel - 68020
--    main_osm_control4  <= "00000001";         -- cpu_cfg_sel - 68000 + fast kickstart

    main_osm_control5  <= "01000011";         -- memory_cfg_sel - chip
--    main_osm_control5  <= "00001111";         -- memory_cfg_sel - slow + chip
--    main_osm_control5  <= "01001111";         -- memory_cfg_sel - slow + chip + HRTMon

    main_osm_control6  <= "00001100";         -- video_cfg_sel - low res option
--    main_osm_control6  <= "11001100";         -- video_cfg_sel - low res option + dither  NB: few issues with this option!!!
--    main_osm_control6  <= "11001111";         -- video_cfg_sel - low res option + dither + scanline mode
--    main_osm_control6  <= "00110000";         -- video_cfg_sel    - high res option
--    main_osm_control6  <= "00000000";         -- video_cfg_sel - nothing selected     
--    main_osm_control6  <= "00000011";         -- video_cfg_sel - scanline     

    main_osm_control7  <= "00000010";         -- floppy_cfg_sel
    main_osm_control8  <= "00000011";         -- harddisk_cfg_sel
    main_osm_control9  <= "00000000";         -- joystick_cfg_sel

main_osm_control  <= main_osm_controla 
                    & main_osm_control9
                    & main_osm_control8
                    & main_osm_control7
                    & main_osm_control6
                    & main_osm_control5
                    & main_osm_control4
                    & main_osm_control3
                    & main_osm_control2
                    & main_osm_control1
                    & main_osm_control0                    
            ; 
--main_osm_control <= main_osm_control_i;            



--Cmd_config : process (clk, reset_n)
--begin
--    if reset_n = '0' then
--        state       <= START_CMD;

--    elsif rising_edge(clk) then
--        -- Defaults outputs
--        op.cmd_start   <= '0';
--        op.rom_start   <= '0';
--        finished    <= '0';
        
--        case state is 
        
--        when START_CMD  =>
--            op.cmd_start   <= '1'; 
--            state       <= WAIT_CMD;
        
--        when WAIT_CMD =>
--            if op.cmd_done = '1' then                
--                state <= START_ROM;
--            end if;
        
--        when START_ROM  =>
--            op.rom_start   <= '1';
--            state       <= WAIT_ROM;
        
--        when WAIT_ROM =>
--            if op.rom_done = '1' then
--                state   <= DONE;
--            else
--                STATE   <= WAIT_ROM;
--            end if;
                    
--        when DONE =>
--            finished <= '1';
--            -- stay here until next reset
        
--        when others => state <= START_CMD;
--        end case;                                                                   
--    end if;
--end process;

----------------------------------------------------------------------------------------------------

-- Apply Core configuration
Config_CORE : entity work.M2M_OSM_Config
    port map (
        clk                 => clk
       ,reset_n             => reset_n
       
       ,main_osm_control_i  => main_osm_control
       ,io_wait             => io_wait
       ,io_ena              => io_ena_cm
       ,io_strobe           => io_strobe_cm
       ,io_din              => io_din_cm
       
--       ,start               => op.cmd_start
       ,start               => '1'
       ,done                => op.cmd_done
    );

--------------------------------------------------------------------------------------------------
---- Config the ROM, i.e. load the ROM
--Config_ROM : entity work.config_kickstart
--    port map (
--        clk                 => clk
--       ,reset_n             => reset_n
       
--       ,rom_addr            => qnice_dev_addr_i(23 downto 0)
----       ,rom_addr            => rom_addr2
--       ,host_addr           => host_addr
--       ,rom_dout            => qnice_dev_data_i
--       ,io_ena              => io_ena_ks
--       ,io_strobe           => io_strobe_ks
--       ,io_din              => io_din_ks
--       ,io_wait             => io_wait
       
--       ,state_o             => state_o
--       ,dat1                => dat1
       
--       ,start               => op.rom_start
--       ,done                => op.rom_done                    
--    );

    
------------------------------------------------------------------------------------------------
-- Create a space to store the Kick / boot ROM before it is loaded to the Amiga Core
--    
--KS_ROM : entity work.rom_mem
--    generic map (
--        ADDR_WIDTH  => ADDR_WIDTH
--       ,DATA_WIDTH  => DATA_WIDTH
--       ,INIT_FILE_NAME  => "AA_Sim_Boot.mem"
--    )
--    port map (
--        clk         => clk
--       ,rst_n       => reset_n
--       ,core_addr   => qnice_dev_addr_i(23 downto 0)
----       ,core_addr   => rom_addr2
----       ,core_addr   => rom_addr
--       ,core_data   => qnice_dev_data_i      
--    );


--KS_ROM : xpm_memory_sprom
--    generic map (
--        MEMORY_SIZE         => ROM_DEPTH * DATA_WIDTH   -- Words x data_width to get the number of bits for mem size         
--       ,MEMORY_PRIMITIVE    => "auto"
--       ,READ_DATA_WIDTH_A   => DATA_WIDTH
--       ,ADDR_WIDTH_A        => ADDR_WIDTH
--       ,MEMORY_INIT_FILE    => INIT_FILE_NAME
--       ,MEMORY_INIT_PARAM   => ""
--       ,USE_MEM_INIT        => 1
--       ,WAKEUP_TIME         => "disable_sleep"
--       ,READ_LATENCY_A      => 0

--    )
--    port map (
--        clka            => clk
----       ,rsta            => rst_n
--       ,rsta            => reset_n
--       ,ena             => '1'
----       ,addra           => core_addr
--       ,addra           => qnice_dev_addr_i(23 downto 0)
----       ,douta           => core_data
--       ,douta           => qnice_dev_data_i
--       ,sleep           => '0'
--       ,regcea          => '1'
--       ,injectdbiterra  => '0'
--       ,injectsbiterra  => '0'       
--    );

               
end architecture RTL;
    