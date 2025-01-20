// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2025 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:agnus:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_agnus_0_0 (
  clk,
  clk7_en,
  cck,
  reset,
  aen,
  rd,
  hwr,
  lwr,
  data_in,
  data_out,
  address_in,
  address_out,
  reg_address_out,
  cpu_custom,
  dbr,
  dbwe,
  _hsync,
  _vsync,
  _csync,
  field1,
  lace,
  hblank,
  vblank,
  hde,
  sol,
  sof,
  vbl_int,
  strhor_denise,
  strhor_paula,
  htotal,
  harddis,
  varbeamen,
  int3,
  audio_dmal,
  audio_dmas,
  disk_dmal,
  disk_dmas,
  bls,
  ntsc,
  a1k,
  ecs,
  aga,
  floppy_speed
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire clk;
input wire clk7_en;
input wire cck;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire reset;
input wire aen;
input wire rd;
input wire hwr;
input wire lwr;
input wire [15 : 0] data_in;
output wire [15 : 0] data_out;
input wire [8 : 1] address_in;
output wire [20 : 1] address_out;
output wire [8 : 1] reg_address_out;
output wire cpu_custom;
output wire dbr;
output wire dbwe;
output wire _hsync;
output wire _vsync;
output wire _csync;
output wire field1;
output wire lace;
output wire hblank;
output wire vblank;
output wire hde;
output wire sol;
output wire sof;
output wire vbl_int;
output wire strhor_denise;
output wire strhor_paula;
output wire [8 : 0] htotal;
output wire harddis;
output wire varbeamen;
output wire int3;
input wire [3 : 0] audio_dmal;
input wire [3 : 0] audio_dmas;
input wire disk_dmal;
input wire disk_dmas;
input wire bls;
input wire ntsc;
input wire a1k;
input wire ecs;
input wire aga;
input wire floppy_speed;

  agnus #(
    .BLS_CNT_MAX(3)
  ) inst (
    .clk(clk),
    .clk7_en(clk7_en),
    .cck(cck),
    .reset(reset),
    .aen(aen),
    .rd(rd),
    .hwr(hwr),
    .lwr(lwr),
    .data_in(data_in),
    .data_out(data_out),
    .address_in(address_in),
    .address_out(address_out),
    .reg_address_out(reg_address_out),
    .cpu_custom(cpu_custom),
    .dbr(dbr),
    .dbwe(dbwe),
    ._hsync(_hsync),
    ._vsync(_vsync),
    ._csync(_csync),
    .field1(field1),
    .lace(lace),
    .hblank(hblank),
    .vblank(vblank),
    .hde(hde),
    .sol(sol),
    .sof(sof),
    .vbl_int(vbl_int),
    .strhor_denise(strhor_denise),
    .strhor_paula(strhor_paula),
    .htotal(htotal),
    .harddis(harddis),
    .varbeamen(varbeamen),
    .int3(int3),
    .audio_dmal(audio_dmal),
    .audio_dmas(audio_dmas),
    .disk_dmal(disk_dmal),
    .disk_dmas(disk_dmas),
    .bls(bls),
    .ntsc(ntsc),
    .a1k(a1k),
    .ecs(ecs),
    .aga(aga),
    .floppy_speed(floppy_speed)
  );
endmodule
