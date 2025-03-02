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


// IP VLNV: xilinx.com:module_ref:hyperram:1.0
// IP Revision: 1

(* X_CORE_INFO = "hyperram,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_hyperram_0_0,hyperram,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_hyperram_0_0,hyperram,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=hyperram,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,G_ERRATA_ISSI_D_FIX=true}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_hyperram_0_0 (
  clk_i,
  clk_del_i,
  delay_refclk_i,
  rst_i,
  avm_write_i,
  avm_read_i,
  avm_address_i,
  avm_writedata_i,
  avm_byteenable_i,
  avm_burstcount_i,
  avm_readdata_o,
  avm_readdatavalid_o,
  avm_waitrequest_o,
  count_long_o,
  count_short_o,
  hr_resetn_o,
  hr_csn_o,
  hr_ck_o,
  hr_rwds_in_i,
  hr_rwds_out_o,
  hr_rwds_oe_n_o,
  hr_dq_in_i,
  hr_dq_out_o,
  hr_dq_oe_n_o
);

input wire clk_i;
input wire clk_del_i;
input wire delay_refclk_i;
input wire rst_i;
input wire avm_write_i;
input wire avm_read_i;
input wire [31 : 0] avm_address_i;
input wire [15 : 0] avm_writedata_i;
input wire [1 : 0] avm_byteenable_i;
input wire [7 : 0] avm_burstcount_i;
output wire [15 : 0] avm_readdata_o;
output wire avm_readdatavalid_o;
output wire avm_waitrequest_o;
output wire [31 : 0] count_long_o;
output wire [31 : 0] count_short_o;
output wire hr_resetn_o;
output wire hr_csn_o;
output wire hr_ck_o;
input wire hr_rwds_in_i;
output wire hr_rwds_out_o;
output wire hr_rwds_oe_n_o;
input wire [7 : 0] hr_dq_in_i;
output wire [7 : 0] hr_dq_out_o;
output wire [7 : 0] hr_dq_oe_n_o;

  hyperram #(
    .G_ERRATA_ISSI_D_FIX(1'B1)
  ) inst (
    .clk_i(clk_i),
    .clk_del_i(clk_del_i),
    .delay_refclk_i(delay_refclk_i),
    .rst_i(rst_i),
    .avm_write_i(avm_write_i),
    .avm_read_i(avm_read_i),
    .avm_address_i(avm_address_i),
    .avm_writedata_i(avm_writedata_i),
    .avm_byteenable_i(avm_byteenable_i),
    .avm_burstcount_i(avm_burstcount_i),
    .avm_readdata_o(avm_readdata_o),
    .avm_readdatavalid_o(avm_readdatavalid_o),
    .avm_waitrequest_o(avm_waitrequest_o),
    .count_long_o(count_long_o),
    .count_short_o(count_short_o),
    .hr_resetn_o(hr_resetn_o),
    .hr_csn_o(hr_csn_o),
    .hr_ck_o(hr_ck_o),
    .hr_rwds_in_i(hr_rwds_in_i),
    .hr_rwds_out_o(hr_rwds_out_o),
    .hr_rwds_oe_n_o(hr_rwds_oe_n_o),
    .hr_dq_in_i(hr_dq_in_i),
    .hr_dq_out_o(hr_dq_out_o),
    .hr_dq_oe_n_o(hr_dq_oe_n_o)
  );
endmodule
