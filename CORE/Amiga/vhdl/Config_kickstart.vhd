-- Send Kickstart configuration to USERIO
-- Note: This loads the KickStart ROM to Amiga memory
--
-- Data should be sourced come from M2M Devices, however for this interation it will come from a pre-loaded ROM.
-- ROM is pre-loaded with an Amiga ROM file.
--
-- Notes:
-- The USERIO_Config needs to be re-factored to improve it's structure and performance
-- For now, this module will work with the way it currently is.  This code will also need to be re-factored 
-- when the USERIO_Config module is re-factored.
-- Command F0 in UserIO is all about receiving and loading the ROM data to the Amiga's RAM
--
-- August 2025  David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity config_kickstart is
    generic (
        DATA_WIDTH  : natural := 16;            -- bus width
        ADDR_WIDTH  : natural := 24;            -- host address width
        ROM_DEPTH   : natural := 4102;          -- number of words in ROM
        START_ADDR  : natural := 16#f8_0000#    -- base host address         
    );
    port (
        clk         : in  std_logic;
        reset_n     : in  std_logic;
        start       : in  std_logic;
        done        : out std_logic;
        
        rom_addr    : out std_logic_vector(ADDR_WIDTH-1 downto 0);
        host_addr   : out std_logic_vector(ADDR_WIDTH-1 downto 0);
        rom_dout    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
                     
        dat1        : out std_logic_vector(15 downto 0);
        
        state_o     : out integer range 1 to 13;  
        
        last_data   : out std_logic;            -- Used by TB to trigger a host_ack signal, not required for systhesis
        
        IO_ENA      : out std_logic;
        IO_STROBE   : out std_logic;
        IO_DIN      : out std_logic_vector(DATA_WIDTH-1 downto 0);
        IO_WAIT     : in  std_logic             
    );       
end entity;

architecture RTL of config_kickstart is 

-- FSM states
type state_t is (
    WAIT_START
   ,IDLE
   ,READ_ROM_ADDR
   ,WAIT_ROM
   ,S_CMD_BYTE
   ,ADDR_BYTE0
   ,ADDR_BYTE1
   ,ADDR_BYTE2
   ,DUMMY_BYTE
   ,DATA_HIGH
   ,DATA_LOW
   ,WAIT_FOR_WAIT
   ,CLEANUP
   ,S_DONE
);

signal state        : state_t := IDLE;
signal index_count  : natural range 0 to ROM_DEPTH-1 := 0;
signal write_addr   : std_logic_vector(ADDR_WIDTH-1 downto 0);
constant CMD_BYTE   : std_logic_vector(7 downto 0) := x"F0";

begin

dat1 <= rom_dout;


-- Main FSM: Drive IO_ENA / IO_STROBE / IO_DIN
process(clk, reset_n)

begin
    if reset_n = '0' then
--        state       <= IDLE;
        state       <= WAIT_START;
        index_count <= 0;
        rom_addr    <= (others => '0');
        write_addr  <= (others => '0');
        IO_ENA      <= '0';
        IO_STROBE   <= '0';
        IO_DIN      <= (others => '0');
        last_data   <= '0';
        done        <= '0';
    elsif rising_edge(clk) then
        -- Defaults outputs each cycle
        IO_STROBE <= '0';
        done      <= '0';
        last_data <= '0';
        
        case state is 
        
        -- Wait for the external kickoff
        when WAIT_START =>
            state_o <= 1;
            if start = '1' then
                state <= IDLE;
            end if;
        
        -- prepare ROM and host address
        when IDLE =>
            state_o <= 2;
            -- Prepare next word's ROM & host address
            rom_addr    <= std_logic_vector(to_unsigned(index_count, ADDR_WIDTH));
            write_addr  <= std_logic_vector(to_unsigned(index_count + START_ADDR, ADDR_WIDTH));
            state       <= WAIT_ROM;
        
        when WAIT_ROM =>
        state_o <= 3;
            state <= S_CMD_BYTE;
--            state <= WAIT_ROM2;
        
--        when WAIT_ROM2 =>
--            state <= S_CMD_BYTE;
        
        when S_CMD_BYTE =>
        state_o <= 4;
            IO_ENA              <= '1';
            IO_DIN(15 downto 8) <= (others => '0');
            IO_DIN(7 downto 0)  <= CMD_BYTE;
            IO_STROBE           <= '1';
            state               <= ADDR_BYTE0;
        
        when ADDR_BYTE0 => 
        state_o <= 5;
            IO_ENA              <= '1';
            IO_DIN(15 downto 8) <= (others => '0');
            IO_DIN(7 downto 0)  <= write_addr(7 downto 0);
            IO_STROBE           <= '1';
            state               <= ADDR_BYTE1;
        
        when ADDR_BYTE1 =>
        state_o <= 6;
            IO_ENA              <= '1';
            IO_DIN(15 downto 8) <= (others => '0');
            IO_DIN(7 downto 0)  <= write_addr(15 downto 8);
            IO_STROBE           <= '1';
            state               <= ADDR_BYTE2;
        
        when ADDR_BYTE2 =>
        state_o <= 7;
            IO_ENA              <= '1';
            IO_DIN(15 downto 8) <= (others => '0');
            IO_DIN(7 downto 0)  <= write_addr(23 downto 16);
            IO_STROBE           <= '1';
            state               <= DUMMY_BYTE;
        
        when DUMMY_BYTE =>
        state_o <= 8;
            IO_ENA              <= '1';
            IO_DIN              <= (others => '0');
            IO_STROBE           <= '1';
            state               <= DATA_HIGH;
        
        when DATA_HIGH =>
        state_o <= 9;
            IO_ENA              <= '1';
            IO_DIN(15 downto 8) <= (others => '0');            
            IO_DIN( 7 downto 0) <= rom_dout(15 downto 8);
            IO_STROBE           <= '1';
            state               <= DATA_LOW;
        
        when DATA_LOW =>
        state_o <= 10;
            IO_ENA              <= '1';
            IO_DIN(15 downto 8) <= (others => '0');
            IO_DIN( 7 downto 0) <= rom_dout(7 downto 0);
            IO_STROBE           <= '1';
            state               <= WAIT_FOR_WAIT;
        
        when WAIT_FOR_WAIT =>
        state_o <= 11;
            last_data   <= '1';
            -- Poll IO_WAIT
            IO_ENA  <= '1';
            if IO_WAIT = '1' then
                state   <= CLEANUP;
            end if;
        
        when CLEANUP =>
        state_o <= 12;
            IO_ENA      <= '0';
            last_data   <= '0';
            IO_DIN      <= (others => '0');
            -- Advance to next word or loop
            if index_count = ROM_DEPTH - 1 then
                index_count <= 0;
--                state       <= IDLE;
                state       <= S_DONE;
            else
                index_count <= index_count + 1;
                state       <= IDLE;
            end if;
        
        when S_DONE =>
        state_o <= 13;
            done <= '1';
            if start = '0' then
                state <= WAIT_START;
            end if;
                          
--        when others => state <= IDLE;
        when others => state <= WAIT_START;
        end case;        
        
        host_addr <= write_addr;
        
        
        
                                               
    end if;
end process;


end architecture;
