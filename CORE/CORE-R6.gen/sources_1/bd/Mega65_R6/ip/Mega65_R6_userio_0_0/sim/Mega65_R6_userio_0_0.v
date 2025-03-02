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


// IP VLNV: xilinx.com:module_ref:userio:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_userio_0_0 (
  clk,
  reset,
  clk7_en,
  reg_address_in,
  data_in,
  data_out,
  pot_cnt_en,
  _fire0,
  _fire1,
  _fire0_dat,
  _fire1_dat,
  _joy1,
  _joy2,
  joy_ana1,
  joy_ana2,
  mouse_btn,
  kms_level,
  kbd_mouse_type,
  kbd_mouse_data,
  aud_mix,
  IO_ENA,
  IO_STROBE,
  IO_WAIT,
  IO_DIN,
  memory_config,
  chipset_config,
  floppy_config,
  scanline,
  ar,
  blver,
  ide_config,
  cpu_config,
  cache_config,
  bootrom,
  usrrst,
  cpurst,
  cpuhlt,
  host_cs,
  host_adr,
  host_we,
  host_bs,
  host_wdat,
  host_rdat,
  host_ack
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire reset;
input wire clk7_en;
input wire [8 : 1] reg_address_in;
input wire [15 : 0] data_in;
output wire [15 : 0] data_out;
input wire pot_cnt_en;
output wire _fire0;
output wire _fire1;
input wire _fire0_dat;
input wire _fire1_dat;
input wire [15 : 0] _joy1;
input wire [15 : 0] _joy2;
input wire [15 : 0] joy_ana1;
input wire [15 : 0] joy_ana2;
input wire [2 : 0] mouse_btn;
input wire kms_level;
input wire [1 : 0] kbd_mouse_type;
input wire [7 : 0] kbd_mouse_data;
output wire [1 : 0] aud_mix;
input wire IO_ENA;
input wire IO_STROBE;
output wire IO_WAIT;
input wire [15 : 0] IO_DIN;
output wire [7 : 0] memory_config;
output wire [4 : 0] chipset_config;
output wire [3 : 0] floppy_config;
output wire [2 : 0] scanline;
output wire [1 : 0] ar;
output wire [1 : 0] blver;
output wire [5 : 0] ide_config;
output wire [1 : 0] cpu_config;
output wire [2 : 0] cache_config;
output wire bootrom;
output wire usrrst;
output wire cpurst;
output wire cpuhlt;
output wire host_cs;
output wire [23 : 0] host_adr;
output wire host_we;
output wire [1 : 0] host_bs;
output wire [15 : 0] host_wdat;
input wire [15 : 0] host_rdat;
input wire host_ack;

  userio #(
    .JOY0DAT(9'B000001010),
    .JOY1DAT(9'B000001100),
    .SCRDAT(9'B111110000),
    .POT0DAT(9'B000010010),
    .POT1DAT(9'B000010100),
    .POTINP(9'B000010110),
    .POTGO(9'B000110100),
    .JOYTEST(9'B000110110),
    .KEY_MENU(8'B01101001),
    .KEY_ESC(8'B01000101),
    .KEY_ENTER(8'B01000100),
    .KEY_UP(8'B01001100),
    .KEY_DOWN(8'B01001101),
    .KEY_LEFT(8'B01001111),
    .KEY_RIGHT(8'B01001110),
    .KEY_PGUP(8'B01101100),
    .KEY_PGDOWN(8'B01101101)
  ) inst (
    .clk(clk),
    .reset(reset),
    .clk7_en(clk7_en),
    .reg_address_in(reg_address_in),
    .data_in(data_in),
    .data_out(data_out),
    .pot_cnt_en(pot_cnt_en),
    ._fire0(_fire0),
    ._fire1(_fire1),
    ._fire0_dat(_fire0_dat),
    ._fire1_dat(_fire1_dat),
    ._joy1(_joy1),
    ._joy2(_joy2),
    .joy_ana1(joy_ana1),
    .joy_ana2(joy_ana2),
    .mouse_btn(mouse_btn),
    .kms_level(kms_level),
    .kbd_mouse_type(kbd_mouse_type),
    .kbd_mouse_data(kbd_mouse_data),
    .aud_mix(aud_mix),
    .IO_ENA(IO_ENA),
    .IO_STROBE(IO_STROBE),
    .IO_WAIT(IO_WAIT),
    .IO_DIN(IO_DIN),
    .memory_config(memory_config),
    .chipset_config(chipset_config),
    .floppy_config(floppy_config),
    .scanline(scanline),
    .ar(ar),
    .blver(blver),
    .ide_config(ide_config),
    .cpu_config(cpu_config),
    .cache_config(cache_config),
    .bootrom(bootrom),
    .usrrst(usrrst),
    .cpurst(cpurst),
    .cpuhlt(cpuhlt),
    .host_cs(host_cs),
    .host_adr(host_adr),
    .host_we(host_we),
    .host_bs(host_bs),
    .host_wdat(host_wdat),
    .host_rdat(host_rdat),
    .host_ack(host_ack)
  );
endmodule
