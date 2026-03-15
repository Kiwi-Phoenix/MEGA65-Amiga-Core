-- Drop in replacement for the DPRAM module used by GAYLE for the IDE.
--
--
-- February 2026        David Raynor (kiwi)
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xpm;
use xpm.vcomponents.all;

entity dpram is
  generic (
    addr_width    : integer := 8;
    data_width    : integer := 8;
    mem_init_file : string  := "none"
  );
  port (
    clock    : in  std_logic;

    address_a : in  std_logic_vector(addr_width-1 downto 0);
    data_a    : in  std_logic_vector(data_width-1 downto 0) := (others => '0');
    enable_a  : in  std_logic := '1';
    wren_a    : in  std_logic := '0';
    q_a       : out std_logic_vector(data_width-1 downto 0);
    cs_a      : in  std_logic := '1';

    address_b : in  std_logic_vector(addr_width-1 downto 0) := (others => '0');
    data_b    : in  std_logic_vector(data_width-1 downto 0) := (others => '0');
    enable_b  : in  std_logic := '1';
    wren_b    : in  std_logic := '0';
    q_b       : out std_logic_vector(data_width-1 downto 0);
    cs_b      : in  std_logic := '1'
  );
end entity;

architecture rtl of dpram is

  constant DEPTH      : integer := 2**addr_width;
  constant MEM_SIZE   : integer := DEPTH * data_width;

  signal dout_a_i : std_logic_vector(data_width-1 downto 0);
  signal dout_b_i : std_logic_vector(data_width-1 downto 0);
  signal ena      : std_logic;
  signal enb      : std_logic;
  signal wea      : std_logic_vector(0 downto 0);
  signal web      : std_logic_vector(0 downto 0);


begin

  -- emulate old cs_* behaviour: drive '1' when chip not selected
  q_a <= dout_a_i when cs_a = '1' else (others => '1');
  q_b <= dout_b_i when cs_b = '1' else (others => '1');
  ena <= enable_a and cs_a;
  enb <= enable_b and cs_b;
  wea <= (others => wren_a and cs_a);
  web <= (others => wren_b and cs_b);

  ram_i : xpm_memory_tdpram
    generic map (
       MEMORY_SIZE        => MEM_SIZE
      ,MEMORY_PRIMITIVE   => "auto"
      ,CLOCKING_MODE      => "common_clock"
      ,MEMORY_INIT_FILE   => mem_init_file
      ,MEMORY_INIT_PARAM  => ""
      ,USE_MEM_INIT       => 0
      ,WAKEUP_TIME        => "disable_sleep"
      ,MESSAGE_CONTROL    => 0

      ,WRITE_DATA_WIDTH_A => data_width
      ,READ_DATA_WIDTH_A  => data_width
      ,BYTE_WRITE_WIDTH_A => data_width
      ,ADDR_WIDTH_A       => addr_width

      ,WRITE_DATA_WIDTH_B => data_width
      ,READ_DATA_WIDTH_B  => data_width
      ,BYTE_WRITE_WIDTH_B => data_width
      ,ADDR_WIDTH_B       => addr_width

      ,READ_LATENCY_A     => 1
      ,READ_LATENCY_B     => 1
      ,WRITE_MODE_A       => "read_first"
      ,WRITE_MODE_B       => "read_first"
    )
    port map (
       clka   => clock
      ,clkb   => clock

      ,addra  => address_a
      ,dina   => data_a
      --,ena    => enable_a and cs_a
      ,ena    => ena
      --,wea    => (others => wren_a and cs_a)
      ,wea    => wea
      ,douta  => dout_a_i

      ,addrb  => address_b
      ,dinb   => data_b
      --,enb    => enable_b and cs_b
      ,enb    => enb
      --,web    => (others => wren_b and cs_b)
      ,web    => web
      ,doutb  => dout_b_i

      ,rsta   => '0'
      ,rstb   => '0'
      ,regcea => '1'
      ,regceb => '1'
      ,sleep  => '0'
      ,injectsbiterra   => '0'
      ,injectsbiterrb   => '0'
      ,injectdbiterra   => '0'
      ,injectdbiterrb   => '0'  
    );

end architecture;