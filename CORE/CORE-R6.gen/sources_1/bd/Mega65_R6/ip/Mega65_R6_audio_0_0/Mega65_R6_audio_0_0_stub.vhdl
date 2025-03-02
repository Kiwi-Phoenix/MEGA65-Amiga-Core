-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
-- Date        : Sat Feb 22 14:34:11 2025
-- Host        : Retro-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_audio_0_0/Mega65_R6_audio_0_0_stub.vhdl
-- Design      : Mega65_R6_audio_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mega65_R6_audio_0_0 is
  Port ( 
    audio_clk_i : in STD_LOGIC;
    audio_reset_i : in STD_LOGIC;
    audio_left_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    audio_right_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    audio_mclk_o : out STD_LOGIC;
    audio_bick_o : out STD_LOGIC;
    audio_sdti_o : out STD_LOGIC;
    audio_lrclk_o : out STD_LOGIC;
    audio_pdn_n_o : out STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Mega65_R6_audio_0_0 : entity is "Mega65_R6_audio_0_0,audio,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of Mega65_R6_audio_0_0 : entity is "Mega65_R6_audio_0_0,audio,{x_ipProduct=Vivado 2024.2.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=audio,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of Mega65_R6_audio_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of Mega65_R6_audio_0_0 : entity is "module_ref";
end Mega65_R6_audio_0_0;

architecture stub of Mega65_R6_audio_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "audio_clk_i,audio_reset_i,audio_left_i[15:0],audio_right_i[15:0],audio_mclk_o,audio_bick_o,audio_sdti_o,audio_lrclk_o,audio_pdn_n_o";
  attribute x_core_info : string;
  attribute x_core_info of stub : architecture is "audio,Vivado 2024.2.1";
begin
end;
