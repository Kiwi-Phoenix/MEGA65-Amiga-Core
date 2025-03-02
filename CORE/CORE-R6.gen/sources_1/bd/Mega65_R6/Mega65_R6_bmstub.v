// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module Mega65_R6 (
  clk_i,
  reset_button_i,
  uart_rxd_i,
  uart_txd_o,
  vga_red_o,
  vga_green_o,
  vga_blue_o,
  vga_hs_o,
  vga_vs_o,
  vga_scl_io,
  vga_sda_io,
  vdac_clk_o,
  vdac_sync_n_o,
  vdac_blank_n_o,
  vdac_psave_n_o,
  tmds_data_p_o,
  tmds_data_n_o,
  tmds_clk_p_o,
  tmds_clk_n_o,
  hdmi_hiz_en_o,
  hdmi_ls_oe_n_o,
  hdmi_hpd_i,
  hdmi_scl_io,
  hdmi_sda_io,
  kb_io0_o,
  kb_io1_o,
  kb_io2_i,
  kb_tck_o,
  kb_tdo_i,
  kb_tms_o,
  kb_tdi_o,
  kb_jtagen_o,
  sd_mosi_o,
  sd_miso_i,
  sd_cd_i,
  sd_d1_i,
  sd_d2_i,
  sd2_reset_o,
  sd_clk_o,
  sd_reset_o,
  sd2_clk_o,
  sd2_mosi_o,
  sd2_miso_i,
  sd2_cd_i,
  sd2_wp_i,
  sd2_d1_i,
  sd2_d2_i,
  audio_mclk_o,
  audio_bick_o,
  audio_sdti_o,
  audio_lrclk_o,
  audio_pdn_n_o,
  audio_i2cfil_o,
  audio_scl_io,
  audio_sda_io,
  fa_up_n_i,
  fa_down_n_i,
  fa_left_n_i,
  fa_right_n_i,
  fa_fire_n_i,
  fa_fire_n_o,
  fa_up_n_o,
  fa_left_n_o,
  fa_down_n_o,
  fa_right_n_o,
  fb_up_n_i,
  fb_down_n_i,
  fb_left_n_i,
  fb_right_n_i,
  fb_fire_n_i,
  fb_up_n_o,
  fb_down_n_o,
  fb_fire_n_o,
  fb_right_n_o,
  fb_left_n_o,
  joystick_5v_disable_o,
  joystick_5v_powergood_i,
  paddle_i,
  paddle_drain_o,
  hr_d_io,
  hr_rwds_io,
  hr_reset_o,
  hr_clk_p_o,
  hr_cs0_o,
  iec_reset_n_o,
  iec_atn_n_o,
  iec_clk_en_n_o,
  iec_clk_n_i,
  iec_clk_n_o,
  iec_data_en_n_o,
  iec_data_n_i,
  iec_data_n_o,
  iec_srq_en_n_o,
  iec_srq_n_i,
  iec_srq_n_o,
  cart_phi2_o,
  cart_dotclock_o,
  cart_dma_i,
  cart_reset_oe_n_o,
  cart_reset_io,
  cart_game_oe_n_o,
  cart_game_io,
  cart_exrom_oe_n_o,
  cart_exrom_io,
  cart_nmi_oe_n_o,
  cart_nmi_io,
  cart_irq_oe_n_o,
  cart_irq_io,
  cart_ctrl_en_o,
  cart_ctrl_dir_o,
  cart_ba_io,
  cart_rw_io,
  cart_io1_io,
  cart_io2_io,
  cart_romh_oe_n_o,
  cart_romh_io,
  cart_roml_oe_n_o,
  cart_roml_io,
  cart_en_o,
  cart_addr_en_o,
  cart_haddr_dir_o,
  cart_laddr_dir_o,
  cart_a_io,
  cart_data_en_o,
  cart_data_dir_o,
  cart_d_io,
  eth_clock_o,
  eth_led2_o,
  eth_mdc_o,
  eth_mdio_io,
  eth_reset_o,
  eth_rxd_i,
  eth_rxdv_i,
  eth_rxer_i,
  eth_txd_o,
  eth_txen_o,
  f_density_o,
  f_diskchanged_i,
  f_index_i,
  f_motora_o,
  f_motorb_o,
  f_rdata_i,
  f_selecta_o,
  f_selectb_o,
  f_side1_o,
  f_stepdir_o,
  f_step_o,
  f_track0_i,
  f_wdata_o,
  f_wgate_o,
  f_writeprotect_i,
  fpga_sda_io,
  fpga_scl_io,
  grove_sda_io,
  grove_scl_io,
  led_g_n_o,
  led_r_n_o,
  led_o,
  p1lo_io,
  p1hi_io,
  p2lo_io,
  p2hi_io,
  pmod1_en_o,
  pmod1_flag_i,
  pmod2_en_o,
  pmod2_flag_i,
  qspidb_io,
  qspicsn_o,
  i2c_scl_io,
  i2c_sda_io,
  dbg_io_11,
  sdram_clk_o,
  sdram_cke_o,
  sdram_ras_n_o,
  sdram_cas_n_o,
  sdram_we_n_o,
  sdram_cs_n_o,
  sdram_ba_o,
  sdram_a_o,
  sdram_dqml_o,
  sdram_dqmh_o,
  sdram_dq_io
);

  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_I CLK" *)
  (* X_INTERFACE_MODE = "slave CLK.CLK_I" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_I, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN Mega65_R6_clk_i, INSERT_VIP 0" *)
  input clk_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_BUTTON_I RST" *)
  (* X_INTERFACE_MODE = "slave RST.RESET_BUTTON_I" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_BUTTON_I, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input reset_button_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input uart_rxd_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output uart_txd_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output [7:0]vga_red_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output [7:0]vga_green_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output [7:0]vga_blue_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output vga_hs_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output vga_vs_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout vga_scl_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout vga_sda_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output vdac_clk_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output vdac_sync_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output vdac_blank_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output vdac_psave_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output [2:0]tmds_data_p_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output [2:0]tmds_data_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output tmds_clk_p_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output tmds_clk_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output hdmi_hiz_en_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output hdmi_ls_oe_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input hdmi_hpd_i;
  (* X_INTERFACE_IGNORE = "true" *)
  inout hdmi_scl_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout hdmi_sda_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output kb_io0_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output kb_io1_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input kb_io2_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output kb_tck_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input kb_tdo_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output kb_tms_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output kb_tdi_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output kb_jtagen_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sd_mosi_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd_miso_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd_cd_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd_d1_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd_d2_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.SD2_RESET_O RST" *)
  (* X_INTERFACE_MODE = "master RST.SD2_RESET_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.SD2_RESET_O, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  output sd2_reset_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SD_CLK_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.SD_CLK_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SD_CLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output sd_clk_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.SD_RESET_O RST" *)
  (* X_INTERFACE_MODE = "master RST.SD_RESET_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.SD_RESET_O, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  output sd_reset_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SD2_CLK_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.SD2_CLK_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SD2_CLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output sd2_clk_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sd2_mosi_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd2_miso_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd2_cd_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd2_wp_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd2_d1_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input sd2_d2_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AUDIO_MCLK_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.AUDIO_MCLK_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AUDIO_MCLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output audio_mclk_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.AUDIO_BICK_O DATA" *)
  (* X_INTERFACE_MODE = "master DATA.AUDIO_BICK_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.AUDIO_BICK_O, LAYERED_METADATA undef" *)
  output audio_bick_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.AUDIO_SDTI_O DATA" *)
  (* X_INTERFACE_MODE = "master DATA.AUDIO_SDTI_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.AUDIO_SDTI_O, LAYERED_METADATA undef" *)
  output audio_sdti_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AUDIO_LRCLK_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.AUDIO_LRCLK_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AUDIO_LRCLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output audio_lrclk_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.AUDIO_PDN_N_O RST" *)
  (* X_INTERFACE_MODE = "master RST.AUDIO_PDN_N_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.AUDIO_PDN_N_O, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  output audio_pdn_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output audio_i2cfil_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.AUDIO_SCL_IO DATA" *)
  (* X_INTERFACE_MODE = "slave DATA.AUDIO_SCL_IO" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.AUDIO_SCL_IO, LAYERED_METADATA undef" *)
  inout audio_scl_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.AUDIO_SDA_IO DATA" *)
  (* X_INTERFACE_MODE = "slave DATA.AUDIO_SDA_IO" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.AUDIO_SDA_IO, LAYERED_METADATA undef" *)
  inout audio_sda_io;
  (* X_INTERFACE_IGNORE = "true" *)
  input fa_up_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input fa_down_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input fa_left_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input fa_right_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input fa_fire_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output fa_fire_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output fa_up_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output fa_left_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output fa_down_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output fa_right_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input fb_up_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input fb_down_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input fb_left_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input fb_right_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input fb_fire_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output fb_up_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output fb_down_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output fb_fire_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output fb_right_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output fb_left_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output joystick_5v_disable_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input joystick_5v_powergood_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input [3:0]paddle_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output paddle_drain_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [7:0]hr_d_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout hr_rwds_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.HR_RESET_O RST" *)
  (* X_INTERFACE_MODE = "master RST.HR_RESET_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.HR_RESET_O, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  output hr_reset_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.HR_CLK_P_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.HR_CLK_P_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.HR_CLK_P_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output hr_clk_p_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output hr_cs0_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.IEC_RESET_N_O RST" *)
  (* X_INTERFACE_MODE = "master RST.IEC_RESET_N_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.IEC_RESET_N_O, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  output iec_reset_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output iec_atn_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.IEC_CLK_EN_N_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.IEC_CLK_EN_N_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.IEC_CLK_EN_N_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output iec_clk_en_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 CE.IEC_CLK_N_I CE" *)
  (* X_INTERFACE_MODE = "slave CE.IEC_CLK_N_I" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CE.IEC_CLK_N_I, POLARITY ACTIVE_LOW" *)
  input iec_clk_n_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.IEC_CLK_N_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.IEC_CLK_N_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.IEC_CLK_N_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output iec_clk_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.IEC_DATA_EN_N_O DATA" *)
  (* X_INTERFACE_MODE = "master DATA.IEC_DATA_EN_N_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.IEC_DATA_EN_N_O, LAYERED_METADATA undef" *)
  output iec_data_en_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.IEC_DATA_N_I DATA" *)
  (* X_INTERFACE_MODE = "slave DATA.IEC_DATA_N_I" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.IEC_DATA_N_I, LAYERED_METADATA undef" *)
  input iec_data_n_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.IEC_DATA_N_O DATA" *)
  (* X_INTERFACE_MODE = "master DATA.IEC_DATA_N_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.IEC_DATA_N_O, LAYERED_METADATA undef" *)
  output iec_data_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output iec_srq_en_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input iec_srq_n_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output iec_srq_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_phi2_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CART_DOTCLOCK_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.CART_DOTCLOCK_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CART_DOTCLOCK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output cart_dotclock_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input cart_dma_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.CART_RESET_OE_N_O RST" *)
  (* X_INTERFACE_MODE = "master RST.CART_RESET_OE_N_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.CART_RESET_OE_N_O, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  output cart_reset_oe_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.CART_RESET_IO RST" *)
  (* X_INTERFACE_MODE = "slave RST.CART_RESET_IO" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.CART_RESET_IO, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  inout cart_reset_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_game_oe_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_game_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_exrom_oe_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_exrom_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_nmi_oe_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_nmi_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_irq_oe_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_irq_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_ctrl_en_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_ctrl_dir_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_ba_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_rw_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_io1_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_io2_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_romh_oe_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_romh_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_roml_oe_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout cart_roml_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_en_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_addr_en_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_haddr_dir_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output cart_laddr_dir_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [15:0]cart_a_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.CART_DATA_EN_O DATA" *)
  (* X_INTERFACE_MODE = "master DATA.CART_DATA_EN_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.CART_DATA_EN_O, LAYERED_METADATA undef" *)
  output cart_data_en_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.CART_DATA_DIR_O DATA" *)
  (* X_INTERFACE_MODE = "master DATA.CART_DATA_DIR_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.CART_DATA_DIR_O, LAYERED_METADATA undef" *)
  output cart_data_dir_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [7:0]cart_d_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ETH_CLOCK_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.ETH_CLOCK_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ETH_CLOCK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output eth_clock_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output eth_led2_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output eth_mdc_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout eth_mdio_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ETH_RESET_O RST" *)
  (* X_INTERFACE_MODE = "master RST.ETH_RESET_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ETH_RESET_O, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  output eth_reset_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input [1:0]eth_rxd_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input eth_rxdv_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input eth_rxer_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output [1:0]eth_txd_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output eth_txen_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_density_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input f_diskchanged_i;
  (* X_INTERFACE_IGNORE = "true" *)
  input f_index_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_motora_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_motorb_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.F_RDATA_I DATA" *)
  (* X_INTERFACE_MODE = "slave DATA.F_RDATA_I" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.F_RDATA_I, LAYERED_METADATA undef" *)
  input f_rdata_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_selecta_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_selectb_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_side1_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_stepdir_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_step_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input f_track0_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_wdata_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output f_wgate_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input f_writeprotect_i;
  (* X_INTERFACE_IGNORE = "true" *)
  inout fpga_sda_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout fpga_scl_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout grove_sda_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout grove_scl_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output led_g_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output led_r_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output led_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [3:0]p1lo_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [3:0]p1hi_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [3:0]p2lo_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [3:0]p2hi_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output pmod1_en_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input pmod1_flag_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output pmod2_en_o;
  (* X_INTERFACE_IGNORE = "true" *)
  input pmod2_flag_i;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [3:0]qspidb_io;
  (* X_INTERFACE_IGNORE = "true" *)
  output qspicsn_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout i2c_scl_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout i2c_sda_io;
  (* X_INTERFACE_IGNORE = "true" *)
  inout dbg_io_11;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SDRAM_CLK_O CLK" *)
  (* X_INTERFACE_MODE = "master CLK.SDRAM_CLK_O" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SDRAM_CLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
  output sdram_clk_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sdram_cke_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sdram_ras_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sdram_cas_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sdram_we_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sdram_cs_n_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output [1:0]sdram_ba_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output [12:0]sdram_a_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sdram_dqml_o;
  (* X_INTERFACE_IGNORE = "true" *)
  output sdram_dqmh_o;
  (* X_INTERFACE_IGNORE = "true" *)
  inout [15:0]sdram_dq_io;

  // stub module has no contents

endmodule
