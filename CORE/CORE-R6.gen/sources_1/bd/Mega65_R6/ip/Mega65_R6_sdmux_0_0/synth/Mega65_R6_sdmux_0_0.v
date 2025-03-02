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


// IP VLNV: xilinx.com:module_ref:sdmux:1.0
// IP Revision: 1

(* X_CORE_INFO = "sdmux,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_sdmux_0_0,sdmux,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_sdmux_0_0,sdmux,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=sdmux,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_sdmux_0_0 (
  sysclk50Mhz_i,
  sysreset_i,
  mode_i,
  active_o,
  force_i,
  detected_int_o,
  detected_ext_o,
  sd_tray_detect_i,
  sd_tray_reset_o,
  sd_tray_clk_o,
  sd_tray_mosi_o,
  sd_tray_miso_i,
  sd_back_detect_i,
  sd_back_reset_o,
  sd_back_clk_o,
  sd_back_mosi_o,
  sd_back_miso_i,
  ctrl_reset_o,
  ctrl_sd_reset_i,
  ctrl_sd_clk_i,
  ctrl_sd_mosi_i,
  ctrl_sd_miso_o
);

input wire sysclk50Mhz_i;
input wire sysreset_i;
input wire mode_i;
output wire active_o;
input wire force_i;
output wire detected_int_o;
output wire detected_ext_o;
input wire sd_tray_detect_i;
output wire sd_tray_reset_o;
output wire sd_tray_clk_o;
output wire sd_tray_mosi_o;
input wire sd_tray_miso_i;
input wire sd_back_detect_i;
output wire sd_back_reset_o;
output wire sd_back_clk_o;
output wire sd_back_mosi_o;
input wire sd_back_miso_i;
output wire ctrl_reset_o;
input wire ctrl_sd_reset_i;
input wire ctrl_sd_clk_i;
input wire ctrl_sd_mosi_i;
output wire ctrl_sd_miso_o;

  sdmux inst (
    .sysclk50Mhz_i(sysclk50Mhz_i),
    .sysreset_i(sysreset_i),
    .mode_i(mode_i),
    .active_o(active_o),
    .force_i(force_i),
    .detected_int_o(detected_int_o),
    .detected_ext_o(detected_ext_o),
    .sd_tray_detect_i(sd_tray_detect_i),
    .sd_tray_reset_o(sd_tray_reset_o),
    .sd_tray_clk_o(sd_tray_clk_o),
    .sd_tray_mosi_o(sd_tray_mosi_o),
    .sd_tray_miso_i(sd_tray_miso_i),
    .sd_back_detect_i(sd_back_detect_i),
    .sd_back_reset_o(sd_back_reset_o),
    .sd_back_clk_o(sd_back_clk_o),
    .sd_back_mosi_o(sd_back_mosi_o),
    .sd_back_miso_i(sd_back_miso_i),
    .ctrl_reset_o(ctrl_reset_o),
    .ctrl_sd_reset_i(ctrl_sd_reset_i),
    .ctrl_sd_clk_i(ctrl_sd_clk_i),
    .ctrl_sd_mosi_i(ctrl_sd_mosi_i),
    .ctrl_sd_miso_o(ctrl_sd_miso_o)
  );
endmodule
