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


// IP VLNV: xilinx.com:module_ref:debouncer:1.0
// IP Revision: 1

(* X_CORE_INFO = "debouncer,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_debouncer_0_0,debouncer,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_debouncer_0_0,debouncer,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=debouncer,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,CLK_FREQ=0}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_debouncer_0_0 (
  clk,
  reset_n,
  flip_joys_i,
  joy_1_on,
  joy_2_on,
  joy_1_up_n,
  joy_1_down_n,
  joy_1_left_n,
  joy_1_right_n,
  joy_1_fire_n,
  dbnce_joy1_up_n,
  dbnce_joy1_down_n,
  dbnce_joy1_left_n,
  dbnce_joy1_right_n,
  dbnce_joy1_fire_n,
  joy_2_up_n,
  joy_2_down_n,
  joy_2_left_n,
  joy_2_right_n,
  joy_2_fire_n,
  dbnce_joy2_up_n,
  dbnce_joy2_down_n,
  dbnce_joy2_left_n,
  dbnce_joy2_right_n,
  dbnce_joy2_fire_n
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_n RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire reset_n;
input wire flip_joys_i;
input wire joy_1_on;
input wire joy_2_on;
input wire joy_1_up_n;
input wire joy_1_down_n;
input wire joy_1_left_n;
input wire joy_1_right_n;
input wire joy_1_fire_n;
output wire dbnce_joy1_up_n;
output wire dbnce_joy1_down_n;
output wire dbnce_joy1_left_n;
output wire dbnce_joy1_right_n;
output wire dbnce_joy1_fire_n;
input wire joy_2_up_n;
input wire joy_2_down_n;
input wire joy_2_left_n;
input wire joy_2_right_n;
input wire joy_2_fire_n;
output wire dbnce_joy2_up_n;
output wire dbnce_joy2_down_n;
output wire dbnce_joy2_left_n;
output wire dbnce_joy2_right_n;
output wire dbnce_joy2_fire_n;

  debouncer #(
    .CLK_FREQ(0)
  ) inst (
    .clk(clk),
    .reset_n(reset_n),
    .flip_joys_i(flip_joys_i),
    .joy_1_on(joy_1_on),
    .joy_2_on(joy_2_on),
    .joy_1_up_n(joy_1_up_n),
    .joy_1_down_n(joy_1_down_n),
    .joy_1_left_n(joy_1_left_n),
    .joy_1_right_n(joy_1_right_n),
    .joy_1_fire_n(joy_1_fire_n),
    .dbnce_joy1_up_n(dbnce_joy1_up_n),
    .dbnce_joy1_down_n(dbnce_joy1_down_n),
    .dbnce_joy1_left_n(dbnce_joy1_left_n),
    .dbnce_joy1_right_n(dbnce_joy1_right_n),
    .dbnce_joy1_fire_n(dbnce_joy1_fire_n),
    .joy_2_up_n(joy_2_up_n),
    .joy_2_down_n(joy_2_down_n),
    .joy_2_left_n(joy_2_left_n),
    .joy_2_right_n(joy_2_right_n),
    .joy_2_fire_n(joy_2_fire_n),
    .dbnce_joy2_up_n(dbnce_joy2_up_n),
    .dbnce_joy2_down_n(dbnce_joy2_down_n),
    .dbnce_joy2_left_n(dbnce_joy2_left_n),
    .dbnce_joy2_right_n(dbnce_joy2_right_n),
    .dbnce_joy2_fire_n(dbnce_joy2_fire_n)
  );
endmodule
