// <<<<< Insert the orig credits and notice here!!!! >>>>>>
//
// March 2026       David Raynor (kiwi)
// Correct the reset defaults on some of the signals.
//

module denise_bitplane_shifter_m65
(
    input  wire        clk,
    input  wire        clk7_en,
    input  wire        c1,
    input  wire        c3,
    input  wire        reset,
    input  wire        load,
    input  wire        hires,
    input  wire        shres,
    input  wire [1:0]  fmode,
    input  wire        aga,
    input  wire [63:0] data_in,
    input  wire [7:0]  scroll,
    output wire        out
);

    // ------------------------------------------------------------
    // Fetchmode mask (combinational)
    // ------------------------------------------------------------
    reg [5:0] fmode_mask;

    always @(*) begin
        case (fmode)
            2'b00: fmode_mask = 6'b00_1111;
            2'b01,
            2'b10: fmode_mask = 6'b01_1111;
            2'b11: fmode_mask = 6'b11_1111;
        endcase
    end

    // ------------------------------------------------------------
    // Shift enable + select logic (combinational)
    // ------------------------------------------------------------
    reg        shift;
    reg [5:0]  select;

    always @(*) begin
        if (shres) begin
            shift  = 1'b1;
            select = scroll[5:0] & fmode_mask;
        end
        else if (hires) begin
            shift  = (~c1 ^ c3);
            select = scroll[6:1] & fmode_mask;
        end
        else begin
            shift  = (~c1 & ~c3);
            select = scroll[7:2] & fmode_mask;
        end
    end

    // ------------------------------------------------------------
    // Main shifter (reset added)
    // ------------------------------------------------------------
    reg [63:0] shifter;

    always @(posedge clk) begin
        if (reset) begin
            shifter <= 64'd0;
        end
        else if (load && !c1 && !c3) begin
            shifter <= data_in;
        end
        else if (shift) begin
            shifter <= {shifter[62:0], 1'b0};
        end
    end

    // ------------------------------------------------------------
    // Scroller (reset added)
    // ------------------------------------------------------------
    reg [63:0] scroller;

    always @(posedge clk) begin
        if (reset) begin
            scroller <= 64'd0;
        end
        else if (shift) begin
            scroller <= {scroller[62:0], shifter[63]};
        end
    end

    wire scroller_out = scroller[select];

    // ------------------------------------------------------------
    // Superhires scroller (reset added)
    // ------------------------------------------------------------
    reg [7:0] sh_scroller;
    reg [2:0] sh_select;

    always @(*) begin
        if (shres)
            sh_select = aga ? 3'b110 : 3'b011;
        else if (hires)
            sh_select = {aga, scroll[0], 1'b1};
        else
            sh_select = {aga, scroll[1:0]};
    end

    always @(posedge clk) begin
        if (reset)
            sh_scroller <= 8'd0;
        else
            sh_scroller <= {sh_scroller[6:0], scroller_out};
    end

    assign out = sh_scroller[sh_select];

endmodule
