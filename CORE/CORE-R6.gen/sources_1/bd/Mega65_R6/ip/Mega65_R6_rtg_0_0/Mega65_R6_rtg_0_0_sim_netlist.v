// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Feb 22 16:48:27 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_rtg_0_0/Mega65_R6_rtg_0_0_sim_netlist.v
// Design      : Mega65_R6_rtg_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Mega65_R6_rtg_0_0,rtg,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "rtg,Vivado 2024.2.1" *) 
(* NotValidForBitStream *)
module Mega65_R6_rtg_0_0
   (clk,
    aen,
    rd,
    wr,
    reset,
    rs,
    ready,
    data_in,
    data_out,
    ena,
    hsize,
    vsize,
    format,
    base,
    stride,
    pal_clk,
    pal_dw,
    pal_dr,
    pal_a,
    pal_wr);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_mode = "slave clk" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input clk;
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
  (* x_interface_info = "xilinx.com:signal:clock:1.0 pal_clk CLK" *) (* x_interface_mode = "master pal_clk" *) (* x_interface_parameter = "XIL_INTERFACENAME pal_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN Mega65_R6_rtg_0_0_pal_clk, INSERT_VIP 0" *) output pal_clk;
  output [23:0]pal_dw;
  input [23:0]pal_dr;
  output [7:0]pal_a;
  output pal_wr;

  wire aen;
  wire [31:0]base;
  wire clk;
  wire [15:0]data_in;
  wire [15:0]data_out;
  wire ena;
  wire [4:0]format;
  wire [11:0]hsize;
  wire [23:0]pal_dr;
  wire [23:0]pal_dw;
  wire pal_wr;
  wire rd;
  wire ready;
  wire reset;
  wire [11:1]rs;
  wire [13:0]stride;
  wire [11:0]vsize;
  wire wr;

  assign pal_a[7:0] = rs[9:2];
  assign pal_clk = clk;
  Mega65_R6_rtg_0_0_rtg U0
       (.aen(aen),
        .base(base),
        .clk(clk),
        .data_in(data_in),
        .data_out(data_out),
        .ena(ena),
        .format(format),
        .hsize(hsize),
        .pal_dr(pal_dr),
        .pal_dw(pal_dw),
        .rd(rd),
        .ready(ready),
        .reset(reset),
        .rs(rs),
        .stride(stride),
        .vsize(vsize),
        .wr(wr));
  LUT4 #(
    .INIT(16'h0800)) 
    pal_wr_INST_0
       (.I0(wr),
        .I1(rs[10]),
        .I2(rs[11]),
        .I3(aen),
        .O(pal_wr));
endmodule

(* ORIG_REF_NAME = "rtg" *) 
module Mega65_R6_rtg_0_0_rtg
   (ena,
    ready,
    stride,
    base,
    vsize,
    hsize,
    format,
    data_out,
    pal_dw,
    clk,
    data_in,
    reset,
    rs,
    aen,
    pal_dr,
    wr,
    rd);
  output ena;
  output ready;
  output [13:0]stride;
  output [31:0]base;
  output [11:0]vsize;
  output [11:0]hsize;
  output [4:0]format;
  output [15:0]data_out;
  output [23:0]pal_dw;
  input clk;
  input [15:0]data_in;
  input reset;
  input [11:1]rs;
  input aen;
  input [23:0]pal_dr;
  input wr;
  input rd;

  wire aen;
  wire [31:0]base;
  wire \base[15]_i_1_n_0 ;
  wire \base[31]_i_1_n_0 ;
  wire clk;
  wire [15:0]data_in;
  wire [15:0]data_out;
  wire [15:0]dout;
  wire \dout[0]_i_1_n_0 ;
  wire \dout[0]_i_2_n_0 ;
  wire \dout[0]_i_3_n_0 ;
  wire \dout[0]_i_4_n_0 ;
  wire \dout[10]_i_1_n_0 ;
  wire \dout[10]_i_2_n_0 ;
  wire \dout[10]_i_3_n_0 ;
  wire \dout[10]_i_4_n_0 ;
  wire \dout[11]_i_1_n_0 ;
  wire \dout[11]_i_2_n_0 ;
  wire \dout[11]_i_3_n_0 ;
  wire \dout[11]_i_4_n_0 ;
  wire \dout[12]_i_1_n_0 ;
  wire \dout[12]_i_2_n_0 ;
  wire \dout[12]_i_3_n_0 ;
  wire \dout[13]_i_1_n_0 ;
  wire \dout[13]_i_2_n_0 ;
  wire \dout[13]_i_3_n_0 ;
  wire \dout[14]_i_1_n_0 ;
  wire \dout[14]_i_2_n_0 ;
  wire \dout[14]_i_3_n_0 ;
  wire \dout[15]_i_1_n_0 ;
  wire \dout[15]_i_2_n_0 ;
  wire \dout[15]_i_3_n_0 ;
  wire \dout[1]_i_1_n_0 ;
  wire \dout[1]_i_2_n_0 ;
  wire \dout[1]_i_3_n_0 ;
  wire \dout[1]_i_4_n_0 ;
  wire \dout[2]_i_1_n_0 ;
  wire \dout[2]_i_2_n_0 ;
  wire \dout[2]_i_3_n_0 ;
  wire \dout[2]_i_4_n_0 ;
  wire \dout[3]_i_1_n_0 ;
  wire \dout[3]_i_2_n_0 ;
  wire \dout[3]_i_3_n_0 ;
  wire \dout[3]_i_4_n_0 ;
  wire \dout[4]_i_1_n_0 ;
  wire \dout[4]_i_2_n_0 ;
  wire \dout[4]_i_3_n_0 ;
  wire \dout[4]_i_4_n_0 ;
  wire \dout[5]_i_1_n_0 ;
  wire \dout[5]_i_2_n_0 ;
  wire \dout[5]_i_3_n_0 ;
  wire \dout[5]_i_4_n_0 ;
  wire \dout[6]_i_1_n_0 ;
  wire \dout[6]_i_2_n_0 ;
  wire \dout[6]_i_3_n_0 ;
  wire \dout[6]_i_4_n_0 ;
  wire \dout[7]_i_1_n_0 ;
  wire \dout[7]_i_2_n_0 ;
  wire \dout[7]_i_3_n_0 ;
  wire \dout[7]_i_4_n_0 ;
  wire \dout[8]_i_1_n_0 ;
  wire \dout[8]_i_2_n_0 ;
  wire \dout[8]_i_3_n_0 ;
  wire \dout[8]_i_4_n_0 ;
  wire \dout[9]_i_1_n_0 ;
  wire \dout[9]_i_2_n_0 ;
  wire \dout[9]_i_3_n_0 ;
  wire \dout[9]_i_4_n_0 ;
  wire ena;
  wire ena_i_1_n_0;
  wire ena_i_2_n_0;
  wire ena_i_3_n_0;
  wire ena_i_4_n_0;
  wire [4:0]format;
  wire \format[4]_i_1_n_0 ;
  wire \format[4]_i_2_n_0 ;
  wire [11:0]hsize;
  wire \hsize[11]_i_1_n_0 ;
  wire \hsize[11]_i_2_n_0 ;
  wire [23:0]pal_dr;
  wire [23:0]pal_dw;
  wire rd;
  wire [2:0]rd_r;
  wire \rd_r[0]_i_1_n_0 ;
  wire \rd_r[1]_i_1_n_0 ;
  wire \rd_r[2]_i_1_n_0 ;
  wire ready;
  wire reset;
  wire [23:0]rpal;
  wire \rpal[15]_i_1_n_0 ;
  wire \rpal[23]_i_1_n_0 ;
  wire [11:1]rs;
  wire [13:0]stride;
  wire \stride[13]_i_1_n_0 ;
  wire \stride[13]_i_2_n_0 ;
  wire [11:0]vsize;
  wire \vsize[11]_i_1_n_0 ;
  wire \vsize[11]_i_2_n_0 ;
  wire wr;

  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \base[15]_i_1 
       (.I0(\vsize[11]_i_2_n_0 ),
        .I1(ena_i_4_n_0),
        .I2(ena_i_3_n_0),
        .I3(rs[1]),
        .I4(rs[2]),
        .I5(rs[3]),
        .O(\base[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000020)) 
    \base[31]_i_1 
       (.I0(\hsize[11]_i_2_n_0 ),
        .I1(rs[9]),
        .I2(rs[8]),
        .I3(rs[10]),
        .I4(ena_i_4_n_0),
        .I5(rs[3]),
        .O(\base[31]_i_1_n_0 ));
  FDRE \base_reg[0] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[0]),
        .Q(base[0]),
        .R(1'b0));
  FDRE \base_reg[10] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[10]),
        .Q(base[10]),
        .R(1'b0));
  FDRE \base_reg[11] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[11]),
        .Q(base[11]),
        .R(1'b0));
  FDRE \base_reg[12] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[12]),
        .Q(base[12]),
        .R(1'b0));
  FDRE \base_reg[13] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[13]),
        .Q(base[13]),
        .R(1'b0));
  FDRE \base_reg[14] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[14]),
        .Q(base[14]),
        .R(1'b0));
  FDRE \base_reg[15] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[15]),
        .Q(base[15]),
        .R(1'b0));
  FDRE \base_reg[16] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[0]),
        .Q(base[16]),
        .R(1'b0));
  FDRE \base_reg[17] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[1]),
        .Q(base[17]),
        .R(1'b0));
  FDRE \base_reg[18] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[2]),
        .Q(base[18]),
        .R(1'b0));
  FDRE \base_reg[19] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[3]),
        .Q(base[19]),
        .R(1'b0));
  FDRE \base_reg[1] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[1]),
        .Q(base[1]),
        .R(1'b0));
  FDRE \base_reg[20] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[4]),
        .Q(base[20]),
        .R(1'b0));
  FDRE \base_reg[21] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[5]),
        .Q(base[21]),
        .R(1'b0));
  FDRE \base_reg[22] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[6]),
        .Q(base[22]),
        .R(1'b0));
  FDRE \base_reg[23] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[7]),
        .Q(base[23]),
        .R(1'b0));
  FDRE \base_reg[24] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[8]),
        .Q(base[24]),
        .R(1'b0));
  FDRE \base_reg[25] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[9]),
        .Q(base[25]),
        .R(1'b0));
  FDRE \base_reg[26] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[10]),
        .Q(base[26]),
        .R(1'b0));
  FDRE \base_reg[27] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[11]),
        .Q(base[27]),
        .R(1'b0));
  FDRE \base_reg[28] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[12]),
        .Q(base[28]),
        .R(1'b0));
  FDRE \base_reg[29] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[13]),
        .Q(base[29]),
        .R(1'b0));
  FDRE \base_reg[2] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[2]),
        .Q(base[2]),
        .R(1'b0));
  FDRE \base_reg[30] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[14]),
        .Q(base[30]),
        .R(1'b0));
  FDRE \base_reg[31] 
       (.C(clk),
        .CE(\base[31]_i_1_n_0 ),
        .D(data_in[15]),
        .Q(base[31]),
        .R(1'b0));
  FDRE \base_reg[3] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[3]),
        .Q(base[3]),
        .R(1'b0));
  FDRE \base_reg[4] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[4]),
        .Q(base[4]),
        .R(1'b0));
  FDRE \base_reg[5] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[5]),
        .Q(base[5]),
        .R(1'b0));
  FDRE \base_reg[6] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[6]),
        .Q(base[6]),
        .R(1'b0));
  FDRE \base_reg[7] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[7]),
        .Q(base[7]),
        .R(1'b0));
  FDRE \base_reg[8] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[8]),
        .Q(base[8]),
        .R(1'b0));
  FDRE \base_reg[9] 
       (.C(clk),
        .CE(\base[15]_i_1_n_0 ),
        .D(data_in[9]),
        .Q(base[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[0]_INST_0 
       (.I0(aen),
        .I1(dout[0]),
        .O(data_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[10]_INST_0 
       (.I0(aen),
        .I1(dout[10]),
        .O(data_out[10]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[11]_INST_0 
       (.I0(aen),
        .I1(dout[11]),
        .O(data_out[11]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[12]_INST_0 
       (.I0(aen),
        .I1(dout[12]),
        .O(data_out[12]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[13]_INST_0 
       (.I0(aen),
        .I1(dout[13]),
        .O(data_out[13]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[14]_INST_0 
       (.I0(aen),
        .I1(dout[14]),
        .O(data_out[14]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[15]_INST_0 
       (.I0(aen),
        .I1(dout[15]),
        .O(data_out[15]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[1]_INST_0 
       (.I0(aen),
        .I1(dout[1]),
        .O(data_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[2]_INST_0 
       (.I0(aen),
        .I1(dout[2]),
        .O(data_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[3]_INST_0 
       (.I0(aen),
        .I1(dout[3]),
        .O(data_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[4]_INST_0 
       (.I0(aen),
        .I1(dout[4]),
        .O(data_out[4]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[5]_INST_0 
       (.I0(aen),
        .I1(dout[5]),
        .O(data_out[5]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[6]_INST_0 
       (.I0(aen),
        .I1(dout[6]),
        .O(data_out[6]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[7]_INST_0 
       (.I0(aen),
        .I1(dout[7]),
        .O(data_out[7]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[8]_INST_0 
       (.I0(aen),
        .I1(dout[8]),
        .O(data_out[8]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \data_out[9]_INST_0 
       (.I0(aen),
        .I1(dout[9]),
        .O(data_out[9]));
  LUT6 #(
    .INIT(64'hABAAABABABAAAAAA)) 
    \dout[0]_i_1 
       (.I0(\dout[0]_i_2_n_0 ),
        .I1(ena_i_3_n_0),
        .I2(ena_i_4_n_0),
        .I3(\dout[0]_i_3_n_0 ),
        .I4(rs[3]),
        .I5(\dout[0]_i_4_n_0 ),
        .O(\dout[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000E20000000000)) 
    \dout[0]_i_2 
       (.I0(pal_dr[16]),
        .I1(rs[1]),
        .I2(pal_dr[0]),
        .I3(rs[10]),
        .I4(rs[11]),
        .I5(aen),
        .O(\dout[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFCBBFC88)) 
    \dout[0]_i_3 
       (.I0(stride[0]),
        .I1(rs[2]),
        .I2(vsize[0]),
        .I3(rs[1]),
        .I4(hsize[0]),
        .O(\dout[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \dout[0]_i_4 
       (.I0(ena),
        .I1(format[0]),
        .I2(rs[2]),
        .I3(base[0]),
        .I4(rs[1]),
        .I5(base[16]),
        .O(\dout[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF10111000)) 
    \dout[10]_i_1 
       (.I0(ena_i_3_n_0),
        .I1(ena_i_4_n_0),
        .I2(\dout[10]_i_2_n_0 ),
        .I3(rs[3]),
        .I4(\dout[10]_i_3_n_0 ),
        .I5(\dout[10]_i_4_n_0 ),
        .O(\dout[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[10]_i_2 
       (.I0(stride[10]),
        .I1(rs[2]),
        .I2(vsize[10]),
        .I3(rs[1]),
        .I4(hsize[10]),
        .O(\dout[10]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \dout[10]_i_3 
       (.I0(base[26]),
        .I1(rs[1]),
        .I2(base[10]),
        .I3(rs[2]),
        .O(\dout[10]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \dout[10]_i_4 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(pal_dr[10]),
        .I4(rs[1]),
        .O(\dout[10]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF10111000)) 
    \dout[11]_i_1 
       (.I0(ena_i_3_n_0),
        .I1(ena_i_4_n_0),
        .I2(\dout[11]_i_2_n_0 ),
        .I3(rs[3]),
        .I4(\dout[11]_i_3_n_0 ),
        .I5(\dout[11]_i_4_n_0 ),
        .O(\dout[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[11]_i_2 
       (.I0(stride[11]),
        .I1(rs[2]),
        .I2(vsize[11]),
        .I3(rs[1]),
        .I4(hsize[11]),
        .O(\dout[11]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \dout[11]_i_3 
       (.I0(base[27]),
        .I1(rs[1]),
        .I2(base[11]),
        .I3(rs[2]),
        .O(\dout[11]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \dout[11]_i_4 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(pal_dr[11]),
        .I4(rs[1]),
        .O(\dout[11]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000010)) 
    \dout[12]_i_1 
       (.I0(\dout[12]_i_2_n_0 ),
        .I1(rs[9]),
        .I2(rs[8]),
        .I3(rs[10]),
        .I4(ena_i_4_n_0),
        .I5(\dout[12]_i_3_n_0 ),
        .O(\dout[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3C3C7C7F3F3F7C7F)) 
    \dout[12]_i_2 
       (.I0(stride[12]),
        .I1(rs[3]),
        .I2(rs[2]),
        .I3(base[28]),
        .I4(rs[1]),
        .I5(base[12]),
        .O(\dout[12]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \dout[12]_i_3 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(pal_dr[12]),
        .I4(rs[1]),
        .O(\dout[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000010)) 
    \dout[13]_i_1 
       (.I0(\dout[13]_i_2_n_0 ),
        .I1(rs[9]),
        .I2(rs[8]),
        .I3(rs[10]),
        .I4(ena_i_4_n_0),
        .I5(\dout[13]_i_3_n_0 ),
        .O(\dout[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFCFC7C7FFFFF7C7F)) 
    \dout[13]_i_2 
       (.I0(stride[13]),
        .I1(rs[2]),
        .I2(rs[3]),
        .I3(base[29]),
        .I4(rs[1]),
        .I5(base[13]),
        .O(\dout[13]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \dout[13]_i_3 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(pal_dr[13]),
        .I4(rs[1]),
        .O(\dout[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000010)) 
    \dout[14]_i_1 
       (.I0(\dout[14]_i_2_n_0 ),
        .I1(rs[9]),
        .I2(rs[8]),
        .I3(rs[10]),
        .I4(ena_i_4_n_0),
        .I5(\dout[14]_i_3_n_0 ),
        .O(\dout[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h66EF77EF)) 
    \dout[14]_i_2 
       (.I0(rs[3]),
        .I1(rs[2]),
        .I2(base[30]),
        .I3(rs[1]),
        .I4(base[14]),
        .O(\dout[14]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \dout[14]_i_3 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(pal_dr[14]),
        .I4(rs[1]),
        .O(\dout[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAABAA)) 
    \dout[15]_i_1 
       (.I0(\dout[15]_i_2_n_0 ),
        .I1(\dout[15]_i_3_n_0 ),
        .I2(rs[9]),
        .I3(rs[8]),
        .I4(rs[10]),
        .I5(ena_i_4_n_0),
        .O(\dout[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \dout[15]_i_2 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(pal_dr[15]),
        .I4(rs[1]),
        .O(\dout[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFFFFBABF)) 
    \dout[15]_i_3 
       (.I0(rs[3]),
        .I1(base[15]),
        .I2(rs[1]),
        .I3(base[31]),
        .I4(rs[2]),
        .O(\dout[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hABAAABABABAAAAAA)) 
    \dout[1]_i_1 
       (.I0(\dout[1]_i_2_n_0 ),
        .I1(ena_i_3_n_0),
        .I2(ena_i_4_n_0),
        .I3(\dout[1]_i_3_n_0 ),
        .I4(rs[3]),
        .I5(\dout[1]_i_4_n_0 ),
        .O(\dout[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000E20000000000)) 
    \dout[1]_i_2 
       (.I0(pal_dr[17]),
        .I1(rs[1]),
        .I2(pal_dr[1]),
        .I3(rs[10]),
        .I4(rs[11]),
        .I5(aen),
        .O(\dout[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[1]_i_3 
       (.I0(stride[1]),
        .I1(rs[2]),
        .I2(vsize[1]),
        .I3(rs[1]),
        .I4(hsize[1]),
        .O(\dout[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[1]_i_4 
       (.I0(format[1]),
        .I1(rs[2]),
        .I2(base[1]),
        .I3(rs[1]),
        .I4(base[17]),
        .O(\dout[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hABAAABABABAAAAAA)) 
    \dout[2]_i_1 
       (.I0(\dout[2]_i_2_n_0 ),
        .I1(ena_i_3_n_0),
        .I2(ena_i_4_n_0),
        .I3(\dout[2]_i_3_n_0 ),
        .I4(rs[3]),
        .I5(\dout[2]_i_4_n_0 ),
        .O(\dout[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000E20000000000)) 
    \dout[2]_i_2 
       (.I0(pal_dr[18]),
        .I1(rs[1]),
        .I2(pal_dr[2]),
        .I3(rs[10]),
        .I4(rs[11]),
        .I5(aen),
        .O(\dout[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[2]_i_3 
       (.I0(stride[2]),
        .I1(rs[2]),
        .I2(vsize[2]),
        .I3(rs[1]),
        .I4(hsize[2]),
        .O(\dout[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[2]_i_4 
       (.I0(format[2]),
        .I1(rs[2]),
        .I2(base[2]),
        .I3(rs[1]),
        .I4(base[18]),
        .O(\dout[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hABAAABABABAAAAAA)) 
    \dout[3]_i_1 
       (.I0(\dout[3]_i_2_n_0 ),
        .I1(ena_i_3_n_0),
        .I2(ena_i_4_n_0),
        .I3(\dout[3]_i_3_n_0 ),
        .I4(rs[3]),
        .I5(\dout[3]_i_4_n_0 ),
        .O(\dout[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000E20000000000)) 
    \dout[3]_i_2 
       (.I0(pal_dr[19]),
        .I1(rs[1]),
        .I2(pal_dr[3]),
        .I3(rs[10]),
        .I4(rs[11]),
        .I5(aen),
        .O(\dout[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[3]_i_3 
       (.I0(stride[3]),
        .I1(rs[2]),
        .I2(vsize[3]),
        .I3(rs[1]),
        .I4(hsize[3]),
        .O(\dout[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[3]_i_4 
       (.I0(format[3]),
        .I1(rs[2]),
        .I2(base[3]),
        .I3(rs[1]),
        .I4(base[19]),
        .O(\dout[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hABAAABABABAAAAAA)) 
    \dout[4]_i_1 
       (.I0(\dout[4]_i_2_n_0 ),
        .I1(ena_i_3_n_0),
        .I2(ena_i_4_n_0),
        .I3(\dout[4]_i_3_n_0 ),
        .I4(rs[3]),
        .I5(\dout[4]_i_4_n_0 ),
        .O(\dout[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000E20000000000)) 
    \dout[4]_i_2 
       (.I0(pal_dr[20]),
        .I1(rs[1]),
        .I2(pal_dr[4]),
        .I3(rs[10]),
        .I4(rs[11]),
        .I5(aen),
        .O(\dout[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[4]_i_3 
       (.I0(stride[4]),
        .I1(rs[2]),
        .I2(vsize[4]),
        .I3(rs[1]),
        .I4(hsize[4]),
        .O(\dout[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[4]_i_4 
       (.I0(format[4]),
        .I1(rs[2]),
        .I2(base[4]),
        .I3(rs[1]),
        .I4(base[20]),
        .O(\dout[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hABAAABABABAAAAAA)) 
    \dout[5]_i_1 
       (.I0(\dout[5]_i_2_n_0 ),
        .I1(ena_i_3_n_0),
        .I2(ena_i_4_n_0),
        .I3(\dout[5]_i_3_n_0 ),
        .I4(rs[3]),
        .I5(\dout[5]_i_4_n_0 ),
        .O(\dout[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000E20000000000)) 
    \dout[5]_i_2 
       (.I0(pal_dr[21]),
        .I1(rs[1]),
        .I2(pal_dr[5]),
        .I3(rs[10]),
        .I4(rs[11]),
        .I5(aen),
        .O(\dout[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[5]_i_3 
       (.I0(stride[5]),
        .I1(rs[2]),
        .I2(vsize[5]),
        .I3(rs[1]),
        .I4(hsize[5]),
        .O(\dout[5]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \dout[5]_i_4 
       (.I0(base[21]),
        .I1(rs[1]),
        .I2(base[5]),
        .I3(rs[2]),
        .O(\dout[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hABAAABABABAAAAAA)) 
    \dout[6]_i_1 
       (.I0(\dout[6]_i_2_n_0 ),
        .I1(ena_i_3_n_0),
        .I2(ena_i_4_n_0),
        .I3(\dout[6]_i_3_n_0 ),
        .I4(rs[3]),
        .I5(\dout[6]_i_4_n_0 ),
        .O(\dout[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000E20000000000)) 
    \dout[6]_i_2 
       (.I0(pal_dr[22]),
        .I1(rs[1]),
        .I2(pal_dr[6]),
        .I3(rs[10]),
        .I4(rs[11]),
        .I5(aen),
        .O(\dout[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[6]_i_3 
       (.I0(stride[6]),
        .I1(rs[2]),
        .I2(vsize[6]),
        .I3(rs[1]),
        .I4(hsize[6]),
        .O(\dout[6]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \dout[6]_i_4 
       (.I0(base[22]),
        .I1(rs[1]),
        .I2(base[6]),
        .I3(rs[2]),
        .O(\dout[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hABAAABABABAAAAAA)) 
    \dout[7]_i_1 
       (.I0(\dout[7]_i_2_n_0 ),
        .I1(ena_i_3_n_0),
        .I2(ena_i_4_n_0),
        .I3(\dout[7]_i_3_n_0 ),
        .I4(rs[3]),
        .I5(\dout[7]_i_4_n_0 ),
        .O(\dout[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000E20000000000)) 
    \dout[7]_i_2 
       (.I0(pal_dr[23]),
        .I1(rs[1]),
        .I2(pal_dr[7]),
        .I3(rs[10]),
        .I4(rs[11]),
        .I5(aen),
        .O(\dout[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[7]_i_3 
       (.I0(stride[7]),
        .I1(rs[2]),
        .I2(vsize[7]),
        .I3(rs[1]),
        .I4(hsize[7]),
        .O(\dout[7]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \dout[7]_i_4 
       (.I0(base[23]),
        .I1(rs[1]),
        .I2(base[7]),
        .I3(rs[2]),
        .O(\dout[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF10111000)) 
    \dout[8]_i_1 
       (.I0(ena_i_3_n_0),
        .I1(ena_i_4_n_0),
        .I2(\dout[8]_i_2_n_0 ),
        .I3(rs[3]),
        .I4(\dout[8]_i_3_n_0 ),
        .I5(\dout[8]_i_4_n_0 ),
        .O(\dout[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[8]_i_2 
       (.I0(stride[8]),
        .I1(rs[2]),
        .I2(vsize[8]),
        .I3(rs[1]),
        .I4(hsize[8]),
        .O(\dout[8]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \dout[8]_i_3 
       (.I0(base[24]),
        .I1(rs[1]),
        .I2(base[8]),
        .I3(rs[2]),
        .O(\dout[8]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \dout[8]_i_4 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(pal_dr[8]),
        .I4(rs[1]),
        .O(\dout[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF10111000)) 
    \dout[9]_i_1 
       (.I0(ena_i_3_n_0),
        .I1(ena_i_4_n_0),
        .I2(\dout[9]_i_2_n_0 ),
        .I3(rs[3]),
        .I4(\dout[9]_i_3_n_0 ),
        .I5(\dout[9]_i_4_n_0 ),
        .O(\dout[9]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \dout[9]_i_2 
       (.I0(stride[9]),
        .I1(rs[2]),
        .I2(vsize[9]),
        .I3(rs[1]),
        .I4(hsize[9]),
        .O(\dout[9]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \dout[9]_i_3 
       (.I0(base[25]),
        .I1(rs[1]),
        .I2(base[9]),
        .I3(rs[2]),
        .O(\dout[9]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \dout[9]_i_4 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(pal_dr[9]),
        .I4(rs[1]),
        .O(\dout[9]_i_4_n_0 ));
  FDRE \dout_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[0]_i_1_n_0 ),
        .Q(dout[0]),
        .R(1'b0));
  FDRE \dout_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[10]_i_1_n_0 ),
        .Q(dout[10]),
        .R(1'b0));
  FDRE \dout_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[11]_i_1_n_0 ),
        .Q(dout[11]),
        .R(1'b0));
  FDRE \dout_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[12]_i_1_n_0 ),
        .Q(dout[12]),
        .R(1'b0));
  FDRE \dout_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[13]_i_1_n_0 ),
        .Q(dout[13]),
        .R(1'b0));
  FDRE \dout_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[14]_i_1_n_0 ),
        .Q(dout[14]),
        .R(1'b0));
  FDRE \dout_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[15]_i_1_n_0 ),
        .Q(dout[15]),
        .R(1'b0));
  FDRE \dout_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[1]_i_1_n_0 ),
        .Q(dout[1]),
        .R(1'b0));
  FDRE \dout_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[2]_i_1_n_0 ),
        .Q(dout[2]),
        .R(1'b0));
  FDRE \dout_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[3]_i_1_n_0 ),
        .Q(dout[3]),
        .R(1'b0));
  FDRE \dout_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[4]_i_1_n_0 ),
        .Q(dout[4]),
        .R(1'b0));
  FDRE \dout_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[5]_i_1_n_0 ),
        .Q(dout[5]),
        .R(1'b0));
  FDRE \dout_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[6]_i_1_n_0 ),
        .Q(dout[6]),
        .R(1'b0));
  FDRE \dout_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[7]_i_1_n_0 ),
        .Q(dout[7]),
        .R(1'b0));
  FDRE \dout_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[8]_i_1_n_0 ),
        .Q(dout[8]),
        .R(1'b0));
  FDRE \dout_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(\dout[9]_i_1_n_0 ),
        .Q(dout[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h00000000AAABAAA8)) 
    ena_i_1
       (.I0(ena),
        .I1(ena_i_2_n_0),
        .I2(ena_i_3_n_0),
        .I3(ena_i_4_n_0),
        .I4(data_in[0]),
        .I5(reset),
        .O(ena_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hF7FF)) 
    ena_i_2
       (.I0(rs[1]),
        .I1(rs[2]),
        .I2(rs[3]),
        .I3(wr),
        .O(ena_i_2_n_0));
  LUT3 #(
    .INIT(8'hFB)) 
    ena_i_3
       (.I0(rs[10]),
        .I1(rs[8]),
        .I2(rs[9]),
        .O(ena_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFD)) 
    ena_i_4
       (.I0(aen),
        .I1(rs[11]),
        .I2(rs[4]),
        .I3(rs[5]),
        .I4(rs[6]),
        .I5(rs[7]),
        .O(ena_i_4_n_0));
  FDRE ena_reg
       (.C(clk),
        .CE(1'b1),
        .D(ena_i_1_n_0),
        .Q(ena),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \format[4]_i_1 
       (.I0(rs[9]),
        .I1(rs[8]),
        .I2(rs[10]),
        .I3(ena_i_4_n_0),
        .I4(\vsize[11]_i_2_n_0 ),
        .I5(\format[4]_i_2_n_0 ),
        .O(\format[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \format[4]_i_2 
       (.I0(rs[3]),
        .I1(rs[2]),
        .I2(rs[1]),
        .O(\format[4]_i_2_n_0 ));
  FDRE \format_reg[0] 
       (.C(clk),
        .CE(\format[4]_i_1_n_0 ),
        .D(data_in[0]),
        .Q(format[0]),
        .R(1'b0));
  FDRE \format_reg[1] 
       (.C(clk),
        .CE(\format[4]_i_1_n_0 ),
        .D(data_in[1]),
        .Q(format[1]),
        .R(1'b0));
  FDRE \format_reg[2] 
       (.C(clk),
        .CE(\format[4]_i_1_n_0 ),
        .D(data_in[2]),
        .Q(format[2]),
        .R(1'b0));
  FDRE \format_reg[3] 
       (.C(clk),
        .CE(\format[4]_i_1_n_0 ),
        .D(data_in[3]),
        .Q(format[3]),
        .R(1'b0));
  FDRE \format_reg[4] 
       (.C(clk),
        .CE(\format[4]_i_1_n_0 ),
        .D(data_in[4]),
        .Q(format[4]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0010000000000000)) 
    \hsize[11]_i_1 
       (.I0(ena_i_4_n_0),
        .I1(rs[10]),
        .I2(rs[8]),
        .I3(rs[9]),
        .I4(\hsize[11]_i_2_n_0 ),
        .I5(rs[3]),
        .O(\hsize[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0010)) 
    \hsize[11]_i_2 
       (.I0(rs[2]),
        .I1(reset),
        .I2(wr),
        .I3(rs[1]),
        .O(\hsize[11]_i_2_n_0 ));
  FDRE \hsize_reg[0] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[0]),
        .Q(hsize[0]),
        .R(1'b0));
  FDRE \hsize_reg[10] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[10]),
        .Q(hsize[10]),
        .R(1'b0));
  FDRE \hsize_reg[11] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[11]),
        .Q(hsize[11]),
        .R(1'b0));
  FDRE \hsize_reg[1] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[1]),
        .Q(hsize[1]),
        .R(1'b0));
  FDRE \hsize_reg[2] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[2]),
        .Q(hsize[2]),
        .R(1'b0));
  FDRE \hsize_reg[3] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[3]),
        .Q(hsize[3]),
        .R(1'b0));
  FDRE \hsize_reg[4] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[4]),
        .Q(hsize[4]),
        .R(1'b0));
  FDRE \hsize_reg[5] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[5]),
        .Q(hsize[5]),
        .R(1'b0));
  FDRE \hsize_reg[6] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[6]),
        .Q(hsize[6]),
        .R(1'b0));
  FDRE \hsize_reg[7] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[7]),
        .Q(hsize[7]),
        .R(1'b0));
  FDRE \hsize_reg[8] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[8]),
        .Q(hsize[8]),
        .R(1'b0));
  FDRE \hsize_reg[9] 
       (.C(clk),
        .CE(\hsize[11]_i_1_n_0 ),
        .D(data_in[9]),
        .Q(hsize[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[0]_INST_0 
       (.I0(data_in[0]),
        .I1(rs[1]),
        .I2(rpal[0]),
        .O(pal_dw[0]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[10]_INST_0 
       (.I0(data_in[10]),
        .I1(rs[1]),
        .I2(rpal[10]),
        .O(pal_dw[10]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[11]_INST_0 
       (.I0(data_in[11]),
        .I1(rs[1]),
        .I2(rpal[11]),
        .O(pal_dw[11]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[12]_INST_0 
       (.I0(data_in[12]),
        .I1(rs[1]),
        .I2(rpal[12]),
        .O(pal_dw[12]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[13]_INST_0 
       (.I0(data_in[13]),
        .I1(rs[1]),
        .I2(rpal[13]),
        .O(pal_dw[13]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[14]_INST_0 
       (.I0(data_in[14]),
        .I1(rs[1]),
        .I2(rpal[14]),
        .O(pal_dw[14]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[15]_INST_0 
       (.I0(data_in[15]),
        .I1(rs[1]),
        .I2(rpal[15]),
        .O(pal_dw[15]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[16]_INST_0 
       (.I0(rpal[16]),
        .I1(rs[1]),
        .I2(data_in[0]),
        .O(pal_dw[16]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[17]_INST_0 
       (.I0(rpal[17]),
        .I1(rs[1]),
        .I2(data_in[1]),
        .O(pal_dw[17]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[18]_INST_0 
       (.I0(rpal[18]),
        .I1(rs[1]),
        .I2(data_in[2]),
        .O(pal_dw[18]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[19]_INST_0 
       (.I0(rpal[19]),
        .I1(rs[1]),
        .I2(data_in[3]),
        .O(pal_dw[19]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[1]_INST_0 
       (.I0(data_in[1]),
        .I1(rs[1]),
        .I2(rpal[1]),
        .O(pal_dw[1]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[20]_INST_0 
       (.I0(rpal[20]),
        .I1(rs[1]),
        .I2(data_in[4]),
        .O(pal_dw[20]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[21]_INST_0 
       (.I0(rpal[21]),
        .I1(rs[1]),
        .I2(data_in[5]),
        .O(pal_dw[21]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[22]_INST_0 
       (.I0(rpal[22]),
        .I1(rs[1]),
        .I2(data_in[6]),
        .O(pal_dw[22]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[23]_INST_0 
       (.I0(rpal[23]),
        .I1(rs[1]),
        .I2(data_in[7]),
        .O(pal_dw[23]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[2]_INST_0 
       (.I0(data_in[2]),
        .I1(rs[1]),
        .I2(rpal[2]),
        .O(pal_dw[2]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[3]_INST_0 
       (.I0(data_in[3]),
        .I1(rs[1]),
        .I2(rpal[3]),
        .O(pal_dw[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[4]_INST_0 
       (.I0(data_in[4]),
        .I1(rs[1]),
        .I2(rpal[4]),
        .O(pal_dw[4]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[5]_INST_0 
       (.I0(data_in[5]),
        .I1(rs[1]),
        .I2(rpal[5]),
        .O(pal_dw[5]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[6]_INST_0 
       (.I0(data_in[6]),
        .I1(rs[1]),
        .I2(rpal[6]),
        .O(pal_dw[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[7]_INST_0 
       (.I0(data_in[7]),
        .I1(rs[1]),
        .I2(rpal[7]),
        .O(pal_dw[7]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[8]_INST_0 
       (.I0(data_in[8]),
        .I1(rs[1]),
        .I2(rpal[8]),
        .O(pal_dw[8]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pal_dw[9]_INST_0 
       (.I0(data_in[9]),
        .I1(rs[1]),
        .I2(rpal[9]),
        .O(pal_dw[9]));
  LUT6 #(
    .INIT(64'h00200000AA2A0000)) 
    \rd_r[0]_i_1 
       (.I0(rd),
        .I1(rd_r[2]),
        .I2(rs[10]),
        .I3(rs[11]),
        .I4(aen),
        .I5(rd_r[0]),
        .O(\rd_r[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04000000)) 
    \rd_r[1]_i_1 
       (.I0(rd_r[2]),
        .I1(rs[10]),
        .I2(rs[11]),
        .I3(aen),
        .I4(rd_r[0]),
        .O(\rd_r[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00200000AA2AAAAA)) 
    \rd_r[2]_i_1 
       (.I0(rd_r[1]),
        .I1(rd_r[2]),
        .I2(rs[10]),
        .I3(rs[11]),
        .I4(aen),
        .I5(rd_r[0]),
        .O(\rd_r[2]_i_1_n_0 ));
  FDRE \rd_r_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\rd_r[0]_i_1_n_0 ),
        .Q(rd_r[0]),
        .R(1'b0));
  FDRE \rd_r_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\rd_r[1]_i_1_n_0 ),
        .Q(rd_r[1]),
        .R(1'b0));
  FDRE \rd_r_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\rd_r[2]_i_1_n_0 ),
        .Q(rd_r[2]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hCCCCCCCC8C888088)) 
    ready_INST_0
       (.I0(rd_r[0]),
        .I1(aen),
        .I2(rs[11]),
        .I3(rs[10]),
        .I4(rd_r[2]),
        .I5(wr),
        .O(ready));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \rpal[15]_i_1 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(rs[1]),
        .I4(reset),
        .I5(wr),
        .O(\rpal[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000200000)) 
    \rpal[23]_i_1 
       (.I0(rs[10]),
        .I1(rs[11]),
        .I2(aen),
        .I3(reset),
        .I4(wr),
        .I5(rs[1]),
        .O(\rpal[23]_i_1_n_0 ));
  FDRE \rpal_reg[0] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[0]),
        .Q(rpal[0]),
        .R(1'b0));
  FDRE \rpal_reg[10] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[10]),
        .Q(rpal[10]),
        .R(1'b0));
  FDRE \rpal_reg[11] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[11]),
        .Q(rpal[11]),
        .R(1'b0));
  FDRE \rpal_reg[12] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[12]),
        .Q(rpal[12]),
        .R(1'b0));
  FDRE \rpal_reg[13] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[13]),
        .Q(rpal[13]),
        .R(1'b0));
  FDRE \rpal_reg[14] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[14]),
        .Q(rpal[14]),
        .R(1'b0));
  FDRE \rpal_reg[15] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[15]),
        .Q(rpal[15]),
        .R(1'b0));
  FDRE \rpal_reg[16] 
       (.C(clk),
        .CE(\rpal[23]_i_1_n_0 ),
        .D(data_in[0]),
        .Q(rpal[16]),
        .R(1'b0));
  FDRE \rpal_reg[17] 
       (.C(clk),
        .CE(\rpal[23]_i_1_n_0 ),
        .D(data_in[1]),
        .Q(rpal[17]),
        .R(1'b0));
  FDRE \rpal_reg[18] 
       (.C(clk),
        .CE(\rpal[23]_i_1_n_0 ),
        .D(data_in[2]),
        .Q(rpal[18]),
        .R(1'b0));
  FDRE \rpal_reg[19] 
       (.C(clk),
        .CE(\rpal[23]_i_1_n_0 ),
        .D(data_in[3]),
        .Q(rpal[19]),
        .R(1'b0));
  FDRE \rpal_reg[1] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[1]),
        .Q(rpal[1]),
        .R(1'b0));
  FDRE \rpal_reg[20] 
       (.C(clk),
        .CE(\rpal[23]_i_1_n_0 ),
        .D(data_in[4]),
        .Q(rpal[20]),
        .R(1'b0));
  FDRE \rpal_reg[21] 
       (.C(clk),
        .CE(\rpal[23]_i_1_n_0 ),
        .D(data_in[5]),
        .Q(rpal[21]),
        .R(1'b0));
  FDRE \rpal_reg[22] 
       (.C(clk),
        .CE(\rpal[23]_i_1_n_0 ),
        .D(data_in[6]),
        .Q(rpal[22]),
        .R(1'b0));
  FDRE \rpal_reg[23] 
       (.C(clk),
        .CE(\rpal[23]_i_1_n_0 ),
        .D(data_in[7]),
        .Q(rpal[23]),
        .R(1'b0));
  FDRE \rpal_reg[2] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[2]),
        .Q(rpal[2]),
        .R(1'b0));
  FDRE \rpal_reg[3] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[3]),
        .Q(rpal[3]),
        .R(1'b0));
  FDRE \rpal_reg[4] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[4]),
        .Q(rpal[4]),
        .R(1'b0));
  FDRE \rpal_reg[5] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[5]),
        .Q(rpal[5]),
        .R(1'b0));
  FDRE \rpal_reg[6] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[6]),
        .Q(rpal[6]),
        .R(1'b0));
  FDRE \rpal_reg[7] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[7]),
        .Q(rpal[7]),
        .R(1'b0));
  FDRE \rpal_reg[8] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[8]),
        .Q(rpal[8]),
        .R(1'b0));
  FDRE \rpal_reg[9] 
       (.C(clk),
        .CE(\rpal[15]_i_1_n_0 ),
        .D(data_in[9]),
        .Q(rpal[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \stride[13]_i_1 
       (.I0(rs[9]),
        .I1(rs[8]),
        .I2(rs[10]),
        .I3(ena_i_4_n_0),
        .I4(\vsize[11]_i_2_n_0 ),
        .I5(\stride[13]_i_2_n_0 ),
        .O(\stride[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \stride[13]_i_2 
       (.I0(rs[2]),
        .I1(rs[1]),
        .I2(rs[3]),
        .O(\stride[13]_i_2_n_0 ));
  FDRE \stride_reg[0] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[0]),
        .Q(stride[0]),
        .R(1'b0));
  FDRE \stride_reg[10] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[10]),
        .Q(stride[10]),
        .R(1'b0));
  FDRE \stride_reg[11] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[11]),
        .Q(stride[11]),
        .R(1'b0));
  FDRE \stride_reg[12] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[12]),
        .Q(stride[12]),
        .R(1'b0));
  FDRE \stride_reg[13] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[13]),
        .Q(stride[13]),
        .R(1'b0));
  FDRE \stride_reg[1] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[1]),
        .Q(stride[1]),
        .R(1'b0));
  FDRE \stride_reg[2] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[2]),
        .Q(stride[2]),
        .R(1'b0));
  FDRE \stride_reg[3] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[3]),
        .Q(stride[3]),
        .R(1'b0));
  FDRE \stride_reg[4] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[4]),
        .Q(stride[4]),
        .R(1'b0));
  FDRE \stride_reg[5] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[5]),
        .Q(stride[5]),
        .R(1'b0));
  FDRE \stride_reg[6] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[6]),
        .Q(stride[6]),
        .R(1'b0));
  FDRE \stride_reg[7] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[7]),
        .Q(stride[7]),
        .R(1'b0));
  FDRE \stride_reg[8] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[8]),
        .Q(stride[8]),
        .R(1'b0));
  FDRE \stride_reg[9] 
       (.C(clk),
        .CE(\stride[13]_i_1_n_0 ),
        .D(data_in[9]),
        .Q(stride[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000001000000)) 
    \vsize[11]_i_1 
       (.I0(\vsize[11]_i_2_n_0 ),
        .I1(ena_i_4_n_0),
        .I2(ena_i_3_n_0),
        .I3(rs[1]),
        .I4(rs[3]),
        .I5(rs[2]),
        .O(\vsize[11]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \vsize[11]_i_2 
       (.I0(reset),
        .I1(wr),
        .O(\vsize[11]_i_2_n_0 ));
  FDRE \vsize_reg[0] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[0]),
        .Q(vsize[0]),
        .R(1'b0));
  FDRE \vsize_reg[10] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[10]),
        .Q(vsize[10]),
        .R(1'b0));
  FDRE \vsize_reg[11] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[11]),
        .Q(vsize[11]),
        .R(1'b0));
  FDRE \vsize_reg[1] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[1]),
        .Q(vsize[1]),
        .R(1'b0));
  FDRE \vsize_reg[2] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[2]),
        .Q(vsize[2]),
        .R(1'b0));
  FDRE \vsize_reg[3] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[3]),
        .Q(vsize[3]),
        .R(1'b0));
  FDRE \vsize_reg[4] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[4]),
        .Q(vsize[4]),
        .R(1'b0));
  FDRE \vsize_reg[5] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[5]),
        .Q(vsize[5]),
        .R(1'b0));
  FDRE \vsize_reg[6] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[6]),
        .Q(vsize[6]),
        .R(1'b0));
  FDRE \vsize_reg[7] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[7]),
        .Q(vsize[7]),
        .R(1'b0));
  FDRE \vsize_reg[8] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[8]),
        .Q(vsize[8]),
        .R(1'b0));
  FDRE \vsize_reg[9] 
       (.C(clk),
        .CE(\vsize[11]_i_1_n_0 ),
        .D(data_in[9]),
        .Q(vsize[9]),
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
