// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Feb 22 14:34:11 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_audio_0_0/Mega65_R6_audio_0_0_stub.v
// Design      : Mega65_R6_audio_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "Mega65_R6_audio_0_0,audio,{}" *) (* core_generation_info = "Mega65_R6_audio_0_0,audio,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=audio,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* ip_definition_source = "module_ref" *) (* x_core_info = "audio,Vivado 2024.2.1" *) 
module Mega65_R6_audio_0_0(audio_clk_i, audio_reset_i, audio_left_i, 
  audio_right_i, audio_mclk_o, audio_bick_o, audio_sdti_o, audio_lrclk_o, audio_pdn_n_o)
/* synthesis syn_black_box black_box_pad_pin="audio_reset_i,audio_left_i[15:0],audio_right_i[15:0],audio_bick_o,audio_sdti_o,audio_lrclk_o,audio_pdn_n_o" */
/* synthesis syn_force_seq_prim="audio_clk_i" */
/* synthesis syn_force_seq_prim="audio_mclk_o" */;
  input audio_clk_i /* synthesis syn_isclock = 1 */;
  input audio_reset_i;
  input [15:0]audio_left_i;
  input [15:0]audio_right_i;
  output audio_mclk_o /* synthesis syn_isclock = 1 */;
  output audio_bick_o;
  output audio_sdti_o;
  output audio_lrclk_o;
  output audio_pdn_n_o;
endmodule
