// Copyright 2006, 2007 Dennis van Weeren
//
// This file is part of Minimig
//
// Minimig is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// Minimig is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//
//
// This is the sprites part of denise
// It supports all OCS sprite modes.
//
// March 2026       David Raynor (kiwi)
// Correct the reset defaults on some of the signals.
//

module denise_sprites_m65
(
    input         clk,          // 28MHz clock
    input         clk7_en,
    input         reset,
    input         c1,
    input         c3,
    input         aga,
    input  [8:1]  reg_address_in,
    input  [8:0]  hpos,
    input  [15:0] data_in,
    input  [47:0] chip48,
    input         sprena,
    input  [3:0]  esprm,
    input  [3:0]  osprm,
    input  [1:0]  spres,
    output [7:0]  nsprite,
    output reg [7:0] sprdata
);

    // ------------------------------------------------------------
    // Register decode
    // ------------------------------------------------------------
    localparam SPRPOSCTLBASE = 9'h140;
    localparam FMODE         = 9'h1fc;

    wire selsprx = (reg_address_in[8:6] == SPRPOSCTLBASE[8:6]);

    wire selspr0 = selsprx && (reg_address_in[5:3] == 3'd0);
    wire selspr1 = selsprx && (reg_address_in[5:3] == 3'd1);
    wire selspr2 = selsprx && (reg_address_in[5:3] == 3'd2);
    wire selspr3 = selsprx && (reg_address_in[5:3] == 3'd3);
    wire selspr4 = selsprx && (reg_address_in[5:3] == 3'd4);
    wire selspr5 = selsprx && (reg_address_in[5:3] == 3'd5);
    wire selspr6 = selsprx && (reg_address_in[5:3] == 3'd6);
    wire selspr7 = selsprx && (reg_address_in[5:3] == 3'd7);

    // ------------------------------------------------------------
    // FMODE register (only state in this module)
    // ------------------------------------------------------------
    reg [15:0] fmode;

    always @(posedge clk) begin
        if (reset) begin
            fmode <= 16'h0000;
        end else if (clk7_en) begin
            if (aga && (reg_address_in[8:1] == FMODE[8:1]))
                fmode <= data_in;
        end
    end

    // ------------------------------------------------------------
    // Shift enable logic
    // ------------------------------------------------------------
    reg shift;

    always @(*) begin
        case (spres)
            2'b11: shift = 1'b1;          // lores
            2'b10: shift = (~c1 ^ c3);    // hires
            default: shift = (~c1 & ~c3); // lores default
        endcase
    end

    wire clk7n_en = c1 & c3;

    // ------------------------------------------------------------
    // Sprite shifter instances
    // ------------------------------------------------------------
    wire [1:0] sprdat0, sprdat1, sprdat2, sprdat3;
    wire [1:0] sprdat4, sprdat5, sprdat6, sprdat7;

    wire attach0, attach1, attach2, attach3;
    wire attach4, attach5, attach6, attach7;

    denise_sprites_shifter_m65 sps0 (
        .clk(clk), .clk7_en(clk7_en), .clk7n_en(clk7n_en),
        .reset(reset), .aen(selspr0),
        .address(reg_address_in[2:1]), .hpos(hpos),
        .fmode(fmode), .shift(shift),
        .chip48(chip48), .data_in(data_in),
        .sprdata(sprdat0), .attach(attach0)
    );

    denise_sprites_shifter_m65 sps1 (
        .clk(clk), .clk7_en(clk7_en), .clk7n_en(clk7n_en),
        .reset(reset), .aen(selspr1),
        .address(reg_address_in[2:1]), .hpos(hpos),
        .fmode(fmode), .shift(shift),
        .chip48(chip48), .data_in(data_in),
        .sprdata(sprdat1), .attach(attach1)
    );

    denise_sprites_shifter_m65 sps2 (
        .clk(clk), .clk7_en(clk7_en), .clk7n_en(clk7n_en),
        .reset(reset), .aen(selspr2),
        .address(reg_address_in[2:1]), .hpos(hpos),
        .fmode(fmode), .shift(shift),
        .chip48(chip48), .data_in(data_in),
        .sprdata(sprdat2), .attach(attach2)
    );

    denise_sprites_shifter_m65 sps3 (
        .clk(clk), .clk7_en(clk7_en), .clk7n_en(clk7n_en),
        .reset(reset), .aen(selspr3),
        .address(reg_address_in[2:1]), .hpos(hpos),
        .fmode(fmode), .shift(shift),
        .chip48(chip48), .data_in(data_in),
        .sprdata(sprdat3), .attach(attach3)
    );

    denise_sprites_shifter_m65 sps4 (
        .clk(clk), .clk7_en(clk7_en), .clk7n_en(clk7n_en),
        .reset(reset), .aen(selspr4),
        .address(reg_address_in[2:1]), .hpos(hpos),
        .fmode(fmode), .shift(shift),
        .chip48(chip48), .data_in(data_in),
        .sprdata(sprdat4), .attach(attach4)
    );

    denise_sprites_shifter_m65 sps5 (
        .clk(clk), .clk7_en(clk7_en), .clk7n_en(clk7n_en),
        .reset(reset), .aen(selspr5),
        .address(reg_address_in[2:1]), .hpos(hpos),
        .fmode(fmode), .shift(shift),
        .chip48(chip48), .data_in(data_in),
        .sprdata(sprdat5), .attach(attach5)
    );

    denise_sprites_shifter_m65 sps6 (
        .clk(clk), .clk7_en(clk7_en), .clk7n_en(clk7n_en),
        .reset(reset), .aen(selspr6),
        .address(reg_address_in[2:1]), .hpos(hpos),
        .fmode(fmode), .shift(shift),
        .chip48(chip48), .data_in(data_in),
        .sprdata(sprdat6), .attach(attach6)
    );

    denise_sprites_shifter_m65 sps7 (
        .clk(clk), .clk7_en(clk7_en), .clk7n_en(clk7n_en),
        .reset(reset), .aen(selspr7),
        .address(reg_address_in[2:1]), .hpos(hpos),
        .fmode(fmode), .shift(shift),
        .chip48(chip48), .data_in(data_in),
        .sprdata(sprdat7), .attach(attach7)
    );

    // ------------------------------------------------------------
    // Sprite valid signals
    // ------------------------------------------------------------
    assign nsprite[0] = sprena && (sprdat0 != 2'b00);
    assign nsprite[1] = sprena && (sprdat1 != 2'b00);
    assign nsprite[2] = sprena && (sprdat2 != 2'b00);
    assign nsprite[3] = sprena && (sprdat3 != 2'b00);
    assign nsprite[4] = sprena && (sprdat4 != 2'b00);
    assign nsprite[5] = sprena && (sprdat5 != 2'b00);
    assign nsprite[6] = sprena && (sprdat6 != 2'b00);
    assign nsprite[7] = sprena && (sprdat7 != 2'b00);

    // ------------------------------------------------------------
    // Sprite priority + colour decode
    // ------------------------------------------------------------
    always @(*) begin
        sprdata = 8'h00;

        // sprites 0/1
        if (nsprite[1:0] != 2'b00) begin
            if (attach1 || (!aga && attach0))
                sprdata = {osprm, sprdat1, sprdat0};
            else if (nsprite[0])
                sprdata = {esprm, 2'b00, sprdat0};
            else
                sprdata = {osprm, 2'b00, sprdat1};
        end

        // sprites 2/3
        else if (nsprite[3:2] != 2'b00) begin
            if (attach3 || (!aga && attach2))
                sprdata = {osprm, sprdat3, sprdat2};
            else if (nsprite[2])
                sprdata = {esprm, 2'b01, sprdat2};
            else
                sprdata = {osprm, 2'b01, sprdat3};
        end

        // sprites 4/5
        else if (nsprite[5:4] != 2'b00) begin
            if (attach5 || (!aga && attach4))
                sprdata = {osprm, sprdat5, sprdat4};
            else if (nsprite[4])
                sprdata = {esprm, 2'b10, sprdat4};
            else
                sprdata = {osprm, 2'b10, sprdat5};
        end

        // sprites 6/7
        else if (nsprite[7:6] != 2'b00) begin
            if (attach7 || (!aga && attach6))
                sprdata = {osprm, sprdat7, sprdat6};
            else if (nsprite[6])
                sprdata = {esprm, 2'b11, sprdat6};
            else
                sprdata = {osprm, 2'b11, sprdat7};
        end
    end

endmodule

