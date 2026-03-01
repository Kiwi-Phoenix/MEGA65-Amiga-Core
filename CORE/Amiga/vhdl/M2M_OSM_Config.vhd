-- Send configuration data to the Minimig USERIO module.
-- 
-- Note: This module is not used for sending the memory / ROM data to USERIO.  That is done by a separate module.
--
-- Some Notes:
-- This module will send the Amiga Core configuration to the USERIO module, specifically the USERIO_CONFIG module.
-- The USERIO module will handle two types ofr configuration,
-- 1) Loading of the ROM to memory.  
-- 2) The 9 other user configurations.
-- 
-- This M2M_OSM_Conig module will desl with the 9 other user configurations.  Loading of ROM to memory is taken care of by another mondule.
--
-- Configuration is send / pulsed to USERIO in pairs.  First the "command" is send, i.e. telling USERIO the configuration to set. The second pulse is the 
-- configuration data.
-- IO_ENA is set high at the start of the data pair.  I.e when sending the command.
-- IO_ENA is then brought low again after the Config data has been sent.
--
-- To Send the data, command and config data, IO_STROBE must be set high and then set low again after the data is sent.
-- Therefore two pulse signals are being sent, one to start and end each data pair being sent, and one for each data item being sent.
-- I.e. IO_ENA tells USERIO that some config data is comming, and IO_STROBE identifies that the data is sent and on IO_DIN 
--
--  NOTE: TBC some some configurations, made need to "force" a reset on once done so that the configuarion will take.
-- It seems to hold it in a temp variable / signle until reset.  If this is the case, then may need to modify this module to do just that.  Or a controlling module
-- that instaintates thie module and then trigger a reset of the CORE so that the config is applied.
-- This is not the case for all config options, but it is the majority of them, so might as well do it in all cases, unless I it becomes annoying.
--
--
-- August 2025  David Raynor (Kiwi)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity M2M_OSM_Config is
    port (
        clk                 : in  std_logic;
        reset_n             : in  std_logic;            -- active-low reset
        main_osm_control_i  : in  std_logic_vector(255 downto 0);
        
        -- Signals for testing
        data_bytes          : out std_logic_vector(7 downto 0);
        cmd_idx             : out integer;
        
        -- Signal to start and finish
        start               : in  std_logic;
        done                : out std_logic;
        
        -- User IO to CORE (SPI)
        IO_WAIT             : in  std_logic;            -- from userio_config
        IO_ENA              : out std_logic;
        IO_STROBE           : out std_logic;
        IO_DIN              : out std_logic_vector(15 downto 0)
    );
end entity;

architecture RTL of M2M_OSM_Config is

-- State machine definition
------------------------------------------------------------------------------
    type t_state is (IDLE, 
                     ASSERT_ENA,                     
                     WAIT_CMD_REQ, 
                     PULSE_CMD,                      
                     WAIT_DATA_REQ, 
                     PULSE_DATA,                     
                     NEXT_OR_DONE,
                     S_DONE
            );
    signal state         : t_state := IDLE;
    signal next_state    : t_state;
    


  -- Index of current config slot
  -- Number of commands to send (1→9)
  constant N_CFGS : natural := 9;  
  signal cfg_idx    : integer range 1 to N_CFGS := 1;

  --------------------------------------------------------------------------
  -- Pure functions return  8-bit cmd or data for a given index
  --------------------------------------------------------------------------
  function get_cmd(i: integer) return std_logic_vector is
  begin
    case i is 
      when 1 => return x"F1";  when 2 => return x"F2";
      when 3 => return x"F3";  when 4 => return x"F4";
      when 5 => return x"F5";  when 6 => return x"F6";
      when 7 => return x"F7";  when 8 => return x"F8";
      when 9 => return x"F9";
      when others => return x"00";
    end case;
  end function;

begin
      
proc_state : process(clk, reset_n)
begin
    if reset_n = '0' then
        state   <= IDLE;
        cfg_idx <= 1;
    elsif rising_edge(clk) then
        state <= next_state;
        -- Advance index only when we actually move to NEXT_OR_DONE
        if state = NEXT_OR_DONE then
            if cfg_idx < N_CFGS then
                cfg_idx <= cfg_idx + 1;
            else
                cfg_idx <= 1;  
            end if;
        end if;
    end if;
end process;

-- Next-state logic and output gneration
-----------------------------------------------------------------------------
-- Note process(all) only done in VHDL-2008
comb_fsm : process(all)
variable selected_byte : std_logic_vector(7 downto 0);

begin
    -- default outputs
    IO_ENA      <= '0';
    IO_STROBE   <= '0';
    IO_DIN      <= (others => '0');
    data_bytes  <= (others => '0');
    cmd_idx     <= cfg_idx;
    done        <= '0';
    next_state  <= state;
    
  case cfg_idx is
    when 1 => selected_byte := main_osm_control_i(15  downto  8);
    when 2 => selected_byte := main_osm_control_i(23  downto 16);
    when 3 => selected_byte := main_osm_control_i(31  downto 24);
    when 4 => selected_byte := main_osm_control_i(39  downto 32);
    when 5 => selected_byte := main_osm_control_i(47  downto 40);
    when 6 => selected_byte := main_osm_control_i(55  downto 48);
    when 7 => selected_byte := main_osm_control_i(63  downto 56);
    when 8 => selected_byte := main_osm_control_i(71  downto 64);
    when 9 => selected_byte := main_osm_control_i(79  downto 72);
    when others => selected_byte := (others => '0');
  end case;            
    
    case state is
        when IDLE =>
            if start = '1' then
                next_state <= ASSERT_ENA;
            end if;
--            if reset_n = '1' then
--                next_state <= ASSERT_ENA;
--            end if;
            
        when ASSERT_ENA =>
            IO_ENA     <= '1';
            next_state <= WAIT_CMD_REQ;
        
        when WAIT_CMD_REQ =>
            IO_ENA  <= '1';
            if IO_WAIT = '0' then
                next_state <= PULSE_CMD;
            end if;
        
        when PULSE_CMD =>
            IO_ENA      <= '1';
            IO_STROBE   <= '1';
            IO_DIN      <= x"00" & get_cmd(cfg_idx);
--            cmd_idx     <= cfg_idx;
            next_state  <= WAIT_DATA_REQ;
            
        when WAIT_DATA_REQ =>
            IO_ENA      <= '1';
            IO_STROBE   <= '0';
            if IO_WAIT = '0' then
                next_state <= PULSE_DATA;
            end if;
        
        when PULSE_DATA =>
            IO_ENA      <= '1';
            IO_STROBE   <= '1';
            IO_DIN      <= x"00" & selected_byte;
            data_bytes  <= selected_byte;
            next_state  <= NEXT_OR_DONE;
            
        when NEXT_OR_DONE => 
            IO_ENA      <= '0';
--            IO_STROBE   <= '0';
            --next_state  <= WAIT_CMD_REQ;
            
--            if cfg_idx < N_CFGS then
--                next_state  <= WAIT_CMD_REQ;
--            else 
--                next_state <= S_DONE;
--            end if;
            next_state <= WAIT_CMD_REQ when cfg_idx < N_CFGS else S_DONE;
         
         when S_DONE =>
            done <= '1';
            if start = '0' then
                next_state <= IDLE;
            end if;
            
         when others =>
            next_state  <= IDLE;
    end case;   

end process;
               
end architecture;


