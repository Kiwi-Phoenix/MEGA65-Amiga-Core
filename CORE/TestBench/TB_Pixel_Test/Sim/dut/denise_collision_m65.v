// Collision detection module
//
// <<<<< Insert the orig credits and notice here!!!! >>>>>>
//
// March 2026       David Raynor (kiwi)
// Correct the reset defaults on some of the signals.
//

module denise_collision_m65
(
    input         clk,             // 28MHz clock
    input         clk7_en,
    input         reset,           // reset
    input         aga,             // AGA enabled
    input  [8:1]  reg_address_in,  // register address inputs
    input  [15:0] data_in,         // bus data in
    output [15:0] data_out,        // bus data out
    input         dblpf,           // dual playfield signal
    input  [7:0]  bpldata,         // bitplane serial video data in
    input  [7:0]  nsprite          // sprite activity flags
);

    // register names and addresses
    localparam CLXCON  = 9'h098;
    localparam CLXCON2 = 9'h10e;
    localparam CLXDAT  = 9'h00e;

    // local registers
    reg  [15:0] clxcon;    // collision detection control register
    reg  [15:0] clxcon2;   // collision control register 2
    reg  [14:0] clxdat;    // collision detection data register
    reg         clxdat_read_del;

    wire [3:0] sprmatch;   // sprite group matches clxcon settings
    wire       oddmatch;   // odd bitplane data matches clxcon settings
    wire       evenmatch;  // even bitplane data matches clxcon settings

    // ------------------------------------------------------------
    // CLXCON register
    // ------------------------------------------------------------
    always @(posedge clk) begin
        if (reset) begin
            clxcon <= 16'h0fff;          // safe default
        end else if (clk7_en) begin
            if (reg_address_in[8:1] == CLXCON[8:1])
                clxcon <= data_in;
        end
    end

    // CLXCON2 register
    always @(posedge clk) begin
        if (reset) begin
            clxcon2 <= 16'h0000;
        end else if (clk7_en) begin
            if (reg_address_in[8:1] == CLXCON[8:1])
                clxcon2 <= 16'h0000;     // cleared when CLXCON written
            else if (aga && (reg_address_in[8:1] == CLXCON2[8:1]))
                clxcon2 <= data_in;
        end
    end

    // ------------------------------------------------------------
    // Bitplane match logic
    // ------------------------------------------------------------
    wire [7:0] bm;

    // JB: playfield collision detection fix
    assign bm =
        (bpldata[7:0] ^ ~{clxcon2[1:0], clxcon[5:0]}) |
        (~{clxcon2[7:6], clxcon[11:6]});

    // undocumented Denise behaviour (Rotor, Spaceport, Archon fixes)
    assign evenmatch = bm[7] & bm[5] & bm[3] & bm[1];
    assign oddmatch  = bm[6] & bm[4] & bm[2] & bm[0] & (dblpf | evenmatch);

    // ------------------------------------------------------------
    // Sprite group match logic
    // ------------------------------------------------------------
    assign sprmatch[0] = nsprite[0] | (nsprite[1] & clxcon[12]);
    assign sprmatch[1] = nsprite[2] | (nsprite[3] & clxcon[13]);
    assign sprmatch[2] = nsprite[4] | (nsprite[5] & clxcon[14]);
    assign sprmatch[3] = nsprite[6] | (nsprite[7] & clxcon[15]);

    // ------------------------------------------------------------
    // Collision generation
    // ------------------------------------------------------------
    wire [14:0] cl;

    assign cl[0]  = evenmatch   & oddmatch;      // odd to even bitplanes
    assign cl[1]  = oddmatch    & sprmatch[0];   // odd bitplanes to sprite 0/1
    assign cl[2]  = oddmatch    & sprmatch[1];   // odd bitplanes to sprite 2/3
    assign cl[3]  = oddmatch    & sprmatch[2];   // odd bitplanes to sprite 4/5
    assign cl[4]  = oddmatch    & sprmatch[3];   // odd bitplanes to sprite 6/7
    assign cl[5]  = evenmatch   & sprmatch[0];   // even bitplanes to sprite 0/1
    assign cl[6]  = evenmatch   & sprmatch[1];   // even bitplanes to sprite 2/3
    assign cl[7]  = evenmatch   & sprmatch[2];   // even bitplanes to sprite 4/5
    assign cl[8]  = evenmatch   & sprmatch[3];   // even bitplanes to sprite 6/7
    assign cl[9]  = sprmatch[0] & sprmatch[1];   // sprite 0/1 to 2/3
    assign cl[10] = sprmatch[0] & sprmatch[2];   // sprite 0/1 to 4/5
    assign cl[11] = sprmatch[0] & sprmatch[3];   // sprite 0/1 to 6/7
    assign cl[12] = sprmatch[1] & sprmatch[2];   // sprite 2/3 to 4/5
    assign cl[13] = sprmatch[1] & sprmatch[3];   // sprite 2/3 to 6/7
    assign cl[14] = sprmatch[2] & sprmatch[3];   // sprite 4/5 to 6/7

    // ------------------------------------------------------------
    // CLXDAT read edge detection
    // ------------------------------------------------------------
    wire clxdat_read = (reg_address_in[8:1] == CLXDAT[8:1]);

    always @(posedge clk) begin
        if (reset) begin
            clxdat_read_del <= 1'b0;
        end else if (clk7_en) begin
            clxdat_read_del <= clxdat_read;
        end
    end

    // ------------------------------------------------------------
    // Collision register (CLXDAT)
    // ------------------------------------------------------------
    always @(posedge clk) begin
        if (reset) begin
            clxdat <= 15'h0000;
        end else if (clk7_en) begin
            // clear after read (on falling edge of clxdat_read)
            if (!clxdat_read && clxdat_read_del)
                clxdat <= 15'h0000;
            else
                clxdat <= clxdat | cl;
        end
    end

    // ------------------------------------------------------------
    // CLXDAT readback
    // ------------------------------------------------------------
    assign data_out =
        (reg_address_in[8:1] == CLXDAT[8:1]) ?
            {1'b1, clxdat} :
            16'h0000;

endmodule
