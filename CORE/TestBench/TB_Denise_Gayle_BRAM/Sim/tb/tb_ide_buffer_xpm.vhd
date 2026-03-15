library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Amiga_Debug_pkg.all;
use work.debug_utils_pkg.all;

entity tb_ide_buffer_xpm is
end entity;

architecture sim of tb_ide_buffer_xpm is

    constant CLK_PERIOD : time := 10 ns;
    constant ADDR_WIDTH : integer := 12;
    constant DATA_WIDTH : integer := 16;

    signal clk      : std_logic := '0';

    signal addr_a   : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal din_a    : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal we_a     : std_logic := '0';
    signal dout_a   : std_logic_vector(DATA_WIDTH-1 downto 0);

    signal addr_b   : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal din_b    : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal we_b     : std_logic := '0';
    signal dout_b   : std_logic_vector(DATA_WIDTH-1 downto 0);

    type ram_t is array (0 to 2047) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal model    : ram_t := (others => (others => '0'));

    signal rd_a     : std_logic := '0';
    signal rd_b     : std_logic := '0';
    signal addr_a_i : integer range 0 to 2047 := 0;
    signal addr_b_i : integer range 0 to 2047 := 0;
    
    signal addr_a_d : integer range 0 to 2047 := 0;
    signal addr_b_d : integer range 0 to 2047 := 0;
    signal rd_a_d   : std_logic := '0';
    signal rd_b_d   : std_logic := '0';
    

begin

    clk <= not clk after CLK_PERIOD/2;

    uut: entity work.dpram
        generic map (
             addr_width => ADDR_WIDTH
            ,data_width => DATA_WIDTH
            )
        port map (
             clock       => clk
            ,address_a   => addr_a
            ,data_a      => din_a
            ,wren_a      => we_a
            ,q_a         => dout_a
            ,address_b   => addr_b
            ,data_b      => din_b
            ,wren_b      => we_b
            ,q_b         => dout_b
        );


process
begin
    -- Run the simulation for 100,000 ns
    wait for 210000 ns;
    --wait for 10000 ns;
    report "TB completed" severity note;
    std.env.stop;    
end process;


    -- behavioural model update
    process(clk)
        variable a, b : integer;
    begin
        if rising_edge(clk) then
            a := to_integer(unsigned(addr_a));
            b := to_integer(unsigned(addr_b));

            if we_a = '1' then
                model(a) <= din_a;
            end if;

            if we_b = '1' then
                model(b) <= din_b;
            end if;
        end if;
    end process;

    -- checker
    process(clk)
    begin
        if rising_edge(clk) then
            addr_a_d    <= addr_a_i;
            addr_b_d    <= addr_b_i;
            rd_a_d      <= rd_a;
            rd_b_d      <= rd_b;
            
            if rd_a_d = '1' then
                assert dout_a = model(addr_a_d)
                    report "IDE BUF Port A mismatch at " &
                           integer'image(addr_a_i) &
                           " exp=" & slv_to_hex_any(model(addr_a_d)) &
                           " got=" & slv_to_hex_any(dout_a)
                    severity error;
            end if;

            if rd_b_d = '1' then
                assert dout_b = model(addr_b_d)
                    report "IDE BUF Port B mismatch at " &
                           integer'image(addr_b_i) &
                           " exp=" & slv_to_hex_any(model(addr_b_d)) &
                           " got=" & slv_to_hex_any(dout_b)
                    severity error;
            end if;
        end if;
    end process;

    -- stimulus
    stim: process
        variable a, i : integer;
    begin
        wait for 5*CLK_PERIOD;

        -- directed: Port A only
        for a in 0 to 63 loop
            addr_a <= std_logic_vector(to_unsigned(a, ADDR_WIDTH));
            din_a  <= std_logic_vector(to_unsigned(a*3, DATA_WIDTH));
            we_a   <= '1';
            rd_a   <= '0';
            wait for CLK_PERIOD;
        end loop;
        we_a <= '0';

        for a in 0 to 63 loop
            addr_a   <= std_logic_vector(to_unsigned(a, ADDR_WIDTH));
            addr_a_i <= a;
            rd_a     <= '1';
            wait for CLK_PERIOD;
        end loop;
        rd_a <= '0';

        -- directed: Port B only
        for a in 0 to 63 loop
            addr_b <= std_logic_vector(to_unsigned(a+128, ADDR_WIDTH));
            din_b  <= std_logic_vector(to_unsigned(a*5, DATA_WIDTH));
            we_b   <= '1';
            rd_b   <= '0';
            wait for CLK_PERIOD;
        end loop;
        we_b <= '0';

        for a in 0 to 63 loop
            addr_b   <= std_logic_vector(to_unsigned(a+128, ADDR_WIDTH));
            addr_b_i <= a+128;
            rd_b     <= '1';
            wait for CLK_PERIOD;
        end loop;
        rd_b <= '0';

        -- cross-port: A writes, B reads
        for a in 0 to 63 loop
            addr_a <= std_logic_vector(to_unsigned(a+256, ADDR_WIDTH));
            din_a  <= std_logic_vector(to_unsigned(a*7, DATA_WIDTH));
            we_a   <= '1';
            rd_a   <= '0';
            wait for CLK_PERIOD;
        end loop;
        we_a <= '0';

        for a in 0 to 63 loop
            addr_b   <= std_logic_vector(to_unsigned(a+256, ADDR_WIDTH));
            addr_b_i <= a+256;
            rd_b     <= '1';
            wait for CLK_PERIOD;
        end loop;
        rd_b <= '0';

        -- simultaneous writes to different addresses
        for a in 0 to 31 loop
            addr_a <= std_logic_vector(to_unsigned(a+512, ADDR_WIDTH));
            din_a  <= std_logic_vector(to_unsigned(a*11, DATA_WIDTH));
            we_a   <= '1';

            addr_b <= std_logic_vector(to_unsigned(a+1024, ADDR_WIDTH));
            din_b  <= std_logic_vector(to_unsigned(a*13, DATA_WIDTH));
            we_b   <= '1';

            rd_a <= '0';
            rd_b <= '0';
            wait for CLK_PERIOD;
        end loop;
        we_a <= '0';
        we_b <= '0';

        -- random stress
        for i in 0 to 20000 loop
            a := i mod 2048;

            if (i mod 4) = 0 then
                addr_a <= std_logic_vector(to_unsigned(a, ADDR_WIDTH));
                din_a  <= std_logic_vector(to_unsigned(i*17, DATA_WIDTH));
                we_a   <= '1';
                rd_a   <= '0';

                we_b   <= '0';
                rd_b   <= '0';
            elsif (i mod 4) = 1 then
                addr_b <= std_logic_vector(to_unsigned(a, ADDR_WIDTH));
                din_b  <= std_logic_vector(to_unsigned(i*19, DATA_WIDTH));
                we_b   <= '1';
                rd_b   <= '0';

                we_a   <= '0';
                rd_a   <= '0';
            elsif (i mod 4) = 2 then
                addr_a   <= std_logic_vector(to_unsigned(a, ADDR_WIDTH));
                addr_a_i <= a;
                we_a     <= '0';
                rd_a     <= '1';

                we_b     <= '0';
                rd_b     <= '0';
            else
                addr_b   <= std_logic_vector(to_unsigned(a, ADDR_WIDTH));
                addr_b_i <= a;
                we_b     <= '0';
                rd_b     <= '1';

                we_a     <= '0';
                rd_a     <= '0';
            end if;

            wait for CLK_PERIOD;
        end loop;

        we_a <= '0';
        we_b <= '0';
        rd_a <= '0';
        rd_b <= '0';

        report "IDE buffer RAM TB completed" severity note;
        wait;
    end process;

end architecture;