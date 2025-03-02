-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
-- Date        : Sat Feb 22 14:34:11 2025
-- Host        : Retro-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_audio_0_0/Mega65_R6_audio_0_0_sim_netlist.vhdl
-- Design      : Mega65_R6_audio_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Mega65_R6_audio_0_0_audio is
  port (
    audio_sdti_o : out STD_LOGIC;
    audio_lrclk_o : out STD_LOGIC;
    audio_bick_o : out STD_LOGIC;
    audio_clk_i : in STD_LOGIC;
    audio_right_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    audio_left_i : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of Mega65_R6_audio_0_0_audio : entity is "audio";
end Mega65_R6_audio_0_0_audio;

architecture STRUCTURE of Mega65_R6_audio_0_0_audio is
  signal audio_lrclk_o_i_1_n_0 : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal \fs_counter[6]_i_2_n_0\ : STD_LOGIC;
  signal fs_counter_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \fs_counter_reg_n_0_[1]\ : STD_LOGIC;
  signal \i2s_data[16]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[17]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[18]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[19]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[20]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[21]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[22]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[23]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[24]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[25]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[26]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[27]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[28]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[29]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[30]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[31]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[47]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[48]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[49]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[50]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[51]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[52]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[53]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[54]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[55]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[56]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[57]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[58]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[59]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[60]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[61]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[62]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[63]_i_1_n_0\ : STD_LOGIC;
  signal \i2s_data[63]_i_2_n_0\ : STD_LOGIC;
  signal \i2s_data[63]_i_3_n_0\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[16]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[17]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[18]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[19]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[20]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[21]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[22]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[23]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[24]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[25]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[26]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[27]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[28]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[29]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[30]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[31]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[32]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[33]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[34]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[35]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[36]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[37]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[38]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[39]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[40]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[41]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[42]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[43]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[44]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[45]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[46]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[47]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[48]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[49]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[50]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[51]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[52]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[53]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[54]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[55]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[56]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[57]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[58]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[59]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[60]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[61]\ : STD_LOGIC;
  signal \i2s_data_reg_n_0_[62]\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \fs_counter[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \fs_counter[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \fs_counter[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \fs_counter[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \fs_counter[4]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \fs_counter[6]_i_2\ : label is "soft_lutpair1";
begin
audio_bick_o_reg: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => '1',
      D => \fs_counter_reg_n_0_[1]\,
      Q => audio_bick_o,
      R => '0'
    );
audio_lrclk_o_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fs_counter_reg(7),
      O => audio_lrclk_o_i_1_n_0
    );
audio_lrclk_o_reg: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => '1',
      D => audio_lrclk_o_i_1_n_0,
      Q => audio_lrclk_o,
      R => '0'
    );
audio_sdti_o_reg: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => '1',
      D => p_0_in,
      Q => audio_sdti_o,
      R => '0'
    );
\fs_counter[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fs_counter_reg(0),
      O => \p_0_in__0\(0)
    );
\fs_counter[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => fs_counter_reg(0),
      I1 => \fs_counter_reg_n_0_[1]\,
      O => \p_0_in__0\(1)
    );
\fs_counter[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \fs_counter_reg_n_0_[1]\,
      I1 => fs_counter_reg(0),
      I2 => fs_counter_reg(2),
      O => \p_0_in__0\(2)
    );
\fs_counter[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => fs_counter_reg(2),
      I1 => fs_counter_reg(0),
      I2 => \fs_counter_reg_n_0_[1]\,
      I3 => fs_counter_reg(3),
      O => \p_0_in__0\(3)
    );
\fs_counter[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => fs_counter_reg(3),
      I1 => \fs_counter_reg_n_0_[1]\,
      I2 => fs_counter_reg(0),
      I3 => fs_counter_reg(2),
      I4 => fs_counter_reg(4),
      O => \p_0_in__0\(4)
    );
\fs_counter[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => fs_counter_reg(4),
      I1 => fs_counter_reg(2),
      I2 => fs_counter_reg(0),
      I3 => \fs_counter_reg_n_0_[1]\,
      I4 => fs_counter_reg(3),
      I5 => fs_counter_reg(5),
      O => \p_0_in__0\(5)
    );
\fs_counter[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FFFFFF08000000"
    )
        port map (
      I0 => fs_counter_reg(5),
      I1 => fs_counter_reg(3),
      I2 => \fs_counter[6]_i_2_n_0\,
      I3 => fs_counter_reg(2),
      I4 => fs_counter_reg(4),
      I5 => fs_counter_reg(6),
      O => \p_0_in__0\(6)
    );
\fs_counter[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => fs_counter_reg(0),
      I1 => \fs_counter_reg_n_0_[1]\,
      O => \fs_counter[6]_i_2_n_0\
    );
\fs_counter[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => fs_counter_reg(7),
      I1 => \i2s_data[63]_i_3_n_0\,
      I2 => fs_counter_reg(6),
      O => clear
    );
\fs_counter[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D2"
    )
        port map (
      I0 => fs_counter_reg(6),
      I1 => \i2s_data[63]_i_3_n_0\,
      I2 => fs_counter_reg(7),
      O => \p_0_in__0\(7)
    );
\fs_counter_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => audio_clk_i,
      CE => '1',
      D => \p_0_in__0\(0),
      Q => fs_counter_reg(0),
      R => clear
    );
\fs_counter_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => audio_clk_i,
      CE => '1',
      D => \p_0_in__0\(1),
      Q => \fs_counter_reg_n_0_[1]\,
      R => clear
    );
\fs_counter_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => audio_clk_i,
      CE => '1',
      D => \p_0_in__0\(2),
      Q => fs_counter_reg(2),
      R => clear
    );
\fs_counter_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => audio_clk_i,
      CE => '1',
      D => \p_0_in__0\(3),
      Q => fs_counter_reg(3),
      R => clear
    );
\fs_counter_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => audio_clk_i,
      CE => '1',
      D => \p_0_in__0\(4),
      Q => fs_counter_reg(4),
      R => clear
    );
\fs_counter_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => audio_clk_i,
      CE => '1',
      D => \p_0_in__0\(5),
      Q => fs_counter_reg(5),
      R => clear
    );
\fs_counter_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => audio_clk_i,
      CE => '1',
      D => \p_0_in__0\(6),
      Q => fs_counter_reg(6),
      R => clear
    );
\fs_counter_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => audio_clk_i,
      CE => '1',
      D => \p_0_in__0\(7),
      Q => fs_counter_reg(7),
      R => clear
    );
\i2s_data[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => audio_right_i(0),
      I1 => fs_counter_reg(7),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(6),
      O => \i2s_data[16]_i_1_n_0\
    );
\i2s_data[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[16]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(1),
      O => \i2s_data[17]_i_1_n_0\
    );
\i2s_data[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[17]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(2),
      O => \i2s_data[18]_i_1_n_0\
    );
\i2s_data[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[18]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(3),
      O => \i2s_data[19]_i_1_n_0\
    );
\i2s_data[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[19]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(4),
      O => \i2s_data[20]_i_1_n_0\
    );
\i2s_data[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[20]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(5),
      O => \i2s_data[21]_i_1_n_0\
    );
\i2s_data[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[21]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(6),
      O => \i2s_data[22]_i_1_n_0\
    );
\i2s_data[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[22]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(7),
      O => \i2s_data[23]_i_1_n_0\
    );
\i2s_data[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[23]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(8),
      O => \i2s_data[24]_i_1_n_0\
    );
\i2s_data[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[24]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(9),
      O => \i2s_data[25]_i_1_n_0\
    );
\i2s_data[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[25]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(10),
      O => \i2s_data[26]_i_1_n_0\
    );
\i2s_data[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[26]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(11),
      O => \i2s_data[27]_i_1_n_0\
    );
\i2s_data[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[27]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(12),
      O => \i2s_data[28]_i_1_n_0\
    );
\i2s_data[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[28]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(13),
      O => \i2s_data[29]_i_1_n_0\
    );
\i2s_data[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[29]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(14),
      O => \i2s_data[30]_i_1_n_0\
    );
\i2s_data[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[30]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_right_i(15),
      O => \i2s_data[31]_i_1_n_0\
    );
\i2s_data[47]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
        port map (
      I0 => fs_counter_reg(7),
      I1 => \i2s_data[63]_i_3_n_0\,
      I2 => fs_counter_reg(6),
      I3 => \fs_counter_reg_n_0_[1]\,
      I4 => fs_counter_reg(0),
      O => \i2s_data[47]_i_1_n_0\
    );
\i2s_data[48]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[47]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(0),
      O => \i2s_data[48]_i_1_n_0\
    );
\i2s_data[49]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[48]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(1),
      O => \i2s_data[49]_i_1_n_0\
    );
\i2s_data[50]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[49]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(2),
      O => \i2s_data[50]_i_1_n_0\
    );
\i2s_data[51]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[50]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(3),
      O => \i2s_data[51]_i_1_n_0\
    );
\i2s_data[52]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[51]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(4),
      O => \i2s_data[52]_i_1_n_0\
    );
\i2s_data[53]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[52]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(5),
      O => \i2s_data[53]_i_1_n_0\
    );
\i2s_data[54]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[53]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(6),
      O => \i2s_data[54]_i_1_n_0\
    );
\i2s_data[55]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[54]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(7),
      O => \i2s_data[55]_i_1_n_0\
    );
\i2s_data[56]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[55]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(8),
      O => \i2s_data[56]_i_1_n_0\
    );
\i2s_data[57]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[56]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(9),
      O => \i2s_data[57]_i_1_n_0\
    );
\i2s_data[58]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[57]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(10),
      O => \i2s_data[58]_i_1_n_0\
    );
\i2s_data[59]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[58]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(11),
      O => \i2s_data[59]_i_1_n_0\
    );
\i2s_data[60]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[59]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(12),
      O => \i2s_data[60]_i_1_n_0\
    );
\i2s_data[61]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[60]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(13),
      O => \i2s_data[61]_i_1_n_0\
    );
\i2s_data[62]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[61]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(14),
      O => \i2s_data[62]_i_1_n_0\
    );
\i2s_data[63]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \fs_counter_reg_n_0_[1]\,
      I1 => fs_counter_reg(0),
      O => \i2s_data[63]_i_1_n_0\
    );
\i2s_data[63]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAAA2AA"
    )
        port map (
      I0 => \i2s_data_reg_n_0_[62]\,
      I1 => fs_counter_reg(6),
      I2 => \i2s_data[63]_i_3_n_0\,
      I3 => fs_counter_reg(7),
      I4 => audio_left_i(15),
      O => \i2s_data[63]_i_2_n_0\
    );
\i2s_data[63]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => fs_counter_reg(4),
      I1 => fs_counter_reg(2),
      I2 => fs_counter_reg(0),
      I3 => \fs_counter_reg_n_0_[1]\,
      I4 => fs_counter_reg(3),
      I5 => fs_counter_reg(5),
      O => \i2s_data[63]_i_3_n_0\
    );
\i2s_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[16]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[16]\,
      R => '0'
    );
\i2s_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[17]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[17]\,
      R => '0'
    );
\i2s_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[18]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[18]\,
      R => '0'
    );
\i2s_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[19]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[19]\,
      R => '0'
    );
\i2s_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[20]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[20]\,
      R => '0'
    );
\i2s_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[21]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[21]\,
      R => '0'
    );
\i2s_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[22]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[22]\,
      R => '0'
    );
\i2s_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[23]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[23]\,
      R => '0'
    );
\i2s_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[24]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[24]\,
      R => '0'
    );
\i2s_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[25]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[25]\,
      R => '0'
    );
\i2s_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[26]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[26]\,
      R => '0'
    );
\i2s_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[27]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[27]\,
      R => '0'
    );
\i2s_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[28]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[28]\,
      R => '0'
    );
\i2s_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[29]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[29]\,
      R => '0'
    );
\i2s_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[30]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[30]\,
      R => '0'
    );
\i2s_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[31]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[31]\,
      R => '0'
    );
\i2s_data_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[31]\,
      Q => \i2s_data_reg_n_0_[32]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[32]\,
      Q => \i2s_data_reg_n_0_[33]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[33]\,
      Q => \i2s_data_reg_n_0_[34]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[34]\,
      Q => \i2s_data_reg_n_0_[35]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[35]\,
      Q => \i2s_data_reg_n_0_[36]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[36]\,
      Q => \i2s_data_reg_n_0_[37]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[37]\,
      Q => \i2s_data_reg_n_0_[38]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[38]\,
      Q => \i2s_data_reg_n_0_[39]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[39]\,
      Q => \i2s_data_reg_n_0_[40]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[40]\,
      Q => \i2s_data_reg_n_0_[41]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[41]\,
      Q => \i2s_data_reg_n_0_[42]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[42]\,
      Q => \i2s_data_reg_n_0_[43]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[43]\,
      Q => \i2s_data_reg_n_0_[44]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[44]\,
      Q => \i2s_data_reg_n_0_[45]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[45]\,
      Q => \i2s_data_reg_n_0_[46]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data_reg_n_0_[46]\,
      Q => \i2s_data_reg_n_0_[47]\,
      R => \i2s_data[47]_i_1_n_0\
    );
\i2s_data_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[48]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[48]\,
      R => '0'
    );
\i2s_data_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[49]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[49]\,
      R => '0'
    );
\i2s_data_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[50]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[50]\,
      R => '0'
    );
\i2s_data_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[51]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[51]\,
      R => '0'
    );
\i2s_data_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[52]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[52]\,
      R => '0'
    );
\i2s_data_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[53]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[53]\,
      R => '0'
    );
\i2s_data_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[54]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[54]\,
      R => '0'
    );
\i2s_data_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[55]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[55]\,
      R => '0'
    );
\i2s_data_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[56]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[56]\,
      R => '0'
    );
\i2s_data_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[57]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[57]\,
      R => '0'
    );
\i2s_data_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[58]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[58]\,
      R => '0'
    );
\i2s_data_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[59]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[59]\,
      R => '0'
    );
\i2s_data_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[60]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[60]\,
      R => '0'
    );
\i2s_data_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[61]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[61]\,
      R => '0'
    );
\i2s_data_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[62]_i_1_n_0\,
      Q => \i2s_data_reg_n_0_[62]\,
      R => '0'
    );
\i2s_data_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => audio_clk_i,
      CE => \i2s_data[63]_i_1_n_0\,
      D => \i2s_data[63]_i_2_n_0\,
      Q => p_0_in,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Mega65_R6_audio_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Mega65_R6_audio_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Mega65_R6_audio_0_0 : entity is "Mega65_R6_audio_0_0,audio,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of Mega65_R6_audio_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of Mega65_R6_audio_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of Mega65_R6_audio_0_0 : entity is "audio,Vivado 2024.2.1";
end Mega65_R6_audio_0_0;

architecture STRUCTURE of Mega65_R6_audio_0_0 is
  signal \^audio_clk_i\ : STD_LOGIC;
begin
  \^audio_clk_i\ <= audio_clk_i;
  audio_mclk_o <= \^audio_clk_i\;
U0: entity work.Mega65_R6_audio_0_0_audio
     port map (
      audio_bick_o => audio_bick_o,
      audio_clk_i => \^audio_clk_i\,
      audio_left_i(15 downto 0) => audio_left_i(15 downto 0),
      audio_lrclk_o => audio_lrclk_o,
      audio_right_i(15 downto 0) => audio_right_i(15 downto 0),
      audio_sdti_o => audio_sdti_o
    );
audio_pdn_n_o_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => audio_reset_i,
      O => audio_pdn_n_o
    );
end STRUCTURE;
