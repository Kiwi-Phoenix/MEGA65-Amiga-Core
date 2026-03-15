`timescale 1ns / 1ps
// Denise colortable wrapper for TB
// Wrapper required as one of teh signal names is a reserved key word in VHDL
// Causes issues when referencing the port in the Verilog module from VHDL.
//  Wrapper "shields" VHDL from this and avoids changing the Orig source module for TB purposes.

module denise_colortable_wrapper(
  input  wire           clk,              // 28MHz clock
  input  wire           clk7_en,          // 7MHz clock enable
  input  wire [  9-1:1] reg_address_in,   // register adress inputs
  input  wire [ 12-1:0] data_in,          // bus data in
  input  wire           rdram,            // read the color table instead of writing to it
  input  wire [  8-1:0] selectx,           // colour select input
  input  wire [  8-1:0] bplxor,           // clut address xor value
  input  wire [  3-1:0] bank,             // color bank select
  input  wire           loct,             // 12-bit palette select
  input  wire           ehb_en,           // EHB enable
  output      [ 24-1:0] rgb               // RGB output
    );


denise_colortable colortable
    (
        .clk            (clk)
       ,.clk7_en        (clk7_en)
       ,.reg_address_in (reg_address_in)
       ,.data_in        (data_in)
       ,.rdram          (rdram)
       ,.select         (selectx)
       ,.bplxor         (bplxor)
       ,.bank           (bank)
       ,.loct           (loct)
       ,.ehb_en         (ehb_en)
       ,.rgb            (rgb)
    );



endmodule
