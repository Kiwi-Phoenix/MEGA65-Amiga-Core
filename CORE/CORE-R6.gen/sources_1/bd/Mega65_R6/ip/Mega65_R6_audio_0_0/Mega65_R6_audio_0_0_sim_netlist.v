// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Feb 22 14:34:11 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_audio_0_0/Mega65_R6_audio_0_0_sim_netlist.v
// Design      : Mega65_R6_audio_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Mega65_R6_audio_0_0,audio,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "audio,Vivado 2024.2.1" *) 
(* NotValidForBitStream *)
module Mega65_R6_audio_0_0
   (audio_clk_i,
    audio_reset_i,
    audio_left_i,
    audio_right_i,
    audio_mclk_o,
    audio_bick_o,
    audio_sdti_o,
    audio_lrclk_o,
    audio_pdn_n_o);
  input audio_clk_i;
  input audio_reset_i;
  input [15:0]audio_left_i;
  input [15:0]audio_right_i;
  output audio_mclk_o;
  output audio_bick_o;
  output audio_sdti_o;
  output audio_lrclk_o;
  output audio_pdn_n_o;

  wire audio_bick_o;
  wire audio_clk_i;
  wire [15:0]audio_left_i;
  wire audio_lrclk_o;
  wire audio_pdn_n_o;
  wire audio_reset_i;
  wire [15:0]audio_right_i;
  wire audio_sdti_o;

  assign audio_mclk_o = audio_clk_i;
  Mega65_R6_audio_0_0_audio U0
       (.audio_bick_o(audio_bick_o),
        .audio_clk_i(audio_clk_i),
        .audio_left_i(audio_left_i),
        .audio_lrclk_o(audio_lrclk_o),
        .audio_right_i(audio_right_i),
        .audio_sdti_o(audio_sdti_o));
  LUT1 #(
    .INIT(2'h1)) 
    audio_pdn_n_o_INST_0
       (.I0(audio_reset_i),
        .O(audio_pdn_n_o));
endmodule

(* ORIG_REF_NAME = "audio" *) 
module Mega65_R6_audio_0_0_audio
   (audio_sdti_o,
    audio_lrclk_o,
    audio_bick_o,
    audio_clk_i,
    audio_right_i,
    audio_left_i);
  output audio_sdti_o;
  output audio_lrclk_o;
  output audio_bick_o;
  input audio_clk_i;
  input [15:0]audio_right_i;
  input [15:0]audio_left_i;

  wire audio_bick_o;
  wire audio_clk_i;
  wire [15:0]audio_left_i;
  wire audio_lrclk_o;
  wire audio_lrclk_o_i_1_n_0;
  wire [15:0]audio_right_i;
  wire audio_sdti_o;
  wire clear;
  wire \fs_counter[6]_i_2_n_0 ;
  wire [7:0]fs_counter_reg;
  wire \fs_counter_reg_n_0_[1] ;
  wire \i2s_data[16]_i_1_n_0 ;
  wire \i2s_data[17]_i_1_n_0 ;
  wire \i2s_data[18]_i_1_n_0 ;
  wire \i2s_data[19]_i_1_n_0 ;
  wire \i2s_data[20]_i_1_n_0 ;
  wire \i2s_data[21]_i_1_n_0 ;
  wire \i2s_data[22]_i_1_n_0 ;
  wire \i2s_data[23]_i_1_n_0 ;
  wire \i2s_data[24]_i_1_n_0 ;
  wire \i2s_data[25]_i_1_n_0 ;
  wire \i2s_data[26]_i_1_n_0 ;
  wire \i2s_data[27]_i_1_n_0 ;
  wire \i2s_data[28]_i_1_n_0 ;
  wire \i2s_data[29]_i_1_n_0 ;
  wire \i2s_data[30]_i_1_n_0 ;
  wire \i2s_data[31]_i_1_n_0 ;
  wire \i2s_data[47]_i_1_n_0 ;
  wire \i2s_data[48]_i_1_n_0 ;
  wire \i2s_data[49]_i_1_n_0 ;
  wire \i2s_data[50]_i_1_n_0 ;
  wire \i2s_data[51]_i_1_n_0 ;
  wire \i2s_data[52]_i_1_n_0 ;
  wire \i2s_data[53]_i_1_n_0 ;
  wire \i2s_data[54]_i_1_n_0 ;
  wire \i2s_data[55]_i_1_n_0 ;
  wire \i2s_data[56]_i_1_n_0 ;
  wire \i2s_data[57]_i_1_n_0 ;
  wire \i2s_data[58]_i_1_n_0 ;
  wire \i2s_data[59]_i_1_n_0 ;
  wire \i2s_data[60]_i_1_n_0 ;
  wire \i2s_data[61]_i_1_n_0 ;
  wire \i2s_data[62]_i_1_n_0 ;
  wire \i2s_data[63]_i_1_n_0 ;
  wire \i2s_data[63]_i_2_n_0 ;
  wire \i2s_data[63]_i_3_n_0 ;
  wire \i2s_data_reg_n_0_[16] ;
  wire \i2s_data_reg_n_0_[17] ;
  wire \i2s_data_reg_n_0_[18] ;
  wire \i2s_data_reg_n_0_[19] ;
  wire \i2s_data_reg_n_0_[20] ;
  wire \i2s_data_reg_n_0_[21] ;
  wire \i2s_data_reg_n_0_[22] ;
  wire \i2s_data_reg_n_0_[23] ;
  wire \i2s_data_reg_n_0_[24] ;
  wire \i2s_data_reg_n_0_[25] ;
  wire \i2s_data_reg_n_0_[26] ;
  wire \i2s_data_reg_n_0_[27] ;
  wire \i2s_data_reg_n_0_[28] ;
  wire \i2s_data_reg_n_0_[29] ;
  wire \i2s_data_reg_n_0_[30] ;
  wire \i2s_data_reg_n_0_[31] ;
  wire \i2s_data_reg_n_0_[32] ;
  wire \i2s_data_reg_n_0_[33] ;
  wire \i2s_data_reg_n_0_[34] ;
  wire \i2s_data_reg_n_0_[35] ;
  wire \i2s_data_reg_n_0_[36] ;
  wire \i2s_data_reg_n_0_[37] ;
  wire \i2s_data_reg_n_0_[38] ;
  wire \i2s_data_reg_n_0_[39] ;
  wire \i2s_data_reg_n_0_[40] ;
  wire \i2s_data_reg_n_0_[41] ;
  wire \i2s_data_reg_n_0_[42] ;
  wire \i2s_data_reg_n_0_[43] ;
  wire \i2s_data_reg_n_0_[44] ;
  wire \i2s_data_reg_n_0_[45] ;
  wire \i2s_data_reg_n_0_[46] ;
  wire \i2s_data_reg_n_0_[47] ;
  wire \i2s_data_reg_n_0_[48] ;
  wire \i2s_data_reg_n_0_[49] ;
  wire \i2s_data_reg_n_0_[50] ;
  wire \i2s_data_reg_n_0_[51] ;
  wire \i2s_data_reg_n_0_[52] ;
  wire \i2s_data_reg_n_0_[53] ;
  wire \i2s_data_reg_n_0_[54] ;
  wire \i2s_data_reg_n_0_[55] ;
  wire \i2s_data_reg_n_0_[56] ;
  wire \i2s_data_reg_n_0_[57] ;
  wire \i2s_data_reg_n_0_[58] ;
  wire \i2s_data_reg_n_0_[59] ;
  wire \i2s_data_reg_n_0_[60] ;
  wire \i2s_data_reg_n_0_[61] ;
  wire \i2s_data_reg_n_0_[62] ;
  wire p_0_in;
  wire [7:0]p_0_in__0;

  FDRE audio_bick_o_reg
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(\fs_counter_reg_n_0_[1] ),
        .Q(audio_bick_o),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    audio_lrclk_o_i_1
       (.I0(fs_counter_reg[7]),
        .O(audio_lrclk_o_i_1_n_0));
  FDRE audio_lrclk_o_reg
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(audio_lrclk_o_i_1_n_0),
        .Q(audio_lrclk_o),
        .R(1'b0));
  FDRE audio_sdti_o_reg
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in),
        .Q(audio_sdti_o),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \fs_counter[0]_i_1 
       (.I0(fs_counter_reg[0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \fs_counter[1]_i_1 
       (.I0(fs_counter_reg[0]),
        .I1(\fs_counter_reg_n_0_[1] ),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \fs_counter[2]_i_1 
       (.I0(\fs_counter_reg_n_0_[1] ),
        .I1(fs_counter_reg[0]),
        .I2(fs_counter_reg[2]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \fs_counter[3]_i_1 
       (.I0(fs_counter_reg[2]),
        .I1(fs_counter_reg[0]),
        .I2(\fs_counter_reg_n_0_[1] ),
        .I3(fs_counter_reg[3]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \fs_counter[4]_i_1 
       (.I0(fs_counter_reg[3]),
        .I1(\fs_counter_reg_n_0_[1] ),
        .I2(fs_counter_reg[0]),
        .I3(fs_counter_reg[2]),
        .I4(fs_counter_reg[4]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \fs_counter[5]_i_1 
       (.I0(fs_counter_reg[4]),
        .I1(fs_counter_reg[2]),
        .I2(fs_counter_reg[0]),
        .I3(\fs_counter_reg_n_0_[1] ),
        .I4(fs_counter_reg[3]),
        .I5(fs_counter_reg[5]),
        .O(p_0_in__0[5]));
  LUT6 #(
    .INIT(64'hF7FFFFFF08000000)) 
    \fs_counter[6]_i_1 
       (.I0(fs_counter_reg[5]),
        .I1(fs_counter_reg[3]),
        .I2(\fs_counter[6]_i_2_n_0 ),
        .I3(fs_counter_reg[2]),
        .I4(fs_counter_reg[4]),
        .I5(fs_counter_reg[6]),
        .O(p_0_in__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \fs_counter[6]_i_2 
       (.I0(fs_counter_reg[0]),
        .I1(\fs_counter_reg_n_0_[1] ),
        .O(\fs_counter[6]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h20)) 
    \fs_counter[7]_i_1 
       (.I0(fs_counter_reg[7]),
        .I1(\i2s_data[63]_i_3_n_0 ),
        .I2(fs_counter_reg[6]),
        .O(clear));
  LUT3 #(
    .INIT(8'hD2)) 
    \fs_counter[7]_i_2 
       (.I0(fs_counter_reg[6]),
        .I1(\i2s_data[63]_i_3_n_0 ),
        .I2(fs_counter_reg[7]),
        .O(p_0_in__0[7]));
  FDRE #(
    .INIT(1'b0)) 
    \fs_counter_reg[0] 
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in__0[0]),
        .Q(fs_counter_reg[0]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \fs_counter_reg[1] 
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in__0[1]),
        .Q(\fs_counter_reg_n_0_[1] ),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \fs_counter_reg[2] 
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in__0[2]),
        .Q(fs_counter_reg[2]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \fs_counter_reg[3] 
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in__0[3]),
        .Q(fs_counter_reg[3]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \fs_counter_reg[4] 
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in__0[4]),
        .Q(fs_counter_reg[4]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \fs_counter_reg[5] 
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in__0[5]),
        .Q(fs_counter_reg[5]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \fs_counter_reg[6] 
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in__0[6]),
        .Q(fs_counter_reg[6]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \fs_counter_reg[7] 
       (.C(audio_clk_i),
        .CE(1'b1),
        .D(p_0_in__0[7]),
        .Q(fs_counter_reg[7]),
        .R(clear));
  LUT4 #(
    .INIT(16'h0800)) 
    \i2s_data[16]_i_1 
       (.I0(audio_right_i[0]),
        .I1(fs_counter_reg[7]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[6]),
        .O(\i2s_data[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[17]_i_1 
       (.I0(\i2s_data_reg_n_0_[16] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[1]),
        .O(\i2s_data[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[18]_i_1 
       (.I0(\i2s_data_reg_n_0_[17] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[2]),
        .O(\i2s_data[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[19]_i_1 
       (.I0(\i2s_data_reg_n_0_[18] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[3]),
        .O(\i2s_data[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[20]_i_1 
       (.I0(\i2s_data_reg_n_0_[19] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[4]),
        .O(\i2s_data[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[21]_i_1 
       (.I0(\i2s_data_reg_n_0_[20] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[5]),
        .O(\i2s_data[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[22]_i_1 
       (.I0(\i2s_data_reg_n_0_[21] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[6]),
        .O(\i2s_data[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[23]_i_1 
       (.I0(\i2s_data_reg_n_0_[22] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[7]),
        .O(\i2s_data[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[24]_i_1 
       (.I0(\i2s_data_reg_n_0_[23] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[8]),
        .O(\i2s_data[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[25]_i_1 
       (.I0(\i2s_data_reg_n_0_[24] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[9]),
        .O(\i2s_data[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[26]_i_1 
       (.I0(\i2s_data_reg_n_0_[25] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[10]),
        .O(\i2s_data[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[27]_i_1 
       (.I0(\i2s_data_reg_n_0_[26] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[11]),
        .O(\i2s_data[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[28]_i_1 
       (.I0(\i2s_data_reg_n_0_[27] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[12]),
        .O(\i2s_data[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[29]_i_1 
       (.I0(\i2s_data_reg_n_0_[28] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[13]),
        .O(\i2s_data[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[30]_i_1 
       (.I0(\i2s_data_reg_n_0_[29] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[14]),
        .O(\i2s_data[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[31]_i_1 
       (.I0(\i2s_data_reg_n_0_[30] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_right_i[15]),
        .O(\i2s_data[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \i2s_data[47]_i_1 
       (.I0(fs_counter_reg[7]),
        .I1(\i2s_data[63]_i_3_n_0 ),
        .I2(fs_counter_reg[6]),
        .I3(\fs_counter_reg_n_0_[1] ),
        .I4(fs_counter_reg[0]),
        .O(\i2s_data[47]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[48]_i_1 
       (.I0(\i2s_data_reg_n_0_[47] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[0]),
        .O(\i2s_data[48]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[49]_i_1 
       (.I0(\i2s_data_reg_n_0_[48] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[1]),
        .O(\i2s_data[49]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[50]_i_1 
       (.I0(\i2s_data_reg_n_0_[49] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[2]),
        .O(\i2s_data[50]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[51]_i_1 
       (.I0(\i2s_data_reg_n_0_[50] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[3]),
        .O(\i2s_data[51]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[52]_i_1 
       (.I0(\i2s_data_reg_n_0_[51] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[4]),
        .O(\i2s_data[52]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[53]_i_1 
       (.I0(\i2s_data_reg_n_0_[52] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[5]),
        .O(\i2s_data[53]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[54]_i_1 
       (.I0(\i2s_data_reg_n_0_[53] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[6]),
        .O(\i2s_data[54]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[55]_i_1 
       (.I0(\i2s_data_reg_n_0_[54] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[7]),
        .O(\i2s_data[55]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[56]_i_1 
       (.I0(\i2s_data_reg_n_0_[55] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[8]),
        .O(\i2s_data[56]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[57]_i_1 
       (.I0(\i2s_data_reg_n_0_[56] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[9]),
        .O(\i2s_data[57]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[58]_i_1 
       (.I0(\i2s_data_reg_n_0_[57] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[10]),
        .O(\i2s_data[58]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[59]_i_1 
       (.I0(\i2s_data_reg_n_0_[58] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[11]),
        .O(\i2s_data[59]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[60]_i_1 
       (.I0(\i2s_data_reg_n_0_[59] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[12]),
        .O(\i2s_data[60]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[61]_i_1 
       (.I0(\i2s_data_reg_n_0_[60] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[13]),
        .O(\i2s_data[61]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[62]_i_1 
       (.I0(\i2s_data_reg_n_0_[61] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[14]),
        .O(\i2s_data[62]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \i2s_data[63]_i_1 
       (.I0(\fs_counter_reg_n_0_[1] ),
        .I1(fs_counter_reg[0]),
        .O(\i2s_data[63]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAEAAA2AA)) 
    \i2s_data[63]_i_2 
       (.I0(\i2s_data_reg_n_0_[62] ),
        .I1(fs_counter_reg[6]),
        .I2(\i2s_data[63]_i_3_n_0 ),
        .I3(fs_counter_reg[7]),
        .I4(audio_left_i[15]),
        .O(\i2s_data[63]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \i2s_data[63]_i_3 
       (.I0(fs_counter_reg[4]),
        .I1(fs_counter_reg[2]),
        .I2(fs_counter_reg[0]),
        .I3(\fs_counter_reg_n_0_[1] ),
        .I4(fs_counter_reg[3]),
        .I5(fs_counter_reg[5]),
        .O(\i2s_data[63]_i_3_n_0 ));
  FDRE \i2s_data_reg[16] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[16]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \i2s_data_reg[17] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[17]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \i2s_data_reg[18] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[18]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \i2s_data_reg[19] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[19]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \i2s_data_reg[20] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[20]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \i2s_data_reg[21] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[21]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \i2s_data_reg[22] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[22]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \i2s_data_reg[23] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[23]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \i2s_data_reg[24] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[24]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \i2s_data_reg[25] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[25]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \i2s_data_reg[26] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[26]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \i2s_data_reg[27] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[27]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \i2s_data_reg[28] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[28]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \i2s_data_reg[29] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[29]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \i2s_data_reg[30] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[30]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \i2s_data_reg[31] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[31]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \i2s_data_reg[32] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[31] ),
        .Q(\i2s_data_reg_n_0_[32] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[33] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[32] ),
        .Q(\i2s_data_reg_n_0_[33] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[34] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[33] ),
        .Q(\i2s_data_reg_n_0_[34] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[35] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[34] ),
        .Q(\i2s_data_reg_n_0_[35] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[36] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[35] ),
        .Q(\i2s_data_reg_n_0_[36] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[37] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[36] ),
        .Q(\i2s_data_reg_n_0_[37] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[38] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[37] ),
        .Q(\i2s_data_reg_n_0_[38] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[39] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[38] ),
        .Q(\i2s_data_reg_n_0_[39] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[40] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[39] ),
        .Q(\i2s_data_reg_n_0_[40] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[41] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[40] ),
        .Q(\i2s_data_reg_n_0_[41] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[42] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[41] ),
        .Q(\i2s_data_reg_n_0_[42] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[43] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[42] ),
        .Q(\i2s_data_reg_n_0_[43] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[44] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[43] ),
        .Q(\i2s_data_reg_n_0_[44] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[45] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[44] ),
        .Q(\i2s_data_reg_n_0_[45] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[46] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[45] ),
        .Q(\i2s_data_reg_n_0_[46] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[47] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data_reg_n_0_[46] ),
        .Q(\i2s_data_reg_n_0_[47] ),
        .R(\i2s_data[47]_i_1_n_0 ));
  FDRE \i2s_data_reg[48] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[48]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[48] ),
        .R(1'b0));
  FDRE \i2s_data_reg[49] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[49]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[49] ),
        .R(1'b0));
  FDRE \i2s_data_reg[50] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[50]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[50] ),
        .R(1'b0));
  FDRE \i2s_data_reg[51] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[51]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[51] ),
        .R(1'b0));
  FDRE \i2s_data_reg[52] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[52]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[52] ),
        .R(1'b0));
  FDRE \i2s_data_reg[53] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[53]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[53] ),
        .R(1'b0));
  FDRE \i2s_data_reg[54] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[54]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[54] ),
        .R(1'b0));
  FDRE \i2s_data_reg[55] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[55]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[55] ),
        .R(1'b0));
  FDRE \i2s_data_reg[56] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[56]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[56] ),
        .R(1'b0));
  FDRE \i2s_data_reg[57] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[57]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[57] ),
        .R(1'b0));
  FDRE \i2s_data_reg[58] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[58]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[58] ),
        .R(1'b0));
  FDRE \i2s_data_reg[59] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[59]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[59] ),
        .R(1'b0));
  FDRE \i2s_data_reg[60] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[60]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[60] ),
        .R(1'b0));
  FDRE \i2s_data_reg[61] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[61]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[61] ),
        .R(1'b0));
  FDRE \i2s_data_reg[62] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[62]_i_1_n_0 ),
        .Q(\i2s_data_reg_n_0_[62] ),
        .R(1'b0));
  FDRE \i2s_data_reg[63] 
       (.C(audio_clk_i),
        .CE(\i2s_data[63]_i_1_n_0 ),
        .D(\i2s_data[63]_i_2_n_0 ),
        .Q(p_0_in),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
