//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
//Date        : Sat Jan 18 13:44:35 2025
//Host        : Retro-PC running 64-bit major release  (build 9200)
//Command     : generate_target Mega65_R6_wrapper.bd
//Design      : Mega65_R6_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Mega65_R6_wrapper
   (audio_bick_o,
    audio_i2cfil_o,
    audio_lrclk_o,
    audio_mclk_o,
    audio_pdn_n_o,
    audio_scl_io,
    audio_sda_io,
    audio_sdti_o,
    cart_a_io,
    cart_addr_en_o,
    cart_ba_io,
    cart_ctrl_dir_o,
    cart_ctrl_en_o,
    cart_d_io,
    cart_data_dir_o,
    cart_data_en_o,
    cart_dma_i,
    cart_dotclock_o,
    cart_en_o,
    cart_exrom_io,
    cart_exrom_oe_n_o,
    cart_game_io,
    cart_game_oe_n_o,
    cart_haddr_dir_o,
    cart_io1_io,
    cart_io2_io,
    cart_irq_io,
    cart_irq_oe_n_o,
    cart_laddr_dir_o,
    cart_nmi_io,
    cart_nmi_oe_n_o,
    cart_phi2_o,
    cart_reset_io,
    cart_reset_oe_n_o,
    cart_romh_io,
    cart_romh_oe_n_o,
    cart_roml_io,
    cart_roml_oe_n_o,
    cart_rw_io,
    clk_i,
    dbg_io_11,
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
    f_step_o,
    f_stepdir_o,
    f_track0_i,
    f_wdata_o,
    f_wgate_o,
    f_writeprotect_i,
    fa_down_n_i,
    fa_down_n_o,
    fa_fire_n_i,
    fa_fire_n_o,
    fa_left_n_i,
    fa_left_n_o,
    fa_right_n_i,
    fa_right_n_o,
    fa_up_n_i,
    fa_up_n_o,
    fb_down_n_i,
    fb_down_n_o,
    fb_fire_n_i,
    fb_fire_n_o,
    fb_left_n_i,
    fb_left_n_o,
    fb_right_n_i,
    fb_right_n_o,
    fb_up_n_i,
    fb_up_n_o,
    fpga_scl_io,
    fpga_sda_io,
    grove_scl_io,
    grove_sda_io,
    hdmi_hiz_en_o,
    hdmi_hpd_i,
    hdmi_ls_oe_n_o,
    hdmi_scl_io,
    hdmi_sda_io,
    hr_clk_p_o,
    hr_cs0_o,
    hr_d_io,
    hr_reset_o,
    hr_rwds_io,
    i2c_scl_io,
    i2c_sda_io,
    iec_atn_n_o,
    iec_clk_en_n_o,
    iec_clk_n_i,
    iec_clk_n_o,
    iec_data_en_n_o,
    iec_data_n_i,
    iec_data_n_o,
    iec_reset_n_o,
    iec_srq_en_n_o,
    iec_srq_n_i,
    iec_srq_n_o,
    joystick_5v_disable_o,
    joystick_5v_powergood_i,
    kb_io0_o,
    kb_io1_o,
    kb_io2_i,
    kb_jtagen_o,
    kb_tck_o,
    kb_tdi_o,
    kb_tdo_i,
    kb_tms_o,
    led_g_n_o,
    led_o,
    led_r_n_o,
    p1hi_io,
    p1lo_io,
    p2hi_io,
    p2lo_io,
    paddle_drain_o,
    paddle_i,
    pmod1_en_o,
    pmod1_flag_i,
    pmod2_en_o,
    pmod2_flag_i,
    qspicsn_o,
    qspidb_io,
    reset_button_i,
    sd2_cd_i,
    sd2_clk_o,
    sd2_d1_i,
    sd2_d2_i,
    sd2_miso_i,
    sd2_mosi_o,
    sd2_reset_o,
    sd2_wp_i,
    sd_cd_i,
    sd_clk_o,
    sd_d1_i,
    sd_d2_i,
    sd_miso_i,
    sd_mosi_o,
    sd_reset_o,
    sdram_a_o,
    sdram_ba_o,
    sdram_cas_n_o,
    sdram_cke_o,
    sdram_clk_o,
    sdram_cs_n_o,
    sdram_dq_io,
    sdram_dqmh_o,
    sdram_dqml_o,
    sdram_ras_n_o,
    sdram_we_n_o,
    tmds_clk_n_o,
    tmds_clk_p_o,
    tmds_data_n_o,
    tmds_data_p_o,
    uart_rxd_i,
    uart_txd_o,
    vdac_blank_n_o,
    vdac_clk_o,
    vdac_psave_n_o,
    vdac_sync_n_o,
    vga_blue_o,
    vga_green_o,
    vga_hs_o,
    vga_red_o,
    vga_scl_io,
    vga_sda_io,
    vga_vs_o);
  output audio_bick_o;
  output audio_i2cfil_o;
  output audio_lrclk_o;
  output audio_mclk_o;
  output audio_pdn_n_o;
  inout audio_scl_io;
  inout audio_sda_io;
  output audio_sdti_o;
  inout [15:0]cart_a_io;
  output cart_addr_en_o;
  inout cart_ba_io;
  output cart_ctrl_dir_o;
  output cart_ctrl_en_o;
  inout [7:0]cart_d_io;
  output cart_data_dir_o;
  output cart_data_en_o;
  input cart_dma_i;
  output cart_dotclock_o;
  output cart_en_o;
  inout cart_exrom_io;
  output cart_exrom_oe_n_o;
  inout cart_game_io;
  output cart_game_oe_n_o;
  output cart_haddr_dir_o;
  inout cart_io1_io;
  inout cart_io2_io;
  inout cart_irq_io;
  output cart_irq_oe_n_o;
  output cart_laddr_dir_o;
  inout cart_nmi_io;
  output cart_nmi_oe_n_o;
  output cart_phi2_o;
  inout cart_reset_io;
  output cart_reset_oe_n_o;
  inout cart_romh_io;
  output cart_romh_oe_n_o;
  inout cart_roml_io;
  output cart_roml_oe_n_o;
  inout cart_rw_io;
  input clk_i;
  inout dbg_io_11;
  output eth_clock_o;
  output eth_led2_o;
  output eth_mdc_o;
  inout eth_mdio_io;
  output eth_reset_o;
  input [1:0]eth_rxd_i;
  input eth_rxdv_i;
  input eth_rxer_i;
  output [1:0]eth_txd_o;
  output eth_txen_o;
  output f_density_o;
  input f_diskchanged_i;
  input f_index_i;
  output f_motora_o;
  output f_motorb_o;
  input f_rdata_i;
  output f_selecta_o;
  output f_selectb_o;
  output f_side1_o;
  output f_step_o;
  output f_stepdir_o;
  input f_track0_i;
  output f_wdata_o;
  output f_wgate_o;
  input f_writeprotect_i;
  input fa_down_n_i;
  output fa_down_n_o;
  input fa_fire_n_i;
  output fa_fire_n_o;
  input fa_left_n_i;
  output fa_left_n_o;
  input fa_right_n_i;
  output fa_right_n_o;
  input fa_up_n_i;
  output fa_up_n_o;
  input fb_down_n_i;
  output fb_down_n_o;
  input fb_fire_n_i;
  output fb_fire_n_o;
  input fb_left_n_i;
  output fb_left_n_o;
  input fb_right_n_i;
  output fb_right_n_o;
  input fb_up_n_i;
  output fb_up_n_o;
  inout fpga_scl_io;
  inout fpga_sda_io;
  inout grove_scl_io;
  inout grove_sda_io;
  output hdmi_hiz_en_o;
  input hdmi_hpd_i;
  output hdmi_ls_oe_n_o;
  inout hdmi_scl_io;
  inout hdmi_sda_io;
  output hr_clk_p_o;
  output hr_cs0_o;
  inout [7:0]hr_d_io;
  output hr_reset_o;
  inout hr_rwds_io;
  inout i2c_scl_io;
  inout i2c_sda_io;
  output iec_atn_n_o;
  output iec_clk_en_n_o;
  input iec_clk_n_i;
  output iec_clk_n_o;
  output iec_data_en_n_o;
  input iec_data_n_i;
  output iec_data_n_o;
  output iec_reset_n_o;
  output iec_srq_en_n_o;
  input iec_srq_n_i;
  output iec_srq_n_o;
  output joystick_5v_disable_o;
  input joystick_5v_powergood_i;
  output kb_io0_o;
  output kb_io1_o;
  input kb_io2_i;
  output kb_jtagen_o;
  output kb_tck_o;
  output kb_tdi_o;
  input kb_tdo_i;
  output kb_tms_o;
  output led_g_n_o;
  output led_o;
  output led_r_n_o;
  inout [3:0]p1hi_io;
  inout [3:0]p1lo_io;
  inout [3:0]p2hi_io;
  inout [3:0]p2lo_io;
  output paddle_drain_o;
  input [3:0]paddle_i;
  output pmod1_en_o;
  input pmod1_flag_i;
  output pmod2_en_o;
  input pmod2_flag_i;
  output qspicsn_o;
  inout [3:0]qspidb_io;
  input reset_button_i;
  input sd2_cd_i;
  output sd2_clk_o;
  input sd2_d1_i;
  input sd2_d2_i;
  input sd2_miso_i;
  output sd2_mosi_o;
  output sd2_reset_o;
  input sd2_wp_i;
  input sd_cd_i;
  output sd_clk_o;
  input sd_d1_i;
  input sd_d2_i;
  input sd_miso_i;
  output sd_mosi_o;
  output sd_reset_o;
  output [12:0]sdram_a_o;
  output [1:0]sdram_ba_o;
  output sdram_cas_n_o;
  output sdram_cke_o;
  output sdram_clk_o;
  output sdram_cs_n_o;
  inout [15:0]sdram_dq_io;
  output sdram_dqmh_o;
  output sdram_dqml_o;
  output sdram_ras_n_o;
  output sdram_we_n_o;
  output tmds_clk_n_o;
  output tmds_clk_p_o;
  output [2:0]tmds_data_n_o;
  output [2:0]tmds_data_p_o;
  input uart_rxd_i;
  output uart_txd_o;
  output vdac_blank_n_o;
  output vdac_clk_o;
  output vdac_psave_n_o;
  output vdac_sync_n_o;
  output [7:0]vga_blue_o;
  output [7:0]vga_green_o;
  output vga_hs_o;
  output [7:0]vga_red_o;
  inout vga_scl_io;
  inout vga_sda_io;
  output vga_vs_o;

  wire audio_bick_o;
  wire audio_i2cfil_o;
  wire audio_lrclk_o;
  wire audio_mclk_o;
  wire audio_pdn_n_o;
  wire audio_scl_io;
  wire audio_sda_io;
  wire audio_sdti_o;
  wire [15:0]cart_a_io;
  wire cart_addr_en_o;
  wire cart_ba_io;
  wire cart_ctrl_dir_o;
  wire cart_ctrl_en_o;
  wire [7:0]cart_d_io;
  wire cart_data_dir_o;
  wire cart_data_en_o;
  wire cart_dma_i;
  wire cart_dotclock_o;
  wire cart_en_o;
  wire cart_exrom_io;
  wire cart_exrom_oe_n_o;
  wire cart_game_io;
  wire cart_game_oe_n_o;
  wire cart_haddr_dir_o;
  wire cart_io1_io;
  wire cart_io2_io;
  wire cart_irq_io;
  wire cart_irq_oe_n_o;
  wire cart_laddr_dir_o;
  wire cart_nmi_io;
  wire cart_nmi_oe_n_o;
  wire cart_phi2_o;
  wire cart_reset_io;
  wire cart_reset_oe_n_o;
  wire cart_romh_io;
  wire cart_romh_oe_n_o;
  wire cart_roml_io;
  wire cart_roml_oe_n_o;
  wire cart_rw_io;
  wire clk_i;
  wire dbg_io_11;
  wire eth_clock_o;
  wire eth_led2_o;
  wire eth_mdc_o;
  wire eth_mdio_io;
  wire eth_reset_o;
  wire [1:0]eth_rxd_i;
  wire eth_rxdv_i;
  wire eth_rxer_i;
  wire [1:0]eth_txd_o;
  wire eth_txen_o;
  wire f_density_o;
  wire f_diskchanged_i;
  wire f_index_i;
  wire f_motora_o;
  wire f_motorb_o;
  wire f_rdata_i;
  wire f_selecta_o;
  wire f_selectb_o;
  wire f_side1_o;
  wire f_step_o;
  wire f_stepdir_o;
  wire f_track0_i;
  wire f_wdata_o;
  wire f_wgate_o;
  wire f_writeprotect_i;
  wire fa_down_n_i;
  wire fa_down_n_o;
  wire fa_fire_n_i;
  wire fa_fire_n_o;
  wire fa_left_n_i;
  wire fa_left_n_o;
  wire fa_right_n_i;
  wire fa_right_n_o;
  wire fa_up_n_i;
  wire fa_up_n_o;
  wire fb_down_n_i;
  wire fb_down_n_o;
  wire fb_fire_n_i;
  wire fb_fire_n_o;
  wire fb_left_n_i;
  wire fb_left_n_o;
  wire fb_right_n_i;
  wire fb_right_n_o;
  wire fb_up_n_i;
  wire fb_up_n_o;
  wire fpga_scl_io;
  wire fpga_sda_io;
  wire grove_scl_io;
  wire grove_sda_io;
  wire hdmi_hiz_en_o;
  wire hdmi_hpd_i;
  wire hdmi_ls_oe_n_o;
  wire hdmi_scl_io;
  wire hdmi_sda_io;
  wire hr_clk_p_o;
  wire hr_cs0_o;
  wire [7:0]hr_d_io;
  wire hr_reset_o;
  wire hr_rwds_io;
  wire i2c_scl_io;
  wire i2c_sda_io;
  wire iec_atn_n_o;
  wire iec_clk_en_n_o;
  wire iec_clk_n_i;
  wire iec_clk_n_o;
  wire iec_data_en_n_o;
  wire iec_data_n_i;
  wire iec_data_n_o;
  wire iec_reset_n_o;
  wire iec_srq_en_n_o;
  wire iec_srq_n_i;
  wire iec_srq_n_o;
  wire joystick_5v_disable_o;
  wire joystick_5v_powergood_i;
  wire kb_io0_o;
  wire kb_io1_o;
  wire kb_io2_i;
  wire kb_jtagen_o;
  wire kb_tck_o;
  wire kb_tdi_o;
  wire kb_tdo_i;
  wire kb_tms_o;
  wire led_g_n_o;
  wire led_o;
  wire led_r_n_o;
  wire [3:0]p1hi_io;
  wire [3:0]p1lo_io;
  wire [3:0]p2hi_io;
  wire [3:0]p2lo_io;
  wire paddle_drain_o;
  wire [3:0]paddle_i;
  wire pmod1_en_o;
  wire pmod1_flag_i;
  wire pmod2_en_o;
  wire pmod2_flag_i;
  wire qspicsn_o;
  wire [3:0]qspidb_io;
  wire reset_button_i;
  wire sd2_cd_i;
  wire sd2_clk_o;
  wire sd2_d1_i;
  wire sd2_d2_i;
  wire sd2_miso_i;
  wire sd2_mosi_o;
  wire sd2_reset_o;
  wire sd2_wp_i;
  wire sd_cd_i;
  wire sd_clk_o;
  wire sd_d1_i;
  wire sd_d2_i;
  wire sd_miso_i;
  wire sd_mosi_o;
  wire sd_reset_o;
  wire [12:0]sdram_a_o;
  wire [1:0]sdram_ba_o;
  wire sdram_cas_n_o;
  wire sdram_cke_o;
  wire sdram_clk_o;
  wire sdram_cs_n_o;
  wire [15:0]sdram_dq_io;
  wire sdram_dqmh_o;
  wire sdram_dqml_o;
  wire sdram_ras_n_o;
  wire sdram_we_n_o;
  wire tmds_clk_n_o;
  wire tmds_clk_p_o;
  wire [2:0]tmds_data_n_o;
  wire [2:0]tmds_data_p_o;
  wire uart_rxd_i;
  wire uart_txd_o;
  wire vdac_blank_n_o;
  wire vdac_clk_o;
  wire vdac_psave_n_o;
  wire vdac_sync_n_o;
  wire [7:0]vga_blue_o;
  wire [7:0]vga_green_o;
  wire vga_hs_o;
  wire [7:0]vga_red_o;
  wire vga_scl_io;
  wire vga_sda_io;
  wire vga_vs_o;

  Mega65_R6 Mega65_R6_i
       (.audio_bick_o(audio_bick_o),
        .audio_i2cfil_o(audio_i2cfil_o),
        .audio_lrclk_o(audio_lrclk_o),
        .audio_mclk_o(audio_mclk_o),
        .audio_pdn_n_o(audio_pdn_n_o),
        .audio_scl_io(audio_scl_io),
        .audio_sda_io(audio_sda_io),
        .audio_sdti_o(audio_sdti_o),
        .cart_a_io(cart_a_io),
        .cart_addr_en_o(cart_addr_en_o),
        .cart_ba_io(cart_ba_io),
        .cart_ctrl_dir_o(cart_ctrl_dir_o),
        .cart_ctrl_en_o(cart_ctrl_en_o),
        .cart_d_io(cart_d_io),
        .cart_data_dir_o(cart_data_dir_o),
        .cart_data_en_o(cart_data_en_o),
        .cart_dma_i(cart_dma_i),
        .cart_dotclock_o(cart_dotclock_o),
        .cart_en_o(cart_en_o),
        .cart_exrom_io(cart_exrom_io),
        .cart_exrom_oe_n_o(cart_exrom_oe_n_o),
        .cart_game_io(cart_game_io),
        .cart_game_oe_n_o(cart_game_oe_n_o),
        .cart_haddr_dir_o(cart_haddr_dir_o),
        .cart_io1_io(cart_io1_io),
        .cart_io2_io(cart_io2_io),
        .cart_irq_io(cart_irq_io),
        .cart_irq_oe_n_o(cart_irq_oe_n_o),
        .cart_laddr_dir_o(cart_laddr_dir_o),
        .cart_nmi_io(cart_nmi_io),
        .cart_nmi_oe_n_o(cart_nmi_oe_n_o),
        .cart_phi2_o(cart_phi2_o),
        .cart_reset_io(cart_reset_io),
        .cart_reset_oe_n_o(cart_reset_oe_n_o),
        .cart_romh_io(cart_romh_io),
        .cart_romh_oe_n_o(cart_romh_oe_n_o),
        .cart_roml_io(cart_roml_io),
        .cart_roml_oe_n_o(cart_roml_oe_n_o),
        .cart_rw_io(cart_rw_io),
        .clk_i(clk_i),
        .dbg_io_11(dbg_io_11),
        .eth_clock_o(eth_clock_o),
        .eth_led2_o(eth_led2_o),
        .eth_mdc_o(eth_mdc_o),
        .eth_mdio_io(eth_mdio_io),
        .eth_reset_o(eth_reset_o),
        .eth_rxd_i(eth_rxd_i),
        .eth_rxdv_i(eth_rxdv_i),
        .eth_rxer_i(eth_rxer_i),
        .eth_txd_o(eth_txd_o),
        .eth_txen_o(eth_txen_o),
        .f_density_o(f_density_o),
        .f_diskchanged_i(f_diskchanged_i),
        .f_index_i(f_index_i),
        .f_motora_o(f_motora_o),
        .f_motorb_o(f_motorb_o),
        .f_rdata_i(f_rdata_i),
        .f_selecta_o(f_selecta_o),
        .f_selectb_o(f_selectb_o),
        .f_side1_o(f_side1_o),
        .f_step_o(f_step_o),
        .f_stepdir_o(f_stepdir_o),
        .f_track0_i(f_track0_i),
        .f_wdata_o(f_wdata_o),
        .f_wgate_o(f_wgate_o),
        .f_writeprotect_i(f_writeprotect_i),
        .fa_down_n_i(fa_down_n_i),
        .fa_down_n_o(fa_down_n_o),
        .fa_fire_n_i(fa_fire_n_i),
        .fa_fire_n_o(fa_fire_n_o),
        .fa_left_n_i(fa_left_n_i),
        .fa_left_n_o(fa_left_n_o),
        .fa_right_n_i(fa_right_n_i),
        .fa_right_n_o(fa_right_n_o),
        .fa_up_n_i(fa_up_n_i),
        .fa_up_n_o(fa_up_n_o),
        .fb_down_n_i(fb_down_n_i),
        .fb_down_n_o(fb_down_n_o),
        .fb_fire_n_i(fb_fire_n_i),
        .fb_fire_n_o(fb_fire_n_o),
        .fb_left_n_i(fb_left_n_i),
        .fb_left_n_o(fb_left_n_o),
        .fb_right_n_i(fb_right_n_i),
        .fb_right_n_o(fb_right_n_o),
        .fb_up_n_i(fb_up_n_i),
        .fb_up_n_o(fb_up_n_o),
        .fpga_scl_io(fpga_scl_io),
        .fpga_sda_io(fpga_sda_io),
        .grove_scl_io(grove_scl_io),
        .grove_sda_io(grove_sda_io),
        .hdmi_hiz_en_o(hdmi_hiz_en_o),
        .hdmi_hpd_i(hdmi_hpd_i),
        .hdmi_ls_oe_n_o(hdmi_ls_oe_n_o),
        .hdmi_scl_io(hdmi_scl_io),
        .hdmi_sda_io(hdmi_sda_io),
        .hr_clk_p_o(hr_clk_p_o),
        .hr_cs0_o(hr_cs0_o),
        .hr_d_io(hr_d_io),
        .hr_reset_o(hr_reset_o),
        .hr_rwds_io(hr_rwds_io),
        .i2c_scl_io(i2c_scl_io),
        .i2c_sda_io(i2c_sda_io),
        .iec_atn_n_o(iec_atn_n_o),
        .iec_clk_en_n_o(iec_clk_en_n_o),
        .iec_clk_n_i(iec_clk_n_i),
        .iec_clk_n_o(iec_clk_n_o),
        .iec_data_en_n_o(iec_data_en_n_o),
        .iec_data_n_i(iec_data_n_i),
        .iec_data_n_o(iec_data_n_o),
        .iec_reset_n_o(iec_reset_n_o),
        .iec_srq_en_n_o(iec_srq_en_n_o),
        .iec_srq_n_i(iec_srq_n_i),
        .iec_srq_n_o(iec_srq_n_o),
        .joystick_5v_disable_o(joystick_5v_disable_o),
        .joystick_5v_powergood_i(joystick_5v_powergood_i),
        .kb_io0_o(kb_io0_o),
        .kb_io1_o(kb_io1_o),
        .kb_io2_i(kb_io2_i),
        .kb_jtagen_o(kb_jtagen_o),
        .kb_tck_o(kb_tck_o),
        .kb_tdi_o(kb_tdi_o),
        .kb_tdo_i(kb_tdo_i),
        .kb_tms_o(kb_tms_o),
        .led_g_n_o(led_g_n_o),
        .led_o(led_o),
        .led_r_n_o(led_r_n_o),
        .p1hi_io(p1hi_io),
        .p1lo_io(p1lo_io),
        .p2hi_io(p2hi_io),
        .p2lo_io(p2lo_io),
        .paddle_drain_o(paddle_drain_o),
        .paddle_i(paddle_i),
        .pmod1_en_o(pmod1_en_o),
        .pmod1_flag_i(pmod1_flag_i),
        .pmod2_en_o(pmod2_en_o),
        .pmod2_flag_i(pmod2_flag_i),
        .qspicsn_o(qspicsn_o),
        .qspidb_io(qspidb_io),
        .reset_button_i(reset_button_i),
        .sd2_cd_i(sd2_cd_i),
        .sd2_clk_o(sd2_clk_o),
        .sd2_d1_i(sd2_d1_i),
        .sd2_d2_i(sd2_d2_i),
        .sd2_miso_i(sd2_miso_i),
        .sd2_mosi_o(sd2_mosi_o),
        .sd2_reset_o(sd2_reset_o),
        .sd2_wp_i(sd2_wp_i),
        .sd_cd_i(sd_cd_i),
        .sd_clk_o(sd_clk_o),
        .sd_d1_i(sd_d1_i),
        .sd_d2_i(sd_d2_i),
        .sd_miso_i(sd_miso_i),
        .sd_mosi_o(sd_mosi_o),
        .sd_reset_o(sd_reset_o),
        .sdram_a_o(sdram_a_o),
        .sdram_ba_o(sdram_ba_o),
        .sdram_cas_n_o(sdram_cas_n_o),
        .sdram_cke_o(sdram_cke_o),
        .sdram_clk_o(sdram_clk_o),
        .sdram_cs_n_o(sdram_cs_n_o),
        .sdram_dq_io(sdram_dq_io),
        .sdram_dqmh_o(sdram_dqmh_o),
        .sdram_dqml_o(sdram_dqml_o),
        .sdram_ras_n_o(sdram_ras_n_o),
        .sdram_we_n_o(sdram_we_n_o),
        .tmds_clk_n_o(tmds_clk_n_o),
        .tmds_clk_p_o(tmds_clk_p_o),
        .tmds_data_n_o(tmds_data_n_o),
        .tmds_data_p_o(tmds_data_p_o),
        .uart_rxd_i(uart_rxd_i),
        .uart_txd_o(uart_txd_o),
        .vdac_blank_n_o(vdac_blank_n_o),
        .vdac_clk_o(vdac_clk_o),
        .vdac_psave_n_o(vdac_psave_n_o),
        .vdac_sync_n_o(vdac_sync_n_o),
        .vga_blue_o(vga_blue_o),
        .vga_green_o(vga_green_o),
        .vga_hs_o(vga_hs_o),
        .vga_red_o(vga_red_o),
        .vga_scl_io(vga_scl_io),
        .vga_sda_io(vga_sda_io),
        .vga_vs_o(vga_vs_o));
endmodule
