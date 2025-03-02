// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Feb 22 14:34:40 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_amiga_clk_0_0/Mega65_R6_amiga_clk_0_0_stub.v
// Design      : Mega65_R6_amiga_clk_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "Mega65_R6_amiga_clk_0_0,amiga_clk,{}" *) (* core_generation_info = "Mega65_R6_amiga_clk_0_0,amiga_clk,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=amiga_clk,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* ip_definition_source = "module_ref" *) (* x_core_info = "amiga_clk,Vivado 2024.2.1" *) 
module Mega65_R6_amiga_clk_0_0(clk_28, clk7_en, clk7n_en, c1, c3, cck, eclk, reset_n)
/* synthesis syn_black_box black_box_pad_pin="clk7_en,clk7n_en,c1,c3,cck,eclk[9:0],reset_n" */
/* synthesis syn_force_seq_prim="clk_28" */;
  input clk_28 /* synthesis syn_isclock = 1 */;
  output clk7_en;
  output clk7n_en;
  output c1;
  output c3;
  output cck;
  output [9:0]eclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 reset_n RST" *) (* x_interface_mode = "slave reset_n" *) (* x_interface_parameter = "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input reset_n;
endmodule
