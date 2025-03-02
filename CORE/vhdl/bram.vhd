-- Modified version of the original Minimig code to generate RAM.
-- Change to run on Altrix voards instead of the Original Cyclone.
-- Ports needed to be mapped back to the Cyclone port names to maintain compatibility with the original minimig source code.

-- Feb 2025 - David Raynor (Kiwi)



--------------------------------------------------------------
-- Single port Block RAM
--------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.Numeric_STD.all;



ENTITY spram IS
	generic (
		addr_width    : integer := 8;
		data_width    : integer := 8;
		mem_init_file : string := " ";
		mem_name      : string := "MEM" -- for InSystem Memory content editor.
	);
	PORT
	(
		clock   : in  STD_LOGIC;
		address : in  STD_LOGIC_VECTOR (addr_width-1 DOWNTO 0);
		data    : in  STD_LOGIC_VECTOR (data_width-1 DOWNTO 0) := (others => '0');
		enable  : in  STD_LOGIC := '1';
		wren    : in  STD_LOGIC := '0';
		q       : out STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
		cs      : in  std_logic := '1'
	);
END spram;


ARCHITECTURE SYN OF spram IS
COMPONENT spram_sz
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
  );
END COMPONENT;
BEGIN
	spram_sza : spram_sz
	--generic map(addr_width, data_width, 2**addr_width, mem_init_file, mem_name)
--	port map(clock,address,data,enable,wren,q,cs);
	port map (
	       clka    => clock,       
	       addra   => address,
	       dina    => data,
	       douta   => q,
	       ena     => '1',
	       wea     => std_logic_vector(to_unsigned(1,1))
       	           	       
	);			
END SYN;




--------------------------------------------------------------
-- Dual port Block RAM same parameters on both ports
--------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.Numeric_STD.all;

entity dpram is
	generic (
		addr_width    : integer := 8;
		data_width    : integer := 8;
		mem_init_file : string := " "
	);
	PORT
	(
		clock			: in  STD_LOGIC;

		address_a	: in  STD_LOGIC_VECTOR (addr_width-1 DOWNTO 0);
		data_a		: in  STD_LOGIC_VECTOR (data_width-1 DOWNTO 0) := (others => '0');
		enable_a	: in  STD_LOGIC := '1';
		wren_a		: in  STD_LOGIC := '0';
		q_a			: out STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
		cs_a        : in  std_logic := '1';

		address_b	: in  STD_LOGIC_VECTOR (addr_width-1 DOWNTO 0) := (others => '0');
		data_b		: in  STD_LOGIC_VECTOR (data_width-1 DOWNTO 0) := (others => '0');
		enable_b	: in  STD_LOGIC := '1';
		wren_b		: in  STD_LOGIC := '0';
		q_b			: out STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
		cs_b        : in  std_logic := '1'
	);
end entity;


ARCHITECTURE SYN OF dpram IS
COMPONENT dpram_dif
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
  );
END COMPONENT;
BEGIN
	ram : dpram_dif 
--	generic map(addr_width,data_width,addr_width,data_width,mem_init_file)
--	port map(clock,address_a,data_a,enable_a,wren_a,q_a,cs_a,address_b,data_b,enable_b,wren_b,q_b,cs_b);
    port map (
        clka        => clock,
        addra       => address_a,
        dina        => data_a,
        douta       => q_a,
        clkb        => clock,
        addrb       => address_b,
        dinb        => data_b,
        doutb       => q_b,
        ena         => '1',
	    wea         => std_logic_vector(to_unsigned(1,1)),
	    enb         => '1',
	    web         => std_logic_vector(to_unsigned(1,1))                          
    );

END SYN;


--------------------------------------------------------------
-- Dual port Block RAM same parameters on both ports
-- Variation of dpram_diff.  Cannot use dpram_diff to to the 
-- overrides of the number of ports.  Need to work out how to 
-- do this for the Xilinx IP.  For now, defining them separately
-- Until the code gets cleaned up. 
--------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.Numeric_STD.all;

entity dtram_a is
	generic (
		addr_width    : integer := 8;
		data_width    : integer := 40;
		mem_init_file : string := " "
	);
	PORT
	(
		clock			: in  STD_LOGIC;

		address_a	: in  STD_LOGIC_VECTOR (addr_width-1 DOWNTO 0);
		data_a		: in  STD_LOGIC_VECTOR (data_width-1 DOWNTO 0) := (others => '0');
		enable_a	: in  STD_LOGIC := '1';
		wren_a		: in  STD_LOGIC := '0';
		q_a			: out STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
		cs_a        : in  std_logic := '1';

		address_b	: in  STD_LOGIC_VECTOR (addr_width-1 DOWNTO 0) := (others => '0');
		data_b		: in  STD_LOGIC_VECTOR (data_width-1 DOWNTO 0) := (others => '0');
		enable_b	: in  STD_LOGIC := '1';
		wren_b		: in  STD_LOGIC := '0';
		q_b			: out STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
		cs_b        : in  std_logic := '1'
	);
end entity;


ARCHITECTURE SYN OF dtram_a IS
COMPONENT dtram
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(39 DOWNTO 0) 
  );
END COMPONENT;
BEGIN
	ram : dtram
    port map (
        clka        => clock,
        addra       => address_a,
        dina        => data_a,
        douta       => q_a,
        clkb        => clock,
        addrb       => address_b,
        dinb        => data_b,
        doutb       => q_b,
        ena         => '1',
	    wea         => std_logic_vector(to_unsigned(1,1)),
	    enb         => '1',
	    web         => std_logic_vector(to_unsigned(1,1))                          
    );

END SYN;


--------------------------------------------------------------
-- Dual port Block RAM same parameters on both ports
-- Variation of dpram_diff.  Cannot use dpram_diff to to the 
-- overrides of the number of ports.  Need to work out how to 
-- do this for the Xilinx IP.  For now, defining them separately
-- Until the code gets cleaned up. 
--------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.Numeric_STD.all;

entity dpram_be_a is
	generic (
		addr_width    : integer := 8;
		data_width    : integer := 40;
		mem_init_file : string := " "
	);
	PORT
	(
		clock			: in  STD_LOGIC;

		address_a	: in  STD_LOGIC_VECTOR (addr_width-1 DOWNTO 0);
		data_a		: in  STD_LOGIC_VECTOR (data_width-1 DOWNTO 0) := (others => '0');
		enable_a	: in  STD_LOGIC := '1';
		wren_a		: in  STD_LOGIC := '0';
		q_a			: out STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
		cs_a        : in  std_logic := '1';

		address_b	: in  STD_LOGIC_VECTOR (addr_width-1 DOWNTO 0) := (others => '0');
		data_b		: in  STD_LOGIC_VECTOR (data_width-1 DOWNTO 0) := (others => '0');
		enable_b	: in  STD_LOGIC := '1';
		wren_b		: in  STD_LOGIC := '0';
		q_b			: out STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
		cs_b        : in  std_logic := '1'
	);
end entity;


ARCHITECTURE SYN OF dpram_be_a IS
COMPONENT dpram_be
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
  );
END COMPONENT;

BEGIN
	ram : dpram_be
    port map (
        clka        => clock,
        addra       => address_a,
        dina        => data_a,
        douta       => q_a,
        clkb        => clock,
        addrb       => address_b,
        dinb        => data_b,
        doutb       => q_b,
        ena         => '1',
	    wea         => std_logic_vector(to_unsigned(1,1)),
	    enb         => '1',
	    web         => std_logic_vector(to_unsigned(1,1))                          
    );

END SYN;
