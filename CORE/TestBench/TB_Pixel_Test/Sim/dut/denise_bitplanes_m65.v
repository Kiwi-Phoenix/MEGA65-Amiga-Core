// <<<<< Insert the orig credits and notice here!!!! >>>>>>
//
// March 2026       David Raynor (kiwi)
// Correct the reset defaults on some of the signals.
// April 2026       David Ryanor (kiwi)
//  Add reset to the instantiation of bitplane_shifter

module denise_bitplanes_m65
(
    input         clk,             // system bus clock
    input         clk7_en,
    input         reset,
    input         c1,              // 35ns clock enable signals (for synchronization with clk)
    input         c3,
    input         aga,
    input  [8:1]  reg_address_in,  // register address
    input  [15:0] data_in,         // bus data in
    input  [47:0] chip48,          // big chipram read
    input         hires,           // high resolution mode select
    input         shres,           // super high resolution mode select
    input  [8:0]  hpos,            // horizontal position (70ns resolution)
    output [8:1]  bpldata          // bitplane data out
);

// register names and addresses
parameter BPLCON1 = 9'h102;
parameter BPL1DAT = 9'h110;
parameter BPL2DAT = 9'h112;
parameter BPL3DAT = 9'h114;
parameter BPL4DAT = 9'h116;
parameter BPL5DAT = 9'h118;
parameter BPL6DAT = 9'h11a;
parameter BPL7DAT = 9'h11c;
parameter BPL8DAT = 9'h11e;
parameter FMODE   = 9'h1fc;

// local signals
reg  [15:0] bplcon1;       // bplcon1 register
reg  [15:0] fmode;         // fmode register

reg  [63:0] bpl1dat;       // buffer register for bit plane 1
reg  [63:0] bpl2dat;       // buffer register for bit plane 2
reg  [63:0] bpl3dat;       // buffer register for bit plane 3
reg  [63:0] bpl4dat;       // buffer register for bit plane 4
reg  [63:0] bpl5dat;       // buffer register for bit plane 5
reg  [63:0] bpl6dat;       // buffer register for bit plane 6
reg  [63:0] bpl7dat;       // buffer register for bit plane 7
reg  [63:0] bpl8dat;       // buffer register for bit plane 8

reg         load;          // bpl1dat written => load shift registers

reg  [7:0]  extra_delay_f0;   // extra delay when not aligned ddfstart
reg  [7:0]  extra_delay_f12;
reg  [7:0]  extra_delay_f3;
reg  [7:0]  extra_delay_r;

reg  [7:0]  pf1h;          // playfield 1 horizontal scroll
reg  [7:0]  pf2h;          // playfield 2 horizontal scroll
reg  [7:0]  pf1h_del;      // delayed playfield 1 horizontal scroll
reg  [7:0]  pf2h_del;      // delayed playfield 2 horizontal scroll

//--------------------------------------------------------------------------------------
// horizontal scroll depends on horizontal position when BPL0DAT is written
// visible display scroll is updated on fetch boundaries
// increasing scroll value during active display inserts blank pixels

always @* begin
    case (hpos[3:2])
        2'b00 : extra_delay_f0 = 8'b00_0000_00;
        2'b01 : extra_delay_f0 = 8'b00_1100_00;
        2'b10 : extra_delay_f0 = 8'b00_1000_00;
        2'b11 : extra_delay_f0 = 8'b00_0100_00;
    endcase
end

always @* begin
    case (hpos[4:3])
        2'b00 : extra_delay_f12 = 8'b00_0000_00;
        2'b01 : extra_delay_f12 = 8'b01_1000_00;
        2'b10 : extra_delay_f12 = 8'b01_0000_00;
        2'b11 : extra_delay_f12 = 8'b00_1000_00;
    endcase
end

always @* begin
    case (hpos[5:4])
        2'b00 : extra_delay_f3 = 8'b00_0000_00;
        2'b01 : extra_delay_f3 = 8'b11_0000_00;
        2'b10 : extra_delay_f3 = 8'b10_0000_00;
        2'b11 : extra_delay_f3 = 8'b01_0000_00;
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        extra_delay_r <= 8'h00;
    end else if (clk7_en) begin
        if (load) begin
            case (fmode[1:0])
                2'b00   : extra_delay_r <= extra_delay_f0;
                2'b11   : extra_delay_r <= extra_delay_f3;
                default : extra_delay_r <= extra_delay_f12;
            endcase
        end
    end
end

// playfield 1 effective horizontal scroll
always @(posedge clk) begin
    if (reset) begin
        pf1h     <= 8'h00;
        pf1h_del <= 8'h00;
    end else if (clk7_en) begin
        if (load) begin
            pf1h <= {bplcon1[11:10], bplcon1[3:0], bplcon1[9:8]};
        end
        pf1h_del <= pf1h + extra_delay_r;
    end
end

// playfield 2 effective horizontal scroll
always @(posedge clk) begin
    if (reset) begin
        pf2h     <= 8'h00;
        pf2h_del <= 8'h00;
    end else if (clk7_en) begin
        if (load) begin
            pf2h <= {bplcon1[15:14], bplcon1[7:4], bplcon1[13:12]};
        end
        pf2h_del <= pf2h + extra_delay_r;
    end
end

// writing bplcon1 register : horizontal scroll codes for even and odd bitplanes
always @(posedge clk) begin
    if (reset) begin
        bplcon1 <= 16'h3300;
    end else if (clk7_en) begin
        if (reg_address_in[8:1] == BPLCON1[8:1]) begin
            bplcon1 <= aga
                       ? data_in[15:0]
                       : {2'b00, 2'b11, 2'b00, 2'b11, data_in[7:0]};
        end
    end
end

// fmode
always @(posedge clk) begin
    if (reset) begin
        fmode <= 16'h0000;
    end else if (clk7_en) begin
        if (aga && (reg_address_in[8:1] == FMODE[8:1])) begin
            fmode <= data_in;
        end
    end
end

reg [47:0] chip48_fmode = 48'h000000000000;
always @* begin
    case (fmode[1:0])
        2'b11   : chip48_fmode = chip48[47:0];
        2'b10,
        2'b01   : chip48_fmode = {chip48[47:32], 32'h00000000};
        default : chip48_fmode = 48'h000000000000;
    endcase
end

//--------------------------------------------------------------------------------------
wire clk7n_en = c1 & c3;

reg [15:0] data16;
always @(posedge clk) begin
    if (reset) begin
        data16 <= 16'h0000;
    end else if (clk7_en) begin
        data16 <= data_in;
    end
end

// bitplane buffer register for plane 1
always @(posedge clk) begin : a
    reg st;
    if (reset) begin
        st      <= 1'b0;
        bpl1dat <= 64'h0000000000000000;
    end else begin
        if (clk7_en && reg_address_in[8:1] == BPL1DAT[8:1]) begin
            st <= 1'b1;
        end
        if (st && clk7n_en) begin
            st      <= 1'b0;
            bpl1dat <= {data16, chip48_fmode};
        end
    end
end

// bitplane buffer register for plane 2
always @(posedge clk) begin : b
    reg st;
    if (reset) begin
        st      <= 1'b0;
        bpl2dat <= 64'h0000000000000000;
    end else begin
        if (clk7_en && reg_address_in[8:1] == BPL2DAT[8:1]) begin
            st <= 1'b1;
        end
        if (st && clk7n_en) begin
            st      <= 1'b0;
            bpl2dat <= {data16, chip48_fmode};
        end
    end
end

// bitplane buffer register for plane 3
always @(posedge clk) begin : c
    reg st;
    if (reset) begin
        st      <= 1'b0;
        bpl3dat <= 64'h0000000000000000;
    end else begin
        if (clk7_en && reg_address_in[8:1] == BPL3DAT[8:1]) begin
            st <= 1'b1;
        end
        if (st && clk7n_en) begin
            st      <= 1'b0;
            bpl3dat <= {data16, chip48_fmode};
        end
    end
end

// bitplane buffer register for plane 4
always @(posedge clk) begin : d
    reg st;
    if (reset) begin
        st      <= 1'b0;
        bpl4dat <= 64'h0000000000000000;
    end else begin
        if (clk7_en && reg_address_in[8:1] == BPL4DAT[8:1]) begin
            st <= 1'b1;
        end
        if (st && clk7n_en) begin
            st      <= 1'b0;
            bpl4dat <= {data16, chip48_fmode};
        end
    end
end

// bitplane buffer register for plane 5
always @(posedge clk) begin : e
    reg st;
    if (reset) begin
        st      <= 1'b0;
        bpl5dat <= 64'h0000000000000000;
    end else begin
        if (clk7_en && reg_address_in[8:1] == BPL5DAT[8:1]) begin
            st <= 1'b1;
        end
        if (st && clk7n_en) begin
            st      <= 1'b0;
            bpl5dat <= {data16, chip48_fmode};
        end
    end
end

// bitplane buffer register for plane 6
always @(posedge clk) begin : f
    reg st;
    if (reset) begin
        st      <= 1'b0;
        bpl6dat <= 64'h0000000000000000;
    end else begin
        if (clk7_en && reg_address_in[8:1] == BPL6DAT[8:1]) begin
            st <= 1'b1;
        end
        if (st && clk7n_en) begin
            st      <= 1'b0;
            bpl6dat <= {data16, chip48_fmode};
        end
    end
end

// bitplane buffer register for plane 7
always @(posedge clk) begin : g
    reg st;
    if (reset) begin
        st      <= 1'b0;
        bpl7dat <= 64'h0000000000000000;
    end else begin
        if (clk7_en && reg_address_in[8:1] == BPL7DAT[8:1]) begin
            st <= 1'b1;
        end
        if (st && clk7n_en) begin
            st      <= 1'b0;
            bpl7dat <= {data16, chip48_fmode};
        end
    end
end

// bitplane buffer register for plane 8
always @(posedge clk) begin : h
    reg st;
    if (reset) begin
        st      <= 1'b0;
        bpl8dat <= 64'h0000000000000000;
    end else begin
        if (clk7_en && reg_address_in[8:1] == BPL8DAT[8:1]) begin
            st <= 1'b1;
        end
        if (st && clk7n_en) begin
            st      <= 1'b0;
            bpl8dat <= {data16, chip48_fmode};
        end
    end
end

// generate load signal when plane 1 is written
always @(posedge clk) begin
    if (reset) begin
        load <= 1'b0;
    end else if (clk7_en) begin
        load <= (reg_address_in[8:1] == BPL1DAT[8:1]);
    end
end

//--------------------------------------------------------------------------------------
// instantiate bitplane parallel-to-serial converters

denise_bitplane_shifter_m65 bplshft1
(
    .clk    (clk),
    .clk7_en(clk7_en),
    .c1     (c1),
    .c3     (c3),
    .reset  (reset),
    .load   (load),
    .hires  (hires),
    .shres  (shres),
    .fmode  (fmode[1:0]),
    .aga    (aga),
    .data_in(bpl1dat),
    .scroll (pf1h_del),
    .out    (bpldata[1])
);

denise_bitplane_shifter_m65 bplshft2
(
    .clk    (clk),
    .clk7_en(clk7_en),
    .c1     (c1),
    .c3     (c3),
    .reset  (reset),    
    .load   (load),
    .hires  (hires),
    .shres  (shres),
    .fmode  (fmode[1:0]),
    .aga    (aga),
    .data_in(bpl2dat),
    .scroll (pf2h_del),
    .out    (bpldata[2])
);

denise_bitplane_shifter_m65 bplshft3
(
    .clk    (clk),
    .clk7_en(clk7_en),
    .c1     (c1),
    .c3     (c3),
    .reset  (reset),    
    .load   (load),
    .hires  (hires),
    .shres  (shres),
    .fmode  (fmode[1:0]),
    .aga    (aga),
    .data_in(bpl3dat),
    .scroll (pf1h_del),
    .out    (bpldata[3])
);

denise_bitplane_shifter_m65 bplshft4
(
    .clk    (clk),
    .clk7_en(clk7_en),
    .c1     (c1),
    .c3     (c3),
    .reset  (reset),    
    .load   (load),
    .hires  (hires),
    .shres  (shres),
    .fmode  (fmode[1:0]),
    .aga    (aga),
    .data_in(bpl4dat),
    .scroll (pf2h_del),
    .out    (bpldata[4])
);

denise_bitplane_shifter_m65 bplshft5
(
    .clk    (clk),
    .clk7_en(clk7_en),
    .c1     (c1),
    .c3     (c3),
    .reset  (reset),    
    .load   (load),
    .hires  (hires),
    .shres  (shres),
    .fmode  (fmode[1:0]),
    .aga    (aga),
    .data_in(bpl5dat),
    .scroll (pf1h_del),
    .out    (bpldata[5])
);

denise_bitplane_shifter_m65 bplshft6
(
    .clk    (clk),
    .clk7_en(clk7_en),
    .c1     (c1),
    .c3     (c3),
    .reset  (reset),    
    .load   (load),
    .hires  (hires),
    .shres  (shres),
    .fmode  (fmode[1:0]),
    .aga    (aga),
    .data_in(bpl6dat),
    .scroll (pf2h_del),
    .out    (bpldata[6])
);

denise_bitplane_shifter_m65 bplshft7
(
    .clk    (clk),
    .clk7_en(clk7_en),
    .c1     (c1),
    .c3     (c3),
    .reset  (reset),    
    .load   (load),
    .hires  (hires),
    .shres  (shres),
    .fmode  (fmode[1:0]),
    .aga    (aga),
    .data_in(bpl7dat),
    .scroll (pf1h_del),
    .out    (bpldata[7])
);

denise_bitplane_shifter_m65 bplshft8
(
    .clk    (clk),
    .clk7_en(clk7_en),
    .c1     (c1),
    .c3     (c3),
    .reset  (reset),    
    .load   (load),
    .hires  (hires),
    .shres  (shres),
    .fmode  (fmode[1:0]),
    .aga    (aga),
    .data_in(bpl8dat),
    .scroll (pf2h_del),
    .out    (bpldata[8])
);

//  Debug Report
//always @(posedge clk) begin : dbug_report
//    $display("BPL DBG T=%0t hpos=%0d load=%b data_in=%h bpldata=%b",
//        $time, hpos, load, data_in, bpldata);

//end

endmodule