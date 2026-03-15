-- March 2026
-- A more extensive test of Copper than the intial "Hello" test.
-- Same structure as the Hello test.
--
-- Copper test suites
-- Set the TEST_ID to the test that you want to run.
--
-- TEST_ID = 
-- 1 - Basic Moves (Hello Copper)
-- 2 - WAIT
-- 3 - SKIP True
-- 4 - SKIP False


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.debug_utils_pkg.all;

entity tb_copper is
    generic (
        TEST_ID : integer := 16
        );
end entity;

architecture sim of tb_copper is

  constant CLK_PERIOD : time := 10 ns;

  signal clk          : std_logic := '0';
  signal clk7_en      : std_logic := '0';
  signal reset        : std_logic := '1';

  signal reqdma       : std_logic;
  signal ackdma       : std_logic := '0';
  signal enadma       : std_logic := '0';       -- start with DMA disabled
  
  signal sof          : std_logic := '0';       -- Start of Frame

  signal vpos         : std_logic_vector(7 downto 0) := (others => '0');
  signal hpos         : std_logic_vector(8 downto 0) := (others => '0');

  signal data_in         : std_logic_vector(15 downto 0) := (others => '0');
  signal reg_address_in  : std_logic_vector(8 downto 1) := (others => '0');
  signal reg_address_out : std_logic_vector(8 downto 1);
  signal address_out     : std_logic_vector(20 downto 1) := (others => '0');

  -- simple fake chip RAM
  type ram_t is array (0 to 255) of std_logic_vector(15 downto 0);
  signal chipram : ram_t := (others => (others => '0'));
  
  
  -- Denise color RAM model (32 entries for OCS/ECS)
  type color_ram_t is array (0 to 31) of std_logic_vector(15 downto 0);
  signal color_ram : color_ram_t := (others => (others => '0'));
  

  -- Copper registers
  constant COP1LCH  : std_logic_vector(8 downto 1) := x"80";
  constant COP1LCL  : std_logic_vector(8 downto 1) := x"82";
  constant COPJMP1  : std_logic_vector(8 downto 1) := x"88";
  constant COPINS   : std_logic_vector(8 downto 1) := x"8C";

  -- COLOR registers
  constant COLOR00  : std_logic_vector(8 downto 1) := x"18";
  constant COLOR01  : std_logic_vector(8 downto 1) := x"19";
  constant COLOR02  : std_logic_vector(8 downto 1) := x"1A";
  constant COLOR03  : std_logic_vector(8 downto 1) := x"1B";

  constant NULL_REG : std_logic_vector(8 downto 1) := (others => '1');
  constant ZERO_REG : std_logic_vector(8 downto 1) := (others => '0');
  
  -- CPU-Side bus
  signal cpu_reg_addr : std_logic_vector(8 downto 1) := (others => '0');
  signal cpu_data_in  : std_logic_vector(15 downto 0) := (others => '0');
  
  -- DMA-side bus
  signal dma_reg_addr : std_logic_vector(8 downto 1) := (others => '0');
  signal dma_data_in  : std_logic_vector(15 downto 0) := (others => '0');
  
  signal copper_state_tb : std_logic_vector(2 downto 0) := (others => '0');
  signal dma_req_tb      : std_logic := '0';
  signal enable_tb       : std_logic := '0';


-----------------------------------------------------------------------------------

begin

  reg_address_in <= dma_reg_addr when ackdma = '1' else cpu_reg_addr;
  data_in        <= dma_data_in  when ackdma = '1' else cpu_data_in;

  --------------------------------------------------------------------
  -- 28 MHz clock
  --------------------------------------------------------------------
  clk <= not clk after CLK_PERIOD/2;

  --------------------------------------------------------------------
  -- 7 MHz enable
  --------------------------------------------------------------------
  process(clk)
    variable div : integer := 0;
  begin
    if rising_edge(clk) then
      div := div + 1;
      if div = 4 then
        div := 0;
        clk7_en <= '1';
      else
        clk7_en <= '0';
      end if;
    end if;
  end process;

  --------------------------------------------------------------------
  -- Simple hpos/vpos (no PAL timing needed)
  --------------------------------------------------------------------
  process(clk)
  begin
    if rising_edge(clk) then
      if clk7_en = '1' then
        hpos <= std_logic_vector(unsigned(hpos) + 1);
        if hpos = "111111111" then
          vpos <= std_logic_vector(unsigned(vpos) + 1);
        end if;
      end if;
    end if;
  end process;


p_color_capture : process(clk)
  variable idx : integer;
begin
  if rising_edge(clk) then
    if clk7_en = '1' then
      -- Detect Copper MOVE to COLORxx
      if reg_address_out >= COLOR00 and reg_address_out <= COLOR03 then
        --idx := to_integer(unsigned(reg_address_out(4 downto 1)));  -- low nibble
        idx := to_integer(unsigned(address_out(4 downto 1)));  -- low nibble
        color_ram(idx) <= data_in;
      end if;
    end if;
  end if;
end process;

  --------------------------------------------------------------------
  -- DMA emulation (correct)
  --------------------------------------------------------------------
  process(clk)
    variable addr : integer;
  begin
    if rising_edge(clk) then
      if reqdma = '1' then
      --if enadma = '1' and reqdma = '1' then
        ackdma <= '1';
        dma_reg_addr <= COPINS;

        --addr := to_integer(unsigned(address_out(20 downto 2)));
        addr := to_integer(unsigned(address_out(20 downto 1)));
        dma_data_in <= chipram(addr);

      else
        ackdma <= '0';
        dma_reg_addr <= (others => '0');
        dma_data_in <= (others => '0');
      end if;

    end if;
  end process;


stim: process
  variable base : integer := 0;
  -- Test 13
  variable seed1 : integer := 12345;
  variable seed2 : integer := 54321;
  variable r     : real;
  variable rnd   : integer;

begin
  case TEST_ID is

    when 1 =>
      -- Test 1: Basic MOVE
      -- Copper list
        chipram(base + 0) <= x"1234";       -- data    
        chipram(base + 1) <= x"0018";       -- COLOR00
        chipram(base + 2) <= x"5678";       -- data
        chipram(base + 3) <= x"0019";       -- COLOR01
        chipram(base + 4) <= x"9ABC";       -- data
        chipram(base + 5) <= x"001A";       -- COLOR02
        chipram(base + 6) <= x"FFFF";       -- data
        chipram(base + 7) <= x"001B";       -- COLOR03

    when 2 =>
      -- Test 2: WAIT
      chipram(base + 0) <= x"050A";   -- WAIT vpos=5, hpos=10
      chipram(base + 1) <= x"FFFF";   -- mask
      chipram(base + 2) <= x"1234";   -- data
      chipram(base + 3) <= x"0018";   -- COLOR00
      chipram(base + 4) <= x"5678";   -- data
      chipram(base + 5) <= x"0019";   -- COLOR01
      

    when 3 =>
      -- Test 3: SKIP TRUE
      -- WAIT until vpos=5, hpos=10
      chipram(base+0) <= x"050A";
      chipram(base+1) <= x"FFFF";
      
      -- SKIP (condition always TRUE: vpos>=0, hpos>=0)
      --chipram(base+2) <= x"0000";  -- SKIP always true
      chipram(base+2) <= x"0001";  -- SKIP always true
      chipram(base+3) <= x"FFFF";
      
      -- MOVE COLOR00, $AAAA  (should be skipped)
      chipram(base+4) <= x"AAAA";  -- skipped
      chipram(base+5) <= x"0018";
      
      -- MOVE COLOR01, $BBBB  (should execute)
      chipram(base+6) <= x"BBBB";  -- executed
      chipram(base+7) <= x"0019";

    when 4 =>
      -- Test 3B: SKIP FALSE
      -- WAIT until vpos=5, hpos=10
      chipram(base+0) <= x"050A";
      chipram(base+1) <= x"FFFF";
      
      -- SKIP (condition FALSE: vpos>=200)
      --chipram(base+2) <= x"C800";  -- SKIP false
      --chipram(base+3) <= x"FFFF";
      chipram(base+2) <= x"FFFF";  -- SKIP false      
      chipram(base+3) <= x"7FFF";
      
      -- MOVE COLOR00, $AAAA  (should execute)
      chipram(base+4) <= x"AAAA";  -- executed
      chipram(base+5) <= x"0018";
      
      -- MOVE COLOR01, $BBBB  (should execute)
      chipram(base+6) <= x"BBBB";  -- executed
      chipram(base+7) <= x"0019";
      
    when 5 =>
    -- Test 5: SKIP TRUE, next instruction is WAIT (must NOT be skipped)
    -- WAIT until vpos=5, hpos=10
    chipram(base+0) <= x"050A";
    chipram(base+1) <= x"FFFF";
    
    -- SKIP (condition always TRUE: vpos>=0, hpos>=0)
    --chipram(base+2) <= x"0000";  -- SKIP always true
    chipram(base+2) <= x"0001";  -- SKIP always true
    chipram(base+3) <= x"FFFF";
    
    -- WAIT (should execute, not skipped)
    -- e.g. wait for vpos=6, hpos=0
    chipram(base+4) <= x"0601";
    chipram(base+5) <= x"FFFF";
    
    -- MOVE COLOR00, $1234 (should execute after WAIT completes)
    chipram(base+6) <= x"1234";
    chipram(base+7) <= x"0018";       
    
    when 6 => 
    -- Test 6A: SKIP TRUE, next instruction is SKIP (no MOVE to skip)
    -- WAIT until vpos=5, hpos=10
    chipram(base+0) <= x"050A";
    chipram(base+1) <= x"FFFF";
    
    -- SKIP (always true)
    chipram(base+2) <= x"0001";
    chipram(base+3) <= x"FFFF";
    
    -- SKIP again (also always true)
    chipram(base+4) <= x"0001";
    chipram(base+5) <= x"FFFF";
    
    -- MOVE COLOR00, $AAAA (should execute, because there was no MOVE directly after first SKIP)
    chipram(base+6) <= x"AAAA";
    chipram(base+7) <= x"0018";      
    
    when 7 =>
    -- Test 6B: SKIP TRUE, next instruction is illegal MOVE
    -- Use a register address that your copper marks as illegal
    chipram(base+0) <= x"050A";
    chipram(base+1) <= x"FFFF";
    
    chipram(base+2) <= x"0001";  -- SKIP always true
    chipram(base+3) <= x"FFFF";
    
    chipram(base+4) <= x"DEAD";  -- data
    chipram(base+5) <= x"FFFE";  -- illegal reg (example)
    
    -- Then a legal MOVE to prove copper is halted or not, depending on spec
    chipram(base+6) <= x"BEEF";
    chipram(base+7) <= x"0018";    
    
    when 8 =>
    -- Test 7A: WAIT condition already true when executed
    -- Program WAIT for current beam position (e.g. vpos=0, hpos=0 in your TB)
    chipram(base+0) <= x"0007";
    chipram(base+1) <= x"FFFF";
    
    -- MOVE COLOR00, $1111 (should execute almost immediately)
    chipram(base+2) <= x"1111";
    chipram(base+3) <= x"0018";    
   
   when 9 =>
   -- Test 7B: WAIT that never matches (e.g. vpos beyond frame)
    chipram(base+0) <= x"FF00";  -- some impossible vpos in your TB
    chipram(base+1) <= x"FFFF";
    
    -- Following MOVE should never execute
    chipram(base+2) <= x"2222";
    chipram(base+3) <= x"0018";
    
    when 10 =>
--  Test 8 : Illegal MOVE → SKIP → verify next MOVE is skipped
--    // --------------------------------------------------------
--    // 1. Initialise fake chip RAM with Copper program
--    // --------------------------------------------------------
--    //  Address | Instruction
--    //  -----------------------------------------
--    //     0    | MOVE #$1234, $0007   (illegal)
--    //     1    | MOVE #$ABCD, $0180   (should be skipped)
--    //     2    | MOVE #$DEAD, $0180   (should execute)
--    //     3    | END
--    // --------------------------------------------------------

    chipram(base+0) <= x"1234";     -- Data for illegal MOVE
    chipram(base+1) <= x"0007";     -- illegal register address
    
    chipram(base+2) <= x"ABCD";     -- data for skipped MOVE
    chipram(base+3) <= x"0180";     -- COLOR00
    
    chipram(base+4) <= x"DEAD";     -- data for executed MOVE
    chipram(base+5) <= x"0180";     -- COLOR00
    
    chipram(base+6) <= x"FFFF";     -- END
    chipram(base+7) <= x"FFFF";     
   
   when 11 => 
    -- Test 9 : WAIT immediate match skip
    ----------------------------------------------------------------
    -- Copper program:
    --   WAIT 0,7            -- matches immediately at fetch
    --   MOVE #$ABCD,$0180   -- must be skipped
    --   MOVE #$DEAD,$0180   -- must execute
    --   END
    ----------------------------------------------------------------
    chipram(base+0) <= x"0007";   -- WAIT vpos=0 hpos=7
    chipram(base+1) <= x"FFFF";

    chipram(base+2) <= x"ABCD";   -- skipped MOVE
    chipram(base+3) <= x"0180";

    chipram(base+4) <= x"DEAD";   -- executed MOVE
    chipram(base+5) <= x"0180";

    chipram(base+6) <= x"FFFF";   -- END
    chipram(base+7) <= x"FFFF";

    when 12 => 
    --  Test 10 : SKIP over a WAIT instruction
    ----------------------------------------------------------------
    -- Program:
    --   MOVE #$1111,$0007   -- illegal → skip next
    --   WAIT 0,0            -- must be skipped
    --   MOVE #$DEAD,$0180   -- must execute
    --   END
    ----------------------------------------------------------------
    chipram(base+0) <= x"1111";
    chipram(base+1) <= x"0007";   -- illegal

    chipram(base+2) <= x"0000";   -- WAIT vpos=0 hpos=0
    chipram(base+3) <= x"FFFF";

    chipram(base+4) <= x"DEAD";   -- executed MOVE
    chipram(base+5) <= x"0180";

    chipram(base+6) <= x"FFFF";
    chipram(base+7) <= x"FFFF";

    when 13 => 
    --  Test 11 : Skip exactly one instruction in a long chain
    ----------------------------------------------------------------
    -- Program:
    --   MOVE #$1111,$0007   -- illegal → skip next
    --   MOVE #$AAAA,$0180   -- skipped
    --   MOVE #$BBBB,$0180   -- executed
    --   MOVE #$CCCC,$0180   -- executed
    --   END
    ----------------------------------------------------------------
    chipram(base+0) <= x"1111";
    chipram(base+1) <= x"0007";

    chipram(base+2) <= x"AAAA";   -- skipped
    chipram(base+3) <= x"0180";

    chipram(base+4) <= x"BBBB";   -- executed
    chipram(base+5) <= x"0180";

    chipram(base+6) <= x"CCCC";   -- executed
    chipram(base+7) <= x"0180";

    chipram(base+8) <= x"FFFF";
    chipram(base+9) <= x"FFFF";

    when 14 => 
    --  Test 11 : Skip exactly one instruction in a long chain
    ----------------------------------------------------------------
    -- Program:
    --   MOVE #$1111,$0007   -- illegal → skip next
    --   MOVE #$AAAA,$0180   -- skipped
    --   MOVE #$BBBB,$0180   -- executed
    --   MOVE #$CCCC,$0180   -- executed
    --   END
    ----------------------------------------------------------------
    chipram(base+0) <= x"1111";
    chipram(base+1) <= x"0007";

    chipram(base+2) <= x"AAAA";   -- skipped
    chipram(base+3) <= x"0180";

    chipram(base+4) <= x"BBBB";   -- executed
    chipram(base+5) <= x"0180";

    chipram(base+6) <= x"CCCC";   -- executed
    chipram(base+7) <= x"0180";

    chipram(base+8) <= x"FFFF";
    chipram(base+9) <= x"FFFF";

    when 15 =>
    --  Test 12 : Skip over a SKIP instruction
    ----------------------------------------------------------------
    -- Program:
    --   MOVE #$1111,$0007   -- illegal → skip next
    --   MOVE #$2222,$0007   -- illegal → would skip, but must be skipped itself
    --   MOVE #$DEAD,$0180   -- executed
    --   END
    ----------------------------------------------------------------
    chipram(base+0) <= x"1111";
    chipram(base+1) <= x"0007";

    chipram(base+2) <= x"2222";   -- skipped SKIP
    chipram(base+3) <= x"0007";

    chipram(base+4) <= x"DEAD";   -- executed
    chipram(base+5) <= x"0180";

    chipram(base+6) <= x"FFFF";
    chipram(base+7) <= x"FFFF";
    
    when 16 => 
    --  Test 13 : Randomised SKIP stress test
    ----------------------------------------------------------------
    -- Generate 64 random instructions
    ----------------------------------------------------------------
    for i in 0 to 63 loop
        --rnd := uniform(seed1, seed2) * 65535.0;
        uniform(seed1, seed2, r);
        rnd := integer(r * 65535.0);

        -- 25% illegal MOVE
        if rnd < 16384 then
            chipram(base+i*2)   <= std_logic_vector(to_unsigned(rnd,16));
            chipram(base+i*2+1) <= x"0007";  -- illegal
        -- 25% legal MOVE
        elsif rnd < 32768 then
            chipram(base+i*2)   <= std_logic_vector(to_unsigned(rnd,16));
            chipram(i*2+1) <= x"0180";  -- COLOR00
        -- 25% WAIT
        elsif rnd < 49152 then
            chipram(base+i*2)   <= x"0000";  -- WAIT vpos=0 hpos=0
            chipram(base+i*2+1) <= x"FFFF";
        -- 25% random junk
        else
            chipram(base+i*2)   <= std_logic_vector(to_unsigned(rnd,16));
            chipram(base+i*2+1) <= std_logic_vector(to_unsigned(rnd/2,16));
        end if;
    end loop;
    
                    

    when others =>
      report "Unknown TEST_ID" severity failure;

  end case;

  --------------------------------------------------------------------
  -- Shared init sequence (reset, COP1LC, COPJMP1, SOF, enadma)
  --------------------------------------------------------------------
  reset <= '1';
  wait for 200 ns;
  reset <= '0';

  cpu_reg_addr <= COP1LCH;
  cpu_data_in  <= std_logic_vector(to_unsigned(base, 16));
  wait until rising_edge(clk) and clk7_en='1';

  cpu_reg_addr <= COP1LCL;
  cpu_data_in  <= std_logic_vector(to_unsigned(base, 16));
  wait until rising_edge(clk) and clk7_en='1';

  cpu_reg_addr <= COPJMP1;
  cpu_data_in  <= (others => '0');
  wait until rising_edge(clk) and clk7_en='1';

  cpu_reg_addr <= (others => '0');
  cpu_data_in  <= (others => '0');

  enadma <= '1';
  wait until rising_edge(clk) and clk7_en='1';

  sof <= '1';
  wait until rising_edge(clk) and clk7_en='1';
  sof <= '0';

  wait for 20 us;
  report "Test completed" severity note;
  wait;
end process;

check_proc : process(clk)
  type reg_seq_t is array (0 to 3) of std_logic_vector(8 downto 1);
  constant expected_regs : reg_seq_t :=
    (COLOR00, COLOR01, COLOR02, COLOR03);

  variable idx : integer := 0;
  constant LAST_VALID_ADDR : integer := 5;  -- for WAIT test: 0..5 are valid
  
  variable color00_seen : boolean := false;
  variable color01_seen : boolean := false;

begin

  if rising_edge(clk) then
    if clk7_en = '1' then

      -- Detect COLOR writes
      if reg_address_out = COLOR00 then
        color00_seen := true;
      end if;

      if reg_address_out = COLOR01 then
        color01_seen := true;
      end if;

      -- After enough time, evaluate results
      if now > 5 us then



      case TEST_ID is
        when 1 =>
          -- Only treat COLORxx as valid MOVE targets
          if reg_address_out = COLOR00 or
             reg_address_out = COLOR01 or
             reg_address_out = COLOR02 or
             reg_address_out = COLOR03 then
    
            if idx <= expected_regs'high then
              assert reg_address_out = expected_regs(idx)
                report "Unexpected MOVE target" severity error;
              idx := idx + 1;
            else
              assert false report "Too many MOVE instructions" severity error;
            end if;
            assert color_ram(0) = x"1234" report "COLOR00 mismatch " & slv_to_hex_any(color_ram(0))   severity error;
            assert color_ram(1) = x"5678" report "COLOR01 mismatch " & slv_to_hex_any(color_ram(1))   severity error;
            assert color_ram(2) = x"9ABC" report "COLOR02 mismatch " & slv_to_hex_any(color_ram(2))   severity error;
            assert color_ram(3) = x"FFFF" report "COLOR03 mismatch " & slv_to_hex_any(color_ram(3))   severity error;
          end if;
                  
        when 2 =>                      
          ----------------------------------------------------------------
          -- 1. Normal MOVE checking (your existing logic)
          ----------------------------------------------------------------
          if reg_address_out = COLOR00 or
             reg_address_out = COLOR01 or
             reg_address_out = COLOR02 or
             reg_address_out = COLOR03 then
    
            if idx <= expected_regs'high then
              assert reg_address_out = expected_regs(idx)
                report "Unexpected MOVE target" severity error;
              idx := idx + 1;
            else
              assert false report "Too many MOVE instructions" severity error;
            end if;
          end if;    
          ----------------------------------------------------------------
          -- 2. NEW: No MOVE allowed after list end
          ----------------------------------------------------------------
          if to_integer(unsigned(address_out(20 downto 2))) > LAST_VALID_ADDR then
            assert not (reg_address_out = COLOR00 or
                        reg_address_out = COLOR01 or
                        reg_address_out = COLOR02 or
                        reg_address_out = COLOR03)
              report "Unexpected MOVE after list end" severity error;
          end if;        
        
        
        when 3 =>          
          ------------------------------------------------------------------
          -- SKIP TRUE: COLOR00 must NOT be written, COLOR01 must be written
          ------------------------------------------------------------------
            assert not color00_seen
              report "SKIP TRUE: COLOR00 was written but should have been skipped!" severity error;

            assert color01_seen
              report "SKIP TRUE: COLOR01 was NOT written!" severity error;

            report "SKIP TRUE test passed" severity note;
            

        when 4 =>
          ------------------------------------------------------------------
          -- SKIP FALSE: both COLOR00 and COLOR01 must be written
          ------------------------------------------------------------------          
            assert color00_seen
              report "SKIP FALSE: COLOR00 was NOT written!" severity error;

            assert color01_seen
              report "SKIP FALSE: COLOR01 was NOT written!" severity error;

            report "SKIP FALSE test passed" severity note;

       

        when others =>
          null;

      end case;
     end if;
    end if;
  end if;  
end process;


  --------------------------------------------------------------------
  -- DUT
  --------------------------------------------------------------------
  uut: entity work.agnus_copper_M65
    port map (
       clk             => clk
      ,clk7_en         => clk7_en
      ,reset           => reset
      ,ecs             => '1'
      ,reqdma          => reqdma
      ,ackdma          => ackdma
      ,enadma          => enadma
      ,sof             => sof
      ,blit_busy       => '0'
      ,vpos            => vpos
      ,hpos            => hpos
      ,data_in         => data_in
      ,reg_address_in  => reg_address_in
      ,reg_address_out => reg_address_out
      ,address_out     => address_out
      
      ,copper_state_tb => copper_state_tb
      ,dma_req_tb      => dma_req_tb
      ,enable_tb       => enable_tb      
    );




--rpt : process(clk)
--    variable cycle : integer := 0;
--begin
--    if rising_edge(clk) then
--      --if clk7_en = '1' then
--        cycle := cycle + 1;
        
--        report "[CYCLE "  & integer'image(cycle) & " Time=" & time_to_str(now) & "]"  & "," &
--        " TB SIGNALS: "                                                           & "," &
--                            "reqdma="         & sl_to_str(reqdma)                 & "," &
----                            "chipram(" & integer(to_integer(unsigned(address_out(20 downto 2)))) & ")=" &
----                            slv_to_hex_any(to_integer(unsigned(address_out(20 downto 2))))  & "," & 
--                            "address_out="    & slv_to_hex_any(address_out)       & "," &
--                            "reg_address_in=" & slv_to_hex_any(reg_address_in)    & "," &
--                            "dma_reg_addr="   & slv_to_hex_any(dma_reg_addr)      & "," &
--                            "cpu_reg_addr="   & slv_to_hex_any(cpu_reg_addr)      & "," &
--                            "data_in="        & slv_to_hex_any(data_in)           & "," &
--                            "dma_data_in="    & slv_to_hex_any(dma_data_in)       & "," &
--                            "cpu_data_in="    & slv_to_hex_any(cpu_data_in)       & "," &
--                            "";
--      --end if;
--    end if;
--end process;

end architecture;