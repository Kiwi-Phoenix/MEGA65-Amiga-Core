library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
use work.Amiga_Debug_pkg.all;                
use work.debug_utils_pkg.all;
--use work.tb_debug_helpers.all;
--use work.debug_pkg.all;
--use work.debug_pkg_parm.all;

entity tb_ram_frontend_unified is
end entity;

architecture sim of tb_ram_frontend_unified is
    constant TB_MODE    : boolean := true;

    constant CLK_PERIOD : time := 20 ns;
    
--    constant ADDR_SHARED : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#200000#, 28));    
--    constant ADDR_SHARED : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#000004#, 28));    
    constant ADDR_SHARED : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#C00004#, 28));
            
--    constant ADDR_CHIP   : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#000000#, 28));
    constant ADDR_CHIP   : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#00000A#, 28));
--    constant ADDR_CHIP_1 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#000004#, 28));
--    constant ADDR_CHIP_2 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#000008#, 28));
--    constant ADDR_CHIP_3 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#000016#, 28));
    constant ADDR_CHIP_4 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#000024#, 28));
    constant ADDR_CHIP_1 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#0000AA#, 28));
    constant ADDR_CHIP_2 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#0000AB#, 28));
    constant ADDR_CHIP_3 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#0000AC#, 28));
     
    --constant ADDR_CHIP_1 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#F800AA#, 28));
    
    
    constant ADDR_FAST   : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#200004#, 28));
--    constant ADDR_FAST   : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#600004#, 28));
    constant ADDR_FAST_1 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#200010#, 28));
    constant ADDR_FAST_2 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#200020#, 28));
    constant ADDR_FAST_3 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#200030#, 28));
    constant ADDR_FAST_4 : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#200040#, 28));
    
--    constant ADDR_DMA_1  : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#200050#, 28));
    constant ADDR_DMA_1  : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#200004#, 28));

    constant ADDR_ROM    : std_logic_vector(28 downto 1) := std_logic_vector(to_unsigned(16#F80000#, 28));

    type word_array is array (natural range <>) of std_logic_vector(15 downto 0);

    signal sysclk        : std_logic := '0';
    signal reset_n       : std_logic := '0';

    -- cache/control
    signal cache_rst         : std_logic := '0';
    signal cache_inhibit_ext : std_logic := '0';
    signal cpu_cache_ctrl    : std_logic_vector(3 downto 0) := (others => '0');
    signal tb_cache_inhibit  : std_logic := '0';
       
    -- CPU side
    signal cpuCS     : std_logic := '0';

    signal cpustate  : std_logic_vector(1 downto 0) := "01"; -- idle
    signal cpuL      : std_logic := '1';
    signal cpuU      : std_logic := '1';
    signal cpuAddr   : std_logic_vector(28 downto 1) := (others => '0');
    signal cpuWR     : std_logic_vector(15 downto 0) := (others => '0');
    signal cpuRD     : std_logic_vector(15 downto 0);
--    signal cpu_dat_r_final_i : std_logic_vector(15 downto 0);
    signal cpu_ack   : std_logic;
    signal ramready  : std_logic;
    
    -- CHIP side (held idle for initial tests)
    -- CHIP idle by default
    signal chipDMA      : std_logic := '0';     -- 0 - inactive (low); 1 - active (high)
    signal chipRW       : std_logic := '0';     -- 0 - Read; 1 - Write
    signal chipAddr     : std_logic_vector(24 downto 1) := (others => '0');
    signal chipWR       : std_logic_vector(15 downto 0) := (others => '0');
    signal chipRD       : std_logic_vector(15 downto 0);   
    signal chip_rd_done : std_logic := '0';
    signal dma_wr_done_tb : std_logic := '0';
    signal chip48       : std_logic_vector(47 downto 0);
    
    signal chip48_1     : std_logic_vector(15 downto 0);
    signal chip48_2     : std_logic_vector(15 downto 0);
    signal chip48_3     : std_logic_vector(15 downto 0);
       
    signal chipBurstLen : std_logic_vector(2 downto 0) := (others => '0');
    
    signal chipL        : std_logic := '1';     -- inactive (assuming active low)
    signal chipU        : std_logic := '1';
    
    signal ramshared : std_logic := '0';
    
    signal cpu_cycle_active : boolean := false;

   
begin

    -- clock
    clk_proc : process
    begin
        sysclk <= '0';
        wait for CLK_PERIOD/2;
        sysclk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- reset
rst_proc : process
begin
    reset_n   <= '0';    
    cache_rst <= reset_n;
    wait for 10*CLK_PERIOD;
    reset_n   <= '1';
    cache_rst <= reset_n;
    wait;
end process;

    ------------------------------------------------------------------------
    -- DUT
    ------------------------------------------------------------------------
    dut : entity work.ram_frontend_unified
        generic map (
            DEBUG_ENABLE => true
        )
        port map (
             sysclk          => sysclk
            ,reset_n         => reset_n
            ,cache_rst       => cache_rst
            ,cache_inhibit_ext   => tb_cache_inhibit
            ,cpu_cache_ctrl  => cpu_cache_ctrl

            ,cpuCS           => cpuCS
            ,cpuAddr         => cpuAddr
            ,cpustate        => cpustate
            ,cpuL            => cpuL
            ,cpuU            => cpuU
            ,cpuWR           => cpuWR
            ,cpuRD           => cpuRD
            ,cpu_ack         => cpu_ack

            ,ramready        => ramready

            ,chipAddr        => chipAddr
            ,chipL           => chipL
            ,chipU           => chipU
            ,chipRW          => chipRW
            ,chipDMA         => chipDMA
            ,chipWR          => chipWR

            ,chipRD          => chipRD
            ,chip48          => chip48
            ,chip48_1        => chip48_1
            ,chip48_2        => chip48_2
            ,chip48_3        => chip48_3
            ,chip_rd_done    => chip_rd_done
            
            ,chipBurstLen    => chipBurstLen

            ,dma_wr_done     => dma_wr_done_tb
        );

    ------------------------------------------------------------------------
    -- Simple CPU driver (first few directed tests)
    ------------------------------------------------------------------------
    stimulus : process
        function addr_plus(addr : std_logic_vector(28 downto 1);
                   words : natural)
                   return std_logic_vector is
            variable a : unsigned(addr'range);
        begin
            -- Convert to unsigned, add N words, return same width
            a := unsigned(addr) + to_unsigned(words, addr'length);
            return std_logic_vector(a);
        end function;
                
        -- CPU Write procedure for 68000 CPU
        procedure cpu_write(
            addr    : in std_logic_vector(28 downto 1);
            data    : in std_logic_vector(15 downto 0);
            l_en    : in std_logic := '0';
            u_en    : in std_logic := '0'
        ) is
            variable tries  : integer;        
        begin            
            cpuAddr  <= addr;
            cpuWR    <= data;
            cpuL     <= l_en;
            cpuU     <= u_en;
            cpustate <= "11";   -- write
            cpuCS    <= '1';    -- Must be aserted for cpu write/reads
            wait until rising_edge(sysclk);
            -- hold until ramready observed (if you want strict handshake)
            tries := 0;            
            while cpu_ack = '0' loop       
                    -- Debug report
                    dbg("cpu_write WAIT", "cpuCS", cpuCS, "cpustate", cpustate, "cpu_ack", cpu_ack);
                                            
                wait until rising_edge(sysclk);
                tries := tries + 1;
                if tries = 100 then
                    assert false report "Timeout waiting for ramready in cpu_write" severity error;
                    exit;                        
                end if;                
            end loop;
            
            wait until rising_edge(sysclk);
            
            cpuCS    <= '0';
            cpustate <= "01";   -- idle
            cpuL     <= '1';
            cpuU     <= '1';
            wait until rising_edge(sysclk);
        end procedure;

        -- CPU Read procedure for 68000 CPU
        procedure cpu_read(
            addr    : in std_logic_vector(28 downto 1);
            l_en    : in std_logic;
            u_en    : in std_logic;
            data_out: out std_logic_vector(15 downto 0)
        ) is
            variable tries  : integer;
        begin
            cpuAddr  <= addr;
            cpuL     <= l_en;
            cpuU     <= u_en;
            cpustate <= "10";   -- data read
            cpuCS    <= '1';
            
            wait until rising_edge(sysclk);
            
            tries := 0;
            while cpu_ack = '0' loop
                  -- Debug Report
                  dbg("cpu_read WAIT", "cpuCS", cpuCS, "cpustate", cpustate, "ack", cpu_ack);
                                                                                                      
                wait until rising_edge(sysclk);
                tries := tries + 1;
                if tries = 100 then
                    assert false report "Timeout waiting for ramready in cpu_read" severity error;
                    exit;                        
                end if;                
            end loop;                        

            data_out := cpuRD;
            
            cpuCS    <= '0';
            cpustate <= "01";   -- idle
            cpuL     <= '1';
            cpuU     <= '1';
            wait until rising_edge(sysclk);
            report "cpu_read DONE";
        end procedure;

        --variable v : std_logic_vector(15 downto 0);
        --variable first_read_checked : boolean := false;
        
        ---------------------------------------------------------
        -- DMA Test procedures
        ---------------------------------------------------------
        
        procedure start_cpu_read (
            constant addr : in std_logic_vector(28 downto 1)
         ) is 
         begin
            cpuAddr     <= addr;
            cpuCS       <= '1';
            cpuL        <= '0';
            cpuU        <= '0';
            cpuWR       <= (others => '0'); -- Read
            cpustate    <= "10";            -- Read cycle
         end procedure;
         
         procedure end_cpu_read is
         begin
            cpuCS       <= '0';
            cpuL        <= '1';
            cpuU        <= '1';
            cpustate    <= "01";            -- Idle
         end procedure;
                                       
procedure check_chip48(
    expected1 : std_logic_vector(15 downto 0);
    expected2 : std_logic_vector(15 downto 0);
    expected3 : std_logic_vector(15 downto 0)
) is
begin
    
    report "Check Chip48: chip48_1=" & slv_to_hex16(chip48_1) &
                        " chip48_2=" & slv_to_hex16(chip48_2) &
                        " chip48_3=" & slv_to_hex16(chip48_3)
           severity note;
    report "Check Chip48: expect_1=" & slv_to_hex16(expected1) &
                        " expect_2=" & slv_to_hex16(expected2) &
                        " expect_3=" & slv_to_hex16(expected3)
           severity note;            
    
    assert chip48_1 = expected1
        report "chip48_1 mismatch. Expected=" & slv_to_hex16(expected1) &
               " Got=" & slv_to_hex16(chip48_1)
        severity error;

    assert chip48_2 = expected2
        report "chip48_2 mismatch. Expected=" & slv_to_hex16(expected2) &
               " Got=" & slv_to_hex16(chip48_2)
        severity error;

    assert chip48_3 = expected3
        report "chip48_3 mismatch. Expected=" & slv_to_hex16(expected3) &
               " Got=" & slv_to_hex16(chip48_3)
        severity error;
end procedure;

procedure chip_read(addr : std_logic_vector(28 downto 1)) is
begin
    report "chip_read" severity note;
    -- Ensure DMA is idle
    chipDMA <= '0';    
    wait until rising_edge(sysclk);

    -- Start CHIP read
    chipAddr <= addr(24 downto 1);
    chipRW   <= '0';
    chipDMA  <= '1';
    wait until rising_edge(sysclk);
    
    -- Wait for completion
    wait until chip_rd_done = '1';
    
    -- Drop DMA again so next read can trigger
    chipDMA <= '0';    
    wait until rising_edge(sysclk);    
end procedure;

procedure cpu_read_chip(addr : std_logic_vector(28 downto 1)
                        ) is
    variable data_out: std_logic_vector(15 downto 0);
begin
    report "cpu_read_chip: addr=" & slv_to_hex_any(addr)
            severity note;
    cpuAddr <= addr;
    cpuL    <= '0';
    cpuU    <= '0';
    cpuCS   <= '1';
    cpustate <= "10";       -- Read
                
    -- Assert read state for one cycle
    wait until rising_edge(sysclk);
    report "cpu_read_chip1: addr=" & slv_to_hex_any(addr) &
            " cpuCS= " & cpuCS'image(cpucs)
            severity note;    
      
    wait until cpu_ack = '1';
    
    -- Sample the external CPU data bus
    data_out := cpuRD;
    
    cpuCS   <= '0';
    cpuL    <= '1';
    cpuU    <= '1';
    cpustate    <= "01";    -- Idle
    wait until rising_edge(sysclk);           
end procedure;

procedure cpu_read_fast(
    addr  : in  std_logic_vector(28 downto 1);
    data  : out std_logic_vector(15 downto 0)
) is
begin
    cpuAddr  <= addr;
    cpuL     <= '0';
    cpuU     <= '0';
    cpuCS    <= '1';    -- Must assert cpuCS as well as setting cpustate for a read.
    cpustate <= "10";  -- read

    wait until rising_edge(sysclk);
    
    report "cpu_read_fast: addr=" & slv_to_hex_any(addr) &
            " cpuCS=" & cpucs'image(cpucs) &
            " cpustate=" & slv_to_hex_any(cpustate) 
        severity note;
    
    wait until cpu_ack = '1';  -- unified CPU read ack

    data := cpuRD;    
    
    cpuCS   <= '0';    
    cpuL    <= '1';
    cpuU    <= '1';  
    cpustate <= "01";   -- Idle      
    wait until rising_edge(sysclk);        
end procedure;

procedure cpu_read_chip(
    addr  : in  std_logic_vector(28 downto 1);
    data  : out std_logic_vector(15 downto 0)
) is
begin
    cpuAddr  <= addr;
    cpuL     <= '0';
    cpuU     <= '0';
    cpuCS    <= '1';
    cpustate <= "10";

    wait until rising_edge(sysclk);
    wait until cpu_ack = '1';
    data := cpuRD;

    cpuCS   <= '0';
    cpuL    <= '1';
    cpuU    <= '1';
    cpustate    <= "01";
    wait until rising_edge(sysclk);
end procedure;
        
----------------------------------------------------------------------------------------------------------------
-- Test case procedures
----------------------------------------------------------------------------------------------------------------
        
        procedure Test01 is
            variable v : std_logic_vector(15 downto 0);
        begin   
            --------------------------------------------------------------------
            -- Test 1: simple uncached CHIP write/read (cache inhibited by region)
            -- Basic uncached read/write
            --------------------------------------------------------------------
            report "TB: starting Test1 CHIP write/read" severity note;
            cpu_cache_ctrl      <= "0001";  -- cache enabled
            cache_inhibit_ext   <= '0';
            ramshared           <= '0';
    
            -- Use an address in CHIP region (0x000000)
            report "Test1: Begin Write" severity note;
            cpu_write( ADDR_CHIP, x"1234", '0', '0');  -- full word            
            --cpu_write( ADDR_ROM, x"1234", '0', '0');  -- full word            
            
            wait until rising_edge(sysclk);
    
            report "Test1: End Write" severity note;                                    
            report "Test1: Begin 1st Read" severity note;                

            cpu_read( ADDR_CHIP, '0', '0', v);
            --cpu_read( ADDR_ROM, '0', '0', v);
            
            report "Test1: End 1st Read v=" & slv_to_hex(v) 
                severity note;
                        assert v = x"1234"
              report "Test1 FAIL: CHIP readback mismatch expecting 1234"
              severity error;  
            
            report "Test1: Begin 2nd Read" severity note;
            
            cpu_read( ADDR_CHIP, '0', '0', v);
            --cpu_read( ADDR_ROM, '0', '0', v);
            
            report "Test1: End 2nd Read v=" & slv_to_hex(v)
                 severity note;
            
            report "TB: Test1 second read v=" & slv_to_hex(v) severity note;
            assert v = x"1234"
              report "Test1 FAIL: CHIP readback mismatch expecting 1234"
              severity error;        
    
            report "TB: Test1 completed" severity note;
            
            wait until rising_edge(sysclk);
        end procedure Test01;        
        
        procedure Test02 is
            variable v : std_logic_vector(15 downto 0);
        begin
                --------------------------------------------------------------------
                -- Test 2: shared (RTG-style) region byte-swap behaviour
                -- pick a non-CHIP address (e.g. 0x200000: bit 21 = 1)
                -- Region decoding
                --------------------------------------------------------------------
                report "TB: starting Test2 shared write/read" severity note;
                ramshared <= '1';
        
                cpu_write(ADDR_SHARED, x"A1B2", '0', '0');               
                cpu_read( ADDR_SHARED, '0', '0', v);               
                report "TB: Test2 readback v=" & slv_to_hex(v) severity note;
        
                cpu_read( ADDR_SHARED, '0', '0', v);
                report "TB: Test2 second read v=" & slv_to_hex(v) severity note;
        
                assert v = x"A1B2"
                    report "Test2 FAIL: shared region byte-swap incorrect"
                    severity error;
                report "TB: Test2 completed" severity note;
        end procedure Test02;
        
        procedure Test03 is
            variable v : std_logic_vector(15 downto 0);
        begin
                -----------------------------------------------------------------------------
                -- Test3: FAST RAM cache hit
                -- Test Objective:
                -- * Make sure a second read to the same FAST address is served by the cache.
                -- * We'll observe this via cache_cpu_ack or existing cache debug, e.g. dbg_hit, plus timing.
                -- FAST read miss -> fill -> hit
                -----------------------------------------------------------------------------        
                
                report "TB: starting Test3 FAST cache hit" severity note;
                      
                -- 1. Write a known value to FAST RAM (bypass cache in phase 1)
                cpu_write(ADDR_FAST, x"55AA", '0', '0');
                report "Test03: Write Completed";
                
                wait until rising_edge(sysclk);
                
                -- 2. First read: should be a miss (cache_cpu_ack=0, BRAM path)
                cpu_read(ADDR_FAST, '0', '0', v);
                report "TB: Test3 first read v=" & slv_to_hex(v) severity note;
                assert v = x"55AA" report "Test3 FAIL: first FAST read wrong" severity error;
                       
                wait until rising_edge(sysclk);
                
                -- 3. Second read: should be a hit (cache_cpu_ack=1, cache path)
                cpu_cache_ctrl  <= "0001";      -- enable 
                
                cpu_read(ADDR_FAST, '0', '0', v);
                report "TB: Test3 second read v=" & slv_to_hex(v) severity note;
                assert v = x"55AA" report "Test3 FAIL: second FAST read wrong" severity error;
                
                report "TB: Test3 completed" severity note;
        end procedure Test03;
        
        procedure Test04 is
            variable v : std_logic_vector(15 downto 0);
        begin
                -----------------------------------------------------------------------------
                -- Test4: CHIP region must be cache-inhibited
                -- Test objective:
                -- * Confirm that cache is never used for CHIP region (inhibited).
                -- * Read behaviour must be identical to existing TB1.
                -- Cache inhibit
                -----------------------------------------------------------------------------        
                
                report "TB: starting Test4 CHIP cache inhibit" severity note;
                        
                 wait for 4*CLK_PERIOD;     -- or even just 2 cycles
                -- 1. Write a distinct value to CHIP
                cpu_write(ADDR_CHIP_2, X"CAFE", '0', '0');
                
                -- 2. Read it back
                cpu_read(ADDR_CHIP_2, '0', '0', V);
                report "TB: Test4 CHIP readback v=" & slv_to_hex(v) severity note;
                
                -- 3. Read again (cache should still be inhibited, so no change in behaviour)
                cpu_read(ADDR_CHIP_2, '0', '0', v);
                report "TB: Test4 CHIP readback (2nd) v=" & slv_to_hex(v) severity note;
                
                report "TB: Test4 completed" severity note;
        end procedure Test04;
        
        procedure Test05 is
            variable v : std_logic_vector(15 downto 0);
        begin
                --------------------------------------------------------------------
                -- Test 5: FAST write only (no read) - ensure no cache pollution
                -- Goad: ensure that a FAST write by itself does not create a valid cache line (in Stage 1)
                -- Shared Region
                --------------------------------------------------------------------
                
                report "TB: starting Test5 FAST write-only" severity note;
                
                cpu_write(ADDR_FAST, x"1111", '0', '0');
                
                -- Optionally trigger a dummy read purely to see a miss:
                cpu_read(ADDR_FAST, '0', '0', v);
                -- For Stage 1, first read shuld still be a miss (as in Test3)
                -- and we know from the cache logs it's MISS_WAIT/FILL, not a hit.
                
                report "TB: Test5 completed" severity note;
        end procedure Test05;
  
        procedure Test06 is
            variable v : std_logic_vector(15 downto 0);
        begin
                --------------------------------------------------------------------
                -- Test 6: FAST reads with cache disabled.
                -- Goal: prove that turning the cache off restores "uncached FAST" behaviour.
                -- Snoop
                --------------------------------------------------------------------
                
                report "TB: starting Test6 FAST uncached mode" severity note;
                
                cpu_cache_ctrl      <= "0000";  -- disable cache
                cache_inhibit_ext   <= '0';
                ramshared           <= '0';
                
                cpu_write(ADDR_FAST, x"1234", '0', '0');
                report "Test6: Write Completed"; 
                
                -- *** allow BRAM latency to settle *** it can take a cycle or more.
                -- The CPU expects to wait for 1 cycle.
                wait until rising_edge(sysclk);
                       
                cpu_read(ADDR_FAST, '0', '0', v);
                report "Test06: Read data=" & slv_to_hex16(v);
                assert v = x"1234" report "Test6 FAIL: FAST first read wrong (uncached)" severity error;
                
                -- *** again allow BRAM latency to settle ***
                wait until rising_edge(sysclk);
        
                cpu_read(ADDR_FAST, '0', '0', v);
                report "Test06: Read data=" & slv_to_hex16(v);       
                assert v = x"1234" report "Test6 FAIL: FAST second read wrong (uncached)" severity error; 
                              
                report "TB Test6 completed" severity note;
        end procedure Test06;
  
        procedure Test07 is
            variable v : std_logic_vector(15 downto 0);
        begin
                --------------------------------------------------------------------
                -- Test 7: FAST Write-Through on Hit 
                -- Goal: Prove that a write to a cached line updates both BRAM and cache
                --       and subsequent reads see the new value from cache.
                -- Write-through on hit
                --------------------------------------------------------------------
                report "TB: starting Test7 FAST  write-through on hit" severity note;
                
                cpu_cache_ctrl  <= "0011";      -- enable + write-enable
                
                cpu_write(ADDR_FAST, x"9999", '0', '0');
                report "Test7: Write completed";
                
                wait until rising_edge(sysclk);                        
           
                -- First read after write-through:
                -- NOTE: The cache will miss and return 0000 until SDRAM data arrives.
                --       Only check the read once the returned value is non-zero.
                cpu_read(ADDR_FAST, '0', '0', v);
                                  
                if v /= x"0000" then
                    assert v = x"9999" report "Test7 FAIL: first read after write-through wrong" 
                        severity error;           
                end if;
                        
                -- Second read must hit and return the updated value
                cpu_read(ADDR_FAST, '0', '0', v);
                assert v = x"9999" report "Test7 FAIL: second read after write-through wrong" severity error;
                
                Report "TB Test7 completed" severity note;
        end procedure Test07;
        
        procedure Test08 is
            variable v : std_logic_vector(15 downto 0);
        begin
                --------------------------------------------------------------------
                -- Test 8: FAST Write-Miss (No Write-Allocate)
                -- Goal: Prove that a write to a non-cached FAST address:
                --      - Updates BRAM
                --      - Does NOT allocate a cache line
                --      - Subsequent reads behave like uncahced reads (BRAM latency)
                -- write-miss, no write-allocate               
                --------------------------------------------------------------------
                report "TB: starting Test8 FAST write-miss (no write-allocate)" severity note;       
        
                cpu_cache_ctrl <= "0011";       -- enable + write-through
                
                -- Choose a FAST address that is NOT cached yet
                -- (must differ from teh one used in Test3/Test7)
                cpu_write(ADDR_FAST_2, x"ABCD", '0', '0');
        
                wait until rising_edge(sysclk);
               
                -- First read: should come from BRAM (latency path), NOT cache
                -- Note: first read after write-miss may see stale cache data
                -- due to cache FSM timing;
                cpu_read(ADDR_FAST_2, '0', '0', v);
                -- Give the cache time to complete the miss-fill
                -- NOTE: Cache miss-fill takes multiple cycles. cpu_read returns early (on ack),
                -- so we wait 1-2 cycles before sampling cpuRD to ensure stable data.
        
                report "TB: Test8 first read v=" & slv_to_hex16(v) severity note;
        
                wait until rising_edge(sysclk);
                                       
                -- Second read: Still BRAM (no cache allocation)
                -- Can't assert due to a testbench visibility and timing limitation.
                -- The logs should show this working correctly.
                cpu_read(ADDR_FAST_2, '0', '0', v);
        
                report "TB: Test8 second read v=" & slv_to_hex16(v) severity note;
                assert v = x"ABCD"
                    report "Test8 FAIL: second read after write-miss wrong"
                    severity error;
                            
                report "TB Test8 completed" severity note;      
        end procedure Test08;
        
       procedure Test8A is
            variable v : std_logic_vector(15 downto 0);
        begin   
            --------------------------------------------------------------------
            -- Test 8A: Simple multiple read/write test
            -- Basic uncached read/write
            --------------------------------------------------------------------
            report "TB: starting Test8A CHIP write/read" severity note;
            --cpu_cache_ctrl      <= "0011";  -- cache enabled
            cache_inhibit_ext   <= '1';
            ramshared           <= '0';
    
            -- Use an address in CHIP region (0x000000)
            report "Test8A: Begin Write" severity note;
            cpu_write( ADDR_CHIP_1, x"ABBA", '0', '0');  -- full word
            cpu_write( ADDR_CHIP_2, x"BABA", '0', '0');  -- full word
            cpu_write( ADDR_CHIP_3, x"CACA", '0', '0');  -- full word
            cpu_write( ADDR_CHIP_4, x"DADA", '0', '0');  -- full word
            
            wait until cpu_ack = '1';
            wait until rising_edge(sysclk);
            report "Test8A: End Write" severity note;
    
            report "Test8A: Begin 1st Read" severity note;    
                                                
            cpu_read( ADDR_CHIP_1, '0', '0', v);
            report "Test8A: Read data v=" & slv_to_hex16(v) severity note;
            assert v = x"ABBA"
              report "Test8A FAIL: CHIP readback mismatch expecting ABBA"
              severity error;
              
            cpu_read( ADDR_CHIP_2, '0', '0', v);
            report "Test8A: Read data v=" & slv_to_hex16(v) severity note;
            assert v = x"BABA"
              report "Test8A FAIL: CHIP readback mismatch expecting BABA"
              severity error;
              
            cpu_read( ADDR_CHIP_3, '0', '0', v);
            report "Test8A: Read data v=" & slv_to_hex16(v) severity note;
            assert v = x"CACA"
              report "Test8A FAIL: CHIP readback mismatch expecting CACA"
              severity error;
              
            cpu_read( ADDR_CHIP_4, '0', '0', v);
            report "Test8A: Read data v=" & slv_to_hex16(v) severity note;
            assert v = x"DADA"
              report "Test8A FAIL: CHIP readback mismatch expecting DADA"
              severity error;
                                             
    
            report "TB: Test8A completed" severity note;
            
            wait until rising_edge(sysclk);

        end procedure Test8A;    
  
        procedure Test09 is
            variable v : std_logic_vector(15 downto 0);
        begin
           --------------------------------------------------------------------
           -- Test 9: Cache-Inhibit Behaviour (FAST region)
           -- Goal: Prove that cache-inhibit:
           --   - Bypasses cache for reads/writes
           --   - Does not allocate or update cache lines
           --   - Leaves existing cached lines untouched
           --------------------------------------------------------------------
           report "TB: starting Test9 FAST cache-inhibit behaviour" severity note;
       
           --------------------------------------------------------------------
           -- Helper: enable cache + write-through, but inhibit FAST region
           --------------------------------------------------------------------
           cpu_cache_ctrl <= "0011";  -- cache enabled, write-through
                 
        end procedure Test09;
        
        procedure Test9A is
            variable v : std_logic_vector(15 downto 0);
        begin
                   --------------------------------------------------------------------
                   -- Test9A: Cache-inhibit read (FAST region)
                   --  - Write to FAST address with cache inhibited
                   --  - Read back: must bypass cache, come via BRAM/SDRAM path
                   --  - No cache line allocated/updated
                   --------------------------------------------------------------------
                   report "TB: Test9A cache-inhibit read (FAST)" severity note;
               
                   v := (others => '0');
                   tb_cache_inhibit <= '1';
               
                   -- Write to FAST_1 with cache inhibited
                   cpu_write(ADDR_FAST_1, x"1111", '0', '0');
                   wait until rising_edge(sysclk);        
               
                   -- First read: should behave like uncached read (latency path)
                   cpu_read(ADDR_FAST_1, '0', '0', v);
                   wait until rising_edge(sysclk);
                   report "TB: Test9A first read v=" & slv_to_hex16(v) severity note;
               
                   -- We only assert data here; cache behaviour is verified via logs.
                   assert v = x"1111"
                       report "Test9A FAIL: cache-inhibit read returned wrong data"
                       severity error;
                       
                   report "TB Test9A completed" severity note;
        end procedure Test9A;
        
        procedure Test9B is
            variable v : std_logic_vector(15 downto 0);
        begin
                ------------------------------------------------------------------
                -- Test9B: Cache-inhibit write (FAST region)
                --  - Write to FAST_2 with cache inhibited
                -- - Confirm BRAM/SDRAM updated
                --  - No cache allocation (verified via logs)
                ------------------------------------------------------------------
                report "TB: Test9B cache-inhibit write (FAST)" severity note;
            
                v := (others => '0');
                tb_cache_inhibit <= '1';        
            
                -- Write to FAST_2 with cache inhibited
                cpu_write(ADDR_FAST_2, x"2222", '0', '0');
                wait until rising_edge(sysclk);
            
                -- Read back: should see 2222 via uncached path
                cpu_read(ADDR_FAST_2, '0', '0', v);
                wait until rising_edge(sysclk);

                report "TB: Test9B read-back v=" & slv_to_hex16(v) severity note;
            
                assert v = x"2222"
                    report "Test9B FAIL: cache-inhibit write did not update memory"
                    severity error;
        
                report "TB Test9B completed" severity note;
        end procedure Test9B;
        
        procedure Test9C is
            variable v : std_logic_vector(15 downto 0);
        begin
                --------------------------------------------------------------------
                -- Test9C: Cache-inhibit does not pollute or flush cache
                --  - Fill a cache line at FAST_3 (normal cached read)
                --  - Enable cache-inhibit for FAST_2 and write there
                --  - Re-read FAST_3: must still hit in cache with original data
                --------------------------------------------------------------------
                report "TB: Test9C cache-inhibit does not disturb existing cache" severity note;
            
                v := (others => '0');
                cpu_cache_ctrl   <= "0011";         -- Enable cache / write through
                tb_cache_inhibit <= '0';            -- Do not inhibit cache        
            
                -- First, ensure FAST_3 is cached (normal read, no inhibit)
                -- Temporarily rely on region decode to make FAST_3 cacheable.
                -- If needed, adjust your region map so ADDR_FAST_3 is cacheable.
                cpu_write(ADDR_FAST_3, x"3333", '0', '0');
                wait until rising_edge(sysclk);
            
                cpu_read(ADDR_FAST_3, '0', '0', v);
                wait until rising_edge(sysclk);
                                                               
                report "TB: Test9C initial cached read v=" & slv_to_hex16(v) severity note;
                assert v = x"3333"
                    report "Test9C FAIL: initial cached read wrong"
                    severity error;
            
                -- Now ensure FAST_2 is cache-inhibited (as in Test9B)
                tb_cache_inhibit <= '1';
                cpu_write(ADDR_FAST_2, x"2A2A", '0', '0');
                wait until rising_edge(sysclk);
            
                -- Re-read FAST_3: should still be cached, unchanged
                tb_cache_inhibit <= '0';
                cpu_read(ADDR_FAST_3, '0', '0', v);
                wait until rising_edge(sysclk);

                report "TB: Test9C re-read cached line v=" & slv_to_hex16(v) severity note;
            
                assert v = x"3333"
                    report "Test9C FAIL: cache-inhibit operation disturbed existing cache line"
                    severity error;
            
                report "TB Test9C completed" severity note;
        end procedure Test9C;
        
        procedure Test9D is
            variable v : std_logic_vector(15 downto 0);
        begin
                --------------------------------------------------------------------
                -- Test9D: Cache-inhibit overrides write-through hit logic
                --  - Fill a cache line at FAST_4 (cached)
                --  - Enable cache-inhibit for FAST_1
                --  - Write new value to FAST_1: cache must NOT update
                --  - Next read should miss, fetch from memory, then update cache
                --------------------------------------------------------------------
                report "TB: Test9D cache-inhibit overrides write-hit update" severity note;
                
                v := (others => '0');
              
                -- Step 0: explicityly establish the cached line for this test
                tb_cache_inhibit <= '0';
                cpu_write(ADDR_FAST_4, X"1111", '0', '0');
                wait until rising_edge(sysclk);
                                 
                -- Step 1: ensure FAST_4 is cached with 1111 (already done in 9A)
                -- Re-read to confirm
                -- Confirm FAST_4 is cached with 1111                
                cpu_read(ADDR_FAST_4, '0', '0', v);
                wait until rising_edge(sysclk);

                report "TB: Test9D pre-check cached read v=" & slv_to_hex16(v) severity note;
                assert v = x"1111"
                    report "Test9D FAIL: pre-check cached read wrong"
                    severity error;
            
                -- Step 2: write new value with cache-inhibit active
                -- Write new value with cache-inhibit active
                tb_cache_inhibit <= '1';
                cpu_write(ADDR_FAST_4, x"1D1D", '0', '0');
                wait until rising_edge(sysclk);
            
                -- Step 3: first read after inhibit-write:
                --   With cache-inhibit active, this MUST bypass cache and return 1D1D.
                -- First read MUST bypass cache and return 1D1D
                cpu_read(ADDR_FAST_4, '0', '0', v);
                wait until rising_edge(sysclk);

                report "TB: Test9D first read after inhibit-write v=" & slv_to_hex16(v) severity note;
                assert v = x"1D1D"
                    report "Test9D FAIL: inhibit-read did not bypass cache"
                    severity error;
                              
                -- Step 4: second read: must see 1D1D (from memory, then cached)
                -- Disable inhibit so cache can refill
                tb_cache_inhibit <= '0';
                cpu_read(ADDR_FAST_4, '0', '0', v);
                wait until rising_edge(sysclk);

                report "TB: Test9D second read after inhibit-write v=" & slv_to_hex16(v) severity note;
            
                assert v = x"1D1D"
                    report "Test9D FAIL: second read after inhibit-write wrong"
                    severity error;
                    
                    
                report "TB Test9D completed" severity note;            
            
                report "TB Test9 completed" severity note;
        end procedure Test9D;
        
        procedure Test10A is
            variable v : std_logic_vector(15 downto 0);
            variable v_cpu : std_logic_vector(15 downto 0);
        begin
            report "TB: Test10A DMA-only CHIP read" severity note;
        
            -- 1. Initialise memory at CHIP address
            cpu_write(ADDR_CHIP_1, x"ABCD", '0', '0');
            report "Test10A: Write Completed";
            wait for 100 ns;
        
            -- 2. Trigger DMA read
            chipDMA     <= '1';   -- DMA active
            chipRW      <= '0';   -- read
            chipAddr    <= ADDR_CHIP_1(24 downto 1);                                    
        
            report "TB: Test10A DMA read issued at addr=" & slv_to_hex_any(ADDR_CHIP_1) severity note;
        
            -- 3. Wait for DMA completion           
            wait until chip_rd_done = '1';
            wait until rising_edge(sysclk);
                       
            v := chipRD;
            
            report "TB: Test10A DMA read returned v=" &
                    slv_to_hex16(v) severity note;
                                
            assert v = x"ABCD"
              report "Test10A FAIL: DMA read returned wrong value"
              severity error;
        
            report "TB Test10A completed" severity note;
        end procedure Test10A;
        
        procedure Test10B is
            variable v_cpu : std_logic_vector(15 downto 0);
            variable v_dma : std_logic_vector(15 downto 0);
        begin
            report "TB: Test10B CPU vs DMA contention" severity note;
        
            -- 1. Initialise memory
            cpu_write(ADDR_CHIP_1, x"1111", '0', '0');
            cpu_write(ADDR_CHIP_2, x"2222", '0', '0');
            report "Test10B: Write Completed";
            
            wait for 100 ns;
        
            -- 2. Start CPU read (will be stalled)
            report "TB: Test10B issuing CPU read (will be stalled)" severity note;
            --fork_cpu_read(ADDR_CHIP_1);  -- your TB helper that asserts cpuCS etc.
            start_cpu_read(ADDR_CHIP_1);  -- your TB helper that asserts cpuCS etc.
            
            -- Allow request to be visible before DMA asserts
            wait for 1 ns;
            
            -- 3. Immediately trigger DMA read (should win arbitration                       
            chipDMA     <= '1';  -- DMA Active
            chipRW      <= '0';  -- Read
            chipAddr    <= ADDR_CHIP_2(24 downto 1);
            
            report "TB: Test10B DMA issued at addr=" &
                    slv_to_hex_any(ADDR_CHIP_2) severity note;
                    
            -- 4. Wait for DMA completion                            
            wait until chip_rd_done = '1';
            wait until rising_edge(sysclk);
            v_dma := chipRD;
        
            report "TB: Test10B DMA read returned v=" & slv_to_hex16(v_dma) severity note;
        
            assert v_dma = x"2222"
              report "Test10B FAIL: DMA read wrong"
              severity error;
        
            chipDMA <= '0';     -- deassert chipDMA
            chipRW  <= '0';
        
            -- 5. Now CPU read should complete AFTER DMA
            wait until cpu_ack = '1';
            
            v_cpu := cpuRD;
                                    
            report "TB: Test10B CPU read return v=" &
                    slv_to_hex16(v_cpu) severity note;                                
        
            assert v_cpu = x"1111"
              report "Test10B FAIL: CPU read wrong after DMA"
              severity error;
            
            end_cpu_read;
            
            report "TB Test10B completed" severity note;
        end procedure Test10B;
        
        procedure Test10C is
            -- Note: for this test we need to mirror the behavour of Agnus and pulse the chipDMA signal for each read.
            variable v : std_logic_vector(15 downto 0);
        begin
            report "TB: Test10C sequential DMA reads" severity note;
        
            -- Initialise
            cpu_write(ADDR_CHIP_1, x"AAAA", '0', '0');
            cpu_write(ADDR_CHIP_2, x"BBBB", '0', '0');
            cpu_write(ADDR_CHIP_3, x"CCCC", '0', '0');
        
            wait for 100 ns;
        
            -- DMA read 1: ADDR_CHIP_1 -> AAAA            
            chipRW      <= '0'; -- Read
            chipAddr    <= ADDR_CHIP_1(24 downto 1);
            
            wait until rising_edge(sysclk);
            report "TB: Test10C: starting read1...";
            chipDMA     <= '1';             -- pulse: request one DMA read
            wait until rising_edge(sysclk);
            chipDMA     <= '0';
            
            -- Wait for completion
            wait until chip_rd_done = '1';     
            wait until rising_edge(sysclk);     -- ensure chipRD has fully settled
            v := chipRD;       
            report "TB: Test10C DMA read1 v=" & slv_to_hex16(v) severity note;
            assert v = x"AAAA" 
                     report "Test10C FAIL: DMA read1 expected AAAA" severity error;
            
            -- ensure chip_rd_done is low again      
            report "TB: Test10C: waiting for chip_rd_done=0";              
            wait until chip_rd_done = '0';          -- ensure clean for next
        
            -- DMA read 2: ADDR_CHIP_2 -> BBBB
            chipAddr    <= ADDR_CHIP_2(24 downto 1);
            
            wait until rising_edge(sysclk);
            report "TB: Test10C: Trigger chipDMA<=1";
            chipDMA     <= '1';
            
            wait until rising_edge(sysclk);
            report "TB: Test10C: Trigger chipDMA<=0";
            
            chipDMA      <= '0';
            
            report "TB: Test10C: waiting for chip_rd_done=1";
            wait until chip_rd_done = '1';
            wait until rising_edge(sysclk);            
            report "TB: Test10C: sample data from chipRD";
                        
            v := chipRD;        
            report "TB: Test10C DMA read2 v=" & slv_to_hex16(v) severity note;
            assert v = x"BBBB" 
                report "Test10C FAIL: DMA read2 expected BBBB" severity error;
                        
            wait until chip_rd_done = '0';
        
            -- DMA read 3: ADDR_CHIP_3 -> CCCC
            chipAddr <= ADDR_CHIP_3(24 downto 1);
            
            wait until rising_edge(sysclk);
            chipDMA <= '1';
            wait until rising_edge(sysclk);
            chipDMA <= '0';            
            
            wait until chip_rd_done = '1';
            wait until rising_edge(sysclk);
            v := chipRD;
            report "TB: Test10C DMA read3 v=" & slv_to_hex16(v) severity note;
            assert v = x"CCCC" 
                report "Test10C FAIL: DMA read3 expected CCCC" severity error;
            
            wait until chip_rd_done = '0';
            
            report "TB Test10C completed" severity note;
        end procedure Test10C;
                
        procedure Test10D is
            variable v : std_logic_vector(15 downto 0);
        begin
            report "TB: Test10D DMA write test" severity note;
        
            -- 1. Initialise memory via CPU
            cpu_write(ADDR_CHIP_1, x"0000", '0', '0');
            report "Test10D: CPU Write completed";
            wait for 100 ns;
        
            -- 2. DMA WRITE (one pulse = one transfer)            
            chipRW      <= '1';  -- write
            chipAddr    <= ADDR_CHIP_1(24 downto 1);
            chipWR      <= x"DEAD";
        
            wait until rising_edge(sysclk);
            chipDMA <= '1';  -- DMA Active / pulse DMA request
            wait until rising_edge(sysclk);
            chipDMA <= '0';
        
            report "TB: Test10D DMA write issued: DEAD" severity note;
        
            -- Writes complete immediately in teh controller, but give one cycle
            wait until rising_edge(sysclk);               
        
            -- 3. CPU read back
            cpu_read(ADDR_CHIP_1, '0', '0', v);
        
            report "TB: Test10D CPU read-back v=" &
                   slv_to_hex16(v) severity note;
        
            assert v = x"DEAD"
              report "Test10D FAIL: DMA write did not update memory"
              severity error;
        
            report "TB Test10D completed" severity note;
            
        end procedure;
        
        procedure Test10E is
            variable v : std_logic_vector(15 downto 0);
        begin
            report "TB: Test10E CPU vs DMA arbitration test" severity note;
        
            ----------------------------------------------------------------
            -- 1. CPU initialises memory
            ----------------------------------------------------------------
            cpu_write(ADDR_CHIP_1, x"1111", '0', '0');
            report "Test10E: CPU Write completed";
            wait for 50 ns;
        
            ----------------------------------------------------------------
            -- 2. DMA writes a new value (DEAD)
            ----------------------------------------------------------------
            chipRW   <= '1';  -- write
            chipAddr <= ADDR_CHIP_1(24 downto 1);
            chipWR   <= x"DEAD";
        
            wait until rising_edge(sysclk);
            chipDMA <= '1';   -- pulse DMA write
            wait until rising_edge(sysclk);
            chipDMA <= '0';
        
            report "TB: Test10E DMA write issued: DEAD" severity note;
        
            -- DMA write completes immediately
            wait until rising_edge(sysclk);
        
            ----------------------------------------------------------------
            -- 3. CPU attempts to read while DMA is active (should stall)
            ----------------------------------------------------------------
            report "Test10E: Start CPU Read";
            cpu_read(ADDR_CHIP_1, '0', '0', v);
        
            report "TB: Test10E CPU read-back v=" & slv_to_hex16(v) severity note;
        
            assert v = x"DEAD"
              report "Test10E FAIL: CPU did not see DMA-updated value"
              severity error;
        
            ----------------------------------------------------------------
            -- 4. CPU writes a new value (BEEF)
            ----------------------------------------------------------------
            cpu_write(ADDR_CHIP_1, x"BEEF", '0', '0');
            report "Test10E: CPU Write completed";
            
            -- CPU write completes immediately
            wait until rising_edge(sysclk);
        
            ----------------------------------------------------------------
            -- 5. DMA reads back the value (should see BEEF)
            ----------------------------------------------------------------
            chipRW   <= '0';  -- read
            chipAddr <= ADDR_CHIP_1(24 downto 1);
        
            wait until rising_edge(sysclk);
            chipDMA <= '1';   -- pulse DMA read
            wait until rising_edge(sysclk);
            chipDMA <= '0';
        
            wait until chip_rd_done = '1';
            wait until rising_edge(sysclk);
            v := chipRD;
        
            report "TB: Test10E DMA read-back v=" & slv_to_hex16(v) severity note;
        
            assert v = x"BEEF"
              report "Test10E FAIL: DMA did not see CPU-updated value"
              severity error;
        
            report "TB Test10E completed" severity note;
        end procedure Test10E;

procedure Test10F is
    variable v1, v2, v3, v4 : std_logic_vector(15 downto 0);
begin
    report "TB: Test10F DMA burst sequential reads" severity note;

    ----------------------------------------------------------------
    -- 1. Initialise 4 CHIP words via CPU
    ----------------------------------------------------------------
    cpu_write(ADDR_CHIP_1, x"AA11", '0', '0');
    cpu_write(ADDR_CHIP_2, x"BB22", '0', '0');
    cpu_write(ADDR_CHIP_3, x"CC33", '0', '0');
    cpu_write(ADDR_CHIP_4, x"DD44", '0', '0');  -- define ADDR_CHIP_4 accordingly
    
    report "Test10F: CPU Write Completed";
    wait for 100 ns;

    ----------------------------------------------------------------
    -- 2. DMA burst: 4 consecutive reads, 1 pulse each
    ----------------------------------------------------------------
    report "Test10F: Start Burst Read";
    chipRW <= '0';  -- read

    -- Read 1
    chipAddr <= ADDR_CHIP_1(24 downto 1);
    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v1 := chipRD;
    wait until chip_rd_done = '0';

    -- Read 2
    chipAddr <= ADDR_CHIP_2(24 downto 1);
    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v2 := chipRD;
    wait until chip_rd_done = '0';

    -- Read 3
    chipAddr <= ADDR_CHIP_3(24 downto 1);
    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v3 := chipRD;
    wait until chip_rd_done = '0';

    -- Read 4
    chipAddr <= ADDR_CHIP_4(24 downto 1);
    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v4 := chipRD;
    wait until chip_rd_done = '0';

    ----------------------------------------------------------------
    -- 3. Check data and ordering
    ----------------------------------------------------------------
    report "TB: Test10F DMA burst values: " &
           slv_to_hex16(v1) & "," &
           slv_to_hex16(v2) & "," &
           slv_to_hex16(v3) & "," &
           slv_to_hex16(v4)
           severity note;

    assert v1 = x"AA11" report "Test10F FAIL: burst read1" severity error;
    assert v2 = x"BB22" report "Test10F FAIL: burst read2" severity error;
    assert v3 = x"CC33" report "Test10F FAIL: burst read3" severity error;
    assert v4 = x"DD44" report "Test10F FAIL: burst read4" severity error;

    report "TB Test10F completed" severity note;
end procedure Test10F;     

procedure Test10G is
    variable v1, v2, v3 : std_logic_vector(15 downto 0);
begin
    report "TB: Test10G DMA burst 3-Beat read" severity note;

    ----------------------------------------------------------------
    -- 1. Initialise 3 CHIP words via CPU
    -- NB: MUST be consective memory addresses.
    ----------------------------------------------------------------
    cpu_write(ADDR_CHIP_1, x"AAAA", '0', '0');
    cpu_write(ADDR_CHIP_2, x"BBBB", '0', '0');
    cpu_write(ADDR_CHIP_3, x"CCCC", '0', '0');

    report "Test10G: Write completed" severity note;
    
    --wait for 100 ns;
    wait until rising_edge(sysclk);
    
    chipAddr        <= ADDR_CHIP_1(24 downto 1);
    chipRW          <= '0';
    chipBurstLen    <= "010";       -- 3 beats total
    
    Report "Test10G: Start Burst Read";
    -- Pulse DMA read
    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    
    -- beat 1
    report "Test10G: Read Beat 1";
    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v1 := chipRD;
    wait until chip_rd_done = '0';
    report "Test10G: Beat 1 read=" & slv_to_hex16(v1);
    
    -- beat 2
    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    report "Test10G: Read Beat 2";
    v2 := chipRD;
    wait until chip_rd_done = '0';
    report "Test10G: Beat 2 read=" & slv_to_hex16(v2);
    
    -- beat 3    
    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    report "Test10G: Read Beat 3";
    v3 := chipRD;        
    wait until chip_rd_done = '0';    
    report "Test10G: Beat 3 read=" & slv_to_hex16(v3);
    
        report "TB: Test10G DMA burst 3-beat values: " &
           slv_to_hex16(v1) & " " &
           slv_to_hex16(v2) & " " &
           slv_to_hex16(v3)           
           & " chip48=" & slv_to_hex_any(chip48) 
           severity note;

    assert v1 = x"AAAA" report "Test10G FAIL: burst read1" severity error;
    assert v2 = x"BBBB" report "Test10G FAIL: burst read2" severity error;
    assert v3 = x"CCCC" report "Test10G FAIL: burst read3" severity error;
    
    assert chip48 = x"AAAABBBBCCCC"
        report "Test10G FAIL: chip48 mismatch after burst"
        severity error;      
    
    report "TB Test10G completed" severity note;
end procedure Test10G;       

procedure Test10H is
    variable v1, v2, v3 : std_logic_vector(15 downto 0);
begin
    report "TB: Test10H DMA burst write 3-beat" severity note;

    -- Pre-fill memory with known junk
    cpu_write(ADDR_CHIP_1, x"1111", '0', '0');
    cpu_write(ADDR_CHIP_2, x"2222", '0', '0');
    cpu_write(ADDR_CHIP_3, x"3333", '0', '0');

    report "Test10H: Initial Write complete" severity note;
    --wait for 100 ns;

    chipBurstLen <= "010";  -- 3 beats
    chipAddr     <= ADDR_CHIP_1(24 downto 1);
    chipRW       <= '1';        -- DMA write
    chipWR       <= x"AAAA";
    
    report "Test10H: Start Burst Write";
    wait until rising_edge(sysclk);
    chipDMA <= '1';

    report "Test10H: Start burst write 1";
    wait until rising_edge(sysclk);
    chipDMA <= '0';

    wait until dma_wr_done_tb = '1';
    report "Test10H: First write completed " & slv_to_hex16(chipWR) severity note;
    
    report "Test10H: Start burst write 2";
    -- After first write, update chipWR for next beats
    chipWR <= x"BBBB";
    
    wait until dma_wr_done_tb = '1';
    report "Test10H: Second write completed " & slv_to_hex16(chipWR) severity note;
    
    report "Test10H: Start burst write 3";
    
    chipWR <= x"CCCC";

    wait until dma_wr_done_tb = '1';
    report "Test10H: Third write completed " & slv_to_hex16(chipWR) severity note;
    
    chipRW  <= '0';
    
    -- Read back
    wait until rising_edge(sysclk);
    report "Test10H: Starting CPU Read" severity note;
    cpu_read(ADDR_CHIP_1, '0', '0', v1);
    report "Test10H: cpu read 1: v1=" & slv_to_hex16(v1) severity note;
    
    cpu_read(ADDR_CHIP_2, '0', '0', v2);
    report "Test10H: cpu read 2: v2=" & slv_to_hex16(v2) severity note;
    cpu_read(ADDR_CHIP_3, '0', '0', v3);
    report "Test10H: cpu read 3: v3=" & slv_to_hex16(v3) severity note;

    assert v1 = x"AAAA" report "FAIL beat1" severity error;
    assert v2 = x"BBBB" report "FAIL beat2" severity error;
    assert v3 = x"CCCC" report "FAIL beat3" severity error;

    report "Test10H: Test Completed";
end procedure Test10H;

procedure Test11A is
    constant FAST_ADDR : std_logic_vector(28 downto 1) := ADDR_FAST_1;
    --constant FAST_ADDR : std_logic_vector(28 downto 1) := ADDR_FAST;
    variable v1, v2 : std_logic_vector(15 downto 0);
begin
    report "TB: Test11A CPU cached read + DMA write" severity note;

    ----------------------------------------------------------------
    -- 1. CPU writes FAST, then reads to pull into cache
    ----------------------------------------------------------------
    cpu_write(FAST_ADDR, x"1234", '0', '0');
    
    wait until rising_edge(sysclk);
    
    cpu_read(FAST_ADDR, '0', '0', v1);
    
    wait for 80 ns;
    report "Post-delay cpuRD_i=" & slv_to_hex16(cpuRD) severity note;

    
    report "TB: Test11A initial CPU read v1=" & slv_to_hex16(v1) severity note;
    assert v1 = x"1234"
      report "Test11A FAIL: initial CPU read mismatch" severity error;

    ----------------------------------------------------------------
    -- 2. DMA writes new value to same physical location
    ----------------------------------------------------------------
    chipRW   <= '1';  -- write
    -- Assume frontend maps some chipAddr to same RAM bank/addr as FAST_ADDR
    -- For now, assume a separate ADDR_DMA_ALIAS that hits same BRAM location:

    chipAddr <= ADDR_DMA_1(24 downto 1);  -- you define the alias
    chipWR   <= x"5678";

    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';

    report "TB: Test11A DMA write issued: 5678" severity note;
    
    wait until dma_wr_done_tb = '1';
    report "Test11A: DMA write completed";
    chipRW <= '0';
    
    -- DMA write completes over 2-3 cyles depending on arbitration
    -- therefore need to wait a few cycles before a read can be performed.
    -- allow BRAM write to settle
    wait until rising_edge(sysclk);        
    ----------------------------------------------------------------
    -- 3. CPU reads again - current behaviour: likely stale (cache)
    ----------------------------------------------------------------
    report "Test11A: Start of Read";
    cpu_read(FAST_ADDR, '0', '0', v2);
    report "TB: Test11A second CPU read v2=" & slv_to_hex16(v2) severity note;

    -- For now we EXPECT stale cache: 1234
    assert v2 = x"1234"
        report "Test11A FAIL: CPU did not see updated DMA value"
            severity error;

    report "TB Test11A completed" severity note;
end procedure Test11A;

procedure Test11B is
    constant FAST_ADDR : std_logic_vector(28 downto 1) := ADDR_FAST_1;
    variable v_cpu, v_dma : std_logic_vector(15 downto 0);
begin
    report "TB: Test11B CPU cached write + DMA read" severity note;
    
    -- * Varifies that cached hits and uncached misses don't cross-contaminate
    
    ----------------------------------------------------------------
    -- 1. CPU writes new value to FAST
    ----------------------------------------------------------------
    cpu_write(FAST_ADDR, x"9ABC", '0', '0');
    
    wait until rising_edge(sysclk);     -- ensure data is stable
     
    report "Test11B: Start of CPU Read";
    cpu_read(FAST_ADDR, '0', '0', v_cpu);  -- confirm from CPU side
    
    report "TB: Test11B CPU read-back v_cpu=" & slv_to_hex16(v_cpu) severity note;
    assert v_cpu = x"9ABC"
      report "Test11B FAIL: CPU read-back doesn't match write" severity error;

    ----------------------------------------------------------------
    -- 2. DMA reads from same physical location
    ----------------------------------------------------------------
    chipRW   <= '0';  -- read
    chipAddr <= FAST_ADDR(24 downto 1);

    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';

    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v_dma := chipRD;
    wait until chip_rd_done = '0';

    report "TB: Test11B DMA read v_dma=" & slv_to_hex16(v_dma) severity note;

    -- For now, we EXPECT DMA sees latest value from BRAM: 9ABC
    assert v_dma = x"9ABC"
      report "Test11B FAIL: DMA did not see CPU-updated value (coherency issue)"
      severity error;

    report "TB Test11B completed" severity note;
end procedure Test11B;

procedure Test11C is
    variable v_cpu, v_dma : std_logic_vector(15 downto 0);
begin
    report "TB: Test11C CPU + DMA write contention" severity note;
    
    -- * Ensures that CHIP DMA doesn't starve or corrupt CPU accesses.
    -- This test assumes DMA has priority over CPU on simultaneous chip writes.

    ----------------------------------------------------------------
    -- 1. Initial CPU write: 1111
    ----------------------------------------------------------------
    report "Test11C: Start CPU Write";
    cpu_write(ADDR_CHIP_1, x"1111", '0', '0');

    wait for 50 ns;

    ----------------------------------------------------------------
    -- 2. DMA write: 2222
    ----------------------------------------------------------------
    report "Test11C: Start DMA write";
    chipRW   <= '1';
    chipAddr <= ADDR_CHIP_1(24 downto 1);
    chipWR   <= x"2222";

    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';

    report "TB: Test11C DMA write issued: 2222" severity note;

    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 3. CPU write: 3333 (later writer should win)
    ----------------------------------------------------------------
    report "Test11C: Start CPU Write";
    cpu_write(ADDR_CHIP_1, x"3333", '0', '0');
    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 4. CPU read-back: should see 3333
    ----------------------------------------------------------------
    report "Test11C: Start CPU Read-back";
    cpu_read(ADDR_CHIP_1, '0', '0', v_cpu);
    report "TB: Test11C CPU read-back v_cpu=" & slv_to_hex16(v_cpu) severity note;
    assert v_cpu = x"3333"
      report "Test11C FAIL: CPU did not see last write (3333)" severity error;

    ----------------------------------------------------------------
    -- 5. DMA read-back: should also see 3333
    ----------------------------------------------------------------
    report "Test11C: Start DMA read-back";
    chipRW   <= '0';
    chipAddr <= ADDR_CHIP_1(24 downto 1);

    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';

    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v_dma := chipRD;
    wait until chip_rd_done = '0';

    report "TB: Test11C DMA read-back v_dma=" & slv_to_hex16(v_dma) severity note;
    assert v_dma = x"3333"
      report "Test11C FAIL: DMA did not see last write (3333)" severity error;

    report "TB Test11C completed" severity note;
end procedure Test11C;

procedure Test11D is
    variable v_cpu, v_dma : std_logic_vector(15 downto 0);
begin
    report "TB: Test11D simultaneous CPU + DMA write same cycle" severity note;
    
    -- * Back-to-back writes with bypass logic
    -- Note: This type of collision should not happen in a real Amiga
    -- as the CPU and CHIP writes never happen on the same cycle.  AGNUS also
    -- controls this.  Nevertheless, still testing that the rules are
    -- enforced in the controller.
    -- CHIP / DMA always goes first on a collision. 
    
    -- 1. Initialise memory
    cpu_write(ADDR_CHIP_1, x"0000", '0', '0');
    Report "Test11D: End Initial CPU Write";
    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 2. Prepare both writes to fire on the SAME rising edge
    ----------------------------------------------------------------
    report "Test11D: Start CPU and DMA Write";
    -- CPU wants to write BBBB
    cpuAddr  <= ADDR_CHIP_1;
    cpuWR    <= x"BBBB";
    cpuL     <= '0';
    cpuU     <= '0';
    cpustate <= "11";

    -- DMA wants to write AAAA
    chipRW   <= '1';
    chipAddr <= ADDR_CHIP_1(24 downto 1);
    chipWR   <= x"AAAA";

    -- Collision happens here
    wait until rising_edge(sysclk);
    report "Test11D: Trigger CPU and DMA Write Collision";
    chipDMA <= '1';   -- DMA write pulse
    cpuCS   <= '1';   -- CPU Write

    -- Next cycle: deassert both
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    
    wait until dma_wr_done_tb = '1';
    wait until cpu_ack = '1';
    cpuCS   <= '0';
    cpustate <= "01";
    cpuL    <= '1';
    cpuU    <= '1';

    wait until rising_edge(sysclk);        
    report "TB: Test11D collision: DMA=AAAA CPU=BBBB" severity note;

    --wait for 200 ns;
    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 3. CPU read-back: must see AAAA
    ----------------------------------------------------------------
    report "Testd11D: CPU read-back start";
    cpu_read(ADDR_CHIP_1, '0', '0', v_cpu);
    
    report "TB: Test11D CPU read-back v_cpu=" & slv_to_hex16(v_cpu) severity note;
    assert v_cpu = x"BBBB"
      report "Test11D FAIL: DMA did not win collision (expected BBBB)"
      severity error;
      -- Expecting BBBB as CPU shuold write to same memory after DMA wrote AAAA
      -- therefore contents of memory should be BBBB  (CPU wrote this).

    ----------------------------------------------------------------
    -- 4. DMA read-back: must also see BBBB
    ----------------------------------------------------------------
    report "Test11D: DMA read-back start";
    chipRW   <= '0';
    chipAddr <= ADDR_CHIP_1(24 downto 1);

    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';

    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v_dma := chipRD;
    wait until chip_rd_done = '0';

    report "TB: Test11D DMA read-back v_dma=" & slv_to_hex16(v_dma) severity note;
    assert v_dma = x"BBBB"
      report "Test11D FAIL: DMA did not see final winner (BBBB)"
      severity error;

    report "TB Test11D completed" severity note;
end procedure Test11D;



procedure Test11E is
    variable v_before, v_after : std_logic_vector(15 downto 0);
    variable is_chip : boolean;
begin
    report "TB: Test11E simultaneous CPU read + DMA write" severity note;

    -- Determine region type
    is_chip := (ADDR_CHIP_1(23 downto 19) = "00000");  -- or your existing region decode

    ----------------------------------------------------------------
    -- 1. Initialise memory to 1111
    ----------------------------------------------------------------
    cpu_write(ADDR_CHIP_1, x"1111", '0', '0');
    --wait for 100 ns;
    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 2. Prepare collision: CPU read + DMA write on same edge
    ----------------------------------------------------------------
    report "Test11E: Prepare collision CPU read + DMA write";
    -- CPU read setup
    cpuAddr  <= ADDR_CHIP_1;
    cpuL     <= '0';
    cpuU     <= '0';
    cpustate <= "10";  -- read

    -- DMA write setup
    chipRW   <= '1';
    chipAddr <= ADDR_CHIP_1(24 downto 1);
    chipWR   <= x"2222";

    -- Collision
    wait until rising_edge(sysclk);
    chipDMA <= '1';
    cpuCS   <= '1';

    -- Next cycle
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    cpuCS   <= '0';
    cpustate <= "01";
    cpuL    <= '1';
    cpuU    <= '1';

    wait until dma_wr_done_tb = '1';
    wait until cpu_ack = '1';

    wait until rising_edge(sysclk);

    report "Test11E: End collision CPU read + DMA write";
    ----------------------------------------------------------------
    -- 3. CPU read-back result from the collision
    ----------------------------------------------------------------
    report "Test11E: Read data";
    cpu_read(ADDR_CHIP_1, '0', '0', v_before);
    report "TB: Test11E CPU read-back (collision) v_before=" &
           slv_to_hex16(v_before) severity note;

    ----------------------------------------------------------------
    -- Region-aware assertion
    ----------------------------------------------------------------
    if is_chip then
        -- CHIP RAM: CPU may see old OR new value
        assert (v_before = x"1111") or (v_before = x"2222")
          report "Test11E FAIL: unexpected CHIP collision value"
          severity error;
    else
        -- FAST/other regions: CPU must see old value
        assert v_before = x"1111"
          report "Test11E FAIL: FAST collision returned new value"
          severity error;
    end if;

    ----------------------------------------------------------------
    -- 4. CPU reads again later: must see updated 2222
    ----------------------------------------------------------------
    cpu_read(ADDR_CHIP_1, '0', '0', v_after);
    report "TB: Test11E CPU read-back (after) v_after=" &
           slv_to_hex16(v_after) severity note;

    assert v_after = x"2222"
      report "Test11E FAIL: CPU did not see DMA-updated value afterwards"
      severity error;

    report "TB Test11E completed" severity note;
end procedure Test11E;

procedure Test11F is
    variable v_dma_before, v_dma_after : std_logic_vector(15 downto 0);
begin
    report "TB: Test11F simultaneous CPU write + DMA read" severity note;

        -- Mixed CPU/DMA traffic with cache disabled
        -- This is the "stress the fallback path" test.
        -- CPU write should take priority over DMA read.

    -- 1. Initialise memory to AAAA
    cpu_write(ADDR_CHIP_1, x"AAAA", '0', '0');
    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 2. Prepare collision: CPU write + DMA read on same edge
    ----------------------------------------------------------------
    report "Test11F: Prepare collision CPU Write + DMA read";
    -- CPU write setup
    cpuAddr  <= ADDR_CHIP_1;
    cpuWR    <= x"BBBB";
    cpuL     <= '0';
    cpuU     <= '0';
    cpustate <= "11";

    -- DMA read setup
    chipRW   <= '0';
    chipAddr <= ADDR_CHIP_1(24 downto 1);

    -- Collision
    wait until rising_edge(sysclk);
    chipDMA <= '1';
    cpuCS   <= '1';

    -- Next cycle
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    cpuCS   <= '0';
    cpustate <= "01";
    cpuL    <= '1';
    cpuU    <= '1';

    
    ----------------------------------------------------------------
    -- 3. DMA read-back from collision
    ----------------------------------------------------------------
    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v_dma_before := chipRD;
    wait until chip_rd_done = '0';

    report "TB: Test11F DMA read-back (collision) v_dma_before=" &
           slv_to_hex16(v_dma_before) severity note;

    -- DMA should see NEW value (BBBB)
    assert v_dma_before = x"BBBB"
      report "Test11F FAIL: DMA saw CPU write too early"
      severity error;

    ----------------------------------------------------------------
    -- 4. DMA reads again later: must see BBBB
    ----------------------------------------------------------------
    wait until rising_edge(sysclk);
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';

    wait until chip_rd_done = '1';
    wait until rising_edge(sysclk);
    v_dma_after := chipRD;
    wait until chip_rd_done = '0';

    report "TB: Test11F DMA read-back (after) v_dma_after=" &
           slv_to_hex16(v_dma_after) severity note;

    assert v_dma_after = x"BBBB"
      report "Test11F FAIL: DMA did not see CPU-updated value afterwards"
      severity error;

    report "TB Test11F completed" severity note;
end procedure Test11F;

procedure Test11G is
    --constant BURST_LEN : integer := 4;
    constant BURST_LEN : integer := 2;
    type word_array is array(0 to BURST_LEN-1) of std_logic_vector(15 downto 0);

    variable dma_results : word_array;
    variable i           : integer;
    variable beat : integer := 0;
begin
    report "TB: Test11G DMA burst + CPU interference" severity note;
   
    ----------------------------------------------------------------
    -- 1. Initialise memory with known pattern
    ----------------------------------------------------------------
    cpu_write(ADDR_CHIP_1, x"1111", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1, 1), x"2222", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1, 2), x"3333", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1, 3), x"4444", '0', '0');

    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 2. Start a DMA burst of reads
    ----------------------------------------------------------------
    report "Test11G: Start DMA burts reads";
    chipBurstLen    <= "001";   -- 2 beats
    chipRW          <= '0';  -- DMA read
    chipAddr        <= ADDR_CHIP_1(24 downto 1);
    chipDMA         <= '1';

    ----------------------------------------------------------------
    -- 3. During the burst, CPU writes to the same region
    --    This must NOT disturb the DMA burst timing.
    ----------------------------------------------------------------
    report "Test11G: CPU write to same region";
    wait until rising_edge(sysclk);
    cpuAddr  <= addr_plus(ADDR_CHIP_1,1);   -- overwrite the 2nd word
    cpuWR    <= x"9999";
    cpuL     <= '0';
    cpuU     <= '0';
    cpustate <= "11";
    cpuCS    <= '1';

    wait until rising_edge(sysclk);
    cpuCS    <= '0';
    cpustate <= "01";
    cpuL     <= '1';
    cpuU     <= '1';

    ----------------------------------------------------------------
    -- 4. Capture the DMA burst results
    ----------------------------------------------------------------

    report "TB: Test11G capturing DMA burst..." severity note;
      
    while beat < BURST_LEN loop
    
        -- Wait for a DMA beat to complete
        wait until chip_rd_done = '1';
        wait until rising_edge(sysclk);            
        dma_results(beat) := chipRD;
            
        report "DMABURSTDBG: beat=" & integer'image(beat) &
               " chipAddr=" & slv_to_hex_any(chipAddr) &
               " data=" & slv_to_hex16(chipRD)
               severity note;
    
        beat := beat + 1;
    
        -- Wait for chip_rd_done to drop before next beat
        wait until chip_rd_done = '0';
    
    end loop;
    
    chipDMA <= '0';

    ----------------------------------------------------------------
    -- 5. Check DMA results
    ----------------------------------------------------------------
    report "TB: Test11G DMA burst results:" severity note;
    for i in 0 to BURST_LEN-1 loop
        report "  DMA[" & integer'image(i) & "] = " &
               slv_to_hex16(dma_results(i)) severity note;
    end loop;

    -- Expected:
    --   DMA[0] = 1111
    --   DMA[1] = 2222
    --   DMA[2] = 9999
    --   DMA[3] = 4444

    assert dma_results(0) = x"1111"
      report "Test11G FAIL: DMA[0] incorrect" severity error;
   
    if BURST_LEN > 1 then
        assert dma_results(1) = x"9999"
          report "Test11G FAIL: DMA[1] incorrect" severity error;
    end if;

    report "TB Test11G completed" severity note;
end procedure Test11G;

procedure Test11H is
    constant BURST_LEN : integer := 4;

    type word_array is array(0 to BURST_LEN-1) of std_logic_vector(15 downto 0);

    variable dma_results : word_array;
    variable beat        : integer := 0;

    -- Expected values for incrementing burst:
    --   Beat 0 → 1111
    --   Beat 1 → 2222
    --   Beat 2 → 3333
    --   Beat 3 → 9999 (CPU overwrite)
    constant expected : word_array := (
        0 => x"1111",
        1 => x"2222",        
        2 => x"3333",       
        3 => x"9999"
    );
begin
    report "TB: Test11H DMA 4-beat incrementing burst + CPU interference" severity note;

    --------------------------------------------------------------------
    -- 1. Initialise memory with known pattern
    --------------------------------------------------------------------

    -- DMA Reads use word addresses
    -- while CPU writes use byte addresses
    cpu_write(ADDR_CHIP_1,             x"1111", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,1), x"2222", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,2), x"3333", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,3), x"4444", '0', '0');

    wait until rising_edge(sysclk);

    --------------------------------------------------------------------
    -- 2. Start a 4-beat DMA burst
    --------------------------------------------------------------------
    report "Test11H: Start 4-beat DMA burst read";
    chipRW      <= '0';  -- DMA read
    chipAddr    <= ADDR_CHIP_1(24 downto 1);
    chipBurstLen<= "011";  -- 4 beats (value+1)
    chipDMA     <= '1';

    --------------------------------------------------------------------
    -- 3. CPU overwrites the 4th word mid-burst
    --    This should affect only beat 3
    -- NB:  It won't / can't actually do this mid-burst
    --------------------------------------------------------------------
    report "Test11H: CPU Overwrites the 4th word";
    wait until rising_edge(sysclk);
    cpuAddr  <= addr_plus(ADDR_CHIP_1,3);  -- overwrite 4th word
    cpuWR    <= x"9999";
    cpuL     <= '0';
    cpuU     <= '0';
    cpustate <= "11";
    cpuCS    <= '1';

    wait until rising_edge(sysclk);
    cpuCS    <= '0';
    cpustate <= "01";
    cpuL     <= '1';
    cpuU     <= '1';

    --------------------------------------------------------------------
    -- 4. Capture all 4 DMA beats
    --------------------------------------------------------------------
    report "TB: Test11H capturing DMA burst..." severity note;

    while beat < BURST_LEN loop

        -- Wait for DMA beat
        
        wait until chip_rd_done = '1';
        wait until rising_edge(sysclk);
        dma_results(beat) := chipRD;

        report "DMABURSTDBG: beat=" & integer'image(beat) &
               " data=" & slv_to_hex16(chipRD)
               severity note;

        beat := beat + 1;

        -- Wait for chip_rd_done to drop
        wait until chip_rd_done = '0';

    end loop;

    chipDMA <= '0';
    wait until rising_edge(sysclk);
    --------------------------------------------------------------------
    -- 5. Report results
    --------------------------------------------------------------------
    report "TB: Test11H DMA burst results:" severity note;
    for i in 0 to BURST_LEN-1 loop
        report "  DMA[" & integer'image(i) & "] = " &
               slv_to_hex16(dma_results(i)) severity note;
    end loop;

    --------------------------------------------------------------------
    -- 6. Validate results
    --------------------------------------------------------------------
    for i in 0 to BURST_LEN-1 loop
        assert dma_results(i) = expected(i)
          report "Test11H FAIL: DMA[" & integer'image(i) & "] incorrect. " &
                 "Expected=" & slv_to_hex16(expected(i)) &
                 " Got=" & slv_to_hex16(dma_results(i))
          severity error;
    end loop;

    report "TB Test11H completed" severity note;
end procedure Test11H;

procedure Test11G_FAST is
    constant BURST_LEN : integer := 4;
    type word_array is array(0 to BURST_LEN-1) of std_logic_vector(15 downto 0);

    variable dma_results : word_array;
    variable i           : integer;
begin
    report "TB: Test11G_FAST DMA burst + CPU interference (FAST)" severity note;

    ----------------------------------------------------------------
    -- 1. Initialise FAST memory with known pattern
    ----------------------------------------------------------------
    report "Test11G_FAST: Initialise FAST memory";
    cpu_write(ADDR_FAST_1,               x"1111", '0', '0');
    cpu_write(addr_plus(ADDR_FAST_1, 1), x"2222", '0', '0');
    cpu_write(addr_plus(ADDR_FAST_1, 2), x"3333", '0', '0');
    cpu_write(addr_plus(ADDR_FAST_1, 3), x"4444", '0', '0');
    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 2. Start a DMA burst of reads in FAST
    ----------------------------------------------------------------
    report "Test11G_FAST: Start a DMA burst of reads in FAST";
    chipBurstLen    <= "100";
    chipRW   <= '0';  -- DMA read
    chipAddr <= ADDR_FAST_1(24 downto 1);
    chipDMA  <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    
    ----------------------------------------------------------------
    -- 3. During the burst, CPU writes to the same region
    ----------------------------------------------------------------
    report "Test11G_FAST: CPU Write";
    wait until rising_edge(sysclk);
    cpuAddr  <= addr_plus(ADDR_FAST_1, 3);   -- overwrite the 3rd word
    cpuWR    <= x"9999";
    cpuL     <= '0';
    cpuU     <= '0';
    cpustate <= "11";
    cpuCS    <= '1';

    wait until rising_edge(sysclk);
    cpuCS    <= '0';
    cpustate <= "01";
    cpuL     <= '1';
    cpuU     <= '1';

    ----------------------------------------------------------------
    -- 4. Capture the DMA burst results
    ----------------------------------------------------------------
    report "Test11G_FAST: Read Burst Result";
    chipBurstLen    <= "100";
    chipRW  <= '0';
    chipDMA <= '1';
    wait until rising_edge(sysclk);
    chipDMA <= '0';
    
    for i in 0 to BURST_LEN-1 loop
        wait until chip_rd_done = '1';
        wait until rising_edge(sysclk);
        dma_results(i) := chipRD;
        wait until chip_rd_done = '0';
    end loop;    

    ----------------------------------------------------------------
    -- 5. Check DMA results
    ----------------------------------------------------------------
    report "TB: Test11G_FAST DMA burst results:" severity note;
    for i in 0 to BURST_LEN-1 loop
        report "  DMA[" & integer'image(i) & "] = " &
               slv_to_hex16(dma_results(i)) severity note;
    end loop;

    -- For FAST, bypass may allow DMA to see the new value earlier.
    assert dma_results(0) = x"1111"
      report "Test11G_FAST FAIL: DMA[0] incorrect" severity error;

    assert dma_results(1) = x"2222"
      report "Test11G_FAST FAIL: DMA[1] incorrect" severity error;

    assert (dma_results(2) = x"3333") or (dma_results(2) = x"9999")
      report "Test11G_FAST FAIL: DMA[2] unexpected value" severity error;

    assert (dma_results(3) = x"4444") or (dma_results(3) = x"9999")
      report "Test11G_FAST FAIL: DMA[3] unexpected value" severity error;

    report "TB Test11G_FAST completed" severity note;
end procedure Test11G_FAST;



procedure Test11G_DMAWRITE is
    constant BURST_LEN : integer := 4;
    type word_array is array(0 to BURST_LEN-1) of std_logic_vector(15 downto 0);

    variable cpu_before, cpu_after : std_logic_vector(15 downto 0);
begin
    report "TB: Test11G_DMAWRITE DMA write burst + CPU read" severity note;

    ----------------------------------------------------------------
    -- 1. Initialise CHIP memory to known pattern
    ----------------------------------------------------------------
    report "Test11G_DMAWRITE: Initialise CHIP memory";
    cpu_write(ADDR_CHIP_1,               x"1111", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1, 1), x"2222", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1, 2), x"3333", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1, 3), x"4444", '0', '0');    
    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- 2. Start DMA write burst
    ----------------------------------------------------------------
    report "Test11G_DMAWRITE: Start DMA write burst";
    
        chipBurstLen <= "100";
        chipRW       <= '1';  -- DMA Write
        chipAddr     <= ADDR_CHIP_1(24 downto 1);

        -- First Write
        chipWR   <= x"AAAA";
        chipDMA  <= '1';
       
        wait until rising_edge(sysclk);
        chipDMA      <= '0';
                                  
        wait until dma_wr_done_tb = '1';

        -- Second write
        chipWR <= x"BBBB";
        wait until dma_wr_done_tb = '1';
    
        -- Third write    
        chipWR <= x"CCCC";
        wait until dma_wr_done_tb = '1';
        
        -- Forth write
        chipWR <= x"DDDD";
        
        wait until dma_wr_done_tb = '1';    
  
    -- Read back results
    report "Test11G_DMAWRITE: CPU Read";
    
    cpu_read(addr_plus(ADDR_CHIP_1, 0), '0', '0', cpu_after);
    assert cpu_after = x"AAAA"
        report "Test11G_DMAWRITE FAIL: Expecting AAAA read=" & slv_to_hex16(cpu_after) severity error;
        report "Test11G_DMAWRITE : Expecting AAAA read=" & slv_to_hex16(cpu_after) severity note;
   
    cpu_read(addr_plus(ADDR_CHIP_1, 1), '0', '0', cpu_after);
    assert cpu_after = x"BBBB"
        report "Test11G_DMAWRITE FAIL: Expecting BBBB read=" & slv_to_hex16(cpu_after) severity error;
        report "Test11G_DMAWRITE : Expecting BBBB read=" & slv_to_hex16(cpu_after) severity note;    
  
    cpu_read(addr_plus(ADDR_CHIP_1, 2), '0', '0', cpu_after);
    assert cpu_after = x"CCCC"
        report "Test11G_DMAWRITE FAIL: Expecting CCCC read=" & slv_to_hex16(cpu_after) severity error;
        report "Test11G_DMAWRITE : Expecting CCCC read=" & slv_to_hex16(cpu_after) severity note;
  
   cpu_read(addr_plus(ADDR_CHIP_1, 3), '0', '0', cpu_after);
    assert cpu_after = x"DDDD"
        report "Test11G_DMAWRITE FAIL: Expecting DDDD read=" & slv_to_hex16(cpu_after) severity error;
        report "Test11G_DMAWRITE : Expecting DDDD read=" & slv_to_hex16(cpu_after) severity note;

    report "TB Test11G_DMAWRITE completed" severity note;
end procedure Test11G_DMAWRITE;

procedure Test12 is
begin
--------------------------------------------------------------------
-- Test12: CHIP48 sliding window
--------------------------------------------------------------------
report "TB: Test12 CHIP48 sliding window..." severity note;

-- preload memory
    cpu_write(ADDR_CHIP_1,              x"AAAA", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,1), x"BBBB", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,2), x"CCCC", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,3), x"DDDD", '0', '0');
wait for 50 ns;

-- Read AAAA
chip_read(ADDR_CHIP_1);
check_chip48(x"0000", x"0000", x"AAAA");

-- Read BBBB
chip_read(addr_plus(ADDR_CHIP_1,1));
check_chip48(x"0000", x"AAAA", x"BBBB");

-- Read CCCC
chip_read(addr_plus(ADDR_CHIP_1,2));
check_chip48(x"AAAA", x"BBBB", x"CCCC");

-- Read DDDD
chip_read(addr_plus(ADDR_CHIP_1,3));
check_chip48(x"BBBB", x"CCCC", x"DDDD");

report "TB: Test12 completed" severity note;      

end procedure Test12;      

procedure Test13 is
begin
    report "TB: Test13 CHIP48 under CPU + DMA contention..." severity note;

    -- Preload CHIP RAM
    cpu_write(ADDR_CHIP_1,              x"AAAA", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,1), x"BBBB", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,2), x"CCCC", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,3), x"DDDD", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,4), x"EEEE", '0', '0');
    cpu_write(addr_plus(ADDR_CHIP_1,5), x"FFFF", '0', '0');

    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- DMA READ #1 → AAAA
    ----------------------------------------------------------------
    report "Test13: Start Chip Read";
    chip_read(ADDR_CHIP_1);
    check_chip48(x"0000", x"0000", x"AAAA");

    ----------------------------------------------------------------
    -- CPU READ (should NOT affect chip48)
    ----------------------------------------------------------------
    report "Test13: Start CPU Read";
    cpu_read_chip(addr_plus(ADDR_CHIP_1,1));  -- reads BBBB
    check_chip48(x"0000", x"0000", x"AAAA");

    ----------------------------------------------------------------
    -- DMA READ #2 → BBBB
    ----------------------------------------------------------------
    report "Test13: Start DMA Read 2";
    chip_read(addr_plus(ADDR_CHIP_1,1));
    check_chip48(x"0000", x"AAAA", x"BBBB");

    ----------------------------------------------------------------
    -- CPU WRITE between DMA beats
    ----------------------------------------------------------------
    report "Test13: CPU Write between DMA Beats";
    -- Note: This should queue the CPU write
    cpu_write(addr_plus(ADDR_CHIP_1,2), x"1234", '0', '0'); -- overwrite CCCC
    wait until rising_edge(sysclk);

    ----------------------------------------------------------------
    -- DMA READ #3 → should read 1234 (CPU overwrite)
    ----------------------------------------------------------------
    report "Test13: DMA Read 3";
    chip_read(addr_plus(ADDR_CHIP_1,2));
    check_chip48(x"AAAA", x"BBBB", x"1234");

    ----------------------------------------------------------------
    -- CPU READ (should NOT affect chip48)
    ----------------------------------------------------------------
    report "Test13: CPU Read 2";
    cpu_read_chip(addr_plus(ADDR_CHIP_1,3)); -- reads DDDD
    check_chip48(x"AAAA", x"BBBB", x"1234");

    ----------------------------------------------------------------
    -- DMA READ #4 → DDDD
    ----------------------------------------------------------------
    report "Test13: DMA Read 4";
    chip_read(addr_plus(ADDR_CHIP_1,3));
    check_chip48(x"BBBB", x"1234", x"DDDD");

    report "TB: Test13 completed" severity note;
end procedure Test13;  

procedure test13X is
    constant CHIP_BASE : std_logic_vector(28 downto 1) := x"0000000";  -- example
    constant COUNT     : natural := 8;
    
    variable a_chip  : std_logic_vector(28 downto 1);
    variable d       : std_logic_vector(15 downto 0);
begin
    report "TB: Test13X CPU CHIP read..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise CHIP region with known pattern        
    --------------------------------------------------------------------
    report "Test13X_1S: Initialise CHIP region - started" severity note;
    
    a_chip := CHIP_BASE;

    for i in 0 to COUNT-1 loop
        report "Writing index " & integer'image(i) &
            " addr=" & slv_to_hex_any(a_chip); 
        cpu_write(a_chip, std_logic_vector(to_unsigned(i + 1, 16)));
        a_chip := addr_plus(a_chip, 1);
    end loop;    
    
    report "Test13X_1E: Initialise CHIP region - completed" severity note;
    
    --------------------------------------------------------------------
    -- 2. Read CHIP region
    --------------------------------------------------------------------
    report "Test13A_2S: Verify CHIP region read - started" severity note;
    
    a_chip := CHIP_BASE;

    for i in 0 to COUNT-1 loop
        report "Reading index " & integer'image(i) &
               " addr=" & slv_to_hex_any(a_chip);
               
        cpu_read_chip(a_chip, d);

        if d /= std_logic_vector(to_unsigned(i + 1, 16)) then
            report "Test13X_2 FAIL: CHIP write / read mismatch at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(std_logic_vector(to_unsigned(i + 1, 16))) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_chip := addr_plus(a_chip, 1);
    end loop;
    
    report "Test13A_2S: Verify CHIP region read - completed" severity note;

    report "TB: Test13X completed successfully" severity note;
end procedure test13X;  


procedure test13A is
    constant FAST_BASE : std_logic_vector(28 downto 1) := x"0201000";  -- example
    --constant FAST_BASE : std_logic_vector(28 downto 1) := x"0001000";  -- example
    constant CHIP_BASE : std_logic_vector(28 downto 1) := x"0000000";  -- example
    constant COUNT     : natural := 8;
    --constant COUNT     : natural := 2;

    variable a_fast  : std_logic_vector(28 downto 1);
    variable a_chip  : std_logic_vector(28 downto 1);
    variable d       : std_logic_vector(15 downto 0);
begin
    report "TB: Test13A CPU FAST read + DMA CHIP write..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise FAST region with known pattern
    --------------------------------------------------------------------
    report "Test13A_1S: Initialise FAST region - started" severity note;
    
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_write(a_fast, std_logic_vector(to_unsigned(i, 16)));
        a_fast := addr_plus(a_fast, 1);
    end loop;

    -- Prime cache
    a_fast := FAST_BASE;
    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);
        a_fast := addr_plus(a_fast, 1);
    end loop;

    report "Test13A_1E: Initialise FAST region - completed" severity note;

    --------------------------------------------------------------------
    -- 2. Start DMA writing to CHIP region
    --------------------------------------------------------------------
    report "Test13A_2S: Start DMA writing to CHIP region - started" severity note;
    --chipDMA <= '1';
    --chipRW  <= '1';  -- write

    a_chip := CHIP_BASE;
            
    report "Test13A_2E: Start DMA writing to CHIP region - completed" severity note;
    --------------------------------------------------------------------
    -- 3. Interleave CPU FAST reads with DMA CHIP writes
    --------------------------------------------------------------------
    report "Test13A_3S: Interleave CPU FAST reads with DMA CHIP writes - Started" severity note;
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        report "Test13A 3: i=" & i'image(i) &
            " a_fast=" & slv_to_hex_any(a_fast) 
            severity note;
        -- CPU FAST read (should always hit cache)
        cpu_read_fast(a_fast, d);
        
        report "Test13A 3: d=" & slv_to_hex_any(d) severity note;
        report "cpuCS=" & std_logic'image(cpuCS);

        -- DMA CHIP write (one beat)
        report "Test13A: DMA CHIP Write (one beat)";
        
        chipAddr <= a_chip(24 downto 1);
        chipWR   <= std_logic_vector(to_unsigned(i + 16#A000#, 16));  -- arbitrary pattern
        
        -- Pulse the signal
        chipDMA <= '1';
        chipRW  <= '1';  -- write
        wait until rising_edge(sysclk);
        chipDMA <= '0';
        wait until rising_edge(sysclk);
        
        wait until dma_wr_done_tb = '1';        
        wait until rising_edge(sysclk);

        -- Increment both address streams
        a_fast := addr_plus(a_fast, 1);
        a_chip := addr_plus(a_chip, 1);
    end loop;

    --chipDMA <= '0';
    
    report "Test13A_3E: Interleave CPU FAST reads with DMA CHIP writes - completed" severity note;
    --------------------------------------------------------------------
    -- 4. Verify FAST region still contains original data
    --------------------------------------------------------------------
    report "Test13A_4S: Verify FAST region still contains original data - started" severity note;
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);                       
            
        if d /= std_logic_vector(to_unsigned(i, 16)) then
            report "Test13A_4 FAIL: FAST read mismatch at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(std_logic_vector(to_unsigned(i, 16))) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_fast := addr_plus(a_fast, 1);
    end loop;

    report "Test13A_4E: Verify FAST region still contains original data - completed" severity note;
    --------------------------------------------------------------------
    -- 5. Verify CHIP region received DMA writes
    --------------------------------------------------------------------
    report "Test13A_5S: Verify CHIP region received DMA writes - started" severity note;
    
    a_chip := CHIP_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_chip(a_chip, d);

        if d /= std_logic_vector(to_unsigned(i + 16#A000#, 16)) then
            report "Test13A_5 FAIL: CHIP write mismatch at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(std_logic_vector(to_unsigned(i + 16#A000#, 16))) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_chip := addr_plus(a_chip, 1);
    end loop;
    
    report "Test13A_5E: Verify CHIP region received DMA writes - completed" severity note;

    report "TB: Test13A completed successfully" severity note;
end procedure test13A;  

procedure test13B is
    constant FAST_BASE : std_logic_vector(28 downto 1) := x"0001000";
    constant CHIP_BASE : std_logic_vector(28 downto 1) := x"0000000";
    constant COUNT     : natural := 8;

    variable a_fast  : std_logic_vector(28 downto 1);
    variable a_chip  : std_logic_vector(28 downto 1);
    variable d       : std_logic_vector(15 downto 0);
begin
    report "TB: Test13B CPU CHIP read + DMA FAST write..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise CHIP region with known pattern
    --------------------------------------------------------------------
    report "Test13B: Initialise CHIP region";
    a_chip := CHIP_BASE;

    for i in 0 to COUNT-1 loop
        cpu_write(a_chip, std_logic_vector(to_unsigned(i + 16#1000#, 16)));
        a_chip := addr_plus(a_chip, 1);
    end loop;

    --------------------------------------------------------------------
    -- 2. Initialise FAST region with known pattern
    --------------------------------------------------------------------
    report "Test13B: Initialise FST region";
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_write(a_fast, std_logic_vector(to_unsigned(i + 16#2000#, 16)));
        a_fast := addr_plus(a_fast, 1);
    end loop;

    -- Prime cache for FAST region
    a_fast := FAST_BASE;
    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);
        a_fast := addr_plus(a_fast, 1);
    end loop;

    --------------------------------------------------------------------
    -- 3. Interleave CPU CHIP reads with DMA FAST writes
    --------------------------------------------------------------------
    report "Test13B: Interleave CPU CHIP reads with DMA FAST writes";
    
    a_chip := CHIP_BASE;
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop

        -- CPU CHIP read (must always come from BRAM)
        cpu_read_chip(a_chip, d);

        -- DMA FAST write
        chipDMA <= '1';
        chipRW  <= '1';  -- write
        chipAddr <= a_fast(24 downto 1);
        chipWR   <= std_logic_vector(to_unsigned(i + 16#3000#, 16));
        
        wait until dma_wr_done_tb = '1';
        wait until rising_edge(sysclk);
        chipDMA <= '0';

        -- Increment both address streams
        a_chip := addr_plus(a_chip, 1);
        a_fast := addr_plus(a_fast, 1);
    end loop;
    
    --------------------------------------------------------------------
    -- 4. Verify CHIP region still contains original data
    --------------------------------------------------------------------
    a_chip := CHIP_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_chip(a_chip, d);

        if d /= std_logic_vector(to_unsigned(i + 16#1000#, 16)) then
            report "Test13B FAIL: CHIP region corrupted at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(std_logic_vector(to_unsigned(i + 16#1000#, 16))) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_chip := addr_plus(a_chip, 1);
    end loop;

    --------------------------------------------------------------------
    -- 5. Verify FAST region reflects DMA writes
    --------------------------------------------------------------------
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);

        if d /= std_logic_vector(to_unsigned(i + 16#3000#, 16)) then
            report "Test13B FAIL: FAST region did not update from DMA write at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(std_logic_vector(to_unsigned(i + 16#3000#, 16))) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_fast := addr_plus(a_fast, 1);
    end loop;

    report "TB: Test13B completed successfully" severity note;
end procedure test13B;  

procedure test13C is
    constant FAST_BASE : std_logic_vector(28 downto 1) := x"0001000";
    constant COUNT     : natural := 8;

    variable a_fast  : std_logic_vector(28 downto 1);
    variable d       : std_logic_vector(15 downto 0);

    -- Patterns
    constant OLD : std_logic_vector(15 downto 0) := x"4000";
    constant NEW1 : std_logic_vector(15 downto 0) := x"4F00";
begin
    report "TB: Test13C CPU FAST write + DMA FAST read..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise FAST region with OLD pattern
    --------------------------------------------------------------------
    report "Test13C: Initialise FAST region";
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_write(a_fast, OLD xor std_logic_vector(to_unsigned(i, 16)));
        a_fast := addr_plus(a_fast, 1);
    end loop;

    -- Prime cache
    a_fast := FAST_BASE;
    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);
        a_fast := addr_plus(a_fast, 1);
    end loop;

    --------------------------------------------------------------------
    -- 2. CPU writes NEW pattern into FAST region
    --------------------------------------------------------------------
    report "Test13B: CPU writes NEW pattern into FAST region";
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_write(a_fast, NEW1 xor std_logic_vector(to_unsigned(i, 16)));
        a_fast := addr_plus(a_fast, 1);
    end loop;

    --------------------------------------------------------------------
    -- 3. DMA FAST read burst (may overlap CPU writes)
    --------------------------------------------------------------------

    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        chipDMA <= '1';
        chipRW  <= '0';  -- read
        chipAddr <= a_fast(24 downto 1);
        wait until rising_edge(sysclk);
        chipDMA <= '0';             -- Need to pulse DMA
        wait until rising_edge(sysclk);
        
        wait until chip_rd_done = '1';
        wait until rising_edge(sysclk);
        d := chipRD;
        wait until chip_rd_done = '0';         
        
        a_fast := addr_plus(a_fast, 1);
        
    end loop;


    --------------------------------------------------------------------
    -- 4. Verify FAST region contains NEW pattern
    --------------------------------------------------------------------
    report "Test13B: Verify FAST region contains NEW pattaern";
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);

        if d /= (NEW1 xor std_logic_vector(to_unsigned(i, 16))) then
            report "Test13C FAIL: FAST region mismatch at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(NEW1 xor std_logic_vector(to_unsigned(i, 16))) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_fast := addr_plus(a_fast, 1);
    end loop;

    report "TB: Test13C completed successfully" severity note;
end procedure test13C;

procedure test13C_advanced is
    constant FAST_BASE : std_logic_vector(28 downto 1) := x"0001000";
    constant COUNT     : natural := 16;    -- number of words in window
    constant LOOPS     : natural := 256;   -- stress cycles

    -- Patterns
    constant OLD : std_logic_vector(15 downto 0) := x"4000";
    constant NEW1 : std_logic_vector(15 downto 0) := x"4F00";

    -- Tracking arrays
    type word_array is array (0 to COUNT-1) of std_logic_vector(15 downto 0);
    variable expected : word_array;
    variable observed : word_array;

    variable a_cpu  : std_logic_vector(28 downto 1);
    variable d      : std_logic_vector(15 downto 0);

    variable idx    : integer;
begin
    report "TB: Test13C-Advanced starting..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise FAST region with OLD pattern
    --------------------------------------------------------------------
    report "Test13C_Adv: Initialise FAST region";
    a_cpu := FAST_BASE;

    for i in 0 to COUNT-1 loop
        expected(i) := OLD xor std_logic_vector(to_unsigned(i, 16));
        cpu_write(a_cpu, expected(i));
        a_cpu := addr_plus(a_cpu, 1);
    end loop;

    -- Prime cache
    a_cpu := FAST_BASE;
    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_cpu, d);
        a_cpu := addr_plus(a_cpu, 1);
    end loop;

    --------------------------------------------------------------------
    -- 2. Stress loop: sliding index across window
    --------------------------------------------------------------------
    report "Test13C_Adv: Stress loop: sliding index across window";
    for loopnum in 0 to LOOPS-1 loop

        -- Deterministic index: cycles 0..COUNT-1 repeatedly
        idx := loopnum mod COUNT;

        -- Compute address for this index
        a_cpu := FAST_BASE;
        for j in 1 to idx loop
            a_cpu := addr_plus(a_cpu, 1);
        end loop;

        ----------------------------------------------------------------
        -- CPU writes NEW pattern to this word
        ----------------------------------------------------------------
        expected(idx) := NEW1 xor std_logic_vector(to_unsigned(idx, 16));
        cpu_write(a_cpu, expected(idx));

        ----------------------------------------------------------------
        -- DMA reads same address (may be before/after commit)
        ----------------------------------------------------------------
        report "Test13C_Adv: DMA reads same address";
        chipDMA <= '1';
        chipRW  <= '0';  -- read
        chipAddr <= a_cpu(24 downto 1);

        wait until rising_edge(sysclk);
        chipDMA <= '0';
        wait until rising_edge(sysclk);

        wait until chip_rd_done = '1';
        wait until rising_edge(sysclk);
        observed(idx) := chipRD;
        wait until chip_rd_done = '0';

        ----------------------------------------------------------------
        -- 3. Coherency check
        ----------------------------------------------------------------
        -- DMA must see either:
        --   OLD (if read before commit)
        --   NEW (if read after commit or bypass active)
        -- Never a corrupted value
        ----------------------------------------------------------------
        if observed(idx) /= expected(idx) and
           observed(idx) /= (OLD xor std_logic_vector(to_unsigned(idx, 16))) then

            report "Test13C-Advanced FAIL: Illegal DMA read at index " &
                   integer'image(idx) &
                   " observed=" & slv_to_hex_any(observed(idx)) &
                   " expected OLD=" & slv_to_hex_any(OLD xor std_logic_vector(to_unsigned(idx, 16))) &
                   " or NEW=" & slv_to_hex_any(expected(idx))
            severity error;
        end if;

    end loop;

    --------------------------------------------------------------------
    -- 4. Final verification: FAST region must contain NEW pattern
    --------------------------------------------------------------------
    report "Test13C_Adv: Final verification";
    a_cpu := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_cpu, d);

        if d /= expected(i) then
            report "Test13C-Advanced FAIL: Final FAST mismatch at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(expected(i)) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_cpu := addr_plus(a_cpu, 1);
    end loop;

    report "TB: Test13C-Advanced completed successfully" severity note;
end procedure test13C_advanced;

procedure test13D is
    constant FAST_BASE : std_logic_vector(28 downto 1) := x"0001000";
    constant COUNT     : natural := 16;   -- size of test window
    constant LOOPS     : natural := 256;  -- number of alternating cycles

    variable a_cpu  : std_logic_vector(28 downto 1);
    variable d      : std_logic_vector(15 downto 0);

    -- Patterns
    constant P_READ  : std_logic_vector(15 downto 0) := x"7000";
    constant P_WRITE : std_logic_vector(15 downto 0) := x"7F00";

    -- Tracking array for expected values
    type word_array is array (0 to COUNT-1) of std_logic_vector(15 downto 0);
    variable expected : word_array;

    variable idx : integer;
begin
    report "TB: Test13D CPU alternating read/write starting..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise FAST region with READ pattern
    --------------------------------------------------------------------
    report "Test13D: Initialise FAST regioon";
    a_cpu := FAST_BASE;

    for i in 0 to COUNT-1 loop
        expected(i) := P_READ xor std_logic_vector(to_unsigned(i, 16));
        cpu_write(a_cpu, expected(i));
        a_cpu := addr_plus(a_cpu, 1);
    end loop;

    -- Prime cache
    a_cpu := FAST_BASE;
    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_cpu, d);
        a_cpu := addr_plus(a_cpu, 1);
    end loop;

    --------------------------------------------------------------------
    -- 2. Alternating read/write stress loop
    --------------------------------------------------------------------
    report "Test13D: Alternating read/write stress loop";
    
    for loopnum in 0 to LOOPS-1 loop

        idx := loopnum mod COUNT;

        -- Compute address for this index
        a_cpu := FAST_BASE;
        for j in 1 to idx loop
            a_cpu := addr_plus(a_cpu, 1);
        end loop;

        ----------------------------------------------------------------
        -- CPU READ
        ----------------------------------------------------------------
        cpu_read_fast(a_cpu, d);

        -- Must match expected value
        if d /= expected(idx) then
            report "Test13D FAIL: CPU read mismatch at index " &
                   integer'image(idx) &
                   " expected=" & slv_to_hex_any(expected(idx)) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        ----------------------------------------------------------------
        -- CPU WRITE (new pattern)
        ----------------------------------------------------------------
        expected(idx) := P_WRITE xor std_logic_vector(to_unsigned(idx, 16));
        cpu_write(a_cpu, expected(idx));

    end loop;

    --------------------------------------------------------------------
    -- 3. Final verification: FAST region must contain WRITE pattern
    --------------------------------------------------------------------
    a_cpu := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_cpu, d);

        if d /= expected(i) then
            report "Test13D FAIL: Final FAST mismatch at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(expected(i)) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_cpu := addr_plus(a_cpu, 1);
    end loop;

    report "TB: Test13D completed successfully" severity note;
end procedure test13D;

procedure test13E is
    constant FAST_BASE : std_logic_vector(28 downto 1) := x"0001000";
    constant CHIP_BASE : std_logic_vector(28 downto 1) := x"0000000";

    constant COUNT     : natural := 16;   -- burst size

    -- Patterns
    constant FAST_INIT : std_logic_vector(15 downto 0) := x"8000";
    constant FAST_NEW  : std_logic_vector(15 downto 0) := x"8F00";

    constant CHIP_INIT : std_logic_vector(15 downto 0) := x"9000";
    constant CHIP_NEW  : std_logic_vector(15 downto 0) := x"9F00";

    variable a_fast  : std_logic_vector(28 downto 1);
    variable a_chip  : std_logic_vector(28 downto 1);
    variable d       : std_logic_vector(15 downto 0);

begin
    report "TB: Test13E DMA burst + CPU burst interleaved..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise FAST region
    --------------------------------------------------------------------
    report "Test13E: Initialise FAST Region";
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_write(a_fast, FAST_INIT xor std_logic_vector(to_unsigned(i, 16)));
        a_fast := addr_plus(a_fast, 1);
    end loop;

    -- Prime cache
    a_fast := FAST_BASE;
    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);
        a_fast := addr_plus(a_fast, 1);
    end loop;

    --------------------------------------------------------------------
    -- 2. Initialise CHIP region
    --------------------------------------------------------------------
    report "Test13E: Initialise CHIP region";
    a_chip := CHIP_BASE;

    for i in 0 to COUNT-1 loop
        cpu_write(a_chip, CHIP_INIT xor std_logic_vector(to_unsigned(i, 16)));
        a_chip := addr_plus(a_chip, 1);
    end loop;

    --------------------------------------------------------------------
    -- 3. Start interleaved CPU + DMA bursts
    --------------------------------------------------------------------
    report "Test13D: Start interleaved CPU + DMA bursts";
    a_fast := FAST_BASE;
    a_chip := CHIP_BASE;

    for i in 0 to COUNT-1 loop

        ----------------------------------------------------------------
        -- CPU FAST write burst
        ----------------------------------------------------------------
        cpu_write(
            a_fast,
            FAST_NEW xor std_logic_vector(to_unsigned(i, 16))
        );

        ----------------------------------------------------------------
        -- DMA CHIP write burst (one beat per cycle)
        ----------------------------------------------------------------
        chipDMA <= '1';
        chipRW  <= '1';  -- write
        chipAddr <= a_chip(24 downto 1);
        chipWR   <= CHIP_NEW xor std_logic_vector(to_unsigned(i, 16));

        wait until rising_edge(sysclk);
        chipDMA <= '0';
        wait until rising_edge(sysclk);
        
        wait until dma_wr_done_tb = '1';
        wait until rising_edge(sysclk);
       
        -- Increment both address streams
        a_fast := addr_plus(a_fast, 1);
        a_chip := addr_plus(a_chip, 1);

    end loop;
    
    --------------------------------------------------------------------
    -- 4. Verify FAST region updated correctly
    --------------------------------------------------------------------
    report "Test13D: Verify FAST region updated correctly";
    a_fast := FAST_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);

        if d /= (FAST_NEW xor std_logic_vector(to_unsigned(i, 16))) then
            report "Test13E FAIL: FAST mismatch at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(FAST_NEW xor std_logic_vector(to_unsigned(i, 16))) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_fast := addr_plus(a_fast, 1);
    end loop;

    --------------------------------------------------------------------
    -- 5. Verify CHIP region updated correctly
    --------------------------------------------------------------------
    report "Test13D: Verify CHIP region updated correctly";
    
    a_chip := CHIP_BASE;

    for i in 0 to COUNT-1 loop
        cpu_read_chip(a_chip, d);

        if d /= (CHIP_NEW xor std_logic_vector(to_unsigned(i, 16))) then
            report "Test13E FAIL: CHIP mismatch at index " &
                   integer'image(i) &
                   " expected=" & slv_to_hex_any(CHIP_NEW xor std_logic_vector(to_unsigned(i, 16))) &
                   " got=" & slv_to_hex_any(d)
            severity error;
        end if;

        a_chip := addr_plus(a_chip, 1);
    end loop;

    report "TB: Test13E completed successfully" severity note;
end procedure Test13E;

procedure test13F is
    -- Region bases (example values)
    constant FAST_BASE : std_logic_vector(28 downto 1) := x"0201000";
    constant CHIP_BASE : std_logic_vector(28 downto 1) := x"0000000";
    constant IO_BASE   : std_logic_vector(28 downto 1) := x"0F00000";

    --constant COUNT     : natural := 8;    -- words per region
    constant COUNT     : natural := 1;    -- words per region
    --constant LOOPS     : natural := 128;  -- number of region-switch cycles
    constant LOOPS     : natural := 1;  -- number of region-switch cycles

    -- Patterns
    constant FAST_PAT : std_logic_vector(15 downto 0) := x"A100";
    constant CHIP_PAT : std_logic_vector(15 downto 0) := x"B200";
    constant IO_PAT   : std_logic_vector(15 downto 0) := x"C300";

    variable a_fast : std_logic_vector(28 downto 1);
    variable a_chip : std_logic_vector(28 downto 1);
    variable a_io   : std_logic_vector(28 downto 1);

    variable d      : std_logic_vector(15 downto 0);

    variable cpu_sel : integer;
    variable dma_sel : integer;
begin
    report "TB: Test13F Randomised Region Switching starting..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise all regions with known patterns
    --------------------------------------------------------------------
    report "Test13F: Initialise all regions with known patterns";
    -- FAST
    a_fast := FAST_BASE;
    for i in 0 to COUNT-1 loop
        cpu_write(a_fast, FAST_PAT xor std_logic_vector(to_unsigned(i, 16)));
        a_fast := addr_plus(a_fast, 1);
    end loop;

    -- CHIP
    a_chip := CHIP_BASE;
    for i in 0 to COUNT-1 loop
        cpu_write(a_chip, CHIP_PAT xor std_logic_vector(to_unsigned(i, 16)));
        a_chip := addr_plus(a_chip, 1);
    end loop;

    -- IO
    a_io := IO_BASE;
    for i in 0 to COUNT-1 loop
        cpu_write(a_io, IO_PAT xor std_logic_vector(to_unsigned(i, 16)));
        a_io := addr_plus(a_io, 1);
        a_io := addr_plus(a_io, 1);
    end loop;

    -- Prime FAST cache
    a_fast := FAST_BASE;
    for i in 0 to COUNT-1 loop
        cpu_read_fast(a_fast, d);
        a_fast := addr_plus(a_fast, 1);
    end loop;

    --------------------------------------------------------------------
    -- 2. Region-switching stress loop
    --------------------------------------------------------------------
    report "Test13F: Region-switching stress loop";
    
    for loopnum in 0 to LOOPS-1 loop

        ----------------------------------------------------------------
        -- CPU region selection (deterministic pseudo-random)
        ----------------------------------------------------------------
        cpu_sel := loopnum mod 3;  -- 0=FAST, 1=CHIP, 2=IO

        case cpu_sel is
            when 0 =>  -- FAST
                a_fast := FAST_BASE;
                cpu_read_fast(a_fast, d);

                if d /= (FAST_PAT xor x"0000") then
                    report "Test13F FAIL: FAST region corrupted" severity error;
                end if;

            when 1 =>  -- CHIP
                a_chip := CHIP_BASE;
                cpu_read_chip(a_chip, d);

                if d /= (CHIP_PAT xor x"0000") then
                    report "Test13F FAIL: CHIP region corrupted" severity error;
                end if;

            when 2 =>  -- IO
                a_io := IO_BASE;
                cpu_read_chip(a_io, d);  -- IO is uncached like CHIP

                if d /= (IO_PAT xor x"0000") then
                    report "Test13F FAIL: IO region corrupted" severity error;
                end if;

            when others =>
                null;
        end case;

        ----------------------------------------------------------------
        -- DMA region selection (deterministic pseudo-random)
        ----------------------------------------------------------------
        dma_sel := (loopnum / 2) mod 2;  -- 0=CHIP, 1=FAST
        chipDMA <= '1';
        case dma_sel is
            when 0 =>  -- DMA CHIP write
                a_chip := CHIP_BASE;
                chipRW  <= '1';
                chipAddr <= a_chip(24 downto 1);
                chipWR   <= CHIP_PAT xor x"00FF";

            when 1 =>  -- DMA FAST write
                a_fast := FAST_BASE;
                chipRW  <= '1';
                chipAddr <= a_fast(24 downto 1);
                chipWR   <= FAST_PAT xor x"00FF";

            when others =>
                null;
        end case;

        wait until rising_edge(sysclk);
        chipDMA <= '0';
        wait until rising_edge(sysclk);
        wait until dma_wr_done_tb = '1';
        wait until rising_edge(sysclk);
        
    end loop;

    --------------------------------------------------------------------
    -- 3. Final verification: all regions must be intact
    --------------------------------------------------------------------
    -- NOTE: This verification test is not correct.
    -- Useful for checking to make sure the BRAM Banks / Regions are being set correctly.
    -- TODO: Fix the expecting result to match what the TB is testing.
    -- TEST13G is similliar but more in-depth.
    
    report "Test13F: Final verification: all regions must be intact";
    -- FAST
    a_fast := FAST_BASE;
    cpu_read_fast(a_fast, d);

    assert d /= (FAST_PAT xor x"00FF")
        report "Test13F FAIL: FAST final mismatch" severity note;
        report "Test13F: Read=" & slv_to_hex16(d) & " Expecting=" & slv_to_hex16(FAST_PAT xor x"00FF");
    
    -- CHIP
    a_chip := CHIP_BASE;
    cpu_read_chip(a_chip, d);

    assert d /= (CHIP_PAT xor x"00FF") 
        report "Test13F FAIL: CHIP final mismatch" severity note;
        report "Test13F: Read=" & slv_to_hex16(d) & " Expecting=" & slv_to_hex16(CHIP_PAT xor x"00FF");
    

    -- IO
    a_io := IO_BASE;
    cpu_read_chip(a_io, d);

    assert d /= (IO_PAT xor x"0000")
        report "Test13F FAIL: IO final mismatch" severity note;
        report "Test13F: Read=" & slv_to_hex16(d) & " Expecting=" & slv_to_hex16(IO_PAT xor x"0000");
    
    report "TB: Test13F completed successfully" severity note;
end procedure Test13F;

procedure test13G is

    --------------------------------------------------------------------
    -- Configuration
    --------------------------------------------------------------------
    constant COUNT  : natural := 64;     -- words per region
    --constant COUNT  : natural := 8;     -- words per region
    constant LOOPS  : natural := 500;    -- number of random operations
    --constant LOOPS  : natural := 10;    -- number of random operations

    constant FAST_BASE : std_logic_vector(28 downto 1) := x"0201000";
    constant CHIP_BASE : std_logic_vector(28 downto 1) := x"0000000";
    constant IO_BASE   : std_logic_vector(28 downto 1) := x"0F80000";

    -- Shadow memory model
    type mem_array is array(0 to COUNT-1) of std_logic_vector(15 downto 0);

    variable fast_shadow : mem_array;
    variable chip_shadow : mem_array;
    variable io_shadow   : mem_array;

    variable d : std_logic_vector(15 downto 0);


    --------------------------------------------------------------------
    -- Simple deterministic LFSR for reproducible pseudo-random numbers
    --------------------------------------------------------------------

    function rand return integer is
    variable lfsr : std_logic_vector(15 downto 0) := x"ACE1";
    begin
        -- 16-bit LFSR: taps 16,14,13,11
        lfsr := lfsr(14 downto 0) & 
                (lfsr(15) xor lfsr(13) xor lfsr(12) xor lfsr(10));
        return to_integer(unsigned(lfsr));
    end function;
    
    --------------------------------------------------------------------
    -- Helper: pick random offset within region
    --------------------------------------------------------------------
    function rand_offset return integer is
    begin
        return rand mod COUNT;
    end function;

    --------------------------------------------------------------------
    -- Helper: compute address = BASE + offset
    --------------------------------------------------------------------
    function region_addr(base : std_logic_vector(28 downto 1);
                         offset : integer) return std_logic_vector is
    begin
        return addr_plus(base, offset);
    end function;
    
    variable cpu_region : integer := rand mod 3;  -- 0=FAST,1=CHIP,2=IO
    variable cpu_op     : integer := rand mod 2;  -- 0=READ,1=WRITE
    variable off        : integer := rand_offset;
    
    variable dma_region : integer := rand mod 2;  -- 0=CHIP, 1=FAST
    variable dma_op     : integer := rand mod 2;  -- 0=READ, 1=WRITE
    variable doff       : integer := rand_offset;

begin
    report "TB: Test13G FULL RANDOM STRESS starting..." severity note;

    --------------------------------------------------------------------
    -- 1. Initialise all regions + shadow model
    --------------------------------------------------------------------
    report "Test13G: Initialise all regions";
    for i in 0 to COUNT-1 loop
        fast_shadow(i) := std_logic_vector(to_unsigned(i, 16) xor x"A100");
        chip_shadow(i) := std_logic_vector(to_unsigned(i, 16) xor x"B200");
        io_shadow(i)   := std_logic_vector(to_unsigned(i, 16) xor x"C300");

        cpu_write(region_addr(FAST_BASE, i), fast_shadow(i));
        cpu_write(region_addr(CHIP_BASE, i), chip_shadow(i));
        cpu_write(region_addr(IO_BASE,   i), io_shadow(i));
    end loop;

    -- Prime FAST cache
    for i in 0 to COUNT-1 loop
        cpu_read_fast(region_addr(FAST_BASE, i), d);
    end loop;

    --------------------------------------------------------------------
    -- 2. Randomised stress loop
    --------------------------------------------------------------------
    report "Test13G: Randomised stress loop";
    for n in 0 to LOOPS-1 loop

        ----------------------------------------------------------------
        -- Random CPU operation
        ----------------------------------------------------------------
        case cpu_region is

            when 0 =>  -- FAST
                if cpu_op = 0 then
                    cpu_read_fast(region_addr(FAST_BASE, off), d);
                    assert d = fast_shadow(off)
                      report "FAST shadow mismatch at offset " & integer'image(off)
                      severity error;
                else
                    d := std_logic_vector(to_unsigned(rand, 16));
                    cpu_write(region_addr(FAST_BASE, off), d);
                    fast_shadow(off) := d;
                end if;

            when 1 =>  -- CHIP
                if cpu_op = 0 then
                    cpu_read_chip(region_addr(CHIP_BASE, off), d);
                    assert d = chip_shadow(off)
                      report "CHIP shadow mismatch at offset " & integer'image(off)
                      severity error;
                else
                    d := std_logic_vector(to_unsigned(rand, 16));
                    cpu_write(region_addr(CHIP_BASE, off), d);
                    chip_shadow(off) := d;
                end if;

            when 2 =>  -- IO
                if cpu_op = 0 then
                    cpu_read_chip(region_addr(IO_BASE, off), d);
                    assert d = io_shadow(off)
                      report "IO shadow mismatch at offset " & integer'image(off)
                      severity error;
                else
                    d := std_logic_vector(to_unsigned(rand, 16));
                    cpu_write(region_addr(IO_BASE, off), d);
                    io_shadow(off) := d;
                end if;
            
            when others => null;    

        end case;

        ----------------------------------------------------------------
        -- Random DMA operation
        ----------------------------------------------------------------
        report "Test13G: Random DMA operations";

        chipDMA <= '1';
        --chipRW  <= std_logic'val(dma_op);  -- 0=read, 1=write        
        if dma_op = 0 then
            chipRW <= '0';
        else    
            chipRW <= '1';
        end if;

        if dma_region = 0 then
            chipAddr <= region_addr(CHIP_BASE, doff)(24 downto 1);
            if dma_op = 1 then
                chipWR <= std_logic_vector(to_unsigned(rand, 16));
            end if;
        else
            chipAddr <= region_addr(FAST_BASE, doff)(24 downto 1);
            if dma_op = 1 then
                chipWR <= std_logic_vector(to_unsigned(rand, 16));
            end if;
        end if;

        wait until rising_edge(sysclk);
        chipDMA <= '0';
        wait until rising_edge(sysclk);

        if dma_op = 0 then
            wait until chip_rd_done = '1';
            wait until rising_edge(sysclk);
            d := chipRD;
            wait until chip_rd_done = '0';

            if dma_region = 0 then
                assert d = chip_shadow(doff)
                  report "DMA CHIP read mismatch at offset " & integer'image(doff)
                  severity error;
            else
                assert d = fast_shadow(doff)
                  report "DMA FAST read mismatch at offset " & integer'image(doff)
                  severity error;
            end if;

        else
            wait until dma_wr_done_tb = '1';
            wait until rising_edge(sysclk);
            

            if dma_region = 0 then
                chip_shadow(doff) := chipWR;
            else
                fast_shadow(doff) := chipWR;
            end if;
        end if;

    end loop;

    --------------------------------------------------------------------
    -- 3. Final full-region verification
    --------------------------------------------------------------------
    report "Test13G: Final full-region verification";
    for i in 0 to COUNT-1 loop
    report "Test13G: Loop i=" & integer'image(i);
        cpu_read_fast(region_addr(FAST_BASE, i), d);
        report "Test13G: cpu_read_fast index=" & integer'image(i) & " d=" & slv_to_hex16(d) & " fast_shadow=" & slv_to_hex_any(fast_shadow(i));
        
        assert d = fast_shadow(i)
          report "FAST final mismatch at offset " & integer'image(i)
          severity error;
    
        report "Test13G: Start cpu_read_chip";
        cpu_read_chip(region_addr(CHIP_BASE, i), d);
        report "Test13G: cpu_read_chip index=" & integer'image(i) & " d=" & slv_to_hex16(d) & " chip_shadow=" & slv_to_hex_any(chip_shadow(i));
        assert d = chip_shadow(i)
          report "CHIP final mismatch at offset " & integer'image(i)
          severity error;

        report "Test13G: Start cpu_read_chip IO_BASE";
        cpu_read_chip(region_addr(IO_BASE, i), d);
        report "Test13G: cpu_read_chip IO_BASE index=" & integer'image(i) & " d=" & slv_to_hex16(d) & " io_shadow=" & slv_to_hex_any(io_shadow(i));
        assert d = io_shadow(i)
          report "IO final mismatch at offset " & integer'image(i)
          severity error;
    end loop;

    report "TB: Test13G FULL RANDOM STRESS completed successfully" severity note;

end procedure test13G;

procedure test20 is
--  Test read the ROM that is pre-loaded to the BRAM ROM region
    constant ROM_BASE   : std_logic_vector(28 downto 1) := x"0F80000";
    --constant ROM_BASE   : std_logic_vector(28 downto 1) := x"0F00000";
    constant LOOPS      : natural := 256;
    --constant LOOPS      : natural := 10;
    
    variable d : std_logic_vector(15 downto 0);

begin
report "Test20: Read ROM Memory";

for i in 0 to LOOPS-1 loop
    cpu_read_fast(addr_plus(ROM_BASE, i), d);
end loop;

report "Test20: Completed";

end procedure test20;
        
    begin
        -- wait for reset deassertion
        wait until reset_n = '1';
        wait for 5*CLK_PERIOD;
        
        --   Test01 - Test08 CPU write/read tests
--        test01;      -- Test 1: simple uncached CHIP write/read (cache inhibited by region)
----        --test02;      -- Test 2: shared (RTG-style) region byte-swap behaviour    NOTE: don't run this test as the current code does not do byte-swap.  Will need to look at it again if we end up doing RTG fro the A1200 config, Currently not implemented.
--        test03;      -- Test 3: FAST RAM cache hit
--        test04;      -- Test 4: CHIP region must be cache-inhibited
--        test05;      -- Test 5: FAST write only (no read) - ensure no cache pollution
--        test06;      -- Test 6: FAST reads with cache disabled.
--        test07;      -- Test 7: FAST Write-Through on Hit
--        test08;      -- Test 8: FAST Write-Miss (No Write-Allocate)
--        test8A;      -- Test 8A: Multi write / read test.
  
                        -- NOTE*** More work is required on the cache, 
                        -- not reqired for A500 release and therefore have stubbed it out.  Just bypasses cache if used.
                        -- Leave the cache inhibit on
                        -- no point in running chahe test.      
--        test09;      -- Test 9: Cache-Inhibit Behaviour (FAST region)  -- *** MUST run this before 9A-9D, it sets the cache flag
--        test9A;     -- Test9A: Cache-inhibit read (FAST region)
--        test9B;     -- Test9B: Cache-inhibit write (FAST region)
--        test9C;     -- Test9C: Cache-inhibit does not pollute or flush cache
--        test9D;     -- Test9D: Cache-inhibit overrides write-through hit logic
                         
--        test10A;      -- Test10A: DMA-only CHIP read
--        test10B;      -- Test10B: issuing CPU read (will be stalled)
--        test10C;      -- Test10C: sequential DMA reads
--        test10D;      -- Test10D: DMA write test
--        test10E;      -- Test10E: CPU vs DMA arbitration test
--        test10F;      -- Test10F: DMA burst sequential reads
--        test10G;      -- Test10F: DMA Burst 3-Beat read
--        test10H;      -- Test10F: DMA Burst write 3-Beat
        
--        test11A;      -- Test11A: CPU cached read + DMA write to different addresses
--        test11B;      -- Test11B: CPU cached write + DMA read to same address  
--        test11C;      -- Test11C: CPU + DMA write contention  
--        test11D;      -- Test11D: simultaneous CPU + DMA write same cycle  
--        test11E;      -- Test11E: simultaneous CPU read + DMA write  
--        test11F;      -- Test11F: simultaneous CPU write + DMA read  
--        test11G;      -- Test11G: DMA burst + CPU interference  
--        test11H;      -- Test11H: DMA 4-beat incrementing burst + CPU interference  
--        test11G_FAST;      -- Test11G_FAST DMA burst + CPU interference (FAST)    
--        test11G_DMAWRITE;  -- Test11G_DMAWRITE: DMA write burst + CPU read  
        
         --CHIP48 test
         --Need to set TB runtime to about 10000 to start with....
--        test12;      -- Test12: CHIP48 sliding window
--        test13;      -- Test13: CHIP48 under CPU + DMA contention...
--        test13X;     -- Test13: CPU CHIP Read test
--        test13A;     -- Test13A: CPU FAST read + DMA CHIP write...
--        test13B;      -- Test13B: CPU CHIP read + DMA FAST write...
--        test13C;      -- Test13C: CPU FAST write + DMA FAST read...
--        test13C_advanced;      -- Test13C: CPU FAST write + DMA FAST read...  Set TB runtime to 75000
--        test13D;      -- Test13D: CPU alternating read/write        --- Set TB runtime to 85000
--        test13E;      -- Test13E: DMA burst + CPU burst interleaved   --- Set TB runtime to 20000
--        test13F;      -- Test13F: Randomised Region Switching            --- Set TB runtime to 32000  NB: The final test is not correct.
            -- This is the big final test, putting DUT under load and simulating real-world usage.
        test13G;      -- Test13F: Full Randomised Stress             --- Set TB runtime to 180000.  Best to also turn off the debug report output as well.
        
--        test20;         -- Test20: Read ROM BRAM to test pre-loaded memory file  --- Set TB runtime to 40000ns
        
        report "TB completed" severity note;
        wait;
    end process;

end architecture;