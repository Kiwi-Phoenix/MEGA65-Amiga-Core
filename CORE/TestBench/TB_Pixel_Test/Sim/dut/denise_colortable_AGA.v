// A variation on the MiSTer Minimig Amiga Core Denise Colortable module.
// This version supports all three chip sets OCS/ECS/AGA.
// The Orig MiSTer module missed out AGA.
//
// March 2026	David Raynor (Kiwi)
//

module denise_colortable_AGA (
    input  wire        clk,
    input  wire        clk7_en,
    input  wire [8:1]  reg_address_in,
    input  wire [15:0] data_in,
    input  wire        aga,
    input  wire        rdram,
    input  wire [7:0]  select,
    input  wire [7:0]  bplxor,
    input  wire [2:0]  bank,
    input  wire        loct,
    input  wire        ehb_en,
    output reg  [23:0] rgb
);

    parameter COLORBASE = 9'h180;

    wire [8:0] reg_addr = {reg_address_in, 1'b0};
    wire [7:0] select_xored = select ^ bplxor;

    // RAM interface
    wire [7:0]  wr_adr;
    wire [31:0] wr_dat;
    wire [3:0]  wr_bs;
    wire        wr_en;
    wire [7:0]  rd_adr;
    wire [31:0] rd_dat;

    denise_colortable_ram_mf clut (
        .clock     (clk),
        .enable    (1'b1),
        .wraddress (wr_adr),
        .wren      (wr_en),
        .byteena_a (wr_bs),
        .data      (wr_dat),
        .rdaddress (rd_adr),
        .q         (rd_dat)
    );

    // --------------------
    // OCS/ECS write path
    // --------------------
    wire ocs_color_sel =
        !aga &&
        (reg_addr[8:6] == COLORBASE[8:6]) &&
        clk7_en && !rdram;

    wire [4:0]  ocs_idx      = reg_addr[5:1];          // 0..31
    wire [7:0]  ocs_bank_idx = {bank, ocs_idx};        // 0..255

    wire [3:0] r4 = data_in[11:8];
    wire [3:0] g4 = data_in[7:4];
    wire [3:0] b4 = data_in[3:0];

    wire [7:0] r8_ocs = {r4, r4};
    wire [7:0] g8_ocs = {g4, g4};
    wire [7:0] b8_ocs = {b4, b4};

    wire [31:0] ocs_rgb32 = {8'h00, r8_ocs, g8_ocs, b8_ocs};

    // --------------------
    // AGA write path
    // --------------------
    wire aga_color_region =
        aga &&
        (reg_addr[8:6] == COLORBASE[8:6]) &&
        clk7_en && !rdram;

    wire [7:0] color_reg = reg_addr[7:0] - COLORBASE[7:0]; // 0..255
    wire [7:0] aga_idx   = color_reg / 3;
    wire [1:0] aga_comp  = color_reg % 3;

    wire [7:0] aga_byte = data_in[7:0];

    assign wr_adr =
        aga_color_region ? aga_idx :
        ocs_color_sel    ? ocs_bank_idx :
                           8'h00;

    assign wr_en = aga_color_region || ocs_color_sel;

    assign wr_bs =
        !wr_en        ? 4'b0000 :
        !aga          ? 4'b1111 :      // OCS/ECS: full write
        (aga_comp==0) ? 4'b0001 :      // B
        (aga_comp==1) ? 4'b0010 :      // G
                        4'b0100;       // R

    assign wr_dat =
        !aga ? ocs_rgb32 :
        (aga_comp==0) ? {24'h000000, aga_byte} :
        (aga_comp==1) ? {16'h0000, aga_byte, 8'h00} :
                        {aga_byte, 16'h0000};

    // --------------------
    // Read path
    // --------------------
    assign rd_adr =
        rdram ? wr_adr :
        (!aga) ? {bank, select_xored[4:0]} :
                 select_xored;

    wire [7:0] r8 = rd_dat[23:16];
    wire [7:0] g8 = rd_dat[15:8];
    wire [7:0] b8 = rd_dat[7:0];

    wire [23:0] color = {r8, g8, b8};

    // EHB
    reg ehb_sel;
    always @(posedge clk)
        ehb_sel <= select_xored[5];

    wire [23:0] color_ehb =
        {1'b0, color[23:17],
         1'b0, color[15:9],
         1'b0, color[7:1]};

    always @(*) begin
        if (ehb_en && ehb_sel)
            rgb = color_ehb;
        else
            rgb = color;
    end

endmodule