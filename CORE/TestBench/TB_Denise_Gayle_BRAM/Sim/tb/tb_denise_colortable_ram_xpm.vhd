library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Amiga_Debug_pkg.all;
use work.debug_utils_pkg.all;


entity tb_denise_colortable_ram_xpm is
end entity;

architecture sim of tb_denise_colortable_ram_xpm is

    constant CLK_PERIOD : time := 10 ns;

    signal clk      : std_logic := '0';
    signal enable   : std_logic := '1';
    signal byteena  : std_logic_vector(3 downto 0) := (others => '0');
    signal wr_data  : std_logic_vector(31 downto 0) := (others => '0');
    signal wr_addr  : std_logic_vector(7 downto 0)  := (others => '0');
    signal rd_addr  : std_logic_vector(7 downto 0)  := (others => '0');
    signal wr_en    : std_logic := '0';
    signal dut_q    : std_logic_vector(31 downto 0);

    type ram_t is array (0 to 255) of std_logic_vector(31 downto 0);
    signal model    : ram_t := (others => (others => '0'));

    signal rd_active : std_logic := '0';
    signal rd_addr_i : integer range 0 to 255 := 0;

    signal rd_addr_d  : integer range 0 to 255 := 0;
    signal rd_valid_d : std_logic := '0';
    
begin

    clk <= not clk after CLK_PERIOD/2;

    uut: entity work.denise_colortable_ram_mf
        port map (
             clock      => clk
            ,enable     => enable
            ,byteena_a  => byteena
            ,data       => wr_data
            ,wraddress  => wr_addr
            ,rdaddress  => rd_addr
            ,wren       => wr_en
            ,q          => dut_q
        );

process
begin
    -- Run the simulation for 100,000 ns
    wait for 110000 ns;
    --wait for 10000 ns;
    report "TB completed" severity note;
    std.env.stop;    
end process;


    -- behavioural model update
    process(clk)
        variable a : integer;
    begin
        if rising_edge(clk) then
            if wr_en = '1' then
                a := to_integer(unsigned(wr_addr));
                for i in 0 to 3 loop
                    if byteena(i) = '1' then
                        model(a)(8*i+7 downto 8*i) <= wr_data(8*i+7 downto 8*i);
                    end if;
                end loop;
            end if;
        end if;
    end process;

    -- checker (1-cycle latency)
    process(clk)
    begin
        if rising_edge(clk) then
            rd_addr_d   <= rd_addr_i;
            rd_valid_d  <= rd_active;
        
            if rd_valid_d = '1' then        
                assert dut_q = model(rd_addr_d)
                    report "DENISE RAM mismatch at addr " &
                           integer'image(rd_addr_i) &                           
                           " exp=" & slv_to_hex_any(model(rd_addr_d)) &
                           " got=" & slv_to_hex_any(dut_q)
                    severity error;
            end if;
        end if;
    end process;

    -- stimulus
    stim: process
        variable a : integer;
        variable i : integer;
    begin
        wait for 5*CLK_PERIOD;

        -- directed: full writes, full reads
        for a in 0 to 255 loop
            wr_addr <= std_logic_vector(to_unsigned(a, 8));
            wr_data <= std_logic_vector(to_unsigned(a, 32));
            byteena <= "1111";
            wr_en   <= '1';
            wait for CLK_PERIOD;
        end loop;
        wr_en <= '0';

        for a in 0 to 255 loop
            rd_addr   <= std_logic_vector(to_unsigned(a, 8));
            rd_addr_i <= a;
            rd_active <= '1';
            wait for CLK_PERIOD;
        end loop;
        rd_active <= '0';

        -- directed: byte-enable patterns
        for a in 0 to 15 loop
            wr_addr <= std_logic_vector(to_unsigned(a, 8));
            wr_data <= x"11223344";
            byteena <= "0001"; wr_en <= '1'; wait for CLK_PERIOD;
            wr_data <= x"55667788";
            byteena <= "0010"; wr_en <= '1'; wait for CLK_PERIOD;
            wr_data <= x"99AABBCC";
            byteena <= "0100"; wr_en <= '1'; wait for CLK_PERIOD;
            wr_data <= x"DDEEFF00";
            byteena <= "1000"; wr_en <= '1'; wait for CLK_PERIOD;
        end loop;
        wr_en <= '0';

        for a in 0 to 15 loop
            rd_addr   <= std_logic_vector(to_unsigned(a, 8));
            rd_addr_i <= a;
            rd_active <= '1';
            wait for CLK_PERIOD;
        end loop;
        rd_active <= '0';

        -- random stress
        for i in 0 to 10000 loop
            --a := integer(unsigned(std_logic_vector(to_unsigned(i, 8)))) mod 256;
            --a := to_integer(unsigned(to_unsigned(i, 8))) mod 256;
            a := i mod 256;

            if (i mod 3) = 0 then
                wr_addr <= std_logic_vector(to_unsigned(a, 8));
                wr_data <= std_logic_vector(to_unsigned(i*37, 32));
                byteena <= std_logic_vector(to_unsigned(i, 4));
                wr_en   <= '1';
                rd_active <= '0';
            else
                wr_en    <= '0';
                rd_addr  <= std_logic_vector(to_unsigned(a, 8));
                rd_addr_i <= a;
                rd_active <= '1';
            end if;

            wait for CLK_PERIOD;
        end loop;

        rd_active <= '0';
        wr_en     <= '0';

        report "DENISE color table RAM TB completed" severity note;
        wait;
    end process;

end architecture;