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


// IP VLNV: xilinx.com:module_ref:minimig_m68k_bridge:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_minimig_m68k_bridge_0_0 (
  clk,
  clk7_en,
  clk7n_en,
  c1,
  c3,
  eclk,
  vpa,
  dbr,
  dbs,
  xbs,
  nrdy,
  bls,
  cck,
  memory_config,
  _as,
  _lds,
  _uds,
  r_w,
  _dtack,
  rd,
  hwr,
  lwr,
  address,
  address_out,
  data,
  cpudatain,
  data_out,
  data_in,
  rd_cyc,
  _cpu_reset,
  cpu_halt,
  host_cs,
  host_adr,
  host_we,
  host_bs,
  host_wdat,
  host_rdat,
  host_ack
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire clk;
input wire clk7_en;
input wire clk7n_en;
input wire c1;
input wire c3;
input wire [9 : 0] eclk;
input wire vpa;
input wire dbr;
input wire dbs;
input wire xbs;
input wire nrdy;
output wire bls;
input wire cck;
input wire [3 : 0] memory_config;
input wire _as;
input wire _lds;
input wire _uds;
input wire r_w;
output wire _dtack;
output wire rd;
output wire hwr;
output wire lwr;
input wire [23 : 1] address;
output wire [23 : 1] address_out;
output wire [15 : 0] data;
input wire [15 : 0] cpudatain;
output wire [15 : 0] data_out;
input wire [15 : 0] data_in;
output wire rd_cyc;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 _cpu_reset RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME _cpu_reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire _cpu_reset;
input wire cpu_halt;
input wire host_cs;
input wire [23 : 1] host_adr;
input wire host_we;
input wire [1 : 0] host_bs;
input wire [15 : 0] host_wdat;
output wire [15 : 0] host_rdat;
output wire host_ack;

  minimig_m68k_bridge inst (
    .clk(clk),
    .clk7_en(clk7_en),
    .clk7n_en(clk7n_en),
    .c1(c1),
    .c3(c3),
    .eclk(eclk),
    .vpa(vpa),
    .dbr(dbr),
    .dbs(dbs),
    .xbs(xbs),
    .nrdy(nrdy),
    .bls(bls),
    .cck(cck),
    .memory_config(memory_config),
    ._as(_as),
    ._lds(_lds),
    ._uds(_uds),
    .r_w(r_w),
    ._dtack(_dtack),
    .rd(rd),
    .hwr(hwr),
    .lwr(lwr),
    .address(address),
    .address_out(address_out),
    .data(data),
    .cpudatain(cpudatain),
    .data_out(data_out),
    .data_in(data_in),
    .rd_cyc(rd_cyc),
    ._cpu_reset(_cpu_reset),
    .cpu_halt(cpu_halt),
    .host_cs(host_cs),
    .host_adr(host_adr),
    .host_we(host_we),
    .host_bs(host_bs),
    .host_wdat(host_wdat),
    .host_rdat(host_rdat),
    .host_ack(host_ack)
  );
endmodule
