// <<<<< Insert the orig credits and notice here!!!! >>>>>>
//
// March 2026       David Raynor (kiwi)
// Correct the reset defaults on some of the signals.
//  


module denise_m65_V1_0 (
    input  wire         clk,          // 28MHz clock
    input  wire         clk7_en,      // 7MHz clock enable
    input  wire         c1,           // 35ns clock enable signals (for synchronization with clk)
    input  wire         c3,
    input  wire         cck,          // colour clock enable
    input  wire         reset,        // reset
    input  wire         strhor,       // horizontal strobe
    input  wire [9-1:1] reg_address_in, // register address inputs
    input  wire [16-1:0] data_in,     // bus data in
    input  wire [48-1:0] chip48,      // big chipram read
    output wire [16-1:0] data_out,    // bus data out
    input  wire         blank,        // blanking input
    output wire [8-1:0] red,          // red component video out
    output wire [8-1:0] green,        // green component video out
    output wire [8-1:0] blue,         // blue component video out
    input  wire         a1k,          // control EHB chipset feature
    input  wire         ecs,          // enables ECS chipset features
    input  wire         aga,          // enables AGA features
    output wire         hires,        // hires
    output wire         shres,         // shres
    output wire [8:0]   hpos_den_tb
);



// ---------------------------------------------------------------------
// Register addresses
// ---------------------------------------------------------------------
parameter DIWSTRT   = 9'h08e;           // Translate to $47 in 8-bits compare
parameter DIWSTOP   = 9'h090;           // $48
parameter DIWHIGH   = 9'h1e4;           // $F2
parameter BPLCON0   = 9'h100;           // $80
parameter BPLCON2   = 9'h104;           // $82
parameter BPLCON3   = 9'h106;           // $83
parameter BPLCON4   = 9'h10c;           // $86
parameter DENISEID  = 9'h07c;           // $3E - Read only register that returns FFFF on OCS, FFFC on ECS 00F8 on AGA.  Used by Kickstart to detect chipset type.
parameter BPL1DAT   = 9'h110;           // $88
parameter COLORBASE = 9'h180;           // $C0

// ---------------------------------------------------------------------
// Beam counter / window / display enable
// ---------------------------------------------------------------------
reg  [8:0] hpos;          // horizontal beamcounter
reg  [3:0] l_bpu;         // latched bitplane enable
reg  [8:0] hdiwstrt;      // horizontal display window start position
reg  [8:0] hdiwstop;      // horizontal display window stop position
reg        window;        // window enable signal
reg        window_ena;    // registered window
reg        display_ena;   // sprites visible between first BPL1DAT and end of scanline

assign hpos_den_tb = hpos;


// ---------------------------------------------------------------------
// BPLCONx registers and derived signals
// ---------------------------------------------------------------------
reg  [15:0] bplcon0;
wire [3:0]  bpu;
wire        ham;
wire        dpf;
wire        ecsena;

reg  [15:0] bplcon2;
wire        rdram;
wire        killehb;

reg  [15:0] bplcon3;
wire [2:0]  bank;
wire [2:0]  pf2of;
wire        loct;
wire [1:0]  spres;
wire        brdrblnk;
wire        brdsprt;

reg  [15:0] bplcon4;
reg  [7:0]  bplxor;
reg  [3:0]  esprm;
reg  [3:0]  osprm;

// ---------------------------------------------------------------------
// Misc state
// ---------------------------------------------------------------------
reg  [7:0]  clut_data;
reg         window_del;
reg         sprsel_del;

// ---------------------------------------------------------------------
// Wires from submodules
// ---------------------------------------------------------------------
wire [8:1]  bpldata_out;
wire [8:1]  bpldata;
wire [7:0]  sprdata;
wire [7:0]  plfdata;
wire [2:1]  nplayfield;
wire [7:0]  nsprite;
wire        sprsel;
wire [23:0] ham_rgb;
wire [23:0] clut_rgb;
wire [15:0] deniseid_out;
wire [15:0] col_out;
wire [15:0] rgb_out;

// DJR - Temp HACK  To be removed!!!!!
//assign bpldata_out[1] = (hpos[0]);      // simple pattern
//assign bpldata_out[2] = (hpos[1]);
//assign bpldata_out[3] = 1'b0;
//assign bpldata_out[4] = 1'b0;
//assign bpldata_out[5] = 1'b0;
//assign bpldata_out[6] = 1'b0;
//assign bpldata_out[7] = 1'b0;
//assign bpldata_out[8] = 1'b0;
//--------------------------------------------------------------


// ---------------------------------------------------------------------
// Data out mux
// ---------------------------------------------------------------------
assign data_out = col_out | deniseid_out | rgb_out;

// ---------------------------------------------------------------------
// Horizontal position
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        hpos <= 9'd0;
    end else if (clk7_en) begin
        if (strhor)
            hpos <= 9'd2;
        else
            hpos <= hpos + 9'd1;
    end
end

// ---------------------------------------------------------------------
// Display enable (sprites visible region)
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        display_ena <= 1'b0;
    end else if (clk7_en) begin
        if (reset || blank)
            display_ena <= 1'b0;
        else if (reg_address_in[8:1] == BPL1DAT[8:1])
            display_ena <= 1'b1;
    end
end

// ---------------------------------------------------------------------
// BPLCON0
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        bplcon0 <= 16'h0000;
    end else if (clk7_en) begin
        if (reg_address_in[8:1] == BPLCON0[8:1])
            bplcon0 <= data_in;
    end
end

assign hires  = bplcon0[15];
assign bpu    = {bplcon0[4] & aga, bplcon0[14:12]};
assign ham    = bplcon0[11];
assign dpf    = bplcon0[10];
assign shres  = bplcon0[6];
assign ecsena = bplcon0[0];

// ---------------------------------------------------------------------
// Latched BPU (l_bpu)
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        l_bpu <= 4'd0;
    end else if (clk7_en) begin
        if (reg_address_in[8:1] == BPL1DAT[8:1]) begin
            if (aga)
                l_bpu <= bpu;
            else
                // Denise thinks this is EHB 6-plane mode
                l_bpu <= (bpu == 4'd7) ? 4'd6 : bpu;
        end
    end
end

// ---------------------------------------------------------------------
// BPLCON2
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        bplcon2 <= 16'h0000;
    end else if (clk7_en) begin
        if (reg_address_in[8:1] == BPLCON2[8:1])
            bplcon2 <= data_in;
    end
end

assign rdram   = bplcon2[8] & aga;
assign killehb = bplcon2[9] & ecs;

// RGB readback (rdram)
assign rgb_out =
    (reg_address_in[8:6] == COLORBASE[8:6]) && rdram
        ? (loct
           ? {4'b0000, clut_rgb[19:16], clut_rgb[11:8], clut_rgb[3:0]}
           : {4'b0000, clut_rgb[23:20], clut_rgb[15:12], clut_rgb[7:4]})
        : 16'h0000;

// ---------------------------------------------------------------------
// BPLCON3
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        bplcon3 <= 16'h0c00;
    end else if (clk7_en) begin
        if (reg_address_in[8:1] == BPLCON3[8:1])
            bplcon3 <= data_in;
    end
end

assign bank     = bplcon3[15:13] & {3{aga}};
assign pf2of    = bplcon3[12:10];
assign loct     = bplcon3[9] & aga;
assign spres    = bplcon3[7:6] & {2{aga}};
assign brdrblnk = bplcon3[5] & ecsena;
assign brdsprt  = bplcon3[1] & ecsena;

// ---------------------------------------------------------------------
// BPLCON4, BPLXOR, sprite colour offsets
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        bplcon4 <= 16'h0011;
    end else if (clk7_en) begin
        if (aga && (reg_address_in[8:1] == BPLCON4[8:1]))
            bplcon4 <= data_in;
    end
end

// BPLXOR active from first write to BPL1DAT until DIWSTOP
always @(posedge clk) begin
    if (reset) begin
        bplxor <= 8'd0;
    end else if (clk7_en) begin
        if (hpos == hdiwstop)
            bplxor <= 8'd0;
        else if (display_ena)
            bplxor <= bplcon4[15:8];
    end
end

always @(posedge clk) begin
    if (reset) begin
        esprm <= 4'd1;
        osprm <= 4'd1;
    end else if (clk7_en) begin
        esprm <= bplcon4[7:4];
        osprm <= bplcon4[3:0];
    end
end

// ---------------------------------------------------------------------
// DIWSTRT / DIWSTOP / DIWHIGH
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        hdiwstrt <= 9'd0;
    end else if (clk7_en) begin
        if (reg_address_in[8:1] == DIWSTRT[8:1]) begin
            hdiwstrt[7:0] <= data_in[7:0];
            hdiwstrt[8]   <= 1'b0; // default H9 = 0
        end else if (reg_address_in[8:1] == DIWHIGH[8:1] && ecs) begin
            hdiwstrt[8] <= data_in[5];
        end
    end
end

always @(posedge clk) begin
    if (reset) begin
        hdiwstop <= 9'd0;
    end else if (clk7_en) begin
        if (reg_address_in[8:1] == DIWSTOP[8:1]) begin
            hdiwstop[7:0] <= data_in[7:0];
            hdiwstop[8]   <= 1'b1; // default H8 = 1
        end else if (reg_address_in[8:1] == DIWHIGH[8:1] && ecs) begin
            hdiwstop[8] <= data_in[13];
        end
    end
end

// ---------------------------------------------------------------------
// Denise ID
// ---------------------------------------------------------------------
assign deniseid_out =
    (reg_address_in[8:1] == DENISEID[8:1])
        ? (aga ? 16'h00f8
               : (ecs ? 16'hfffc : 16'hffff))
        : 16'h0000;

// ---------------------------------------------------------------------
// Window / window_ena
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        window <= 1'b0;
    end else if (clk7_en) begin
        if (hpos == hdiwstrt)
            window <= 1'b1;
        else if (hpos == hdiwstop)
            window <= 1'b0;
    end
end

always @(posedge clk) begin
    if (reset) begin
        window_ena <= 1'b0;
    end else if (clk7_en) begin
        window_ena <= window;
    end
end

// ---------------------------------------------------------------------
// Bitplanes
// ---------------------------------------------------------------------
denise_bitplanes_m65 bplm0 (
    .clk           (clk),
    .clk7_en       (clk7_en),
    .reset         (reset),
    .c1            (c1),
    .c3            (c3),
    .aga           (aga),
    .reg_address_in(reg_address_in),
    .data_in       (data_in),
    .chip48        (chip48),
    .hires         (hires),
    .shres         (shres & ecs),
    .hpos          (hpos),
    .bpldata       (bpldata_out)
);

// Window + l_bpu gating
assign bpldata[1] = window_ena && (l_bpu > 0) ? bpldata_out[1] : 1'b0;  
assign bpldata[2] = window_ena && (l_bpu > 1) ? bpldata_out[2] : 1'b0;
assign bpldata[3] = window_ena && (l_bpu > 2) ? bpldata_out[3] : 1'b0;
assign bpldata[4] = window_ena && (l_bpu > 3) ? bpldata_out[4] : 1'b0;
assign bpldata[5] = window_ena && (l_bpu > 4) ? bpldata_out[5] : 1'b0;
assign bpldata[6] = window_ena && (l_bpu > 5) ? bpldata_out[6] : 1'b0;
assign bpldata[7] = window_ena && (l_bpu > 6) ? bpldata_out[7] : 1'b0;
assign bpldata[8] = window_ena && (l_bpu > 7) ? bpldata_out[8] : 1'b0;

// ---------------------------------------------------------------------
// Playfields
// ---------------------------------------------------------------------
denise_playfields_m65 plfm0 (
    .aga        (aga),
    .bpldata    (bpldata),
    .dblpf      (dpf),
    .pf2of      (pf2of),
    .bplcon2    (bplcon2[6:0]),
    .nplayfield (nplayfield),
    .plfdata    (plfdata)
);

// ---------------------------------------------------------------------
// Sprites
// ---------------------------------------------------------------------
wire [1:0] spres_d = (spres == 2'b00)
                     ? (shres ? 2'b10 : 2'b01)
                     : spres;

denise_sprites_m65 sprm0 (
    .clk           (clk),
    .clk7_en       (clk7_en),
    .reset         (reset),
    .c1            (c1),
    .c3            (c3),
    .aga           (aga),
    .reg_address_in(reg_address_in),
    .hpos          (hpos),
    .data_in       (data_in),
    .chip48        (chip48),
    .sprena        (display_ena | brdsprt),
    .esprm         (esprm),
    .osprm         (osprm),
    .spres         (spres_d),
    .nsprite       (nsprite),
    .sprdata       (sprdata)
);

// ---------------------------------------------------------------------
// Sprite priority
// ---------------------------------------------------------------------
wire [2:1] nplayfield_masked = nplayfield & {window_ena, window_ena};

denise_spritepriority_m65 spm0 (
    .bplcon2   (bplcon2[5:0]),
    .nplayfield(nplayfield_masked),
    .nsprite   (nsprite),
    .sprsel    (sprsel)
);

// ---------------------------------------------------------------------
// Colour table
// ---------------------------------------------------------------------
wire ehb_en = !killehb && !a1k && !ham && !dpf && (l_bpu == 4'd6);

denise_colortable_AGA_m65 clut0 (
    .clk           (clk),
    .clk7_en       (clk7_en),
    .reg_address_in(reg_address_in),
    .data_in       (data_in),
    .aga           (aga),
    .rdram         (rdram),
    .select        (clut_data),
    .bplxor        (bplxor),
    .bank          (bank),
    .loct          (loct),
    .ehb_en        (ehb_en),
    .rgb           (clut_rgb)
);

// ---------------------------------------------------------------------
// HAM
// ---------------------------------------------------------------------
wire ham8    = ham && (l_bpu == 4'd8);
wire ham_sel = ham; // original behaviour

denise_hamgenerator_m65 ham0 (
    .clk           (clk),
    .clk7_en       (clk7_en),
    .reg_address_in(reg_address_in),
    .data_in       (data_in[11:0]),
    .select        (bpldata),
    .bplxor        (bplxor),
    .bank          (bank),
    .loct          (loct),
    .ham8          (ham8),
    .rgb           (ham_rgb)
);

// ---------------------------------------------------------------------
// Collision
// ---------------------------------------------------------------------
denise_collision_m65 col0 (
    .clk           (clk),
    .clk7_en       (clk7_en),
    .reset         (reset),
    .aga           (aga),
    .reg_address_in(reg_address_in),
    .data_in       (data_in),
    .data_out      (col_out),
    .dblpf         (dpf),
    .bpldata       (bpldata),
    .nsprite       (nsprite)
);

// ---------------------------------------------------------------------
// CLUT select (combinational)
// ---------------------------------------------------------------------
always @* begin
    if (brdsprt && sprsel)          // border sprites
        clut_data = sprdata;
    else if (!window_ena)           // outside visible window: border colour
        clut_data = 8'b00000000;
    else if (sprsel)                // sprites
        clut_data = sprdata;
    else                            // playfield
        clut_data = plfdata ^ bplxor;
end

// ---------------------------------------------------------------------
// Delayed window / sprsel
// ---------------------------------------------------------------------
always @(posedge clk) begin
    if (reset) begin
        window_del <= 1'b0;
        sprsel_del <= 1'b0;
    end else if (clk7_en) begin
        window_del <= window_ena;
        sprsel_del <= sprsel;
    end
end

// ---------------------------------------------------------------------
// RGB output
// ---------------------------------------------------------------------

// DJR TEMP force colour output.
wire [23:0] out_rgb =
    (ham_sel && window_del && !sprsel_del) ? ham_rgb : clut_rgb;

wire t_blank =
    /*blank |*/ (ecs & ecsena & brdrblnk & (~window_del | ~display_ena));
    
//wire [23:0] out_rgb = 24'h00ff00; // bright green
//wire t_blank = 1'b0;              // ignore blanking for a moment
    
    
assign {red, green, blue} = t_blank ? 24'h000000 : out_rgb;    
//------------------------------
// DJR Temp HACK for the red_grean, blue assignments to by pass all the logic to get a signal out
// TEMP: brutal TB hack - ignore bitplanes, CLUT, everything
//reg [7:0] red_t, green_t, blue_t;
//always @(posedge clk) begin
//    if (reset) begin
//        red_t   <= 8'h00;
//        green_t <= 8'h00;
//        blue_t  <= 8'h00;
//    end else if (clk7_en) begin
//        if (!blank && window_ena) begin
//            // Solid bright red in the display window
//            red_t   <= 8'hF0;
//            green_t <= 8'h00;
//            blue_t  <= 8'h00;
//        end else begin
//            red_t   <= 8'h00;
//            green_t <= 8'h00;
//            blue_t  <= 8'h00;
//        end
//    end
//end

// Assume you still have bpldata_out forced to a pattern for now
// e.g. bpldata_out[1] = hpos[0];

//always @(posedge clk) begin
//    if (reset) begin
//        red_t   <= 8'h00;
//        green_t <= 8'h00;
//        blue_t  <= 8'h00;
//    end else if (clk7_en) begin
//        if (!blank && window_ena) begin
//            // Directly show bitplane 1 as red, bypass CLUT
//            red_t   <= {8{bpldata[1]}};
//            green_t <= 8'h00;
//            blue_t  <= 8'h00;
//        end else begin
//            red_t   <= 8'h00;
//            green_t <= 8'h00;
//            blue_t  <= 8'h00;
//        end
//    end
//end




//assign red      = red_t;
//assign green    = green_t;
//assign blue     = blue_t;

//--------------------------------------------------------------




// ---------------------------------------------------------------------
// Denise Debug
// ---------------------------------------------------------------------

//always @(posedge clk) begin
//  if (clk7_en) begin
//    $display("DENISE @ T=%0t | reg_address_in=%h data_in=%h hpos=%0d win=%b disp=%b blank=%b RGB=%h%h%h",
//             $time, reg_address_in, data_in, hpos, window_ena, display_ena, blank, red, green, blue);
    
//    $display("T=%0t hpos=%0d win=%0d l_bpu=%0d bpldata_out[1]=%b",
//             $time, hpos, window_ena, l_bpu, bpldata_out[1]);             
//  end
//end

//
// Denise debug: BPL1DAT → bitplanes → RGB
//
//always @(posedge clk) begin
//  if (clk7_en) begin
//    // 1. Bus write / register decode
//    if (reg_address_in[8:1] == BPL1DAT[8:1]) begin
//      $display("DBG[BPL1DAT] T=%0t hpos=%0d reg_addr=%h data_in=%h l_bpu(next)=%0d",
//               $time, hpos, reg_address_in, data_in, bpu);
//    end

//    // 2. Latched BPU and windowing
//    $display("DBG[WIN/BPU] T=%0t hpos=%0d window=%b window_ena=%b display_ena=%b l_bpu=%0d",
//             $time, hpos, window, window_ena, display_ena, l_bpu);

//    // 3. Raw bitplane shifter output vs gated bitplane
//    $display("DBG[BPL] T=%0t hpos=%0d bpldata_out[1]=%b bpldata[1]=%b",
//             $time, hpos, bpldata_out[1], bpldata[1]);

//    // 4. CLUT / HAM / RGB
//    $display("DBG[RGB] T=%0t hpos=%0d ham_sel=%b sprsel=%b window_del=%b sprsel_del=%b RGB=%h%h%h",
//             $time, hpos, ham_sel, sprsel, window_del, sprsel_del, red, green, blue);
//  end
//end


endmodule
