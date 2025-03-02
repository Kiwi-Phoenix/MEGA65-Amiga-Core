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


// IP VLNV: xilinx.com:module_ref:mouse_input:1.0
// IP Revision: 1

(* X_CORE_INFO = "mouse_input,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_mouse_input_0_0,mouse_input,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_mouse_input_0_0,mouse_input,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=mouse_input,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_mouse_input_0_0 (
  clk,
  amiga_mouse_enable_a,
  amiga_mouse_enable_b,
  amiga_mouse_assume_a,
  amiga_mouse_assume_b,
  pot_drain,
  fa_potx,
  fa_poty,
  fb_potx,
  fb_poty,
  fa_fire,
  fa_left,
  fa_right,
  fa_up,
  fa_down,
  fb_fire,
  fb_left,
  fb_right,
  fb_up,
  fb_down,
  fa_left_out,
  fa_right_out,
  fa_up_out,
  fa_down_out,
  fb_left_out,
  fb_right_out,
  fb_up_out,
  fb_down_out,
  mouse_debug,
  pota_x,
  pota_y,
  potb_x,
  potb_y
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire clk;
input wire amiga_mouse_enable_a;
input wire amiga_mouse_enable_b;
input wire amiga_mouse_assume_a;
input wire amiga_mouse_assume_b;
output wire pot_drain;
input wire fa_potx;
input wire fa_poty;
input wire fb_potx;
input wire fb_poty;
input wire fa_fire;
input wire fa_left;
input wire fa_right;
input wire fa_up;
input wire fa_down;
input wire fb_fire;
input wire fb_left;
input wire fb_right;
input wire fb_up;
input wire fb_down;
output wire fa_left_out;
output wire fa_right_out;
output wire fa_up_out;
output wire fa_down_out;
output wire fb_left_out;
output wire fb_right_out;
output wire fb_up_out;
output wire fb_down_out;
output wire [7 : 0] mouse_debug;
output wire [7 : 0] pota_x;
output wire [7 : 0] pota_y;
output wire [7 : 0] potb_x;
output wire [7 : 0] potb_y;

  mouse_input inst (
    .clk(clk),
    .amiga_mouse_enable_a(amiga_mouse_enable_a),
    .amiga_mouse_enable_b(amiga_mouse_enable_b),
    .amiga_mouse_assume_a(amiga_mouse_assume_a),
    .amiga_mouse_assume_b(amiga_mouse_assume_b),
    .pot_drain(pot_drain),
    .fa_potx(fa_potx),
    .fa_poty(fa_poty),
    .fb_potx(fb_potx),
    .fb_poty(fb_poty),
    .fa_fire(fa_fire),
    .fa_left(fa_left),
    .fa_right(fa_right),
    .fa_up(fa_up),
    .fa_down(fa_down),
    .fb_fire(fb_fire),
    .fb_left(fb_left),
    .fb_right(fb_right),
    .fb_up(fb_up),
    .fb_down(fb_down),
    .fa_left_out(fa_left_out),
    .fa_right_out(fa_right_out),
    .fa_up_out(fa_up_out),
    .fa_down_out(fa_down_out),
    .fb_left_out(fb_left_out),
    .fb_right_out(fb_right_out),
    .fb_up_out(fb_up_out),
    .fb_down_out(fb_down_out),
    .mouse_debug(mouse_debug),
    .pota_x(pota_x),
    .pota_y(pota_y),
    .potb_x(potb_x),
    .potb_y(potb_y)
  );
endmodule
