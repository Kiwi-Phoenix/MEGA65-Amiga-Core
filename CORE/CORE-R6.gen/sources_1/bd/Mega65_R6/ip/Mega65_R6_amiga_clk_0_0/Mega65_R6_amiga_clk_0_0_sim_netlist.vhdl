-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
-- Date        : Sat Feb 22 14:34:40 2025
-- Host        : Retro-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/bd/Mega65_R6/ip/Mega65_R6_amiga_clk_0_0/Mega65_R6_amiga_clk_0_0_sim_netlist.vhdl
-- Design      : Mega65_R6_amiga_clk_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Mega65_R6_amiga_clk_0_0_amiga_clk is
  port (
    clk7_en : out STD_LOGIC;
    clk7n_en : out STD_LOGIC;
    c3 : out STD_LOGIC;
    c1 : out STD_LOGIC;
    cck : out STD_LOGIC;
    eclk : out STD_LOGIC_VECTOR ( 9 downto 0 );
    clk_28 : in STD_LOGIC;
    reset_n : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of Mega65_R6_amiga_clk_0_0_amiga_clk : entity is "amiga_clk";
end Mega65_R6_amiga_clk_0_0_amiga_clk;

architecture STRUCTURE of Mega65_R6_amiga_clk_0_0_amiga_clk is
  signal c1_i_1_n_0 : STD_LOGIC;
  signal \^c3\ : STD_LOGIC;
  signal \^cck\ : STD_LOGIC;
  signal cck_i_2_n_0 : STD_LOGIC;
  signal \clk7_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal clk7_en_reg_i_1_n_0 : STD_LOGIC;
  signal clk7_en_reg_i_2_n_0 : STD_LOGIC;
  signal clk7n_en_reg_i_1_n_0 : STD_LOGIC;
  signal clk_7 : STD_LOGIC;
  signal \^eclk\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal p_0_in : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal shifter : STD_LOGIC;
  signal \shifter[0]_i_1_n_0\ : STD_LOGIC;
  signal \shifter[0]_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \clk7_cnt[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of clk7_en_reg_i_1 : label is "soft_lutpair0";
begin
  c3 <= \^c3\;
  cck <= \^cck\;
  eclk(9 downto 0) <= \^eclk\(9 downto 0);
c1_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^c3\,
      O => c1_i_1_n_0
    );
c1_reg: unisim.vcomponents.FDRE
     port map (
      C => clk_28,
      CE => '1',
      D => c1_i_1_n_0,
      Q => c1,
      R => '0'
    );
c3_reg: unisim.vcomponents.FDRE
     port map (
      C => clk_28,
      CE => '1',
      D => clk_7,
      Q => \^c3\,
      R => '0'
    );
cck_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \clk7_cnt_reg_n_0_[0]\,
      I1 => clk_7,
      O => shifter
    );
cck_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^cck\,
      O => cck_i_2_n_0
    );
cck_reg: unisim.vcomponents.FDPE
     port map (
      C => clk_28,
      CE => shifter,
      D => cck_i_2_n_0,
      PRE => clk7_en_reg_i_2_n_0,
      Q => \^cck\
    );
\clk7_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \clk7_cnt_reg_n_0_[0]\,
      O => p_0_in(0)
    );
\clk7_cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \clk7_cnt_reg_n_0_[0]\,
      I1 => clk_7,
      O => p_0_in(1)
    );
\clk7_cnt_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_28,
      CE => '1',
      CLR => clk7_en_reg_i_2_n_0,
      D => p_0_in(0),
      Q => \clk7_cnt_reg_n_0_[0]\
    );
\clk7_cnt_reg[1]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk_28,
      CE => '1',
      D => p_0_in(1),
      PRE => clk7_en_reg_i_2_n_0,
      Q => clk_7
    );
clk7_en_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => clk_7,
      I1 => \clk7_cnt_reg_n_0_[0]\,
      O => clk7_en_reg_i_1_n_0
    );
clk7_en_reg_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => reset_n,
      O => clk7_en_reg_i_2_n_0
    );
clk7_en_reg_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk_28,
      CE => '1',
      D => clk7_en_reg_i_1_n_0,
      PRE => clk7_en_reg_i_2_n_0,
      Q => clk7_en
    );
clk7n_en_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => clk_7,
      I1 => \clk7_cnt_reg_n_0_[0]\,
      O => clk7n_en_reg_i_1_n_0
    );
clk7n_en_reg_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk_28,
      CE => '1',
      D => clk7n_en_reg_i_1_n_0,
      PRE => clk7_en_reg_i_2_n_0,
      Q => clk7n_en
    );
\shifter[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0010"
    )
        port map (
      I0 => \^eclk\(8),
      I1 => \^eclk\(6),
      I2 => \shifter[0]_i_2_n_0\,
      I3 => \^eclk\(7),
      I4 => \^eclk\(9),
      O => \shifter[0]_i_1_n_0\
    );
\shifter[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \^eclk\(4),
      I1 => \^eclk\(3),
      I2 => \^eclk\(1),
      I3 => \^eclk\(0),
      I4 => \^eclk\(2),
      I5 => \^eclk\(5),
      O => \shifter[0]_i_2_n_0\
    );
\shifter_reg[0]\: unisim.vcomponents.FDPE
     port map (
      C => clk_28,
      CE => shifter,
      D => \shifter[0]_i_1_n_0\,
      PRE => clk7_en_reg_i_2_n_0,
      Q => \^eclk\(0)
    );
\shifter_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(0),
      Q => \^eclk\(1)
    );
\shifter_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(1),
      Q => \^eclk\(2)
    );
\shifter_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(2),
      Q => \^eclk\(3)
    );
\shifter_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(3),
      Q => \^eclk\(4)
    );
\shifter_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(4),
      Q => \^eclk\(5)
    );
\shifter_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(5),
      Q => \^eclk\(6)
    );
\shifter_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(6),
      Q => \^eclk\(7)
    );
\shifter_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(7),
      Q => \^eclk\(8)
    );
\shifter_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk_28,
      CE => shifter,
      CLR => clk7_en_reg_i_2_n_0,
      D => \^eclk\(8),
      Q => \^eclk\(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Mega65_R6_amiga_clk_0_0 is
  port (
    clk_28 : in STD_LOGIC;
    clk7_en : out STD_LOGIC;
    clk7n_en : out STD_LOGIC;
    c1 : out STD_LOGIC;
    c3 : out STD_LOGIC;
    cck : out STD_LOGIC;
    eclk : out STD_LOGIC_VECTOR ( 9 downto 0 );
    reset_n : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Mega65_R6_amiga_clk_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Mega65_R6_amiga_clk_0_0 : entity is "Mega65_R6_amiga_clk_0_0,amiga_clk,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of Mega65_R6_amiga_clk_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of Mega65_R6_amiga_clk_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of Mega65_R6_amiga_clk_0_0 : entity is "amiga_clk,Vivado 2024.2.1";
end Mega65_R6_amiga_clk_0_0;

architecture STRUCTURE of Mega65_R6_amiga_clk_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of reset_n : signal is "xilinx.com:signal:reset:1.0 reset_n RST";
  attribute x_interface_mode : string;
  attribute x_interface_mode of reset_n : signal is "slave reset_n";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of reset_n : signal is "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
U0: entity work.Mega65_R6_amiga_clk_0_0_amiga_clk
     port map (
      c1 => c1,
      c3 => c3,
      cck => cck,
      clk7_en => clk7_en,
      clk7n_en => clk7n_en,
      clk_28 => clk_28,
      eclk(9 downto 0) => eclk(9 downto 0),
      reset_n => reset_n
    );
end STRUCTURE;
