/*----------------------------------------------------------------------------------------
Replace module for Denise colortable ram.
Uses XPM for memory IP.
Drop in replacement for the MiSTer minimig IP that was used.

February 2026       David Raynor (Kiwi)

----------------------------------------------------------------------------------------*/

module denise_colortable_ram_mf (
     input         clock
    ,input         enable
    ,input  [3:0]  byteena_a
    ,input  [31:0] data
    ,input  [7:0]  wraddress
    ,input  [7:0]  rdaddress
    ,input         wren
    ,output [31:0] q
);

    xpm_memory_tdpram #(
         .MEMORY_SIZE        (256 * 32)     // 8 KB
        ,.MEMORY_PRIMITIVE   ("auto")
        ,.CLOCKING_MODE      ("common_clock")
        ,.MEMORY_INIT_FILE   ("none")
        ,.MEMORY_INIT_PARAM  ("0")
        ,.USE_MEM_INIT       (0)
        ,.WAKEUP_TIME        ("disable_sleep")
        ,.MESSAGE_CONTROL    (0)

        ,.WRITE_DATA_WIDTH_A (32)
        ,.READ_DATA_WIDTH_A  (32)
        ,.BYTE_WRITE_WIDTH_A (8)
        ,.ADDR_WIDTH_A       (8)

        ,.WRITE_DATA_WIDTH_B (32)
        ,.READ_DATA_WIDTH_B  (32)
        ,.BYTE_WRITE_WIDTH_B (8)
        ,.ADDR_WIDTH_B       (8)

        ,.READ_LATENCY_B     (1)            // unregistered output
        ,.WRITE_MODE_B       ("read_first") // matches OLD_DATA
        ,.WRITE_MODE_A       ("read_first")
    ) color_ram (
         .clka      (clock)
        ,.clkb      (clock)

        // Port A (write)
        ,.addra     (wraddress)
        ,.dina      (data)
        ,.ena       (enable)
        ,.wea       (byteena_a & {4{wren}})

        // Port B (read)
        ,.addrb     (rdaddress)
        ,.enb       (enable)
        ,.doutb     (q)

        // Unused ports
        ,.dinb      (32'b0)
        ,.web       (4'b0)
        ,.douta     ()
        ,.rsta      (1'b0)
        ,.rstb      (1'b0)
        ,.regcea    (1'b1)
        ,.regceb    (1'b1)
        ,.sleep     (1'b0)
    );

endmodule