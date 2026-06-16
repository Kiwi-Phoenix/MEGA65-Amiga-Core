// <<<<< Insert the orig credits and notice here!!!! >>>>>>
//
// March 2026       David Raynor (kiwi)
// Correct the reset defaults on some of the signals.
//  


module denise_sprites_shifter_m65
(
    input         clk,        // 28MHz clock
    input         clk7_en,
    input         clk7n_en,   // 7MHz clock enable (c1 & c3)
    input         reset,      // reset
    input         aen,        // address enable
    input  [1:0]  address,    // register address input
    input  [8:0]  hpos,       // horizontal beam counter
    input  [15:0] fmode,
    input         shift,
    input  [47:0] chip48,
    input  [15:0] data_in,    // bus data in
    output [1:0]  sprdata,    // serialized sprite data out
    output reg    attach      // sprite is attached
);

    // register names and addresses
    localparam POS  = 2'b00;
    localparam CTL  = 2'b01;
    localparam DATA = 2'b10;
    localparam DATB = 2'b11;

    // local signals
    reg  [63:0] datla;     // data register A
    reg  [63:0] datlb;     // data register B
    reg  [63:0] shifta;    // shift register A
    reg  [63:0] shiftb;    // shift register B
    reg  [8:0]  hstart;    // horizontal start value
    reg         armed;     // sprite "armed" signal
    reg         load;      // load shift register signal

    reg  [15:0] data16;
    always @(posedge clk) begin
        if (reset) begin
            data16 <= 16'h0000;
        end else if (clk7_en) begin
            data16 <= data_in;
        end
    end

    // switch data according to fmode
    reg [63:0] spr_fmode_dat;
    always @(*) begin
        case (fmode[3:2])
            2'b00: spr_fmode_dat = {data16, 48'h000000000000};
            2'b11: spr_fmode_dat = {data16, chip48[47:0]};
            default: spr_fmode_dat = {data16, chip48[47:32], 32'h00000000};
        endcase
    end

    // generate armed signal
    always @(posedge clk) begin
        if (reset) begin
            armed <= 1'b0;
        end else if (clk7_en) begin
            if (aen && (address == CTL))
                armed <= 1'b0;   // writing CTL disables sprite
            else if (aen && (address == DATA))
                armed <= 1'b1;   // writing DATA arms sprite
        end
    end

    // generate load signal
    always @(posedge clk) begin
        if (reset) begin
            load <= 1'b0;
        end else if (clk7_en) begin
            load <= armed &&
                    (hpos[7:0] == hstart[7:0]) &&
                    (fmode[15] || (hpos[8] == hstart[8]));
        end
    end

    // POS register
    always @(posedge clk) begin
        if (reset) begin
            hstart <= 9'd0;
        end else if (clk7_en) begin
            if (aen && (address == POS))
                hstart[8:1] <= data_in[7:0];
        end
    end

    // CTL register
    always @(posedge clk) begin
        if (reset) begin
            attach    <= 1'b0;
            hstart[0] <= 1'b0;
        end else if (clk7_en) begin
            if (aen && (address == CTL))
                {attach, hstart[0]} <= {data_in[7], data_in[0]};
        end
    end

    // data register A
    always @(posedge clk) begin : a
        reg st;
        if (reset) begin
            st    <= 1'b0;
            datla <= 64'h0;
        end else begin
            if (clk7_en && aen && (address == DATA))
                st <= 1'b1;
            if (st && clk7n_en) begin
                st    <= 1'b0;
                datla <= spr_fmode_dat;
            end
        end
    end

    // data register B
    always @(posedge clk) begin : b
        reg st;
        if (reset) begin
            st    <= 1'b0;
            datlb <= 64'h0;
        end else begin
            if (clk7_en && aen && (address == DATB))
                st <= 1'b1;
            if (st && clk7n_en) begin
                st    <= 1'b0;
                datlb <= spr_fmode_dat;
            end
        end
    end

    // sprite shift register
    always @(posedge clk) begin
        if (reset) begin
            shifta <= 64'h0;
            shiftb <= 64'h0;
        end else if (clk7_en && load) begin
            // load new data into shift register
            shifta <= datla;
            shiftb <= datlb;
        end else if (shift) begin
            shifta <= {shifta[62:0], 1'b0};
            shiftb <= {shiftb[62:0], 1'b0};
        end
    end

    // serialized output data (pipelined)
    reg [7:0] sprdata_r;
    always @(posedge clk) begin
        if (reset) begin
            sprdata_r <= 8'h00;
        end else begin
            sprdata_r <= {shiftb[63], shifta[63], sprdata_r[7:2]};
        end
    end

    assign sprdata = sprdata_r[1:0];

endmodule
