// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Feb 22 16:48:27 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_rtg_0_0/Mega65_R6_rtg_0_0_stub.v
// Design      : Mega65_R6_rtg_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "Mega65_R6_rtg_0_0,rtg,{}" *) (* core_generation_info = "Mega65_R6_rtg_0_0,rtg,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=rtg,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* ip_definition_source = "module_ref" *) (* x_core_info = "rtg,Vivado 2024.2.1" *) 
module Mega65_R6_rtg_0_0(clk, aen, rd, wr, reset, rs, ready, data_in, data_out, ena, 
  hsize, vsize, format, base, stride, pal_clk, pal_dw, pal_dr, pal_a, pal_wr)
/* synthesis syn_black_box black_box_pad_pin="aen,rd,wr,reset,rs[11:1],ready,data_in[15:0],data_out[15:0],ena,hsize[11:0],vsize[11:0],format[4:0],base[31:0],stride[13:0],pal_dw[23:0],pal_dr[23:0],pal_a[7:0],pal_wr" */
/* synthesis syn_force_seq_prim="clk" */
/* synthesis syn_force_seq_prim="pal_clk" */;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_mode = "slave clk" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
  input aen;
  input rd;
  input wr;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 reset RST" *) (* x_interface_mode = "slave reset" *) (* x_interface_parameter = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input reset;
  input [11:1]rs;
  output ready;
  input [15:0]data_in;
  output [15:0]data_out;
  output ena;
  output [11:0]hsize;
  output [11:0]vsize;
  output [4:0]format;
  output [31:0]base;
  output [13:0]stride;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 pal_clk CLK" *) (* x_interface_mode = "master pal_clk" *) (* x_interface_parameter = "XIL_INTERFACENAME pal_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN Mega65_R6_rtg_0_0_pal_clk, INSERT_VIP 0" *) output pal_clk /* synthesis syn_isclock = 1 */;
  output [23:0]pal_dw;
  input [23:0]pal_dr;
  output [7:0]pal_a;
  output pal_wr;
endmodule
