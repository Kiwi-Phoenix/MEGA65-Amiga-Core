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


// IP VLNV: xilinx.com:module_ref:avm_arbit_general:1.0
// IP Revision: 1

(* X_CORE_INFO = "avm_arbit_general,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_avm_arbit_general_0_0,avm_arbit_general,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_avm_arbit_general_0_0,avm_arbit_general,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=avm_arbit_general,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,G_NUM_SLAVES=0,G_FREQ_HZ=100000000,G_ADDRESS_SIZE=0,G_DATA_SIZE=0}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_avm_arbit_general_0_0 (
  clk_i,
  rst_i,
  s_avm_write_i,
  s_avm_read_i,
  s_avm_address_i,
  s_avm_writedata_i,
  s_avm_byteenable_i,
  s_avm_burstcount_i,
  s_avm_readdata_o,
  s_avm_readdatavalid_o,
  s_avm_waitrequest_o,
  m_avm_write_o,
  m_avm_read_o,
  m_avm_address_o,
  m_avm_writedata_o,
  m_avm_byteenable_o,
  m_avm_burstcount_o,
  m_avm_readdata_i,
  m_avm_readdatavalid_i,
  m_avm_waitrequest_i
);

input wire clk_i;
input wire rst_i;
input wire [0 : 0] s_avm_write_i;
input wire [0 : 0] s_avm_read_i;
input wire [0 : 0] s_avm_address_i;
input wire [0 : 0] s_avm_writedata_i;
input wire [0 : 0] s_avm_byteenable_i;
input wire [0 : 0] s_avm_burstcount_i;
output wire [0 : 0] s_avm_readdata_o;
output wire [0 : 0] s_avm_readdatavalid_o;
output wire [0 : 0] s_avm_waitrequest_o;
output wire m_avm_write_o;
output wire m_avm_read_o;
output wire [0 : 0] m_avm_address_o;
output wire [0 : 0] m_avm_writedata_o;
output wire [0 : 0] m_avm_byteenable_o;
output wire [7 : 0] m_avm_burstcount_o;
input wire [0 : 0] m_avm_readdata_i;
input wire m_avm_readdatavalid_i;
input wire m_avm_waitrequest_i;

  avm_arbit_general #(
    .G_NUM_SLAVES(0),
    .G_FREQ_HZ(100000000),
    .G_ADDRESS_SIZE(0),
    .G_DATA_SIZE(0)
  ) inst (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .s_avm_write_i(s_avm_write_i),
    .s_avm_read_i(s_avm_read_i),
    .s_avm_address_i(s_avm_address_i),
    .s_avm_writedata_i(s_avm_writedata_i),
    .s_avm_byteenable_i(s_avm_byteenable_i),
    .s_avm_burstcount_i(s_avm_burstcount_i),
    .s_avm_readdata_o(s_avm_readdata_o),
    .s_avm_readdatavalid_o(s_avm_readdatavalid_o),
    .s_avm_waitrequest_o(s_avm_waitrequest_o),
    .m_avm_write_o(m_avm_write_o),
    .m_avm_read_o(m_avm_read_o),
    .m_avm_address_o(m_avm_address_o),
    .m_avm_writedata_o(m_avm_writedata_o),
    .m_avm_byteenable_o(m_avm_byteenable_o),
    .m_avm_burstcount_o(m_avm_burstcount_o),
    .m_avm_readdata_i(m_avm_readdata_i),
    .m_avm_readdatavalid_i(m_avm_readdatavalid_i),
    .m_avm_waitrequest_i(m_avm_waitrequest_i)
  );
endmodule
