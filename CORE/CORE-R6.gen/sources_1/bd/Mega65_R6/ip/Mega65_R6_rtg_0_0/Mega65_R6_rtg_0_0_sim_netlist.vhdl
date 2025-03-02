-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
-- Date        : Sat Feb 22 16:48:27 2025
-- Host        : Retro-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_rtg_0_0/Mega65_R6_rtg_0_0_sim_netlist.vhdl
-- Design      : Mega65_R6_rtg_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Mega65_R6_rtg_0_0_rtg is
  port (
    ena : out STD_LOGIC;
    ready : out STD_LOGIC;
    stride : out STD_LOGIC_VECTOR ( 13 downto 0 );
    base : out STD_LOGIC_VECTOR ( 31 downto 0 );
    vsize : out STD_LOGIC_VECTOR ( 11 downto 0 );
    hsize : out STD_LOGIC_VECTOR ( 11 downto 0 );
    format : out STD_LOGIC_VECTOR ( 4 downto 0 );
    data_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    pal_dw : out STD_LOGIC_VECTOR ( 23 downto 0 );
    clk : in STD_LOGIC;
    data_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    reset : in STD_LOGIC;
    rs : in STD_LOGIC_VECTOR ( 11 downto 1 );
    aen : in STD_LOGIC;
    pal_dr : in STD_LOGIC_VECTOR ( 23 downto 0 );
    wr : in STD_LOGIC;
    rd : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of Mega65_R6_rtg_0_0_rtg : entity is "rtg";
end Mega65_R6_rtg_0_0_rtg;

architecture STRUCTURE of Mega65_R6_rtg_0_0_rtg is
  signal \^base\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \base[15]_i_1_n_0\ : STD_LOGIC;
  signal \base[31]_i_1_n_0\ : STD_LOGIC;
  signal dout : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \dout[0]_i_1_n_0\ : STD_LOGIC;
  signal \dout[0]_i_2_n_0\ : STD_LOGIC;
  signal \dout[0]_i_3_n_0\ : STD_LOGIC;
  signal \dout[0]_i_4_n_0\ : STD_LOGIC;
  signal \dout[10]_i_1_n_0\ : STD_LOGIC;
  signal \dout[10]_i_2_n_0\ : STD_LOGIC;
  signal \dout[10]_i_3_n_0\ : STD_LOGIC;
  signal \dout[10]_i_4_n_0\ : STD_LOGIC;
  signal \dout[11]_i_1_n_0\ : STD_LOGIC;
  signal \dout[11]_i_2_n_0\ : STD_LOGIC;
  signal \dout[11]_i_3_n_0\ : STD_LOGIC;
  signal \dout[11]_i_4_n_0\ : STD_LOGIC;
  signal \dout[12]_i_1_n_0\ : STD_LOGIC;
  signal \dout[12]_i_2_n_0\ : STD_LOGIC;
  signal \dout[12]_i_3_n_0\ : STD_LOGIC;
  signal \dout[13]_i_1_n_0\ : STD_LOGIC;
  signal \dout[13]_i_2_n_0\ : STD_LOGIC;
  signal \dout[13]_i_3_n_0\ : STD_LOGIC;
  signal \dout[14]_i_1_n_0\ : STD_LOGIC;
  signal \dout[14]_i_2_n_0\ : STD_LOGIC;
  signal \dout[14]_i_3_n_0\ : STD_LOGIC;
  signal \dout[15]_i_1_n_0\ : STD_LOGIC;
  signal \dout[15]_i_2_n_0\ : STD_LOGIC;
  signal \dout[15]_i_3_n_0\ : STD_LOGIC;
  signal \dout[1]_i_1_n_0\ : STD_LOGIC;
  signal \dout[1]_i_2_n_0\ : STD_LOGIC;
  signal \dout[1]_i_3_n_0\ : STD_LOGIC;
  signal \dout[1]_i_4_n_0\ : STD_LOGIC;
  signal \dout[2]_i_1_n_0\ : STD_LOGIC;
  signal \dout[2]_i_2_n_0\ : STD_LOGIC;
  signal \dout[2]_i_3_n_0\ : STD_LOGIC;
  signal \dout[2]_i_4_n_0\ : STD_LOGIC;
  signal \dout[3]_i_1_n_0\ : STD_LOGIC;
  signal \dout[3]_i_2_n_0\ : STD_LOGIC;
  signal \dout[3]_i_3_n_0\ : STD_LOGIC;
  signal \dout[3]_i_4_n_0\ : STD_LOGIC;
  signal \dout[4]_i_1_n_0\ : STD_LOGIC;
  signal \dout[4]_i_2_n_0\ : STD_LOGIC;
  signal \dout[4]_i_3_n_0\ : STD_LOGIC;
  signal \dout[4]_i_4_n_0\ : STD_LOGIC;
  signal \dout[5]_i_1_n_0\ : STD_LOGIC;
  signal \dout[5]_i_2_n_0\ : STD_LOGIC;
  signal \dout[5]_i_3_n_0\ : STD_LOGIC;
  signal \dout[5]_i_4_n_0\ : STD_LOGIC;
  signal \dout[6]_i_1_n_0\ : STD_LOGIC;
  signal \dout[6]_i_2_n_0\ : STD_LOGIC;
  signal \dout[6]_i_3_n_0\ : STD_LOGIC;
  signal \dout[6]_i_4_n_0\ : STD_LOGIC;
  signal \dout[7]_i_1_n_0\ : STD_LOGIC;
  signal \dout[7]_i_2_n_0\ : STD_LOGIC;
  signal \dout[7]_i_3_n_0\ : STD_LOGIC;
  signal \dout[7]_i_4_n_0\ : STD_LOGIC;
  signal \dout[8]_i_1_n_0\ : STD_LOGIC;
  signal \dout[8]_i_2_n_0\ : STD_LOGIC;
  signal \dout[8]_i_3_n_0\ : STD_LOGIC;
  signal \dout[8]_i_4_n_0\ : STD_LOGIC;
  signal \dout[9]_i_1_n_0\ : STD_LOGIC;
  signal \dout[9]_i_2_n_0\ : STD_LOGIC;
  signal \dout[9]_i_3_n_0\ : STD_LOGIC;
  signal \dout[9]_i_4_n_0\ : STD_LOGIC;
  signal \^ena\ : STD_LOGIC;
  signal ena_i_1_n_0 : STD_LOGIC;
  signal ena_i_2_n_0 : STD_LOGIC;
  signal ena_i_3_n_0 : STD_LOGIC;
  signal ena_i_4_n_0 : STD_LOGIC;
  signal \^format\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \format[4]_i_1_n_0\ : STD_LOGIC;
  signal \format[4]_i_2_n_0\ : STD_LOGIC;
  signal \^hsize\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \hsize[11]_i_1_n_0\ : STD_LOGIC;
  signal \hsize[11]_i_2_n_0\ : STD_LOGIC;
  signal rd_r : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \rd_r[0]_i_1_n_0\ : STD_LOGIC;
  signal \rd_r[1]_i_1_n_0\ : STD_LOGIC;
  signal \rd_r[2]_i_1_n_0\ : STD_LOGIC;
  signal rpal : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal \rpal[15]_i_1_n_0\ : STD_LOGIC;
  signal \rpal[23]_i_1_n_0\ : STD_LOGIC;
  signal \^stride\ : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal \stride[13]_i_1_n_0\ : STD_LOGIC;
  signal \stride[13]_i_2_n_0\ : STD_LOGIC;
  signal \^vsize\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \vsize[11]_i_1_n_0\ : STD_LOGIC;
  signal \vsize[11]_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \data_out[0]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \data_out[10]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \data_out[11]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \data_out[12]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \data_out[13]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \data_out[14]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \data_out[15]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \data_out[1]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \data_out[2]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \data_out[3]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \data_out[4]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \data_out[5]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \data_out[6]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \data_out[7]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \data_out[8]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \data_out[9]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \dout[14]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \dout[15]_i_3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of ena_i_2 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \format[4]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \hsize[11]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \pal_dw[0]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \pal_dw[10]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pal_dw[11]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pal_dw[12]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \pal_dw[13]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \pal_dw[14]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \pal_dw[15]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \pal_dw[16]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \pal_dw[17]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \pal_dw[18]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \pal_dw[19]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \pal_dw[1]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \pal_dw[20]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \pal_dw[21]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \pal_dw[22]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \pal_dw[23]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \pal_dw[2]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \pal_dw[3]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \pal_dw[4]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \pal_dw[5]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \pal_dw[6]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \pal_dw[7]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \pal_dw[8]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \pal_dw[9]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \stride[13]_i_2\ : label is "soft_lutpair1";
begin
  base(31 downto 0) <= \^base\(31 downto 0);
  ena <= \^ena\;
  format(4 downto 0) <= \^format\(4 downto 0);
  hsize(11 downto 0) <= \^hsize\(11 downto 0);
  stride(13 downto 0) <= \^stride\(13 downto 0);
  vsize(11 downto 0) <= \^vsize\(11 downto 0);
\base[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000100"
    )
        port map (
      I0 => \vsize[11]_i_2_n_0\,
      I1 => ena_i_4_n_0,
      I2 => ena_i_3_n_0,
      I3 => rs(1),
      I4 => rs(2),
      I5 => rs(3),
      O => \base[15]_i_1_n_0\
    );
\base[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000020"
    )
        port map (
      I0 => \hsize[11]_i_2_n_0\,
      I1 => rs(9),
      I2 => rs(8),
      I3 => rs(10),
      I4 => ena_i_4_n_0,
      I5 => rs(3),
      O => \base[31]_i_1_n_0\
    );
\base_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(0),
      Q => \^base\(0),
      R => '0'
    );
\base_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(10),
      Q => \^base\(10),
      R => '0'
    );
\base_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(11),
      Q => \^base\(11),
      R => '0'
    );
\base_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(12),
      Q => \^base\(12),
      R => '0'
    );
\base_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(13),
      Q => \^base\(13),
      R => '0'
    );
\base_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(14),
      Q => \^base\(14),
      R => '0'
    );
\base_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(15),
      Q => \^base\(15),
      R => '0'
    );
\base_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(0),
      Q => \^base\(16),
      R => '0'
    );
\base_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(1),
      Q => \^base\(17),
      R => '0'
    );
\base_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(2),
      Q => \^base\(18),
      R => '0'
    );
\base_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(3),
      Q => \^base\(19),
      R => '0'
    );
\base_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(1),
      Q => \^base\(1),
      R => '0'
    );
\base_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(4),
      Q => \^base\(20),
      R => '0'
    );
\base_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(5),
      Q => \^base\(21),
      R => '0'
    );
\base_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(6),
      Q => \^base\(22),
      R => '0'
    );
\base_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(7),
      Q => \^base\(23),
      R => '0'
    );
\base_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(8),
      Q => \^base\(24),
      R => '0'
    );
\base_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(9),
      Q => \^base\(25),
      R => '0'
    );
\base_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(10),
      Q => \^base\(26),
      R => '0'
    );
\base_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(11),
      Q => \^base\(27),
      R => '0'
    );
\base_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(12),
      Q => \^base\(28),
      R => '0'
    );
\base_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(13),
      Q => \^base\(29),
      R => '0'
    );
\base_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(2),
      Q => \^base\(2),
      R => '0'
    );
\base_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(14),
      Q => \^base\(30),
      R => '0'
    );
\base_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[31]_i_1_n_0\,
      D => data_in(15),
      Q => \^base\(31),
      R => '0'
    );
\base_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(3),
      Q => \^base\(3),
      R => '0'
    );
\base_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(4),
      Q => \^base\(4),
      R => '0'
    );
\base_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(5),
      Q => \^base\(5),
      R => '0'
    );
\base_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(6),
      Q => \^base\(6),
      R => '0'
    );
\base_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(7),
      Q => \^base\(7),
      R => '0'
    );
\base_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(8),
      Q => \^base\(8),
      R => '0'
    );
\base_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \base[15]_i_1_n_0\,
      D => data_in(9),
      Q => \^base\(9),
      R => '0'
    );
\data_out[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(0),
      O => data_out(0)
    );
\data_out[10]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(10),
      O => data_out(10)
    );
\data_out[11]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(11),
      O => data_out(11)
    );
\data_out[12]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(12),
      O => data_out(12)
    );
\data_out[13]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(13),
      O => data_out(13)
    );
\data_out[14]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(14),
      O => data_out(14)
    );
\data_out[15]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(15),
      O => data_out(15)
    );
\data_out[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(1),
      O => data_out(1)
    );
\data_out[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(2),
      O => data_out(2)
    );
\data_out[3]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(3),
      O => data_out(3)
    );
\data_out[4]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(4),
      O => data_out(4)
    );
\data_out[5]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(5),
      O => data_out(5)
    );
\data_out[6]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(6),
      O => data_out(6)
    );
\data_out[7]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(7),
      O => data_out(7)
    );
\data_out[8]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(8),
      O => data_out(8)
    );
\data_out[9]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aen,
      I1 => dout(9),
      O => data_out(9)
    );
\dout[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABABABAAAAAA"
    )
        port map (
      I0 => \dout[0]_i_2_n_0\,
      I1 => ena_i_3_n_0,
      I2 => ena_i_4_n_0,
      I3 => \dout[0]_i_3_n_0\,
      I4 => rs(3),
      I5 => \dout[0]_i_4_n_0\,
      O => \dout[0]_i_1_n_0\
    );
\dout[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E20000000000"
    )
        port map (
      I0 => pal_dr(16),
      I1 => rs(1),
      I2 => pal_dr(0),
      I3 => rs(10),
      I4 => rs(11),
      I5 => aen,
      O => \dout[0]_i_2_n_0\
    );
\dout[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCBBFC88"
    )
        port map (
      I0 => \^stride\(0),
      I1 => rs(2),
      I2 => \^vsize\(0),
      I3 => rs(1),
      I4 => \^hsize\(0),
      O => \dout[0]_i_3_n_0\
    );
\dout[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \^ena\,
      I1 => \^format\(0),
      I2 => rs(2),
      I3 => \^base\(0),
      I4 => rs(1),
      I5 => \^base\(16),
      O => \dout[0]_i_4_n_0\
    );
\dout[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF10111000"
    )
        port map (
      I0 => ena_i_3_n_0,
      I1 => ena_i_4_n_0,
      I2 => \dout[10]_i_2_n_0\,
      I3 => rs(3),
      I4 => \dout[10]_i_3_n_0\,
      I5 => \dout[10]_i_4_n_0\,
      O => \dout[10]_i_1_n_0\
    );
\dout[10]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(10),
      I1 => rs(2),
      I2 => \^vsize\(10),
      I3 => rs(1),
      I4 => \^hsize\(10),
      O => \dout[10]_i_2_n_0\
    );
\dout[10]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \^base\(26),
      I1 => rs(1),
      I2 => \^base\(10),
      I3 => rs(2),
      O => \dout[10]_i_3_n_0\
    );
\dout[10]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => pal_dr(10),
      I4 => rs(1),
      O => \dout[10]_i_4_n_0\
    );
\dout[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF10111000"
    )
        port map (
      I0 => ena_i_3_n_0,
      I1 => ena_i_4_n_0,
      I2 => \dout[11]_i_2_n_0\,
      I3 => rs(3),
      I4 => \dout[11]_i_3_n_0\,
      I5 => \dout[11]_i_4_n_0\,
      O => \dout[11]_i_1_n_0\
    );
\dout[11]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(11),
      I1 => rs(2),
      I2 => \^vsize\(11),
      I3 => rs(1),
      I4 => \^hsize\(11),
      O => \dout[11]_i_2_n_0\
    );
\dout[11]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \^base\(27),
      I1 => rs(1),
      I2 => \^base\(11),
      I3 => rs(2),
      O => \dout[11]_i_3_n_0\
    );
\dout[11]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => pal_dr(11),
      I4 => rs(1),
      O => \dout[11]_i_4_n_0\
    );
\dout[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000010"
    )
        port map (
      I0 => \dout[12]_i_2_n_0\,
      I1 => rs(9),
      I2 => rs(8),
      I3 => rs(10),
      I4 => ena_i_4_n_0,
      I5 => \dout[12]_i_3_n_0\,
      O => \dout[12]_i_1_n_0\
    );
\dout[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3C3C7C7F3F3F7C7F"
    )
        port map (
      I0 => \^stride\(12),
      I1 => rs(3),
      I2 => rs(2),
      I3 => \^base\(28),
      I4 => rs(1),
      I5 => \^base\(12),
      O => \dout[12]_i_2_n_0\
    );
\dout[12]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => pal_dr(12),
      I4 => rs(1),
      O => \dout[12]_i_3_n_0\
    );
\dout[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000010"
    )
        port map (
      I0 => \dout[13]_i_2_n_0\,
      I1 => rs(9),
      I2 => rs(8),
      I3 => rs(10),
      I4 => ena_i_4_n_0,
      I5 => \dout[13]_i_3_n_0\,
      O => \dout[13]_i_1_n_0\
    );
\dout[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FCFC7C7FFFFF7C7F"
    )
        port map (
      I0 => \^stride\(13),
      I1 => rs(2),
      I2 => rs(3),
      I3 => \^base\(29),
      I4 => rs(1),
      I5 => \^base\(13),
      O => \dout[13]_i_2_n_0\
    );
\dout[13]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => pal_dr(13),
      I4 => rs(1),
      O => \dout[13]_i_3_n_0\
    );
\dout[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000010"
    )
        port map (
      I0 => \dout[14]_i_2_n_0\,
      I1 => rs(9),
      I2 => rs(8),
      I3 => rs(10),
      I4 => ena_i_4_n_0,
      I5 => \dout[14]_i_3_n_0\,
      O => \dout[14]_i_1_n_0\
    );
\dout[14]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"66EF77EF"
    )
        port map (
      I0 => rs(3),
      I1 => rs(2),
      I2 => \^base\(30),
      I3 => rs(1),
      I4 => \^base\(14),
      O => \dout[14]_i_2_n_0\
    );
\dout[14]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => pal_dr(14),
      I4 => rs(1),
      O => \dout[14]_i_3_n_0\
    );
\dout[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAABAA"
    )
        port map (
      I0 => \dout[15]_i_2_n_0\,
      I1 => \dout[15]_i_3_n_0\,
      I2 => rs(9),
      I3 => rs(8),
      I4 => rs(10),
      I5 => ena_i_4_n_0,
      O => \dout[15]_i_1_n_0\
    );
\dout[15]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => pal_dr(15),
      I4 => rs(1),
      O => \dout[15]_i_2_n_0\
    );
\dout[15]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFBABF"
    )
        port map (
      I0 => rs(3),
      I1 => \^base\(15),
      I2 => rs(1),
      I3 => \^base\(31),
      I4 => rs(2),
      O => \dout[15]_i_3_n_0\
    );
\dout[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABABABAAAAAA"
    )
        port map (
      I0 => \dout[1]_i_2_n_0\,
      I1 => ena_i_3_n_0,
      I2 => ena_i_4_n_0,
      I3 => \dout[1]_i_3_n_0\,
      I4 => rs(3),
      I5 => \dout[1]_i_4_n_0\,
      O => \dout[1]_i_1_n_0\
    );
\dout[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E20000000000"
    )
        port map (
      I0 => pal_dr(17),
      I1 => rs(1),
      I2 => pal_dr(1),
      I3 => rs(10),
      I4 => rs(11),
      I5 => aen,
      O => \dout[1]_i_2_n_0\
    );
\dout[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(1),
      I1 => rs(2),
      I2 => \^vsize\(1),
      I3 => rs(1),
      I4 => \^hsize\(1),
      O => \dout[1]_i_3_n_0\
    );
\dout[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^format\(1),
      I1 => rs(2),
      I2 => \^base\(1),
      I3 => rs(1),
      I4 => \^base\(17),
      O => \dout[1]_i_4_n_0\
    );
\dout[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABABABAAAAAA"
    )
        port map (
      I0 => \dout[2]_i_2_n_0\,
      I1 => ena_i_3_n_0,
      I2 => ena_i_4_n_0,
      I3 => \dout[2]_i_3_n_0\,
      I4 => rs(3),
      I5 => \dout[2]_i_4_n_0\,
      O => \dout[2]_i_1_n_0\
    );
\dout[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E20000000000"
    )
        port map (
      I0 => pal_dr(18),
      I1 => rs(1),
      I2 => pal_dr(2),
      I3 => rs(10),
      I4 => rs(11),
      I5 => aen,
      O => \dout[2]_i_2_n_0\
    );
\dout[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(2),
      I1 => rs(2),
      I2 => \^vsize\(2),
      I3 => rs(1),
      I4 => \^hsize\(2),
      O => \dout[2]_i_3_n_0\
    );
\dout[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^format\(2),
      I1 => rs(2),
      I2 => \^base\(2),
      I3 => rs(1),
      I4 => \^base\(18),
      O => \dout[2]_i_4_n_0\
    );
\dout[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABABABAAAAAA"
    )
        port map (
      I0 => \dout[3]_i_2_n_0\,
      I1 => ena_i_3_n_0,
      I2 => ena_i_4_n_0,
      I3 => \dout[3]_i_3_n_0\,
      I4 => rs(3),
      I5 => \dout[3]_i_4_n_0\,
      O => \dout[3]_i_1_n_0\
    );
\dout[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E20000000000"
    )
        port map (
      I0 => pal_dr(19),
      I1 => rs(1),
      I2 => pal_dr(3),
      I3 => rs(10),
      I4 => rs(11),
      I5 => aen,
      O => \dout[3]_i_2_n_0\
    );
\dout[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(3),
      I1 => rs(2),
      I2 => \^vsize\(3),
      I3 => rs(1),
      I4 => \^hsize\(3),
      O => \dout[3]_i_3_n_0\
    );
\dout[3]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^format\(3),
      I1 => rs(2),
      I2 => \^base\(3),
      I3 => rs(1),
      I4 => \^base\(19),
      O => \dout[3]_i_4_n_0\
    );
\dout[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABABABAAAAAA"
    )
        port map (
      I0 => \dout[4]_i_2_n_0\,
      I1 => ena_i_3_n_0,
      I2 => ena_i_4_n_0,
      I3 => \dout[4]_i_3_n_0\,
      I4 => rs(3),
      I5 => \dout[4]_i_4_n_0\,
      O => \dout[4]_i_1_n_0\
    );
\dout[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E20000000000"
    )
        port map (
      I0 => pal_dr(20),
      I1 => rs(1),
      I2 => pal_dr(4),
      I3 => rs(10),
      I4 => rs(11),
      I5 => aen,
      O => \dout[4]_i_2_n_0\
    );
\dout[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(4),
      I1 => rs(2),
      I2 => \^vsize\(4),
      I3 => rs(1),
      I4 => \^hsize\(4),
      O => \dout[4]_i_3_n_0\
    );
\dout[4]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^format\(4),
      I1 => rs(2),
      I2 => \^base\(4),
      I3 => rs(1),
      I4 => \^base\(20),
      O => \dout[4]_i_4_n_0\
    );
\dout[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABABABAAAAAA"
    )
        port map (
      I0 => \dout[5]_i_2_n_0\,
      I1 => ena_i_3_n_0,
      I2 => ena_i_4_n_0,
      I3 => \dout[5]_i_3_n_0\,
      I4 => rs(3),
      I5 => \dout[5]_i_4_n_0\,
      O => \dout[5]_i_1_n_0\
    );
\dout[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E20000000000"
    )
        port map (
      I0 => pal_dr(21),
      I1 => rs(1),
      I2 => pal_dr(5),
      I3 => rs(10),
      I4 => rs(11),
      I5 => aen,
      O => \dout[5]_i_2_n_0\
    );
\dout[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(5),
      I1 => rs(2),
      I2 => \^vsize\(5),
      I3 => rs(1),
      I4 => \^hsize\(5),
      O => \dout[5]_i_3_n_0\
    );
\dout[5]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \^base\(21),
      I1 => rs(1),
      I2 => \^base\(5),
      I3 => rs(2),
      O => \dout[5]_i_4_n_0\
    );
\dout[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABABABAAAAAA"
    )
        port map (
      I0 => \dout[6]_i_2_n_0\,
      I1 => ena_i_3_n_0,
      I2 => ena_i_4_n_0,
      I3 => \dout[6]_i_3_n_0\,
      I4 => rs(3),
      I5 => \dout[6]_i_4_n_0\,
      O => \dout[6]_i_1_n_0\
    );
\dout[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E20000000000"
    )
        port map (
      I0 => pal_dr(22),
      I1 => rs(1),
      I2 => pal_dr(6),
      I3 => rs(10),
      I4 => rs(11),
      I5 => aen,
      O => \dout[6]_i_2_n_0\
    );
\dout[6]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(6),
      I1 => rs(2),
      I2 => \^vsize\(6),
      I3 => rs(1),
      I4 => \^hsize\(6),
      O => \dout[6]_i_3_n_0\
    );
\dout[6]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \^base\(22),
      I1 => rs(1),
      I2 => \^base\(6),
      I3 => rs(2),
      O => \dout[6]_i_4_n_0\
    );
\dout[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABABABAAAAAA"
    )
        port map (
      I0 => \dout[7]_i_2_n_0\,
      I1 => ena_i_3_n_0,
      I2 => ena_i_4_n_0,
      I3 => \dout[7]_i_3_n_0\,
      I4 => rs(3),
      I5 => \dout[7]_i_4_n_0\,
      O => \dout[7]_i_1_n_0\
    );
\dout[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000E20000000000"
    )
        port map (
      I0 => pal_dr(23),
      I1 => rs(1),
      I2 => pal_dr(7),
      I3 => rs(10),
      I4 => rs(11),
      I5 => aen,
      O => \dout[7]_i_2_n_0\
    );
\dout[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(7),
      I1 => rs(2),
      I2 => \^vsize\(7),
      I3 => rs(1),
      I4 => \^hsize\(7),
      O => \dout[7]_i_3_n_0\
    );
\dout[7]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \^base\(23),
      I1 => rs(1),
      I2 => \^base\(7),
      I3 => rs(2),
      O => \dout[7]_i_4_n_0\
    );
\dout[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF10111000"
    )
        port map (
      I0 => ena_i_3_n_0,
      I1 => ena_i_4_n_0,
      I2 => \dout[8]_i_2_n_0\,
      I3 => rs(3),
      I4 => \dout[8]_i_3_n_0\,
      I5 => \dout[8]_i_4_n_0\,
      O => \dout[8]_i_1_n_0\
    );
\dout[8]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(8),
      I1 => rs(2),
      I2 => \^vsize\(8),
      I3 => rs(1),
      I4 => \^hsize\(8),
      O => \dout[8]_i_2_n_0\
    );
\dout[8]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \^base\(24),
      I1 => rs(1),
      I2 => \^base\(8),
      I3 => rs(2),
      O => \dout[8]_i_3_n_0\
    );
\dout[8]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => pal_dr(8),
      I4 => rs(1),
      O => \dout[8]_i_4_n_0\
    );
\dout[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF10111000"
    )
        port map (
      I0 => ena_i_3_n_0,
      I1 => ena_i_4_n_0,
      I2 => \dout[9]_i_2_n_0\,
      I3 => rs(3),
      I4 => \dout[9]_i_3_n_0\,
      I5 => \dout[9]_i_4_n_0\,
      O => \dout[9]_i_1_n_0\
    );
\dout[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => \^stride\(9),
      I1 => rs(2),
      I2 => \^vsize\(9),
      I3 => rs(1),
      I4 => \^hsize\(9),
      O => \dout[9]_i_2_n_0\
    );
\dout[9]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => \^base\(25),
      I1 => rs(1),
      I2 => \^base\(9),
      I3 => rs(2),
      O => \dout[9]_i_3_n_0\
    );
\dout[9]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => pal_dr(9),
      I4 => rs(1),
      O => \dout[9]_i_4_n_0\
    );
\dout_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[0]_i_1_n_0\,
      Q => dout(0),
      R => '0'
    );
\dout_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[10]_i_1_n_0\,
      Q => dout(10),
      R => '0'
    );
\dout_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[11]_i_1_n_0\,
      Q => dout(11),
      R => '0'
    );
\dout_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[12]_i_1_n_0\,
      Q => dout(12),
      R => '0'
    );
\dout_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[13]_i_1_n_0\,
      Q => dout(13),
      R => '0'
    );
\dout_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[14]_i_1_n_0\,
      Q => dout(14),
      R => '0'
    );
\dout_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[15]_i_1_n_0\,
      Q => dout(15),
      R => '0'
    );
\dout_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[1]_i_1_n_0\,
      Q => dout(1),
      R => '0'
    );
\dout_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[2]_i_1_n_0\,
      Q => dout(2),
      R => '0'
    );
\dout_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[3]_i_1_n_0\,
      Q => dout(3),
      R => '0'
    );
\dout_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[4]_i_1_n_0\,
      Q => dout(4),
      R => '0'
    );
\dout_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[5]_i_1_n_0\,
      Q => dout(5),
      R => '0'
    );
\dout_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[6]_i_1_n_0\,
      Q => dout(6),
      R => '0'
    );
\dout_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[7]_i_1_n_0\,
      Q => dout(7),
      R => '0'
    );
\dout_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[8]_i_1_n_0\,
      Q => dout(8),
      R => '0'
    );
\dout_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \dout[9]_i_1_n_0\,
      Q => dout(9),
      R => '0'
    );
ena_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000AAABAAA8"
    )
        port map (
      I0 => \^ena\,
      I1 => ena_i_2_n_0,
      I2 => ena_i_3_n_0,
      I3 => ena_i_4_n_0,
      I4 => data_in(0),
      I5 => reset,
      O => ena_i_1_n_0
    );
ena_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F7FF"
    )
        port map (
      I0 => rs(1),
      I1 => rs(2),
      I2 => rs(3),
      I3 => wr,
      O => ena_i_2_n_0
    );
ena_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FB"
    )
        port map (
      I0 => rs(10),
      I1 => rs(8),
      I2 => rs(9),
      O => ena_i_3_n_0
    );
ena_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFD"
    )
        port map (
      I0 => aen,
      I1 => rs(11),
      I2 => rs(4),
      I3 => rs(5),
      I4 => rs(6),
      I5 => rs(7),
      O => ena_i_4_n_0
    );
ena_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => ena_i_1_n_0,
      Q => \^ena\,
      R => '0'
    );
\format[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => rs(9),
      I1 => rs(8),
      I2 => rs(10),
      I3 => ena_i_4_n_0,
      I4 => \vsize[11]_i_2_n_0\,
      I5 => \format[4]_i_2_n_0\,
      O => \format[4]_i_1_n_0\
    );
\format[4]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FB"
    )
        port map (
      I0 => rs(3),
      I1 => rs(2),
      I2 => rs(1),
      O => \format[4]_i_2_n_0\
    );
\format_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \format[4]_i_1_n_0\,
      D => data_in(0),
      Q => \^format\(0),
      R => '0'
    );
\format_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \format[4]_i_1_n_0\,
      D => data_in(1),
      Q => \^format\(1),
      R => '0'
    );
\format_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \format[4]_i_1_n_0\,
      D => data_in(2),
      Q => \^format\(2),
      R => '0'
    );
\format_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \format[4]_i_1_n_0\,
      D => data_in(3),
      Q => \^format\(3),
      R => '0'
    );
\format_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \format[4]_i_1_n_0\,
      D => data_in(4),
      Q => \^format\(4),
      R => '0'
    );
\hsize[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0010000000000000"
    )
        port map (
      I0 => ena_i_4_n_0,
      I1 => rs(10),
      I2 => rs(8),
      I3 => rs(9),
      I4 => \hsize[11]_i_2_n_0\,
      I5 => rs(3),
      O => \hsize[11]_i_1_n_0\
    );
\hsize[11]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
        port map (
      I0 => rs(2),
      I1 => reset,
      I2 => wr,
      I3 => rs(1),
      O => \hsize[11]_i_2_n_0\
    );
\hsize_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(0),
      Q => \^hsize\(0),
      R => '0'
    );
\hsize_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(10),
      Q => \^hsize\(10),
      R => '0'
    );
\hsize_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(11),
      Q => \^hsize\(11),
      R => '0'
    );
\hsize_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(1),
      Q => \^hsize\(1),
      R => '0'
    );
\hsize_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(2),
      Q => \^hsize\(2),
      R => '0'
    );
\hsize_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(3),
      Q => \^hsize\(3),
      R => '0'
    );
\hsize_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(4),
      Q => \^hsize\(4),
      R => '0'
    );
\hsize_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(5),
      Q => \^hsize\(5),
      R => '0'
    );
\hsize_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(6),
      Q => \^hsize\(6),
      R => '0'
    );
\hsize_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(7),
      Q => \^hsize\(7),
      R => '0'
    );
\hsize_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(8),
      Q => \^hsize\(8),
      R => '0'
    );
\hsize_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \hsize[11]_i_1_n_0\,
      D => data_in(9),
      Q => \^hsize\(9),
      R => '0'
    );
\pal_dw[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(0),
      I1 => rs(1),
      I2 => rpal(0),
      O => pal_dw(0)
    );
\pal_dw[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(10),
      I1 => rs(1),
      I2 => rpal(10),
      O => pal_dw(10)
    );
\pal_dw[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(11),
      I1 => rs(1),
      I2 => rpal(11),
      O => pal_dw(11)
    );
\pal_dw[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(12),
      I1 => rs(1),
      I2 => rpal(12),
      O => pal_dw(12)
    );
\pal_dw[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(13),
      I1 => rs(1),
      I2 => rpal(13),
      O => pal_dw(13)
    );
\pal_dw[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(14),
      I1 => rs(1),
      I2 => rpal(14),
      O => pal_dw(14)
    );
\pal_dw[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(15),
      I1 => rs(1),
      I2 => rpal(15),
      O => pal_dw(15)
    );
\pal_dw[16]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rpal(16),
      I1 => rs(1),
      I2 => data_in(0),
      O => pal_dw(16)
    );
\pal_dw[17]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rpal(17),
      I1 => rs(1),
      I2 => data_in(1),
      O => pal_dw(17)
    );
\pal_dw[18]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rpal(18),
      I1 => rs(1),
      I2 => data_in(2),
      O => pal_dw(18)
    );
\pal_dw[19]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rpal(19),
      I1 => rs(1),
      I2 => data_in(3),
      O => pal_dw(19)
    );
\pal_dw[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(1),
      I1 => rs(1),
      I2 => rpal(1),
      O => pal_dw(1)
    );
\pal_dw[20]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rpal(20),
      I1 => rs(1),
      I2 => data_in(4),
      O => pal_dw(20)
    );
\pal_dw[21]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rpal(21),
      I1 => rs(1),
      I2 => data_in(5),
      O => pal_dw(21)
    );
\pal_dw[22]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rpal(22),
      I1 => rs(1),
      I2 => data_in(6),
      O => pal_dw(22)
    );
\pal_dw[23]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => rpal(23),
      I1 => rs(1),
      I2 => data_in(7),
      O => pal_dw(23)
    );
\pal_dw[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(2),
      I1 => rs(1),
      I2 => rpal(2),
      O => pal_dw(2)
    );
\pal_dw[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(3),
      I1 => rs(1),
      I2 => rpal(3),
      O => pal_dw(3)
    );
\pal_dw[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(4),
      I1 => rs(1),
      I2 => rpal(4),
      O => pal_dw(4)
    );
\pal_dw[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(5),
      I1 => rs(1),
      I2 => rpal(5),
      O => pal_dw(5)
    );
\pal_dw[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(6),
      I1 => rs(1),
      I2 => rpal(6),
      O => pal_dw(6)
    );
\pal_dw[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(7),
      I1 => rs(1),
      I2 => rpal(7),
      O => pal_dw(7)
    );
\pal_dw[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(8),
      I1 => rs(1),
      I2 => rpal(8),
      O => pal_dw(8)
    );
\pal_dw[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => data_in(9),
      I1 => rs(1),
      I2 => rpal(9),
      O => pal_dw(9)
    );
\rd_r[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00200000AA2A0000"
    )
        port map (
      I0 => rd,
      I1 => rd_r(2),
      I2 => rs(10),
      I3 => rs(11),
      I4 => aen,
      I5 => rd_r(0),
      O => \rd_r[0]_i_1_n_0\
    );
\rd_r[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04000000"
    )
        port map (
      I0 => rd_r(2),
      I1 => rs(10),
      I2 => rs(11),
      I3 => aen,
      I4 => rd_r(0),
      O => \rd_r[1]_i_1_n_0\
    );
\rd_r[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00200000AA2AAAAA"
    )
        port map (
      I0 => rd_r(1),
      I1 => rd_r(2),
      I2 => rs(10),
      I3 => rs(11),
      I4 => aen,
      I5 => rd_r(0),
      O => \rd_r[2]_i_1_n_0\
    );
\rd_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rd_r[0]_i_1_n_0\,
      Q => rd_r(0),
      R => '0'
    );
\rd_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rd_r[1]_i_1_n_0\,
      Q => rd_r(1),
      R => '0'
    );
\rd_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rd_r[2]_i_1_n_0\,
      Q => rd_r(2),
      R => '0'
    );
ready_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCCCCCC8C888088"
    )
        port map (
      I0 => rd_r(0),
      I1 => aen,
      I2 => rs(11),
      I3 => rs(10),
      I4 => rd_r(2),
      I5 => wr,
      O => ready
    );
\rpal[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200000000000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => rs(1),
      I4 => reset,
      I5 => wr,
      O => \rpal[15]_i_1_n_0\
    );
\rpal[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000200000"
    )
        port map (
      I0 => rs(10),
      I1 => rs(11),
      I2 => aen,
      I3 => reset,
      I4 => wr,
      I5 => rs(1),
      O => \rpal[23]_i_1_n_0\
    );
\rpal_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(0),
      Q => rpal(0),
      R => '0'
    );
\rpal_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(10),
      Q => rpal(10),
      R => '0'
    );
\rpal_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(11),
      Q => rpal(11),
      R => '0'
    );
\rpal_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(12),
      Q => rpal(12),
      R => '0'
    );
\rpal_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(13),
      Q => rpal(13),
      R => '0'
    );
\rpal_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(14),
      Q => rpal(14),
      R => '0'
    );
\rpal_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(15),
      Q => rpal(15),
      R => '0'
    );
\rpal_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[23]_i_1_n_0\,
      D => data_in(0),
      Q => rpal(16),
      R => '0'
    );
\rpal_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[23]_i_1_n_0\,
      D => data_in(1),
      Q => rpal(17),
      R => '0'
    );
\rpal_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[23]_i_1_n_0\,
      D => data_in(2),
      Q => rpal(18),
      R => '0'
    );
\rpal_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[23]_i_1_n_0\,
      D => data_in(3),
      Q => rpal(19),
      R => '0'
    );
\rpal_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(1),
      Q => rpal(1),
      R => '0'
    );
\rpal_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[23]_i_1_n_0\,
      D => data_in(4),
      Q => rpal(20),
      R => '0'
    );
\rpal_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[23]_i_1_n_0\,
      D => data_in(5),
      Q => rpal(21),
      R => '0'
    );
\rpal_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[23]_i_1_n_0\,
      D => data_in(6),
      Q => rpal(22),
      R => '0'
    );
\rpal_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[23]_i_1_n_0\,
      D => data_in(7),
      Q => rpal(23),
      R => '0'
    );
\rpal_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(2),
      Q => rpal(2),
      R => '0'
    );
\rpal_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(3),
      Q => rpal(3),
      R => '0'
    );
\rpal_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(4),
      Q => rpal(4),
      R => '0'
    );
\rpal_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(5),
      Q => rpal(5),
      R => '0'
    );
\rpal_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(6),
      Q => rpal(6),
      R => '0'
    );
\rpal_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(7),
      Q => rpal(7),
      R => '0'
    );
\rpal_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(8),
      Q => rpal(8),
      R => '0'
    );
\rpal_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \rpal[15]_i_1_n_0\,
      D => data_in(9),
      Q => rpal(9),
      R => '0'
    );
\stride[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => rs(9),
      I1 => rs(8),
      I2 => rs(10),
      I3 => ena_i_4_n_0,
      I4 => \vsize[11]_i_2_n_0\,
      I5 => \stride[13]_i_2_n_0\,
      O => \stride[13]_i_1_n_0\
    );
\stride[13]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
        port map (
      I0 => rs(2),
      I1 => rs(1),
      I2 => rs(3),
      O => \stride[13]_i_2_n_0\
    );
\stride_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(0),
      Q => \^stride\(0),
      R => '0'
    );
\stride_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(10),
      Q => \^stride\(10),
      R => '0'
    );
\stride_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(11),
      Q => \^stride\(11),
      R => '0'
    );
\stride_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(12),
      Q => \^stride\(12),
      R => '0'
    );
\stride_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(13),
      Q => \^stride\(13),
      R => '0'
    );
\stride_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(1),
      Q => \^stride\(1),
      R => '0'
    );
\stride_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(2),
      Q => \^stride\(2),
      R => '0'
    );
\stride_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(3),
      Q => \^stride\(3),
      R => '0'
    );
\stride_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(4),
      Q => \^stride\(4),
      R => '0'
    );
\stride_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(5),
      Q => \^stride\(5),
      R => '0'
    );
\stride_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(6),
      Q => \^stride\(6),
      R => '0'
    );
\stride_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(7),
      Q => \^stride\(7),
      R => '0'
    );
\stride_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(8),
      Q => \^stride\(8),
      R => '0'
    );
\stride_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \stride[13]_i_1_n_0\,
      D => data_in(9),
      Q => \^stride\(9),
      R => '0'
    );
\vsize[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000001000000"
    )
        port map (
      I0 => \vsize[11]_i_2_n_0\,
      I1 => ena_i_4_n_0,
      I2 => ena_i_3_n_0,
      I3 => rs(1),
      I4 => rs(3),
      I5 => rs(2),
      O => \vsize[11]_i_1_n_0\
    );
\vsize[11]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => reset,
      I1 => wr,
      O => \vsize[11]_i_2_n_0\
    );
\vsize_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(0),
      Q => \^vsize\(0),
      R => '0'
    );
\vsize_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(10),
      Q => \^vsize\(10),
      R => '0'
    );
\vsize_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(11),
      Q => \^vsize\(11),
      R => '0'
    );
\vsize_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(1),
      Q => \^vsize\(1),
      R => '0'
    );
\vsize_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(2),
      Q => \^vsize\(2),
      R => '0'
    );
\vsize_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(3),
      Q => \^vsize\(3),
      R => '0'
    );
\vsize_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(4),
      Q => \^vsize\(4),
      R => '0'
    );
\vsize_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(5),
      Q => \^vsize\(5),
      R => '0'
    );
\vsize_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(6),
      Q => \^vsize\(6),
      R => '0'
    );
\vsize_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(7),
      Q => \^vsize\(7),
      R => '0'
    );
\vsize_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(8),
      Q => \^vsize\(8),
      R => '0'
    );
\vsize_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \vsize[11]_i_1_n_0\,
      D => data_in(9),
      Q => \^vsize\(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Mega65_R6_rtg_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Mega65_R6_rtg_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Mega65_R6_rtg_0_0 : entity is "Mega65_R6_rtg_0_0,rtg,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of Mega65_R6_rtg_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of Mega65_R6_rtg_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of Mega65_R6_rtg_0_0 : entity is "rtg,Vivado 2024.2.1";
end Mega65_R6_rtg_0_0;

architecture STRUCTURE of Mega65_R6_rtg_0_0 is
  signal \^clk\ : STD_LOGIC;
  signal \^rs\ : STD_LOGIC_VECTOR ( 11 downto 1 );
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_mode : string;
  attribute x_interface_mode of clk : signal is "slave clk";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute x_interface_info of pal_clk : signal is "xilinx.com:signal:clock:1.0 pal_clk CLK";
  attribute x_interface_mode of pal_clk : signal is "master pal_clk";
  attribute x_interface_parameter of pal_clk : signal is "XIL_INTERFACENAME pal_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN Mega65_R6_rtg_0_0_pal_clk, INSERT_VIP 0";
  attribute x_interface_info of reset : signal is "xilinx.com:signal:reset:1.0 reset RST";
  attribute x_interface_mode of reset : signal is "slave reset";
  attribute x_interface_parameter of reset : signal is "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
  \^clk\ <= clk;
  \^rs\(11 downto 1) <= rs(11 downto 1);
  pal_a(7 downto 0) <= \^rs\(9 downto 2);
  pal_clk <= \^clk\;
U0: entity work.Mega65_R6_rtg_0_0_rtg
     port map (
      aen => aen,
      base(31 downto 0) => base(31 downto 0),
      clk => \^clk\,
      data_in(15 downto 0) => data_in(15 downto 0),
      data_out(15 downto 0) => data_out(15 downto 0),
      ena => ena,
      format(4 downto 0) => format(4 downto 0),
      hsize(11 downto 0) => hsize(11 downto 0),
      pal_dr(23 downto 0) => pal_dr(23 downto 0),
      pal_dw(23 downto 0) => pal_dw(23 downto 0),
      rd => rd,
      ready => ready,
      reset => reset,
      rs(11 downto 1) => \^rs\(11 downto 1),
      stride(13 downto 0) => stride(13 downto 0),
      vsize(11 downto 0) => vsize(11 downto 0),
      wr => wr
    );
pal_wr_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => wr,
      I1 => \^rs\(10),
      I2 => \^rs\(11),
      I3 => aen,
      O => pal_wr
    );
end STRUCTURE;
