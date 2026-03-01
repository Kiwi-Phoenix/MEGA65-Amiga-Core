-- Port of the userio.v module from the MiniMig CORE
-- // Copyright 2006, 2007 Dennis van Weeren        
--
-- Preserving the logic and breaking the always blocks up into separate modules to help with debugging and understanding of the process.
--
-- July 2025    David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Amiga_Globals.all;
use work.Amiga_Debug_pkg.all;

entity userio is
    port (
        clk             : in  std_logic;                                -- bus clock
        reset           : in  std_logic;                                -- reset
        clk7_en         : in  std_logic;
        reg_address_in  : in  std_logic_vector(8 downto 1);             -- register adress inputs
        data_in         : in  std_logic_vector(15 downto 0);            -- bus data in
        data_out        : out std_logic_vector(15 downto 0);            -- bus data out
        pot_cnt_en      : in  std_logic;                                -- one count / scanline
        x_fire0         : out std_logic;                                -- joystick 0 fire output (to CIA)
        x_fire1         : out std_logic;                                -- joystick 1 fire output (to CIA)
        x_fire0_dat     : in  std_logic;
        x_fire1_dat     : in  std_logic;
        x_joy1          : in  std_logic_vector(15 downto 0);            -- joystick 1 in (default mouse port)
        x_joy2          : in  std_logic_vector(15 downto 0);            -- joystick 2 in (default joystick port)
        joy_ana1        : in  std_logic_vector(15 downto 0);
        joy_ana2        : in  std_logic_vector(15 downto 0);
        mouse_btn       : in  std_logic_vector(2 downto 0);
        kms_level       : in  std_logic;
        kbd_mouse_type  : in  std_logic_vector(1 downto 0);
        kbd_mouse_data  : in  std_logic_vector(7 downto 0);
        aud_mix         : out std_logic_vector(1 downto 0);
        IO_ENA          : in  std_logic;
        IO_STROBE       : in  std_logic;
        IO_WAIT         : out std_logic;
        IO_DIN          : in  std_logic_vector(15 downto 0);
        memory_config   : out std_logic_vector(7 downto 0);
        chipset_config  : out std_logic_vector(4 downto 0);
        floppy_config   : out std_logic_vector(3 downto 0);
        scanline        : out std_logic_vector(2 downto 0);
        ar              : out std_logic_vector(1 downto 0);
        blver           : out std_logic_vector(1 downto 0);
        ide_config      : out std_logic_vector(5 downto 0);
        cpu_config      : out std_logic_vector(1 downto 0);
        cache_config    : out std_logic_vector(2 downto 0);
        bootrom         : out std_logic := '0';                         -- do the A1000 bootrom magic in gary.v
        usrrst          : out std_logic;                                -- user reset from osd module
        cpurst          : out std_logic;
        cpuhlt          : out std_logic;
        -- host
        host_cs         : out std_logic;
        host_adr        : out std_logic_vector(23 downto 0);
        host_we         : out std_logic;
        host_bs         : out std_logic_vector(1 downto 0);
        host_wdat       : out std_logic_vector(15 downto 0);
        host_rdat       : in  std_logic_vector(15 downto 0);
        host_ack        : in  std_logic                    
    );
end entity;


architecture RTL of userio is
-- Set up Debug
-- Note: requires the constamt DEBUG which is set int eh Amiga_Globals package.
attribute DONT_TOUCH    : string;
subtype t_string1 is string(1 to 4);
type t_dont_touch_array is array(boolean) of t_string1;
constant c_dont_touch : t_dont_touch_array := (false => "    ", true => "TRUE");

attribute DONT_TOUCH of potgo_inst       : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of cd32pad_inst     : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of joy_inst         : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of mouse_inst       : label is c_dont_touch(DEBUG);
attribute DONT_TOUCH of config_inst      : label is c_dont_touch(DEBUG);


-- Setup the registers and addresses
subtype addr9 is unsigned(8 downto 0);
subtype code8 is unsigned(7 downto 0);

-- 9-bit regiser addresses
constant JOY0DAT    : addr9 := to_unsigned(16#00A#, 9);
constant JOY1DAT    : addr9 := to_unsigned(16#00C#, 9);
constant SCRDAT     : addr9 := to_unsigned(16#1F0#, 9);
constant POT0DAT    : addr9 := to_unsigned(16#012#, 9);
constant POT1DAT    : addr9 := to_unsigned(16#014#, 9);
constant POTINP     : addr9 := to_unsigned(16#016#, 9);
constant POTGO      : addr9 := to_unsigned(16#034#, 9);
constant JOYTEST    : addr9 := to_unsigned(16#036#, 9);

-- 8-bit key codes
-- Note: could no see where these are used !!!
constant KEY_MENU   : code8 := to_unsigned(16#69#, 8);
constant KEY_ASC    : code8 := to_unsigned(16#45#, 8);
constant KEY_ENTER  : code8 := to_unsigned(16#44#, 8);
constant KEY_UP     : code8 := to_unsigned(16#4C#, 8);
constant KEY_DOWN   : code8 := to_unsigned(16#4D#, 8);
constant KEY_LEFT   : code8 := to_unsigned(16#4F#, 8);
constant KEY_RIGHT  : code8 := to_unsigned(16#4E#, 8);
constant KEY_PGUP   : code8 := to_unsigned(16#6C#, 8);
constant KEY_PGDOWN : code8 := to_unsigned(16#6D#, 8);    


-- Local signals
signal x_sjoy1      : std_logic_vector(15 downto 0);    -- synchronized joystick 1 signals
signal x_djoy1      : std_logic_vector(15 downto 0);    -- synchronized joystick 1 signals
signal x_sjoy2      : std_logic_vector(15 downto 0);    -- synchronized joystick 2 signals
signal x_djoy2      : std_logic_vector(15 downto 0);    -- synchronized joystick 2 signals
signal potreg       : std_logic_vector(15 downto 0);    -- POTGO write
--signal mouse0dat    : std_logic_vector(15 downto 0);    -- mouse counters
--signal dmouse0dat   : std_logic_vector(15 downto 0);    -- docking mouse counters
--signal dmouse1dat   : std_logic_vector(15 downto 0);    -- docking mouse counters
--signal mouse0scr    : std_logic_vector(7 downto 0);
signal mouse0dat    : unsigned(15 downto 0);    -- mouse counters
signal dmouse0dat   : unsigned(15 downto 0);    -- docking mouse counters
signal dmouse1dat   : unsigned(15 downto 0);    -- docking mouse counters
signal mouse0scr    : unsigned(7 downto 0);
signal x_mleft      : std_logic;                        -- left mouse button
signal x_mthird     : std_logic;                        -- middle mouse button     
signal x_mright     : std_logic;                        -- right mouse buttons
signal joy1enable   : std_logic;                        -- joystick 1 enable (mouse/joy switch)
signal test_load    : std_logic;                        -- load test value to mouse counter
signal test_data    : std_logic_vector(15 downto 0);    -- mouse counter test value
signal cd32pad      : std_logic;
signal joy_swap     : std_logic;

signal cd32pad1_reg : std_logic_vector(7 downto 0);
signal cd32pad2_reg : std_logic_vector(7 downto 0);
--signal potcap       : std_logic_vector(3 downto 0);
signal joy1_pin5    : std_logic;
signal joy2_pin5    : std_logic;
signal joy_ana_en   : std_logic;
signal fire1_d      : std_logic;
signal fire2_d      : std_logic;
--signal pot0x, pot0y, pot1x, pot1y        : std_logic_vector(7 downto 0);
signal pot0x, pot0y, pot1x, pot1y        : unsigned(7 downto 0);
signal potcap       : unsigned(3 downto 0);

signal data_out_x   : unsigned(15 downto 0);
signal reg_address_in_x : unsigned(8 downto 1);




-- Aliases to short the code
alias addr  is reg_address_in_x(8 downto 1);
alias J0    is JOY0DAT(8 downto 1);
alias J1    is JOY1DAT(8 downto 1);
alias SC    is SCRDAT (8 downto 1);
alias P0    is POT0DAT(8 downto 1);
alias P1    is POT1DAT(8 downto 1);
alias PI    is POTINP (8 downto 1);

begin
-- Concurrent Assignments


--  x_fire0 <= fire1_d
--             when (cd32pad = '1' and cd32pad1_reg_load = '0')
--           else (x_sjoy1(4) and x_mleft);
  x_fire0 <= fire1_d
             when (cd32pad = '1' and joy1_pin5 = '0')
           else (x_sjoy1(4) and x_mleft);

--  x_fire1 <= fire2_d
--             when (cd32pad = '1' and cd32pad2_reg_load = '0')
--           else x_sjoy2(4);
  x_fire1 <= fire2_d
             when (cd32pad = '1' and joy2_pin5 = '0')
           else x_sjoy2(4);

--  test_load <= '1'
--                 when reg_address_in(8 downto 1) = JOYTEST(8 downto 1)
--               else '0';
  test_load <= '1'
                 when to_integer(unsigned(reg_address_in(8 downto 1))) = JOYTEST
               else '0';

  test_data <= data_in;

reg_address_in_x  <= unsigned(reg_address_in);
data_out          <= std_logic_vector(data_out_x);

-- Concurrent statement for data_out instead of using a process.
data_out_x <= 
    -- port 1 joystick
    ( mouse0dat(15 downto 10) + dmouse0dat(15 downto 10) ) &
      dmouse0dat(9 downto 8) &
    ( mouse0dat(7 downto 2) + dmouse0dat(7 downto 2) ) &
      dmouse0dat(1 downto 0)
    when (addr = J0) and (joy1enable = '1') else
    
    -- port 1 mouse
    ( mouse0dat(15 downto 8) + dmouse0dat(15 downto 8) ) &
    ( mouse0dat(7 downto 0) + dmouse0dat(7 downto 0) )       
    when addr = J0 else
    
    -- port 2 joystick
    dmouse1dat
    when addr = J1 else
    
    -- pot0 XY
    pot0y & pot0x
    when addr = P0 else
    
    -- pot1 XY
    pot1y & pot1x
    when addr = P1 else
    
    -- extra buttons
    (
        "0" & potcap(3) &
        "0" & potcap(2) &
        "0" & potcap(1) &
        "0" & potcap(0) &
        x"00"
    )
    when addr = PI else
    
    -- scroll
    unsigned(x"00" & mouse0scr)
    when addr = SC else
    
    -- default
    (others => '0')
    ;
    
     


--data_out_mux : process(all)
--  begin
--    if to_integer(unsigned(reg_address_in(8 downto 1))) = JOY0DAT and joy1enable = '1' then
--      data_out <=
--        std_logic_vector(
--        (unsigned(mouse0dat(15 downto 10))
--         + unsigned(dmouse0dat(15 downto 10)))
--         ) &  
--           dmouse0dat(9 downto 8) &
--        std_logic_vector(
--        (unsigned(mouse0dat(7 downto 2 ))
--         + unsigned(dmouse0dat(7 downto 2 ))) 
--        ) &   
--        dmouse0dat(1 downto 0); 

--    elsif to_integer(unsigned(reg_address_in(8 downto 1))) = JOY0DAT then
--      data_out <=
--        std_logic_vector(
--        (unsigned(mouse0dat(15 downto 8)) 
--        + unsigned(dmouse0dat(15 downto 8)))
--        ) &
--        std_logic_vector(
--        (unsigned(mouse0dat(7 downto 0)) + unsigned(dmouse0dat(7 downto 0)))
--        );      

--    elsif to_integer(unsigned(reg_address_in(8 downto 1))) = JOY1DAT then
--      data_out <= dmouse1dat;

--    elsif to_integer(unsigned(reg_address_in(8 downto 1))) = POT0DAT then
--      data_out <= pot0y & pot0x;

--    elsif to_integer(unsigned(reg_address_in(8 downto 1))) = POT1DAT then
--      data_out <= pot1y & pot1x;

--    elsif to_integer(unsigned(reg_address_in(8 downto 1))) = POTINP then
--      data_out <=
--        "0" & potcap(3) &
--        "0" & potcap(2) &
--        "0" & potcap(1) &
--        "0" & potcap(0) &
--        x"00";  -- lower byte = 0

--    elsif to_integer(unsigned(reg_address_in(8 downto 1))) = SCRDAT then
--      data_out <= x"00" & mouse0scr;

--    else
--      data_out <= (others => '0');
--    end if;
--  end process data_out_mux;


potgo_inst : entity work.userio_potgo
    port map (
        clk             => clk
       ,clk7_en         => clk7_en
       ,reset           => reset
       ,POTGO           => POTGO
       ,data_in         => data_in
       ,reg_address_in  => reg_address_in
       ,joy_swap        => joy_swap
       ,pot_cnt_en      => pot_cnt_en
       ,x_djoy1         => x_djoy1
       ,x_djoy2         => x_djoy2
       ,x_mright        => x_mright
       ,x_mthird        => x_mthird
       ,cd32pad         => cd32pad
       ,potreg          => potreg
       ,joy_ana1        => joy_ana1
       ,joy_ana2        => joy_ana2
       ,joy1enable      => joy1enable
       ,cd32pad1_reg    => cd32pad1_reg
       ,cd32pad2_reg    => cd32pad2_reg
       ,potcap          => potcap     
       ,joy1_pin        => joy1_pin5
       ,joy2_pin        => joy2_pin5  
       ,joy_ana_en      => joy_ana_en
       ,pot0x_x         => pot0x
       ,pot1x_x         => pot1x
       ,pot0y_x         => pot0y
       ,pot1y_x         => pot1y
    );
    
cd32pad_inst : entity work.userio_cd32pad
    port map (
        clk             => clk
       ,reset           => reset
       ,x_fire0_dat     => x_fire0_dat
       ,x_fire1_dat     => x_fire1_dat
       ,joy1_pin5       => joy1_pin5
       ,joy2_pin5       => joy2_pin5
       ,x_djoy1         => x_djoy1
       ,x_djoy2         => x_djoy2
       ,fire1_dx        => fire1_d
       ,fire2_dx        => fire2_d            
       ,cd32pad1_reg    => cd32pad1_reg
       ,cd32pad2_reg    => cd32pad2_reg
    );
        
    
joy_inst : entity work.userio_joy
    port map (
        clk             => clk
       ,reset           => reset
       ,clk7_en         => clk7_en
       ,x_joy1          => x_joy1
       ,x_joy2          => x_joy2
       ,joy_ana_en      => joy_ana_en
       ,joy_swap        => joy_swap
       ,test_load       => test_load
       ,test_data       => test_data
       ,x_mleft         => x_mleft
       ,joy1enable      => joy1enable
       ,x_sjoy1         => x_sjoy1
       ,x_djoy1         => x_djoy1
       ,x_sjoy2         => x_sjoy2
       ,x_djoy2         => x_djoy2
       ,dmouse0dat      => dmouse0dat
       ,dmouse1dat  => dmouse1dat       
    );    

mouse_inst : entity work.userio_mouse
    port map (
        clk                 => clk
       ,clk7_en             => clk7_en
       ,reset               => reset
       ,test_load           => test_load
       ,test_data           => test_data
       ,kms_level           => kms_level
       ,kbd_mouse_data      => kbd_mouse_data
       ,kbd_mouse_type      => kbd_mouse_type
       ,mouse_btn           => mouse_btn
       ,mouse0dat           => mouse0dat
       ,x_mleft             => x_mleft
       ,x_mright            => x_mright 
       ,x_mthird            => x_mthird
    );
    
config_inst : entity work.userio_config
    port map (
        clk                 => clk
       ,clk7_en             => clk7_en
       ,reset               => reset
       ,IO_ENA              => IO_ENA
       ,IO_STROBE           => IO_STROBE
       ,IO_WAIT             => IO_WAIT
       ,IO_DIN              => IO_DIN
       ,host_ack            => host_ack
       ,host_adr            => host_adr
       ,host_wdat           => host_wdat
       ,bootrom             => bootrom
       ,host_cs             => host_cs
       ,memory_config       => memory_config
       ,chipset_config      => chipset_config
       ,ide_config          => ide_config
       ,cpu_config          => cpu_config
       ,cache_config        => cache_config
       ,usrrst              => usrrst 
       ,cpurst              => cpurst
       ,scanline            => scanline
       ,ar                  => ar
       ,blver               => blver
       ,floppy_config       => floppy_config
       ,cd32pad             => cd32pad
       ,joy_swap            => joy_swap
       ,joy_ana_en          => joy_ana_en
       ,aud_mix             => aud_mix                          
    );    


end architecture RTL; 