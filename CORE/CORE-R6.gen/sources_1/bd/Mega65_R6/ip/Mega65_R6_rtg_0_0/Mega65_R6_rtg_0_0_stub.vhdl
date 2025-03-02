-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
-- Date        : Sat Feb 22 16:48:27 2025
-- Host        : Retro-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_rtg_0_0/Mega65_R6_rtg_0_0_stub.vhdl
-- Design      : Mega65_R6_rtg_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mega65_R6_rtg_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    aen : in STD_LOGIC;
    rd : in STD_LOGIC;
    wr : in STD_LOGIC;
    reset : in STD_LOGIC;
    rs : in STD_LOGIC_VECTOR ( 11 downto 1 );
    ready : out STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    data_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    ena : out STD_LOGIC;
    hsize : out STD_LOGIC_VECTOR ( 11 downto 0 );
    vsize : out STD_LOGIC_VECTOR ( 11 downto 0 );
    format : out STD_LOGIC_VECTOR ( 4 downto 0 );
    base : out STD_LOGIC_VECTOR ( 31 downto 0 );
    stride : out STD_LOGIC_VECTOR ( 13 downto 0 );
    pal_clk : out STD_LOGIC;
    pal_dw : out STD_LOGIC_VECTOR ( 23 downto 0 );
    pal_dr : in STD_LOGIC_VECTOR ( 23 downto 0 );
    pal_a : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pal_wr : out STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Mega65_R6_rtg_0_0 : entity is "Mega65_R6_rtg_0_0,rtg,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of Mega65_R6_rtg_0_0 : entity is "Mega65_R6_rtg_0_0,rtg,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=rtg,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of Mega65_R6_rtg_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of Mega65_R6_rtg_0_0 : entity is "module_ref";
end Mega65_R6_rtg_0_0;

architecture stub of Mega65_R6_rtg_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "clk,aen,rd,wr,reset,rs[11:1],ready,data_in[15:0],data_out[15:0],ena,hsize[11:0],vsize[11:0],format[4:0],base[31:0],stride[13:0],pal_clk,pal_dw[23:0],pal_dr[23:0],pal_a[7:0],pal_wr";
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_mode : string;
  attribute x_interface_mode of clk : signal is "slave clk";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute x_interface_info of reset : signal is "xilinx.com:signal:reset:1.0 reset RST";
  attribute x_interface_mode of reset : signal is "slave reset";
  attribute x_interface_parameter of reset : signal is "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of pal_clk : signal is "xilinx.com:signal:clock:1.0 pal_clk CLK";
  attribute x_interface_mode of pal_clk : signal is "master pal_clk";
  attribute x_interface_parameter of pal_clk : signal is "XIL_INTERFACENAME pal_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN Mega65_R6_rtg_0_0_pal_clk, INSERT_VIP 0";
  attribute x_core_info : string;
  attribute x_core_info of stub : architecture is "rtg,Vivado 2024.2.1";
begin
end;
