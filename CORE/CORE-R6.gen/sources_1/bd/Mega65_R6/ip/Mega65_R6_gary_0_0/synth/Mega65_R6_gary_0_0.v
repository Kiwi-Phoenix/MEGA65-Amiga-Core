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


// IP VLNV: xilinx.com:module_ref:gary:1.0
// IP Revision: 1

(* X_CORE_INFO = "gary,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_gary_0_0,gary,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_gary_0_0,gary,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=gary,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_gary_0_0 (
  cpu_address_in,
  dma_address_in,
  ram_address_out,
  cpu_data_out,
  cpu_data_in,
  custom_data_out,
  custom_data_in,
  ram_data_out,
  ram_data_in,
  a1k,
  bootrom,
  clk,
  reset,
  cpu_rd,
  cpu_hwr,
  cpu_lwr,
  cpu_hlt,
  ovl,
  dbr,
  dbwe,
  dbs,
  xbs,
  memory_config,
  ecs,
  hdc_ena,
  toccata_ena,
  toccata_base,
  ram_rd,
  ram_hwr,
  ram_lwr,
  sel_reg,
  sel_chip,
  sel_slow,
  sel_kick,
  sel_kick1mb,
  sel_kick256kmirror,
  sel_cia,
  sel_cia_a,
  sel_cia_b,
  sel_rtg,
  sel_rtc,
  sel_ide,
  sel_gayle,
  sel_toccata,
  rom_readonly
);

input wire [23 : 1] cpu_address_in;
input wire [20 : 1] dma_address_in;
output wire [23 : 1] ram_address_out;
input wire [15 : 0] cpu_data_out;
output wire [15 : 0] cpu_data_in;
input wire [15 : 0] custom_data_out;
output wire [15 : 0] custom_data_in;
input wire [15 : 0] ram_data_out;
output wire [15 : 0] ram_data_in;
input wire a1k;
input wire bootrom;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire reset;
input wire cpu_rd;
input wire cpu_hwr;
input wire cpu_lwr;
input wire cpu_hlt;
input wire ovl;
input wire dbr;
input wire dbwe;
output wire dbs;
output wire xbs;
input wire [3 : 0] memory_config;
input wire ecs;
input wire hdc_ena;
input wire toccata_ena;
input wire [7 : 0] toccata_base;
output wire ram_rd;
output wire ram_hwr;
output wire ram_lwr;
output wire sel_reg;
output wire [3 : 0] sel_chip;
output wire [2 : 0] sel_slow;
output wire sel_kick;
output wire sel_kick1mb;
output wire sel_kick256kmirror;
output wire sel_cia;
output wire sel_cia_a;
output wire sel_cia_b;
output wire sel_rtg;
output wire sel_rtc;
output wire sel_ide;
output wire sel_gayle;
output wire sel_toccata;
output wire rom_readonly;

  gary inst (
    .cpu_address_in(cpu_address_in),
    .dma_address_in(dma_address_in),
    .ram_address_out(ram_address_out),
    .cpu_data_out(cpu_data_out),
    .cpu_data_in(cpu_data_in),
    .custom_data_out(custom_data_out),
    .custom_data_in(custom_data_in),
    .ram_data_out(ram_data_out),
    .ram_data_in(ram_data_in),
    .a1k(a1k),
    .bootrom(bootrom),
    .clk(clk),
    .reset(reset),
    .cpu_rd(cpu_rd),
    .cpu_hwr(cpu_hwr),
    .cpu_lwr(cpu_lwr),
    .cpu_hlt(cpu_hlt),
    .ovl(ovl),
    .dbr(dbr),
    .dbwe(dbwe),
    .dbs(dbs),
    .xbs(xbs),
    .memory_config(memory_config),
    .ecs(ecs),
    .hdc_ena(hdc_ena),
    .toccata_ena(toccata_ena),
    .toccata_base(toccata_base),
    .ram_rd(ram_rd),
    .ram_hwr(ram_hwr),
    .ram_lwr(ram_lwr),
    .sel_reg(sel_reg),
    .sel_chip(sel_chip),
    .sel_slow(sel_slow),
    .sel_kick(sel_kick),
    .sel_kick1mb(sel_kick1mb),
    .sel_kick256kmirror(sel_kick256kmirror),
    .sel_cia(sel_cia),
    .sel_cia_a(sel_cia_a),
    .sel_cia_b(sel_cia_b),
    .sel_rtg(sel_rtg),
    .sel_rtc(sel_rtc),
    .sel_ide(sel_ide),
    .sel_gayle(sel_gayle),
    .sel_toccata(sel_toccata),
    .rom_readonly(rom_readonly)
  );
endmodule
