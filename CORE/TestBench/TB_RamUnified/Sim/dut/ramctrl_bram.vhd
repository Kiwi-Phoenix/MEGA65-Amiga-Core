-- RAM Controller BRAM
-- BRAM that is used with the Amiga Core RAM Controller.
--
-- January 2026     David Raynor (Kiwi)
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library xpm;
use xpm.vcomponents.all;

entity ramctrl_bram is
    generic (
        WORD_ADDR_W         : integer := 20;
        READ_LATENCY        : integer := 1;
        DATA_WIDTH          : integer := 16;
        BYTE_WRITE_WIDTH    : integer := 8;  -- 2 bytes per 16-bit word 
        MEMORY_SIZE_BITS    : integer := 256 * 1024 * 8;  -- 256kb        
        MEMORY_FILE         : string := "none";
        MEMORY_INIT_PARM    : string := ""              
    );
    port (
        sysclk      : in std_logic;
        -- Port A:
        ena         : in std_logic;
        wea         : in std_logic_vector(1 downto 0);  -- Should calc this
        addra       : in std_logic_vector(WORD_ADDR_W-1 downto 0);
        dina        : in std_logic_vector(DATA_WIDTH-1 downto 0);
        douta       : out std_logic_vector(DATA_WIDTH-1 downto 0);
        -- Port B:
        enb         : in std_logic;
        web         : in std_logic_vector(1 downto 0);  -- Should calc this
        addrb       : in std_logic_vector(WORD_ADDR_W-1 downto 0);
        dinb        : in std_logic_vector(DATA_WIDTH-1 downto 0);
        doutb       : out std_logic_vector(DATA_WIDTH-1 downto 0)               
    );


end entity;

architecture RTL of ramctrl_bram is

begin
ram_inst : xpm_memory_tdpram
    generic map (
         MEMORY_SIZE        => MEMORY_SIZE_BITS
        ,MEMORY_PRIMITIVE   => "auto"
        ,CLOCKING_MODE      => "common_clock"
        ,WAKEUP_TIME        => "disable_sleep"
        ,ECC_MODE           => "no_ecc"
        ,MEMORY_INIT_FILE   => MEMORY_FILE
        ,MEMORY_INIT_PARAM  => MEMORY_INIT_PARM  
        ,USE_MEM_INIT       => 0
        
        ,ADDR_WIDTH_A       => WORD_ADDR_W
        ,ADDR_WIDTH_B       => WORD_ADDR_W
        
        ,WRITE_DATA_WIDTH_A => DATA_WIDTH
        ,WRITE_DATA_WIDTH_B => DATA_WIDTH
        ,READ_DATA_WIDTH_A  => DATA_WIDTH
        ,READ_DATA_WIDTH_B  => DATA_WIDTH
        
        ,BYTE_WRITE_WIDTH_A => BYTE_WRITE_WIDTH
        ,BYTE_WRITE_WIDTH_B => BYTE_WRITE_WIDTH
                
        ,READ_LATENCY_A     => READ_LATENCY
        ,READ_LATENCY_B     => READ_LATENCY
        ,WRITE_MODE_A       => "write_first"        
        ,WRITE_MODE_B       => "read_first"        
                
    )
    port map (
         -- Port A: writes
         clka             => sysclk
        ,ena              => ena
        ,wea              => wea
        ,addra            => addra
        ,dina             => dina
        ,douta            => douta        
       
         -- Port B: reads
        ,clkb             => sysclk
        ,enb              => enb
        ,web              => web
        ,addrb            => addrb
        ,dinb             => dinb
        ,doutb            => doutb
                 
        ,sleep            => '0'
        ,rsta             => '0'
        ,rstb             => '0'
        ,regcea           => '1' 
        ,regceb           => '1' 
        ,injectsbiterra   => '0'
        ,injectsbiterrb   => '0'
        ,injectdbiterra   => '0'
        ,injectdbiterrb   => '0'        
    );

end architecture;
