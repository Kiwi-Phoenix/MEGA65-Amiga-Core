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


// IP VLNV: xilinx.com:module_ref:rtc_wrapper:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_rtc_wrapper_0_0 (
  clk_i,
  rst_i,
  rtc_o,
  rtc_wait_o,
  rtc_ce_i,
  rtc_we_i,
  rtc_addr_i,
  rtc_wr_data_i,
  rtc_rd_data_o,
  i2c_wait_o,
  i2c_ce_i,
  i2c_we_i,
  i2c_addr_i,
  i2c_wr_data_i,
  i2c_rd_data_o,
  scl_in_i,
  sda_in_i,
  scl_out_o,
  sda_out_o
);

input wire clk_i;
input wire rst_i;
output wire [64 : 0] rtc_o;
output wire rtc_wait_o;
input wire rtc_ce_i;
input wire rtc_we_i;
input wire [7 : 0] rtc_addr_i;
input wire [15 : 0] rtc_wr_data_i;
output wire [15 : 0] rtc_rd_data_o;
output wire i2c_wait_o;
input wire i2c_ce_i;
input wire i2c_we_i;
input wire [27 : 0] i2c_addr_i;
input wire [15 : 0] i2c_wr_data_i;
output wire [15 : 0] i2c_rd_data_o;
input wire [7 : 0] scl_in_i;
input wire [7 : 0] sda_in_i;
output wire [7 : 0] scl_out_o;
output wire [7 : 0] sda_out_o;

  rtc_wrapper #(
    .G_BOARD("0"),
    .G_I2C_CLK_DIV(0)
  ) inst (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .rtc_o(rtc_o),
    .rtc_wait_o(rtc_wait_o),
    .rtc_ce_i(rtc_ce_i),
    .rtc_we_i(rtc_we_i),
    .rtc_addr_i(rtc_addr_i),
    .rtc_wr_data_i(rtc_wr_data_i),
    .rtc_rd_data_o(rtc_rd_data_o),
    .i2c_wait_o(i2c_wait_o),
    .i2c_ce_i(i2c_ce_i),
    .i2c_we_i(i2c_we_i),
    .i2c_addr_i(i2c_addr_i),
    .i2c_wr_data_i(i2c_wr_data_i),
    .i2c_rd_data_o(i2c_rd_data_o),
    .scl_in_i(scl_in_i),
    .sda_in_i(sda_in_i),
    .scl_out_o(scl_out_o),
    .sda_out_o(sda_out_o)
  );
endmodule
