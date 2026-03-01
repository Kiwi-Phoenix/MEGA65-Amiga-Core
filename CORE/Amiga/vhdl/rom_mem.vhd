-- Testing the loading of an AMiga ROM directly into memory.
-- The purpose of this module is to instantiate some memory for hold the Amiga ROM contents
-- so that is can be loaded to the Amiga Core.
-- Pre-load it with the Amiga boot-strap.
-- This will be over-written from M2M if / when the ROM is sourced from there.
--
-- TBC: Whether I can load the ROM file direct from M2M to the Core instead of using this "staging" memeory.
-- The potential problem in doing that is for the Amiga Forever encrypted ROMS.  Need a space to be able to 
-- decrypt as we go.  Need to look into this some a lot more as for options in doing this.
--
-- July 2025    David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;

library xpm;
use xpm.vcomponents.all;



entity rom_mem is
    generic (   
        ADDR_WIDTH      : integer := 24;            
        DATA_WIDTH      : integer := 16;                -- 256KB * 16-bit ROM
        ROM_DEPTH       : integer := 4102;
        INIT_FILE_NAME  : string  := "AA_Sim_Boot.mem"
    );
    port (
        clk     : in  std_logic;
        rst_n   : in  std_logic;
        core_addr   : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
--        core_din    : in  std_logic_vector(15 downto 0);                
        core_data   : out std_logic_vector(DATA_WIDTH-1 downto 0)       
    );

end entity rom_mem;

architecture RTL of rom_mem is


begin

rom_mem_inst : xpm_memory_sprom
    generic map (
        MEMORY_SIZE         => ROM_DEPTH * DATA_WIDTH   -- Words x data_width to get the number of bits for mem size         
       ,MEMORY_PRIMITIVE    => "auto"
       ,READ_DATA_WIDTH_A   => DATA_WIDTH
       ,ADDR_WIDTH_A        => ADDR_WIDTH
       ,MEMORY_INIT_FILE    => INIT_FILE_NAME
       ,MEMORY_INIT_PARAM   => ""
       ,USE_MEM_INIT        => 1
       ,WAKEUP_TIME         => "disable_sleep"
       ,READ_LATENCY_A      => 0
    )
    port map (
        clka            => clk
       ,rsta            => rst_n
       ,ena             => '1'
       ,addra           => core_addr
       ,douta           => core_data
       ,sleep           => '0'
       ,regcea          => '1'
       ,injectdbiterra  => '0'
       ,injectsbiterra  => '0'       
    );
      

end architecture RTL;
