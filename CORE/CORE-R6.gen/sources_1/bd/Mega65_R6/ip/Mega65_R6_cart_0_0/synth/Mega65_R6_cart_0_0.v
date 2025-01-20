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


// IP VLNV: xilinx.com:module_ref:cart:1.0
// IP Revision: 1

(* X_CORE_INFO = "cart,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_cart_0_0,cart,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_cart_0_0,cart,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=cart,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_cart_0_0 (
  clk,
  clk7_en,
  clk7n_en,
  cpu_rst,
  cpu_address_in,
  _cpu_as,
  cpu_rd,
  cpu_hwr,
  cpu_lwr,
  nmi_addr,
  reg_address_in,
  reg_data_in,
  dbr,
  ovl,
  freeze,
  cpuhlt,
  cart_data_out,
  int7,
  sel_cart,
  ovr
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire clk;
input wire clk7_en;
input wire clk7n_en;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 cpu_rst RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME cpu_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire cpu_rst;
input wire [23 : 1] cpu_address_in;
input wire _cpu_as;
input wire cpu_rd;
input wire cpu_hwr;
input wire cpu_lwr;
input wire [31 : 0] nmi_addr;
input wire [8 : 1] reg_address_in;
input wire [15 : 0] reg_data_in;
input wire dbr;
input wire ovl;
input wire freeze;
input wire cpuhlt;
output wire [15 : 0] cart_data_out;
output wire int7;
output wire sel_cart;
output wire ovr;

  cart inst (
    .clk(clk),
    .clk7_en(clk7_en),
    .clk7n_en(clk7n_en),
    .cpu_rst(cpu_rst),
    .cpu_address_in(cpu_address_in),
    ._cpu_as(_cpu_as),
    .cpu_rd(cpu_rd),
    .cpu_hwr(cpu_hwr),
    .cpu_lwr(cpu_lwr),
    .nmi_addr(nmi_addr),
    .reg_address_in(reg_address_in),
    .reg_data_in(reg_data_in),
    .dbr(dbr),
    .ovl(ovl),
    .freeze(freeze),
    .cpuhlt(cpuhlt),
    .cart_data_out(cart_data_out),
    .int7(int7),
    .sel_cart(sel_cart),
    .ovr(ovr)
  );
endmodule
