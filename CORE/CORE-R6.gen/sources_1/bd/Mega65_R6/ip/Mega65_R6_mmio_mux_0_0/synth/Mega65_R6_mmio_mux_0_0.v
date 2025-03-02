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


// IP VLNV: xilinx.com:module_ref:mmio_mux:1.0
// IP Revision: 1

(* X_CORE_INFO = "mmio_mux,Vivado 2024.2.1" *)
(* CHECK_LICENSE_TYPE = "Mega65_R6_mmio_mux_0_0,mmio_mux,{}" *)
(* CORE_GENERATION_INFO = "Mega65_R6_mmio_mux_0_0,mmio_mux,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=mmio_mux,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,GD_TIL=true,GD_SWITCHES=true,GD_HRAM=false,GD_PORE=true}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Mega65_R6_mmio_mux_0_0 (
  HW_RESET,
  CLK,
  addr,
  data_dir,
  data_valid,
  cpu_halt,
  cpu_igrant_n,
  cpu_wait_for_data,
  rom_enable,
  rom_busy,
  ram_enable,
  ram_busy,
  pore_rom_enable,
  pore_rom_busy,
  switch_reg_enable,
  til_reg0_enable,
  til_reg1_enable,
  kbd_en,
  kbd_we,
  kbd_reg,
  cyc_en,
  cyc_we,
  cyc_reg,
  ins_en,
  ins_we,
  ins_reg,
  uart_en,
  uart_we,
  uart_reg,
  uart_cpu_ws,
  eae_en,
  eae_we,
  eae_reg,
  sd_en,
  sd_we,
  sd_reg,
  tin_en,
  tin_we,
  tin_reg,
  vga_en,
  vga_we,
  vga_reg,
  hram_en,
  hram_we,
  hram_reg,
  hram_cpu_ws,
  reset_pre_pore,
  reset_post_pore
);

(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 HW_RESET RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME HW_RESET, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire HW_RESET;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire CLK;
input wire [15 : 0] addr;
input wire data_dir;
input wire data_valid;
input wire cpu_halt;
input wire cpu_igrant_n;
output wire cpu_wait_for_data;
output wire rom_enable;
input wire rom_busy;
output wire ram_enable;
input wire ram_busy;
output wire pore_rom_enable;
input wire pore_rom_busy;
output wire switch_reg_enable;
output wire til_reg0_enable;
output wire til_reg1_enable;
output wire kbd_en;
output wire kbd_we;
output wire [1 : 0] kbd_reg;
output wire cyc_en;
output wire cyc_we;
output wire [1 : 0] cyc_reg;
output wire ins_en;
output wire ins_we;
output wire [1 : 0] ins_reg;
output wire uart_en;
output wire uart_we;
output wire [1 : 0] uart_reg;
input wire uart_cpu_ws;
output wire eae_en;
output wire eae_we;
output wire [2 : 0] eae_reg;
output wire sd_en;
output wire sd_we;
output wire [2 : 0] sd_reg;
output wire tin_en;
output wire tin_we;
output wire [2 : 0] tin_reg;
output wire vga_en;
output wire vga_we;
output wire [3 : 0] vga_reg;
output wire hram_en;
output wire hram_we;
output wire [3 : 0] hram_reg;
input wire hram_cpu_ws;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_pre_pore RST" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_pre_pore, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
output wire reset_pre_pore;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_post_pore RST" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_post_pore, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
output wire reset_post_pore;

  mmio_mux #(
    .GD_TIL(1'B1),
    .GD_SWITCHES(1'B1),
    .GD_HRAM(1'B0),
    .GD_PORE(1'B1)
  ) inst (
    .HW_RESET(HW_RESET),
    .CLK(CLK),
    .addr(addr),
    .data_dir(data_dir),
    .data_valid(data_valid),
    .cpu_halt(cpu_halt),
    .cpu_igrant_n(cpu_igrant_n),
    .cpu_wait_for_data(cpu_wait_for_data),
    .rom_enable(rom_enable),
    .rom_busy(rom_busy),
    .ram_enable(ram_enable),
    .ram_busy(ram_busy),
    .pore_rom_enable(pore_rom_enable),
    .pore_rom_busy(pore_rom_busy),
    .switch_reg_enable(switch_reg_enable),
    .til_reg0_enable(til_reg0_enable),
    .til_reg1_enable(til_reg1_enable),
    .kbd_en(kbd_en),
    .kbd_we(kbd_we),
    .kbd_reg(kbd_reg),
    .cyc_en(cyc_en),
    .cyc_we(cyc_we),
    .cyc_reg(cyc_reg),
    .ins_en(ins_en),
    .ins_we(ins_we),
    .ins_reg(ins_reg),
    .uart_en(uart_en),
    .uart_we(uart_we),
    .uart_reg(uart_reg),
    .uart_cpu_ws(uart_cpu_ws),
    .eae_en(eae_en),
    .eae_we(eae_we),
    .eae_reg(eae_reg),
    .sd_en(sd_en),
    .sd_we(sd_we),
    .sd_reg(sd_reg),
    .tin_en(tin_en),
    .tin_we(tin_we),
    .tin_reg(tin_reg),
    .vga_en(vga_en),
    .vga_we(vga_we),
    .vga_reg(vga_reg),
    .hram_en(hram_en),
    .hram_we(hram_we),
    .hram_reg(hram_reg),
    .hram_cpu_ws(hram_cpu_ws),
    .reset_pre_pore(reset_pre_pore),
    .reset_post_pore(reset_post_pore)
  );
endmodule
