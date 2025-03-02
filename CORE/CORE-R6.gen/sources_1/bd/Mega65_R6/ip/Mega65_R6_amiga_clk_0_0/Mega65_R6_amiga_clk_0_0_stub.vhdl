-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
-- Date        : Sat Feb 22 14:34:40 2025
-- Host        : Retro-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_amiga_clk_0_0/Mega65_R6_amiga_clk_0_0_stub.vhdl
-- Design      : Mega65_R6_amiga_clk_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mega65_R6_amiga_clk_0_0 is
  Port ( 
    clk_28 : in STD_LOGIC;
    clk7_en : out STD_LOGIC;
    clk7n_en : out STD_LOGIC;
    c1 : out STD_LOGIC;
    c3 : out STD_LOGIC;
    cck : out STD_LOGIC;
    eclk : out STD_LOGIC_VECTOR ( 9 downto 0 );
    reset_n : in STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Mega65_R6_amiga_clk_0_0 : entity is "Mega65_R6_amiga_clk_0_0,amiga_clk,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of Mega65_R6_amiga_clk_0_0 : entity is "Mega65_R6_amiga_clk_0_0,amiga_clk,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=amiga_clk,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of Mega65_R6_amiga_clk_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of Mega65_R6_amiga_clk_0_0 : entity is "module_ref";
end Mega65_R6_amiga_clk_0_0;

architecture stub of Mega65_R6_amiga_clk_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "clk_28,clk7_en,clk7n_en,c1,c3,cck,eclk[9:0],reset_n";
  attribute x_interface_info : string;
  attribute x_interface_info of reset_n : signal is "xilinx.com:signal:reset:1.0 reset_n RST";
  attribute x_interface_mode : string;
  attribute x_interface_mode of reset_n : signal is "slave reset_n";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of reset_n : signal is "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_core_info : string;
  attribute x_core_info of stub : architecture is "amiga_clk,Vivado 2024.2.1";
begin
end;
