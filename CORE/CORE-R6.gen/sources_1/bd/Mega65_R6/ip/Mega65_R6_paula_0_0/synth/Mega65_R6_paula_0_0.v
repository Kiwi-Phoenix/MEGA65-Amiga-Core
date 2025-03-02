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


// IP VLNV: xilinx.com:module_ref:paula:1.0
// IP Revision: 1

(* X_CORE_INFO = "paula,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_paula_0_0,paula,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_paula_0_0,paula,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=paula,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,DMACON=010010110,ADKCON=010011110,ADKCONR=000010000}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_paula_0_0 (
  clk,
  clk7_en,
  clk7n_en,
  cck,
  reset,
  reg_address_in,
  data_in,
  data_out,
  txd,
  rxd,
  ntsc,
  sof,
  strhor,
  vblint,
  int2,
  int3,
  int6,
  _ipl,
  audio_dmal,
  audio_dmas,
  disk_dmal,
  disk_dmas,
  _step,
  direc,
  _sel,
  side,
  _motor,
  _track0,
  _change,
  _ready,
  _wprot,
  index,
  fdd_led,
  IO_ENA,
  IO_STROBE,
  IO_WAIT,
  IO_DIN,
  IO_DOUT,
  ldata,
  rdata,
  ldata_okk,
  rdata_okk,
  floppy_drives,
  trackdisp,
  secdisp,
  floppy_fwr,
  floppy_frd
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire clk;
input wire clk7_en;
input wire clk7n_en;
input wire cck;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire reset;
input wire [8 : 1] reg_address_in;
input wire [15 : 0] data_in;
output wire [15 : 0] data_out;
output wire txd;
input wire rxd;
input wire ntsc;
input wire sof;
input wire strhor;
input wire vblint;
input wire int2;
input wire int3;
input wire int6;
output wire [2 : 0] _ipl;
output wire [3 : 0] audio_dmal;
output wire [3 : 0] audio_dmas;
output wire disk_dmal;
output wire disk_dmas;
input wire _step;
input wire direc;
input wire [3 : 0] _sel;
input wire side;
input wire _motor;
output wire _track0;
output wire _change;
output wire _ready;
output wire _wprot;
output wire index;
output wire fdd_led;
input wire IO_ENA;
input wire IO_STROBE;
output wire IO_WAIT;
input wire [15 : 0] IO_DIN;
output wire [15 : 0] IO_DOUT;
output wire [14 : 0] ldata;
output wire [14 : 0] rdata;
output wire [8 : 0] ldata_okk;
output wire [8 : 0] rdata_okk;
input wire [1 : 0] floppy_drives;
output wire [7 : 0] trackdisp;
output wire [13 : 0] secdisp;
output wire floppy_fwr;
output wire floppy_frd;

  paula #(
    .DMACON(9'B010010110),
    .ADKCON(9'B010011110),
    .ADKCONR(9'B000010000)
  ) inst (
    .clk(clk),
    .clk7_en(clk7_en),
    .clk7n_en(clk7n_en),
    .cck(cck),
    .reset(reset),
    .reg_address_in(reg_address_in),
    .data_in(data_in),
    .data_out(data_out),
    .txd(txd),
    .rxd(rxd),
    .ntsc(ntsc),
    .sof(sof),
    .strhor(strhor),
    .vblint(vblint),
    .int2(int2),
    .int3(int3),
    .int6(int6),
    ._ipl(_ipl),
    .audio_dmal(audio_dmal),
    .audio_dmas(audio_dmas),
    .disk_dmal(disk_dmal),
    .disk_dmas(disk_dmas),
    ._step(_step),
    .direc(direc),
    ._sel(_sel),
    .side(side),
    ._motor(_motor),
    ._track0(_track0),
    ._change(_change),
    ._ready(_ready),
    ._wprot(_wprot),
    .index(index),
    .fdd_led(fdd_led),
    .IO_ENA(IO_ENA),
    .IO_STROBE(IO_STROBE),
    .IO_WAIT(IO_WAIT),
    .IO_DIN(IO_DIN),
    .IO_DOUT(IO_DOUT),
    .ldata(ldata),
    .rdata(rdata),
    .ldata_okk(ldata_okk),
    .rdata_okk(rdata_okk),
    .floppy_drives(floppy_drives),
    .trackdisp(trackdisp),
    .secdisp(secdisp),
    .floppy_fwr(floppy_fwr),
    .floppy_frd(floppy_frd)
  );
endmodule
