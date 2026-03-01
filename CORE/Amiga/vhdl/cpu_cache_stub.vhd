-- This is a "stub" for the cpu cache until a proper working cache can be developed.
-- I had one but it really wasn't working well and cant ship with it.
-- The cpu cache is not required for an A500 configuration Amiga Core as the M680000 does not have a cpu cache.
-- However, will be required for an A1200 config inthe future.
-- On Amigas, the cpu cache is only used on FAST ram.  It is not used by the cpu for using CHIP Ram.
-- FAST ram is exclusive for use by the CPU.  CHIP ram is used by both the Custom CHIP set and the CPU.
--  Using this stub as teh request path is already available in the RAM controller.  The "stub" will simply pass
-- the data / requests thru to the ram controller.  From the ram controller's perspective it will appear
-- as though the request are coming in via the cache when it is active.  Therefore, it shujld break anything
-- from its operational model.
--
-- 25 January 2026      David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu_cache_stub is
port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    
    cache_inhibit   : in std_logic;
    cache_wr_done   : out std_logic;
    cache_enable    : in std_logic;
    cache_write_enable : in std_logic;

    -- CPU → Cache Stub
    cpu_cs     : in  std_logic;
    cpu_adr    : in  std_logic_vector(28 downto 1);
    cpu_bs     : in  std_logic_vector(1 downto 0);
    cpu_we     : in  std_logic;
    cpu_dat_w  : in  std_logic_vector(15 downto 0);
    
    cpu_ir           : in std_logic;
    cpu_dr           : in std_logic;
    
    -- Cache Stub → Controller
    cache_cpuCS      : out std_logic;
    cache_ramAddr    : out std_logic_vector(28 downto 1);
    cache_cpu_we     : out std_logic;
    cache_cpu_bs     : out std_logic_vector(1 downto 0);
    cache_ramdout    : out std_logic_vector(15 downto 0);           -- Send write data to ram controller for write to BRAM

    -- Controller → Cache Stub
    --cache_rsp_valid  : in  std_logic;
    --cache_rsp_data_r : in  std_logic_vector(15 downto 0);

    -- Cache Stub → CPU
    cache_cpu_ack    : out std_logic;
    cpu_dat_r  : out std_logic_vector(15 downto 0) := (others => '0')
);
end entity;

architecture rtl of cpu_cache_stub is
begin

    --------------------------------------------------------------------
    -- Pass-through request path
    --------------------------------------------------------------------
    cache_cpuCS      <= cpu_cs;
    cache_ramAddr    <= cpu_adr;
    cache_cpu_we     <= cpu_we;
    cache_cpu_bs     <= cpu_bs;
    cache_ramdout    <= cpu_dat_w;

    --------------------------------------------------------------------
    -- Pass-through response path
    --------------------------------------------------------------------
    --cpu_ack   <= cache_rsp_valid;   
    --cpu_dat_r <= cache_rsp_data_r;
    
        cache_cpu_ack <= '0';     -- no cache data available to read, BRAM will deliver the data
        cpu_dat_r   <= (others => '0');
    

end architecture;