// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Feb 22 14:34:40 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_amiga_clk_0_0/Mega65_R6_amiga_clk_0_0_sim_netlist.v
// Design      : Mega65_R6_amiga_clk_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Mega65_R6_amiga_clk_0_0,amiga_clk,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "amiga_clk,Vivado 2024.2.1" *) 
(* NotValidForBitStream *)
module Mega65_R6_amiga_clk_0_0
   (clk_28,
    clk7_en,
    clk7n_en,
    c1,
    c3,
    cck,
    eclk,
    reset_n);
  input clk_28;
  output clk7_en;
  output clk7n_en;
  output c1;
  output c3;
  output cck;
  output [9:0]eclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 reset_n RST" *) (* x_interface_mode = "slave reset_n" *) (* x_interface_parameter = "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input reset_n;

  wire c1;
  wire c3;
  wire cck;
  wire clk7_en;
  wire clk7n_en;
  wire clk_28;
  wire [9:0]eclk;
  wire reset_n;

  Mega65_R6_amiga_clk_0_0_amiga_clk U0
       (.c1(c1),
        .c3(c3),
        .cck(cck),
        .clk7_en(clk7_en),
        .clk7n_en(clk7n_en),
        .clk_28(clk_28),
        .eclk(eclk),
        .reset_n(reset_n));
endmodule

(* ORIG_REF_NAME = "amiga_clk" *) 
module Mega65_R6_amiga_clk_0_0_amiga_clk
   (clk7_en,
    clk7n_en,
    c3,
    c1,
    cck,
    eclk,
    clk_28,
    reset_n);
  output clk7_en;
  output clk7n_en;
  output c3;
  output c1;
  output cck;
  output [9:0]eclk;
  input clk_28;
  input reset_n;

  wire c1;
  wire c1_i_1_n_0;
  wire c3;
  wire cck;
  wire cck_i_2_n_0;
  wire \clk7_cnt_reg_n_0_[0] ;
  wire clk7_en;
  wire clk7_en_reg_i_1_n_0;
  wire clk7_en_reg_i_2_n_0;
  wire clk7n_en;
  wire clk7n_en_reg_i_1_n_0;
  wire clk_28;
  wire clk_7;
  wire [9:0]eclk;
  wire [1:0]p_0_in;
  wire reset_n;
  wire shifter;
  wire \shifter[0]_i_1_n_0 ;
  wire \shifter[0]_i_2_n_0 ;

  LUT1 #(
    .INIT(2'h1)) 
    c1_i_1
       (.I0(c3),
        .O(c1_i_1_n_0));
  FDRE c1_reg
       (.C(clk_28),
        .CE(1'b1),
        .D(c1_i_1_n_0),
        .Q(c1),
        .R(1'b0));
  FDRE c3_reg
       (.C(clk_28),
        .CE(1'b1),
        .D(clk_7),
        .Q(c3),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    cck_i_1
       (.I0(\clk7_cnt_reg_n_0_[0] ),
        .I1(clk_7),
        .O(shifter));
  LUT1 #(
    .INIT(2'h1)) 
    cck_i_2
       (.I0(cck),
        .O(cck_i_2_n_0));
  FDPE cck_reg
       (.C(clk_28),
        .CE(shifter),
        .D(cck_i_2_n_0),
        .PRE(clk7_en_reg_i_2_n_0),
        .Q(cck));
  LUT1 #(
    .INIT(2'h1)) 
    \clk7_cnt[0]_i_1 
       (.I0(\clk7_cnt_reg_n_0_[0] ),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \clk7_cnt[1]_i_1 
       (.I0(\clk7_cnt_reg_n_0_[0] ),
        .I1(clk_7),
        .O(p_0_in[1]));
  FDCE #(
    .INIT(1'b0)) 
    \clk7_cnt_reg[0] 
       (.C(clk_28),
        .CE(1'b1),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(p_0_in[0]),
        .Q(\clk7_cnt_reg_n_0_[0] ));
  FDPE #(
    .INIT(1'b1)) 
    \clk7_cnt_reg[1] 
       (.C(clk_28),
        .CE(1'b1),
        .D(p_0_in[1]),
        .PRE(clk7_en_reg_i_2_n_0),
        .Q(clk_7));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h1)) 
    clk7_en_reg_i_1
       (.I0(clk_7),
        .I1(\clk7_cnt_reg_n_0_[0] ),
        .O(clk7_en_reg_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    clk7_en_reg_i_2
       (.I0(reset_n),
        .O(clk7_en_reg_i_2_n_0));
  FDPE #(
    .INIT(1'b1)) 
    clk7_en_reg_reg
       (.C(clk_28),
        .CE(1'b1),
        .D(clk7_en_reg_i_1_n_0),
        .PRE(clk7_en_reg_i_2_n_0),
        .Q(clk7_en));
  LUT2 #(
    .INIT(4'h2)) 
    clk7n_en_reg_i_1
       (.I0(clk_7),
        .I1(\clk7_cnt_reg_n_0_[0] ),
        .O(clk7n_en_reg_i_1_n_0));
  FDPE #(
    .INIT(1'b1)) 
    clk7n_en_reg_reg
       (.C(clk_28),
        .CE(1'b1),
        .D(clk7n_en_reg_i_1_n_0),
        .PRE(clk7_en_reg_i_2_n_0),
        .Q(clk7n_en));
  LUT5 #(
    .INIT(32'hFFFF0010)) 
    \shifter[0]_i_1 
       (.I0(eclk[8]),
        .I1(eclk[6]),
        .I2(\shifter[0]_i_2_n_0 ),
        .I3(eclk[7]),
        .I4(eclk[9]),
        .O(\shifter[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \shifter[0]_i_2 
       (.I0(eclk[4]),
        .I1(eclk[3]),
        .I2(eclk[1]),
        .I3(eclk[0]),
        .I4(eclk[2]),
        .I5(eclk[5]),
        .O(\shifter[0]_i_2_n_0 ));
  FDPE \shifter_reg[0] 
       (.C(clk_28),
        .CE(shifter),
        .D(\shifter[0]_i_1_n_0 ),
        .PRE(clk7_en_reg_i_2_n_0),
        .Q(eclk[0]));
  FDCE \shifter_reg[1] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[0]),
        .Q(eclk[1]));
  FDCE \shifter_reg[2] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[1]),
        .Q(eclk[2]));
  FDCE \shifter_reg[3] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[2]),
        .Q(eclk[3]));
  FDCE \shifter_reg[4] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[3]),
        .Q(eclk[4]));
  FDCE \shifter_reg[5] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[4]),
        .Q(eclk[5]));
  FDCE \shifter_reg[6] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[5]),
        .Q(eclk[6]));
  FDCE \shifter_reg[7] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[6]),
        .Q(eclk[7]));
  FDCE \shifter_reg[8] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[7]),
        .Q(eclk[8]));
  FDCE \shifter_reg[9] 
       (.C(clk_28),
        .CE(shifter),
        .CLR(clk7_en_reg_i_2_n_0),
        .D(eclk[8]),
        .Q(eclk[9]));
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
