//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
//Date        : Sat Jan 18 13:44:34 2025
//Host        : Retro-PC running 64-bit major release  (build 9200)
//Command     : generate_target Mega65_R6.bd
//Design      : Mega65_R6
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module CORE_Main_Minimig_GAYLE_imp_XOTHHO
   (addr,
    clk,
    data_in,
    data_out,
    ide_address,
    ide_read,
    ide_readdata,
    ide_req,
    ide_write,
    ide_writedata,
    irq,
    led,
    longword,
    nrdy,
    rd,
    reset,
    sel_gayle,
    sel_ide,
    wr);
  input [23:1]addr;
  input clk;
  input [15:0]data_in;
  output [15:0]data_out;
  input [4:0]ide_address;
  input ide_read;
  output [15:0]ide_readdata;
  output [5:0]ide_req;
  input ide_write;
  input [15:0]ide_writedata;
  output irq;
  output led;
  input longword;
  output nrdy;
  input rd;
  input reset;
  input sel_gayle;
  input sel_ide;
  input wr;

  wire [23:1]addr;
  wire clk;
  wire [15:0]data_in;
  wire [4:0]ide_address;
  wire ide_read;
  wire [5:0]ide_req;
  wire ide_write;
  wire [15:0]ide_writedata;
  wire rd;

  CORE_GAYLE_ide0_imp_1T9NS8W CORE_GAYLE_ide0
       (.clk(clk),
        .io_32(1'b0),
        .io_address(addr[4:1]),
        .io_read(rd),
        .io_write(1'b0),
        .io_writedata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,data_in}),
        .mgmt_address(ide_address[3:0]),
        .mgmt_read(ide_read),
        .mgmt_readdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .mgmt_write(ide_write),
        .mgmt_writedata(ide_writedata),
        .request(ide_req[2:0]),
        .rst_n(1'b0),
        .use_fast(1'b0));
  CORE_GAYLE_ide1_imp_1DOKXQ CORE_GAYLE_ide1
       (.clk(clk),
        .io_32(1'b0),
        .io_address(addr[4:1]),
        .io_read(rd),
        .io_write(1'b0),
        .io_writedata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,data_in}),
        .mgmt_address(ide_address[3:0]),
        .mgmt_read(ide_read),
        .mgmt_readdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .mgmt_write(ide_write),
        .mgmt_writedata(ide_writedata),
        .rst_n(1'b0),
        .use_fast(1'b0));
endmodule

module CORE_Main_Minimig_imp_1RL1CZR
   (IO_DIN,
    IO_DOUT,
    IO_FPGA,
    IO_STROBE,
    IO_UIO,
    IO_WAIT,
    ar,
    aud_mix,
    blue,
    bootrom,
    c1,
    c3,
    cachecfg,
    cck,
    cd,
    ce_pix,
    chip48,
    clk,
    clk7_en,
    clk7n_en,
    cpu_address,
    cpu_data,
    cpu_r_w,
    cpucfg,
    cpudata_in,
    cts,
    dsr,
    dtr,
    eclk,
    fdd_led,
    field1,
    green,
    hblank,
    hdd_led,
    ide_address,
    ide_ena,
    ide_ext_irq,
    ide_fast,
    ide_read,
    ide_readdata,
    ide_req,
    ide_write,
    ide_writedata,
    joya1,
    joya2,
    kbd_mouse_data,
    kbd_mouse_type,
    kms_level,
    lace,
    ldata,
    ldata_okk,
    memcfg,
    mouse_btn,
    nmi_addr,
    ntsc,
    ovr,
    pwr_led,
    ram_address,
    ram_data,
    ramdata_in,
    rdata,
    rdata_okk,
    red,
    res,
    ri,
    rst_ext,
    rst_out,
    rtc,
    rts,
    rxd,
    scanline,
    toccata_aud_left,
    toccata_aud_right,
    toccata_base,
    toccata_ena,
    txd,
    vblank,
    x_cpu_as,
    x_cpu_dtack,
    x_cpu_ipl,
    x_cpu_lds,
    x_cpu_reset,
    x_cpu_reset_in,
    x_cpu_uds,
    x_csync,
    x_hsync,
    x_joy1,
    x_joy2,
    x_joy3,
    x_joy4,
    x_ram_bhe,
    x_ram_ble,
    x_ram_oe,
    x_ram_we,
    x_vsync);
  input [15:0]IO_DIN;
  output [15:0]IO_DOUT;
  input IO_FPGA;
  input IO_STROBE;
  input IO_UIO;
  output IO_WAIT;
  output [1:0]ar;
  output [1:0]aud_mix;
  output [7:0]blue;
  output bootrom;
  input c1;
  input c3;
  output [2:0]cachecfg;
  input cck;
  input cd;
  output ce_pix;
  input [47:0]chip48;
  input clk;
  input clk7_en;
  input clk7n_en;
  input [23:1]cpu_address;
  output [15:0]cpu_data;
  input cpu_r_w;
  output [1:0]cpucfg;
  input [15:0]cpudata_in;
  input cts;
  input dsr;
  output [7:6]dtr;
  input [9:0]eclk;
  output fdd_led;
  output field1;
  output [7:0]green;
  output hblank;
  output hdd_led;
  input [4:0]ide_address;
  output [5:0]ide_ena;
  input ide_ext_irq;
  output [5:0]ide_fast;
  input ide_read;
  output [15:0]ide_readdata;
  output [5:0]ide_req;
  input ide_write;
  input [15:0]ide_writedata;
  input [15:0]joya1;
  input [15:0]joya2;
  input [7:0]kbd_mouse_data;
  input [1:0]kbd_mouse_type;
  input kms_level;
  output lace;
  output [14:0]ldata;
  output [8:0]ldata_okk;
  output [7:0]memcfg;
  input [2:0]mouse_btn;
  input [31:0]nmi_addr;
  output [4:0]ntsc;
  output ovr;
  output pwr_led;
  output [22:1]ram_address;
  output [15:0]ram_data;
  input [15:0]ramdata_in;
  output [14:0]rdata;
  output [8:0]rdata_okk;
  output [7:0]red;
  output [4:0]res;
  input ri;
  input rst_ext;
  output rst_out;
  input [64:0]rtc;
  output [7:6]rts;
  input rxd;
  output [2:0]scanline;
  output [15:0]toccata_aud_left;
  output [15:0]toccata_aud_right;
  input [7:0]toccata_base;
  input toccata_ena;
  output txd;
  output vblank;
  input x_cpu_as;
  output x_cpu_dtack;
  output [2:0]x_cpu_ipl;
  input x_cpu_lds;
  output x_cpu_reset;
  input x_cpu_reset_in;
  input x_cpu_uds;
  output x_csync;
  output x_hsync;
  input [15:0]x_joy1;
  input [15:0]x_joy2;
  input [15:0]x_joy3;
  input [15:0]x_joy4;
  output x_ram_bhe;
  output x_ram_ble;
  output x_ram_oe;
  output x_ram_we;
  output x_vsync;

  wire [15:0]IO_DIN;
  wire [15:0]IO_DOUT;
  wire IO_FPGA;
  wire IO_STROBE;
  wire IO_UIO;
  wire IO_WAIT;
  wire agnus_0_dbr;
  wire agnus_0_dbwe;
  wire agnus_0_sof;
  wire agnus_0_strhor_denise;
  wire agnus_0_strhor_paula;
  wire agnus_0_vbl_int;
  wire [1:0]ar;
  wire [1:0]aud_mix;
  wire [8:0]\^blue ;
  wire bootrom;
  wire c1;
  wire c3;
  wire cart_0_sel_cart;
  wire cck;
  wire cd;
  wire [47:0]chip48;
  wire ciaa_0_irq;
  wire [7:0]ciab_0_portb_out;
  wire clk;
  wire clk7_en;
  wire clk7n_en;
  wire [23:1]cpu_address;
  wire [15:0]cpu_data;
  wire cpu_r_w;
  wire [1:0]cpucfg;
  wire [15:0]cpudata_in;
  wire [9:0]eclk;
  wire fdd_led;
  wire field1;
  wire [15:0]gary_0_custom_data_in;
  wire gary_0_dbs;
  wire [3:0]gary_0_sel_chip;
  wire gary_0_sel_cia;
  wire gary_0_sel_cia_a;
  wire gary_0_sel_cia_b;
  wire gary_0_sel_gayle;
  wire gary_0_sel_ide;
  wire gary_0_sel_kick;
  wire gary_0_sel_kick1mb;
  wire gary_0_sel_kick256kmirror;
  wire gary_0_sel_reg;
  wire [2:0]gary_0_sel_slow;
  wire gary_0_xbs;
  wire [8:0]\^green ;
  wire hblank;
  wire hdd_led;
  wire [4:0]ide_address;
  wire [5:0]ide_fast;
  wire ide_read;
  wire [15:0]ide_readdata;
  wire \^ide_req ;
  wire ide_write;
  wire [15:0]ide_writedata;
  wire [15:0]joya1;
  wire [15:0]joya2;
  wire [7:0]kbd_mouse_data;
  wire [1:0]kbd_mouse_type;
  wire kms_level;
  wire lace;
  wire [14:0]ldata;
  wire [8:0]ldata_okk;
  wire [7:0]memcfg;
  wire [7:0]minimig_bankmapper_0_bank;
  wire [15:0]minimig_m68k_bridge_0_data_out;
  wire minimig_m68k_bridge_0_host_ack;
  wire [15:0]minimig_m68k_bridge_0_host_rdat;
  wire minimig_m68k_bridge_0_hwr;
  wire minimig_m68k_bridge_0_lwr;
  wire minimig_m68k_bridge_0_rd;
  wire [2:0]mouse_btn;
  wire [31:0]nmi_addr;
  wire ovr;
  wire [3:0]paula_0_audio_dmal;
  wire [3:0]paula_0_audio_dmas;
  wire paula_0_disk_dmal;
  wire paula_0_disk_dmas;
  wire paula_0_index;
  wire [22:1]ram_address;
  wire [15:0]ram_data;
  wire [15:0]ramdata_in;
  wire [14:0]rdata;
  wire [8:0]rdata_okk;
  wire [8:0]\^red ;
  wire [4:0]res;
  wire rst_ext;
  wire rst_out;
  wire [7:6]rts;
  wire rxd;
  wire [2:0]scanline;
  wire [15:0]toccata_aud_left;
  wire [15:0]toccata_aud_right;
  wire [7:0]toccata_base;
  wire toccata_ena;
  wire txd;
  wire userio_0__fire0;
  wire userio_0_cpuhlt;
  wire [3:0]userio_0_floppy_config;
  wire [23:0]userio_0_host_adr;
  wire [1:0]userio_0_host_bs;
  wire userio_0_host_cs;
  wire [15:0]userio_0_host_wdat;
  wire userio_0_host_we;
  wire vblank;
  wire x_cpu_as;
  wire x_cpu_dtack;
  wire \^x_cpu_ipl ;
  wire x_cpu_lds;
  wire x_cpu_uds;
  wire x_csync;
  wire x_hsync;
  wire [15:0]x_joy1;
  wire [15:0]x_joy2;
  wire [15:0]x_joy4;
  wire x_ram_bhe;
  wire x_ram_ble;
  wire x_ram_oe;
  wire x_ram_we;
  wire x_vsync;

  assign blue[7:0] = \^blue [7:0];
  assign dtr[7:6] = rts;
  assign green[7:0] = \^green [7:0];
  assign ide_ena[5:0] = ide_fast;
  assign ide_req[0] = \^ide_req ;
  assign ntsc[4:0] = res;
  assign red[7:0] = \^red [7:0];
  assign x_cpu_ipl[0] = \^x_cpu_ipl ;
  CORE_Main_Minimig_DENISE_imp_144SQMM CORE_Main_Minimig_DENISE
       (.a1k(res),
        .aga(res),
        .blank(1'b0),
        .blue(\^blue ),
        .c1(1'b0),
        .c3(1'b0),
        .cck(cck),
        .chip48({1'b0,chip48}),
        .clk(clk),
        .clk7_en(clk7_en),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ecs(res),
        .green(\^green ),
        .red(\^red ),
        .reg_address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reset(rst_out),
        .strhor(agnus_0_strhor_denise));
  CORE_Main_Minimig_GAYLE_imp_XOTHHO CORE_Main_Minimig_GAYLE
       (.addr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clk(clk),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ide_address(ide_address),
        .ide_read(ide_read),
        .ide_readdata(ide_readdata),
        .ide_write(ide_write),
        .ide_writedata(ide_writedata),
        .irq(\^ide_req ),
        .led(hdd_led),
        .longword(1'b0),
        .rd(1'b0),
        .reset(rst_out),
        .sel_gayle(gary_0_sel_gayle),
        .sel_ide(gary_0_sel_ide),
        .wr(1'b0));
  CORE_Main_Minimig_Toccata_imp_1KMIDU9 CORE_Main_Minimig_Toccata
       (.addr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clk(clk),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .hsync(x_hsync),
        .hwr(1'b0),
        .lwr(1'b0),
        .out_left(toccata_aud_left),
        .out_right(toccata_aud_right),
        .rd(1'b0),
        .rst(rst_out),
        .sel(1'b0));
  Mega65_R6_agnus_0_0 agnus_0
       (._csync(x_csync),
        ._hsync(x_hsync),
        ._vsync(x_vsync),
        .a1k(res[0]),
        .address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .aen(gary_0_sel_reg),
        .aga(res[0]),
        .audio_dmal(paula_0_audio_dmal),
        .audio_dmas(paula_0_audio_dmas),
        .bls(1'b0),
        .cck(cck),
        .clk(clk),
        .clk7_en(clk7_en),
        .data_in(gary_0_custom_data_in),
        .dbr(agnus_0_dbr),
        .dbwe(agnus_0_dbwe),
        .disk_dmal(paula_0_disk_dmal),
        .disk_dmas(paula_0_disk_dmas),
        .ecs(res[0]),
        .field1(field1),
        .floppy_speed(userio_0_floppy_config[0]),
        .hblank(hblank),
        .hwr(1'b0),
        .lace(lace),
        .lwr(1'b0),
        .ntsc(res[0]),
        .rd(1'b0),
        .reset(rst_out),
        .sof(agnus_0_sof),
        .strhor_denise(agnus_0_strhor_denise),
        .strhor_paula(agnus_0_strhor_paula),
        .vbl_int(agnus_0_vbl_int),
        .vblank(vblank));
  Mega65_R6_cart_0_0 cart_0
       (._cpu_as(x_cpu_as),
        .clk(clk),
        .clk7_en(clk7_en),
        .clk7n_en(clk7n_en),
        .cpu_address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .cpu_hwr(minimig_m68k_bridge_0_hwr),
        .cpu_lwr(minimig_m68k_bridge_0_lwr),
        .cpu_rd(minimig_m68k_bridge_0_rd),
        .cpu_rst(1'b0),
        .cpuhlt(1'b0),
        .dbr(agnus_0_dbr),
        .freeze(1'b0),
        .int7(\^x_cpu_ipl ),
        .nmi_addr(nmi_addr),
        .ovl(1'b0),
        .ovr(ovr),
        .reg_address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reg_data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .sel_cart(cart_0_sel_cart));
  Mega65_R6_ciaa_0_0 ciaa_0
       (.aen(gary_0_sel_cia_a),
        .clk(clk),
        .clk7_en(clk7_en),
        .clk7n_en(clk7n_en),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .eclk(eclk[0]),
        .hrtmon_en(memcfg[0]),
        .irq(ciaa_0_irq),
        .kbd_mouse_data(kbd_mouse_data),
        .kbd_mouse_type(kbd_mouse_type),
        .kms_level(kms_level),
        .porta_in({userio_0__fire0,userio_0__fire0,userio_0__fire0,userio_0__fire0,userio_0__fire0,userio_0__fire0}),
        .portb_in(x_joy4[7:0]),
        .rd(1'b0),
        .reset(rst_out),
        .rs({1'b0,1'b0,1'b0,1'b0}),
        .tick(x_vsync),
        .wr(1'b0));
  Mega65_R6_ciab_0_0 ciab_0
       (.aen(gary_0_sel_cia_b),
        .clk(clk),
        .clk7_en(clk7_en),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .eclk(eclk[0]),
        .flag(paula_0_index),
        .porta_in({cd,cd,cd,cd,cd,cd}),
        .porta_out(rts),
        .portb_out(ciab_0_portb_out),
        .rd(1'b0),
        .reset(rst_out),
        .rs({1'b0,1'b0,1'b0,1'b0}),
        .tick(x_hsync),
        .wr(1'b0));
  Mega65_R6_gary_0_0 gary_0
       (.a1k(res[0]),
        .bootrom(bootrom),
        .clk(clk),
        .cpu_address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .cpu_data_out(minimig_m68k_bridge_0_data_out),
        .cpu_hlt(1'b0),
        .cpu_hwr(minimig_m68k_bridge_0_hwr),
        .cpu_lwr(minimig_m68k_bridge_0_lwr),
        .cpu_rd(minimig_m68k_bridge_0_rd),
        .custom_data_in(gary_0_custom_data_in),
        .custom_data_out({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dbr(agnus_0_dbr),
        .dbs(gary_0_dbs),
        .dbwe(agnus_0_dbwe),
        .dma_address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ecs(res[0]),
        .hdc_ena(1'b0),
        .memory_config({1'b0,1'b0,1'b0,1'b0}),
        .ovl(1'b0),
        .ram_data_out({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reset(rst_out),
        .sel_chip(gary_0_sel_chip),
        .sel_cia(gary_0_sel_cia),
        .sel_cia_a(gary_0_sel_cia_a),
        .sel_cia_b(gary_0_sel_cia_b),
        .sel_gayle(gary_0_sel_gayle),
        .sel_ide(gary_0_sel_ide),
        .sel_kick(gary_0_sel_kick),
        .sel_kick1mb(gary_0_sel_kick1mb),
        .sel_kick256kmirror(gary_0_sel_kick256kmirror),
        .sel_reg(gary_0_sel_reg),
        .sel_slow(gary_0_sel_slow),
        .toccata_base(toccata_base),
        .toccata_ena(toccata_ena),
        .xbs(gary_0_xbs));
  Mega65_R6_minimig_bankmapper_0_0 minimig_bankmapper_0
       (.bank(minimig_bankmapper_0_bank),
        .cart(cart_0_sel_cart),
        .chip0(gary_0_sel_chip[0]),
        .chip1(gary_0_sel_chip[0]),
        .chip2(gary_0_sel_chip[0]),
        .chip3(gary_0_sel_chip[0]),
        .kick(gary_0_sel_kick),
        .kick1mb(gary_0_sel_kick1mb),
        .kick256kmirror(gary_0_sel_kick256kmirror),
        .memory_config({1'b0,1'b0}),
        .slow0(gary_0_sel_slow[0]),
        .slow1(gary_0_sel_slow[0]),
        .slow2(gary_0_sel_slow[0]));
  Mega65_R6_minimig_m68k_bridge_0_0 minimig_m68k_bridge_0
       (._as(x_cpu_as),
        ._cpu_reset(1'b0),
        ._dtack(x_cpu_dtack),
        ._lds(x_cpu_lds),
        ._uds(x_cpu_uds),
        .address(cpu_address),
        .c1(c1),
        .c3(c3),
        .cck(cck),
        .clk(clk),
        .clk7_en(clk7_en),
        .clk7n_en(clk7n_en),
        .cpu_halt(userio_0_cpuhlt),
        .cpudatain(cpudata_in),
        .data(cpu_data),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .data_out(minimig_m68k_bridge_0_data_out),
        .dbr(agnus_0_dbr),
        .dbs(gary_0_dbs),
        .eclk(eclk),
        .host_ack(minimig_m68k_bridge_0_host_ack),
        .host_adr(userio_0_host_adr[22:0]),
        .host_bs(userio_0_host_bs),
        .host_cs(userio_0_host_cs),
        .host_rdat(minimig_m68k_bridge_0_host_rdat),
        .host_wdat(userio_0_host_wdat),
        .host_we(userio_0_host_we),
        .hwr(minimig_m68k_bridge_0_hwr),
        .lwr(minimig_m68k_bridge_0_lwr),
        .memory_config({1'b0,1'b0,1'b0,1'b0}),
        .nrdy(1'b0),
        .r_w(cpu_r_w),
        .rd(minimig_m68k_bridge_0_rd),
        .vpa(gary_0_sel_cia),
        .xbs(gary_0_xbs));
  Mega65_R6_minimig_sram_bridge_0_0 minimig_sram_bridge_0
       (._bhe(x_ram_bhe),
        ._ble(x_ram_ble),
        ._oe(x_ram_oe),
        ._we(x_ram_we),
        .address(ram_address),
        .address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .bank(minimig_bankmapper_0_bank),
        .c1(c1),
        .c3(c3),
        .clk(clk),
        .data(ram_data),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .hwr(1'b0),
        .lwr(1'b0),
        .ramdata_in(ramdata_in),
        .rd(1'b0));
  Mega65_R6_minimig_syscontrol_0_0 minimig_syscontrol_0
       (.clk(clk),
        .clk7_en(clk7_en),
        .cnt(1'b0),
        .mrst(rst_ext),
        .reset(rst_out));
  Mega65_R6_paula_0_0 paula_0
       (.IO_DIN(IO_DIN),
        .IO_DOUT(IO_DOUT),
        .IO_ENA(IO_FPGA),
        .IO_STROBE(IO_STROBE),
        .IO_WAIT(IO_WAIT),
        ._motor(ciab_0_portb_out[0]),
        ._sel({1'b0,1'b0,1'b0,1'b0}),
        ._step(1'b0),
        .audio_dmal(paula_0_audio_dmal),
        .audio_dmas(paula_0_audio_dmas),
        .cck(cck),
        .clk(clk),
        .clk7_en(clk7_en),
        .clk7n_en(clk7n_en),
        .data_in(gary_0_custom_data_in),
        .direc(1'b0),
        .disk_dmal(paula_0_disk_dmal),
        .disk_dmas(paula_0_disk_dmas),
        .fdd_led(fdd_led),
        .floppy_drives(userio_0_floppy_config[1:0]),
        .index(paula_0_index),
        .int2(ciaa_0_irq),
        .int3(1'b0),
        .int6(1'b0),
        .ldata(ldata),
        .ldata_okk(ldata_okk),
        .ntsc(res[0]),
        .rdata(rdata),
        .rdata_okk(rdata_okk),
        .reg_address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reset(rst_out),
        .rxd(rxd),
        .side(1'b0),
        .sof(agnus_0_sof),
        .strhor(agnus_0_strhor_paula),
        .txd(txd),
        .vblint(agnus_0_vbl_int));
  Mega65_R6_userio_0_0 userio_0
       (.IO_DIN(IO_DIN),
        .IO_ENA(IO_UIO),
        .IO_STROBE(IO_STROBE),
        ._fire0(userio_0__fire0),
        ._fire0_dat(1'b0),
        ._fire1_dat(1'b0),
        ._joy1(x_joy1),
        ._joy2(x_joy2),
        .ar(ar),
        .aud_mix(aud_mix),
        .bootrom(bootrom),
        .chipset_config(res),
        .clk(clk),
        .clk7_en(clk7_en),
        .cpu_config(cpucfg),
        .cpuhlt(userio_0_cpuhlt),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .floppy_config(userio_0_floppy_config),
        .host_ack(minimig_m68k_bridge_0_host_ack),
        .host_adr(userio_0_host_adr),
        .host_bs(userio_0_host_bs),
        .host_cs(userio_0_host_cs),
        .host_rdat(minimig_m68k_bridge_0_host_rdat),
        .host_wdat(userio_0_host_wdat),
        .host_we(userio_0_host_we),
        .ide_config(ide_fast),
        .joy_ana1(joya1),
        .joy_ana2(joya2),
        .kbd_mouse_data({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .kbd_mouse_type(kbd_mouse_type),
        .kms_level(kms_level),
        .memory_config(memcfg),
        .mouse_btn(mouse_btn),
        .pot_cnt_en(1'b0),
        .reg_address_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reset(rst_out),
        .scanline(scanline));
endmodule

module CORE_Main_fastchip_imp_1H25074
   (addr,
    clk,
    clk_sys,
    cyc,
    din,
    dout,
    ide_address,
    ide_ena,
    ide_irq,
    ide_led,
    ide_read,
    ide_readdata,
    ide_req,
    ide_write,
    ide_writedata,
    lds,
    longword,
    ready,
    reset,
    rnw,
    rtg_base,
    rtg_ena,
    rtg_format,
    rtg_hsize,
    rtg_pal_a,
    rtg_pal_clk,
    rtg_pal_dr,
    rtg_pal_dw,
    rtg_pal_wr,
    rtg_stride,
    rtg_vsize,
    sel,
    sel_ack,
    uds);
  input [23:0]addr;
  input clk;
  input clk_sys;
  input cyc;
  input [15:0]din;
  output [15:0]dout;
  input [4:0]ide_address;
  input ide_ena;
  output ide_irq;
  output ide_led;
  input ide_read;
  output [15:0]ide_readdata;
  output [5:0]ide_req;
  input ide_write;
  input [15:0]ide_writedata;
  input lds;
  input longword;
  output ready;
  input reset;
  input rnw;
  output [31:0]rtg_base;
  output rtg_ena;
  output [4:0]rtg_format;
  output [11:0]rtg_hsize;
  output [7:0]rtg_pal_a;
  output rtg_pal_clk;
  input [23:0]rtg_pal_dr;
  output [23:0]rtg_pal_dw;
  output rtg_pal_wr;
  output [13:0]rtg_stride;
  output [11:0]rtg_vsize;
  input sel;
  output sel_ack;
  input uds;

  wire [23:0]addr;
  wire clk_sys;
  wire [15:0]din;
  wire [4:0]ide_address;
  wire ide_irq;
  wire ide_led;
  wire ide_read;
  wire [15:0]ide_readdata;
  wire [5:0]ide_req;
  wire ide_write;
  wire [15:0]ide_writedata;
  wire longword;
  wire reset;
  wire rnw;
  wire [31:0]rtg_base;
  wire rtg_ena;
  wire [4:0]rtg_format;
  wire [11:0]rtg_hsize;
  wire [7:0]rtg_pal_a;
  wire rtg_pal_clk;
  wire [23:0]rtg_pal_dr;
  wire [23:0]rtg_pal_dw;
  wire rtg_pal_wr;
  wire [13:0]rtg_stride;
  wire [11:0]rtg_vsize;

  CORE_Main_fastchip_gayle_imp_1FUMFM4 CORE_Main_fastchip_gayle
       (.addr(addr[22:0]),
        .clk(clk_sys),
        .data_in(din),
        .ide_address(ide_address),
        .ide_read(ide_read),
        .ide_readdata(ide_readdata),
        .ide_req(ide_req),
        .ide_write(ide_write),
        .ide_writedata(ide_writedata),
        .irq(ide_irq),
        .led(ide_led),
        .longword(longword),
        .rd(1'b0),
        .reset(reset),
        .sel_gayle(1'b0),
        .sel_ide(1'b0),
        .wr(1'b0));
  Mega65_R6_akiko_0_0 akiko_0
       (.addr({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clk(clk_sys),
        .cs(1'b0),
        .din({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rd(rnw),
        .wr(1'b0));
  Mega65_R6_rtg_0_0 rtg_0
       (.aen(1'b0),
        .base(rtg_base),
        .clk(clk_sys),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ena(rtg_ena),
        .format(rtg_format),
        .hsize(rtg_hsize),
        .pal_a(rtg_pal_a),
        .pal_clk(rtg_pal_clk),
        .pal_dr(rtg_pal_dr),
        .pal_dw(rtg_pal_dw),
        .pal_wr(rtg_pal_wr),
        .rd(rnw),
        .reset(reset),
        .rs({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .stride(rtg_stride),
        .vsize(rtg_vsize),
        .wr(1'b0));
endmodule

module CORE_Main_imp_HPA42T
   (audio_left_o,
    audio_right_o,
    clk_main_i,
    clk_main_speed_i,
    joy_1_down_n_i,
    joy_1_fire_n_i,
    joy_1_left_n_i,
    joy_1_right_n_i,
    joy_1_up_n_i,
    joy_2_down_n_i,
    joy_2_fire_n_i,
    joy_2_left_n_i,
    joy_2_right_n_i,
    joy_2_up_n_i,
    kb_key_num_i,
    kb_key_pressed_n_i,
    pause_i,
    pot1_x_i,
    pot1_y_i,
    pot2_x_i,
    pot2_y_i,
    reset_hard_i,
    reset_soft_i,
    video_blue_o,
    video_ce_o,
    video_ce_ovl_o,
    video_green_o,
    video_hblank_o,
    video_hs_o,
    video_red_o,
    video_vblank_o,
    video_vs_o);
  output [15:0]audio_left_o;
  output [15:0]audio_right_o;
  input clk_main_i;
  input clk_main_speed_i;
  input joy_1_down_n_i;
  input joy_1_fire_n_i;
  input joy_1_left_n_i;
  input joy_1_right_n_i;
  input joy_1_up_n_i;
  input joy_2_down_n_i;
  input joy_2_fire_n_i;
  input joy_2_left_n_i;
  input joy_2_right_n_i;
  input joy_2_up_n_i;
  input kb_key_num_i;
  input kb_key_pressed_n_i;
  input pause_i;
  input [7:0]pot1_x_i;
  input [7:0]pot1_y_i;
  input [7:0]pot2_x_i;
  input [7:0]pot2_y_i;
  input reset_hard_i;
  input reset_soft_i;
  output [7:0]video_blue_o;
  output video_ce_o;
  output video_ce_ovl_o;
  output [7:0]video_green_o;
  output video_hblank_o;
  output video_hs_o;
  output [7:0]video_red_o;
  output video_vblank_o;
  output video_vs_o;

  wire amiga_clk_0_c1;
  wire amiga_clk_0_c3;
  wire amiga_clk_0_cck;
  wire amiga_clk_0_clk7_en;
  wire amiga_clk_0_clk7n_en;
  wire [9:0]amiga_clk_0_eclk;
  wire clk_main_i;
  wire reset_hard_i;

  CORE_Main_Minimig_imp_1RL1CZR CORE_Main_Minimig
       (.IO_DIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .IO_FPGA(1'b0),
        .IO_STROBE(1'b0),
        .IO_UIO(1'b0),
        .c1(amiga_clk_0_c1),
        .c3(amiga_clk_0_c3),
        .cck(amiga_clk_0_cck),
        .cd(1'b0),
        .chip48({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clk(clk_main_i),
        .clk7_en(amiga_clk_0_clk7_en),
        .clk7n_en(amiga_clk_0_clk7n_en),
        .cpu_address({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .cpu_r_w(1'b0),
        .cpudata_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .cts(1'b0),
        .dsr(1'b0),
        .eclk(amiga_clk_0_eclk),
        .ide_address({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ide_ext_irq(1'b0),
        .ide_read(1'b0),
        .ide_write(1'b0),
        .ide_writedata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .joya1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .joya2({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .kbd_mouse_data({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .kbd_mouse_type({1'b0,1'b0}),
        .kms_level(1'b0),
        .mouse_btn({1'b0,1'b0,1'b0}),
        .nmi_addr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ramdata_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ri(1'b0),
        .rst_ext(1'b0),
        .rtc({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rxd(1'b0),
        .toccata_base({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .toccata_ena(1'b0),
        .x_cpu_as(1'b0),
        .x_cpu_lds(1'b0),
        .x_cpu_reset_in(1'b0),
        .x_cpu_uds(1'b0),
        .x_joy1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .x_joy2({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .x_joy3({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .x_joy4({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  CORE_Main_fastchip_imp_1H25074 CORE_Main_fastchip
       (.addr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clk(1'b0),
        .clk_sys(1'b0),
        .cyc(1'b0),
        .din({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ide_address({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ide_ena(1'b0),
        .ide_read(1'b0),
        .ide_write(1'b0),
        .ide_writedata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .lds(1'b0),
        .longword(1'b0),
        .reset(1'b0),
        .rnw(1'b0),
        .rtg_pal_dr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .sel(1'b0),
        .uds(1'b0));
  CORE_cpu_wrapper_imp_14VCVT1 CORE_cpu_wrapper
       (.bootrom(1'b0),
        .cachecfg({1'b0,1'b0,1'b0}),
        .chip_dout(1'b0),
        .chip_dtack(1'b0),
        .chip_ipl({1'b0,1'b0,1'b0}),
        .clk(1'b0),
        .cpucfg({1'b0,1'b0}),
        .fastchip_dout({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .fastchip_ready(1'b0),
        .fastchip_selack(1'b0),
        .fastramcfg({1'b0,1'b0,1'b0}),
        .ph1(1'b0),
        .ph2(1'b0),
        .ramdout({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ramready(1'b0),
        .reset(1'b0));
  Mega65_R6_amiga_clk_0_0 amiga_clk_0
       (.c1(amiga_clk_0_c1),
        .c3(amiga_clk_0_c3),
        .cck(amiga_clk_0_cck),
        .clk7_en(amiga_clk_0_clk7_en),
        .clk7n_en(amiga_clk_0_clk7n_en),
        .clk_28(clk_main_i),
        .eclk(amiga_clk_0_eclk),
        .reset_n(reset_hard_i));
endmodule

module CORE_cpu_wrapper_cpu_inst_p_imp_N8SESV
   (CACR_out,
    CPU,
    FC,
    IPL,
    IPL_autovector,
    VBR_out,
    addr_out,
    berr,
    busstate,
    clk,
    clkena_in,
    clr_berr,
    data_in,
    data_write,
    longword,
    nLDS,
    nReset,
    nResetOut,
    nUDS,
    nWr,
    regin_out,
    skipFetch);
  output [3:0]CACR_out;
  input [1:0]CPU;
  output [2:0]FC;
  input [2:0]IPL;
  input IPL_autovector;
  output [31:0]VBR_out;
  output [31:0]addr_out;
  input berr;
  output [1:0]busstate;
  input clk;
  input clkena_in;
  output clr_berr;
  input [15:0]data_in;
  output [15:0]data_write;
  output longword;
  output nLDS;
  input nReset;
  output nResetOut;
  output nUDS;
  output nWr;
  output [31:0]regin_out;
  output skipFetch;

  wire [1:0]CPU;
  wire clk;

  CORE_cpu_inst_p_TG68K_ALU_imp_JVEZ3O CORE_cpu_inst_p_TG68K_ALU
       (.CPU(CPU),
        .FlagsSR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .OP1out({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .OP2out({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .Reset(1'b0),
        .Z_error(1'b0),
        .bf_ext_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .bf_ext_out({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .bf_ffo_offset({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .bf_loffset({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .bf_shift({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .bf_width({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .check_aligned(1'b0),
        .clk(clk),
        .clkena_lw(1'b0),
        .data_read({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .decodeOPC(1'b0),
        .exe_condition(1'b0),
        .exe_datatype({1'b0,1'b0}),
        .exe_opcode({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .exec({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .execOPC(1'b0),
        .exec_tas(1'b0),
        .last_data_read({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .long_start(1'b0),
        .micro_state(1'b0),
        .movem_presub(1'b0),
        .non_aligned(1'b0),
        .opcode({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reg_QA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reg_QB({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rot_bits({1'b0,1'b0}),
        .set_stop(1'b0),
        .sndOPC({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

module CORE_cpu_wrapper_imp_14VCVT1
   (bootrom,
    cachecfg,
    cacr,
    chip_addr,
    chip_as,
    chip_din,
    chip_dout,
    chip_dtack,
    chip_ipl,
    chip_lds,
    chip_rw,
    chip_uds,
    clk,
    cpucfg,
    cpustate,
    fastchip_dout,
    fastchip_lds,
    fastchip_lw,
    fastchip_ready,
    fastchip_rnw,
    fastchip_sel,
    fastchip_selack,
    fastchip_uds,
    fastramcfg,
    nmi_addr,
    ph1,
    ph2,
    ramaddr,
    ramdin,
    ramdout,
    ramlds,
    ramready,
    ramsel,
    ramshared,
    ramuds,
    reset,
    reset_out,
    toccata_base,
    toccata_ena);
  input bootrom;
  input [2:0]cachecfg;
  output [3:0]cacr;
  output [23:1]chip_addr;
  output chip_as;
  output [15:0]chip_din;
  input chip_dout;
  input chip_dtack;
  input [2:0]chip_ipl;
  output chip_lds;
  output chip_rw;
  output chip_uds;
  input clk;
  input [1:0]cpucfg;
  output [1:0]cpustate;
  input [15:0]fastchip_dout;
  output fastchip_lds;
  output fastchip_lw;
  input fastchip_ready;
  output fastchip_rnw;
  output fastchip_sel;
  input fastchip_selack;
  output fastchip_uds;
  input [2:0]fastramcfg;
  output [31:0]nmi_addr;
  input ph1;
  input ph2;
  output [28:1]ramaddr;
  output [15:0]ramdin;
  input [15:0]ramdout;
  output ramlds;
  input ramready;
  output ramsel;
  output ramshared;
  output ramuds;
  input reset;
  output reset_out;
  output [7:0]toccata_base;
  output toccata_ena;

  wire clk;
  wire [1:0]cpucfg;
  wire [1:0]cpustate;
  wire fastchip_ready;
  wire ph1;
  wire ph2;
  wire reset;

  CORE_cpu_wrapper_cpu_inst_o_imp_110928A CORE_cpu_wrapper_cpu_inst_o
       (.BERRn(1'b0),
        .BGACKn(1'b0),
        .BRn(1'b0),
        .DTACKn(1'b0),
        .HALTn(1'b0),
        .IPL0n(1'b0),
        .IPL1n(1'b0),
        .IPL2n(1'b0),
        .VPAn(1'b0),
        .clk(clk),
        .enPhi1(ph1),
        .enPhi2(ph2),
        .extReset(reset),
        .iEdb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .oEdb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .pwrUp(1'b0));
  CORE_cpu_wrapper_cpu_inst_p_imp_N8SESV CORE_cpu_wrapper_cpu_inst_p
       (.CPU(cpucfg),
        .IPL({1'b0,1'b0,1'b0}),
        .IPL_autovector(1'b0),
        .berr(1'b0),
        .busstate(cpustate),
        .clk(clk),
        .clkena_in(fastchip_ready),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .nReset(reset));
endmodule

module M2M_Framework_imp_PNB7X9
   (audio_clk_o,
    audio_left_o,
    audio_reset_o,
    audio_right_o,
    audio_scl_io,
    audio_sda_io,
    clk_i,
    fpga_scl_io,
    fpga_sda_io,
    grove_scl_io,
    grove_sda_io,
    hdmi_scl_io,
    hdmi_sda_io,
    hr_clk_o,
    hr_clk_p_o,
    hr_core_address_i,
    hr_core_burstcount_i,
    hr_core_byteenable_i,
    hr_core_read_i,
    hr_core_readdata_o,
    hr_core_readdatavalid_o,
    hr_core_waitrequest_o,
    hr_core_write_i,
    hr_core_writedata_i,
    hr_cs0_o,
    hr_d_io,
    hr_high_o,
    hr_low_o,
    hr_reset_o,
    hr_rst_o,
    hr_rwds_io,
    i2c_scl_io,
    i2c_sda_io,
    joy_1_down_n_i,
    joy_1_down_n_o,
    joy_1_fire_n_i,
    joy_1_fire_n_o,
    joy_1_left_n_i,
    joy_1_left_n_o,
    joy_1_right_n_i,
    joy_1_right_n_o,
    joy_1_up_n_i,
    joy_1_up_n_o,
    joy_2_down_n_i,
    joy_2_down_n_o,
    joy_2_fire_n_i,
    joy_2_fire_n_o,
    joy_2_left_n_i,
    joy_2_left_n_o,
    joy_2_right_n_i,
    joy_2_right_n_o,
    joy_2_up_n_i,
    joy_2_up_n_o,
    kb_io0_o,
    kb_io1_o,
    kb_io2_i,
    main_audio_l_i,
    main_audio_r_i,
    main_clk_i,
    main_drive_led_col_i,
    main_drive_led_i,
    main_joy1_down_n_i,
    main_joy1_down_n_o,
    main_joy1_fire_n_i,
    main_joy1_fire_n_o,
    main_joy1_left_n_i,
    main_joy1_left_n_o,
    main_joy1_right_n_i,
    main_joy1_right_n_o,
    main_joy1_up_n_i,
    main_joy1_up_n_o,
    main_joy2_down_n_i,
    main_joy2_down_n_o,
    main_joy2_fire_n_i,
    main_joy2_fire_n_o,
    main_joy2_left_n_i,
    main_joy2_left_n_o,
    main_joy2_right_n_i,
    main_joy2_right_n_o,
    main_joy2_up_n_i,
    main_joy2_up_n_o,
    main_key_num_o,
    main_key_pressed_n_o,
    main_osm_control_m_o,
    main_pot1_x_o,
    main_pot1_y_o,
    main_pot2_x_o,
    main_pot2_y_o,
    main_power_led_col_i,
    main_power_led_i,
    main_qnice_gp_reg_o,
    main_qnice_pause_o,
    main_qnice_reset_o,
    main_reset_core_o,
    main_reset_m2m_o,
    main_rst_i,
    main_rtc_o,
    paddle_drain_o,
    paddle_i,
    qnice_ascal_mode_i,
    qnice_ascal_polyphase_i,
    qnice_ascal_triplebuf_i,
    qnice_audio_filter_i,
    qnice_audio_mute_i,
    qnice_clk_o,
    qnice_csync_i,
    qnice_dvi_i,
    qnice_flip_joyports_i,
    qnice_gp_reg_o,
    qnice_osm_cfg_scaling_i,
    qnice_osm_control_m_o,
    qnice_ramrom_addr_o,
    qnice_ramrom_ce_o,
    qnice_ramrom_data_in_i,
    qnice_ramrom_data_out_o,
    qnice_ramrom_dev_o,
    qnice_ramrom_wait_i,
    qnice_ramrom_we_o,
    qnice_retro15kHz_i,
    qnice_rst_o,
    qnice_scandoubler_i,
    qnice_video_mode_i,
    qnice_zoom_crop_i,
    reset_n_i,
    sd2_cd_i,
    sd2_clk_o,
    sd2_miso_i,
    sd2_mosi_o,
    sd2_reset_o,
    sd_cd_i,
    sd_clk_o,
    sd_miso_i,
    sd_mosi_o,
    sd_reset_o,
    tmds_clk_n_o,
    tmds_clk_p_o,
    tmds_data_n_o,
    tmds_data_p_o,
    uart_rxd_i,
    uart_txd_o,
    vdac_blank_n_o,
    vdac_clk_o,
    vdac_sync_n_o,
    vga_blue_o,
    vga_green_o,
    vga_hs_o,
    vga_red_o,
    vga_scl_io,
    vga_sda_io,
    vga_vs_o,
    video_blue_i,
    video_ce_i,
    video_ce_ovl_i,
    video_clk_i,
    video_green_i,
    video_hblank_i,
    video_hs_i,
    video_red_i,
    video_rst_i,
    video_vblank_i,
    video_vs_i);
  output audio_clk_o;
  output [15:0]audio_left_o;
  output audio_reset_o;
  output [15:0]audio_right_o;
  inout audio_scl_io;
  inout audio_sda_io;
  input clk_i;
  inout fpga_scl_io;
  inout fpga_sda_io;
  inout grove_scl_io;
  inout grove_sda_io;
  inout hdmi_scl_io;
  inout hdmi_sda_io;
  output hr_clk_o;
  output hr_clk_p_o;
  input [31:0]hr_core_address_i;
  input [7:0]hr_core_burstcount_i;
  input [1:0]hr_core_byteenable_i;
  input hr_core_read_i;
  output [15:0]hr_core_readdata_o;
  output hr_core_readdatavalid_o;
  output hr_core_waitrequest_o;
  input hr_core_write_i;
  input [15:0]hr_core_writedata_i;
  output hr_cs0_o;
  inout [7:0]hr_d_io;
  output hr_high_o;
  output hr_low_o;
  output hr_reset_o;
  output hr_rst_o;
  inout hr_rwds_io;
  inout i2c_scl_io;
  inout i2c_sda_io;
  input joy_1_down_n_i;
  output joy_1_down_n_o;
  input joy_1_fire_n_i;
  output joy_1_fire_n_o;
  input joy_1_left_n_i;
  output joy_1_left_n_o;
  input joy_1_right_n_i;
  output joy_1_right_n_o;
  input joy_1_up_n_i;
  output joy_1_up_n_o;
  input joy_2_down_n_i;
  output joy_2_down_n_o;
  input joy_2_fire_n_i;
  output joy_2_fire_n_o;
  input joy_2_left_n_i;
  output joy_2_left_n_o;
  input joy_2_right_n_i;
  output joy_2_right_n_o;
  input joy_2_up_n_i;
  output joy_2_up_n_o;
  output kb_io0_o;
  output kb_io1_o;
  input kb_io2_i;
  input [15:0]main_audio_l_i;
  input [15:0]main_audio_r_i;
  input main_clk_i;
  input [23:0]main_drive_led_col_i;
  input main_drive_led_i;
  input main_joy1_down_n_i;
  output main_joy1_down_n_o;
  input main_joy1_fire_n_i;
  output main_joy1_fire_n_o;
  input main_joy1_left_n_i;
  output main_joy1_left_n_o;
  input main_joy1_right_n_i;
  output main_joy1_right_n_o;
  input main_joy1_up_n_i;
  output main_joy1_up_n_o;
  input main_joy2_down_n_i;
  output main_joy2_down_n_o;
  input main_joy2_fire_n_i;
  output main_joy2_fire_n_o;
  input main_joy2_left_n_i;
  output main_joy2_left_n_o;
  input main_joy2_right_n_i;
  output main_joy2_right_n_o;
  input main_joy2_up_n_i;
  output main_joy2_up_n_o;
  output main_key_num_o;
  output main_key_pressed_n_o;
  output [255:0]main_osm_control_m_o;
  output [7:0]main_pot1_x_o;
  output [7:0]main_pot1_y_o;
  output [7:0]main_pot2_x_o;
  output [7:0]main_pot2_y_o;
  input [23:0]main_power_led_col_i;
  input main_power_led_i;
  output [255:0]main_qnice_gp_reg_o;
  output main_qnice_pause_o;
  output main_qnice_reset_o;
  output main_reset_core_o;
  output main_reset_m2m_o;
  input main_rst_i;
  output main_rtc_o;
  output paddle_drain_o;
  input [3:0]paddle_i;
  input qnice_ascal_mode_i;
  input qnice_ascal_polyphase_i;
  input qnice_ascal_triplebuf_i;
  input qnice_audio_filter_i;
  input qnice_audio_mute_i;
  output qnice_clk_o;
  input qnice_csync_i;
  input qnice_dvi_i;
  input qnice_flip_joyports_i;
  output [255:0]qnice_gp_reg_o;
  input [8:0]qnice_osm_cfg_scaling_i;
  output [255:0]qnice_osm_control_m_o;
  output [27:0]qnice_ramrom_addr_o;
  output qnice_ramrom_ce_o;
  input [15:0]qnice_ramrom_data_in_i;
  output [15:0]qnice_ramrom_data_out_o;
  output [15:0]qnice_ramrom_dev_o;
  input qnice_ramrom_wait_i;
  output qnice_ramrom_we_o;
  input qnice_retro15kHz_i;
  output qnice_rst_o;
  input qnice_scandoubler_i;
  input qnice_video_mode_i;
  input qnice_zoom_crop_i;
  input reset_n_i;
  input sd2_cd_i;
  output sd2_clk_o;
  input sd2_miso_i;
  output sd2_mosi_o;
  output sd2_reset_o;
  input sd_cd_i;
  output sd_clk_o;
  input sd_miso_i;
  output sd_mosi_o;
  output sd_reset_o;
  output tmds_clk_n_o;
  output tmds_clk_p_o;
  output [2:0]tmds_data_n_o;
  output [2:0]tmds_data_p_o;
  input uart_rxd_i;
  output uart_txd_o;
  output vdac_blank_n_o;
  output vdac_clk_o;
  output vdac_sync_n_o;
  output [7:0]vga_blue_o;
  output [7:0]vga_green_o;
  output vga_hs_o;
  output [7:0]vga_red_o;
  inout vga_scl_io;
  inout vga_sda_io;
  output vga_vs_o;
  input [7:0]video_blue_i;
  input video_ce_i;
  input video_ce_ovl_i;
  input video_clk_i;
  input [7:0]video_green_i;
  input video_hblank_i;
  input video_hs_i;
  input [7:0]video_red_i;
  input video_rst_i;
  input video_vblank_i;
  input video_vs_i;

  wire [31:0]M2M_AV_Pipeline_hr_address_o;
  wire [7:0]M2M_AV_Pipeline_hr_burstcount_o;
  wire [1:0]M2M_AV_Pipeline_hr_byteenable_o;
  wire M2M_AV_Pipeline_hr_read_o;
  wire M2M_AV_Pipeline_hr_write_o;
  wire [15:0]M2M_AV_Pipeline_hr_writedata_o;
  wire [11:0]M2M_AV_Pipeline_qnice_h_bp_o;
  wire [11:0]M2M_AV_Pipeline_qnice_v_fp_o;
  wire [11:0]M2M_AV_Pipeline_qnice_v_pixels_o;
  wire [11:0]M2M_AV_Pipeline_qnice_v_pulse_o;
  wire [11:0]M2M_AV_Pipeline_qnice_vdmax_o;
  wire [1:0]M2M_CDC_Stable_hr2QNICE_dst_data_o;
  wire [1:0]M2M_CDC_Stable_main2Audio_dst_data_o;
  wire [4:0]M2M_Qnice_Wrapper_qnice_ascal_mode_o;
  wire [31:0]M2M_Qnice_Wrapper_qnice_avm_address_o;
  wire [7:0]M2M_Qnice_Wrapper_qnice_avm_burstcount_o;
  wire [1:0]M2M_Qnice_Wrapper_qnice_avm_byteenable_o;
  wire M2M_Qnice_Wrapper_qnice_avm_read_o;
  wire M2M_Qnice_Wrapper_qnice_avm_write_o;
  wire [15:0]M2M_Qnice_Wrapper_qnice_avm_writedata_o;
  wire M2M_Qnice_Wrapper_qnice_i2c_ce_o;
  wire M2M_Qnice_Wrapper_qnice_i2c_we_o;
  wire M2M_Qnice_Wrapper_qnice_osm_cfg_enable_o;
  wire [15:0]M2M_Qnice_Wrapper_qnice_osm_cfg_xy_o;
  wire M2M_Qnice_Wrapper_qnice_poly_wr_o;
  wire M2M_Qnice_Wrapper_qnice_rtc_ce_o;
  wire M2M_Qnice_Wrapper_qnice_rtc_we_o;
  wire audio_clk_o;
  wire [15:0]audio_left_o;
  wire audio_reset_o;
  wire [15:0]audio_right_o;
  wire [0:0]avm_fifo_0_s_avm_readdata_o;
  wire avm_fifo_0_s_avm_readdatavalid_o;
  wire avm_fifo_0_s_avm_waitrequest_o;
  wire cdc_pulse_0_dst_pulse_o;
  wire clk_i;
  wire clk_m2m_0_audio_clk_o;
  wire clk_m2m_0_audio_rst_o;
  wire clk_m2m_0_hr_clk_del_o;
  wire clk_m2m_0_hr_clk_o;
  wire clk_m2m_0_hr_delay_refclk_o;
  wire clk_m2m_0_hr_rst_o;
  wire clk_m2m_0_qnice_clk_o;
  wire clk_m2m_0_qnice_rst_o;
  wire clk_m2m_0_sys_pps_o;
  wire [27:0]clock_counter_0_cnt_o;
  wire hr_clk_p_o;
  wire hr_cs0_o;
  wire hr_high_o;
  wire hr_low_o;
  wire hr_reset_o;
  wire [15:0]hyperram_0_avm_readdata_o;
  wire hyperram_0_avm_readdatavalid_o;
  wire hyperram_0_avm_waitrequest_o;
  wire joy_1_down_n_i;
  wire joy_1_down_n_o;
  wire joy_1_fire_n_i;
  wire joy_1_fire_n_o;
  wire joy_1_left_n_i;
  wire joy_1_left_n_o;
  wire joy_1_right_n_i;
  wire joy_1_right_n_o;
  wire joy_1_up_n_i;
  wire joy_1_up_n_o;
  wire joy_2_down_n_i;
  wire joy_2_down_n_o;
  wire joy_2_fire_n_i;
  wire joy_2_fire_n_o;
  wire joy_2_left_n_i;
  wire joy_2_left_n_o;
  wire joy_2_right_n_i;
  wire joy_2_right_n_o;
  wire joy_2_up_n_i;
  wire joy_2_up_n_o;
  wire kb_io0_o;
  wire kb_io1_o;
  wire kb_io2_i;
  wire [15:0]main_audio_l_i;
  wire main_clk_i;
  wire [23:0]main_drive_led_col_i;
  wire main_drive_led_i;
  wire main_key_num_o;
  wire main_key_pressed_n_o;
  wire [23:0]main_power_led_col_i;
  wire main_power_led_i;
  wire main_rst_i;
  wire paddle_drain_o;
  wire [3:0]paddle_i;
  wire qnice_ascal_mode_i;
  wire qnice_ascal_polyphase_i;
  wire qnice_ascal_triplebuf_i;
  wire qnice_audio_filter_i;
  wire qnice_audio_mute_i;
  wire qnice_csync_i;
  wire qnice_dvi_i;
  wire qnice_flip_joyports_i;
  wire [255:0]qnice_gp_reg_o;
  wire [11:0]qnice_h_fp_i_1;
  wire [15:0]qnice_h_freq_i_1;
  wire [11:0]qnice_h_pixels_i_1;
  wire [11:0]qnice_h_pulse_i_1;
  wire [11:0]qnice_hdmax_i_1;
  wire [15:0]qnice_i2c_rd_data_i_1;
  wire qnice_i2c_wait_i_1;
  wire [15:0]qnice_osm_cfg_dxdy_i_1;
  wire [8:0]qnice_osm_cfg_scaling_i;
  wire [255:0]qnice_osm_control_m_o;
  wire [27:0]qnice_ramrom_addr_o;
  wire qnice_ramrom_ce_o;
  wire [15:0]qnice_ramrom_data_in_i;
  wire [15:0]qnice_ramrom_data_out_o;
  wire [15:0]qnice_ramrom_dev_o;
  wire qnice_ramrom_wait_i;
  wire qnice_ramrom_we_o;
  wire qnice_retro15kHz_i;
  wire [15:0]qnice_rtc_rd_data_i_1;
  wire qnice_rtc_wait_i_1;
  wire qnice_scandoubler_i;
  wire [11:0]qnice_v_bp_i_1;
  wire qnice_video_mode_i;
  wire [15:0]qnice_vram_data_i_1;
  wire qnice_zoom_crop_i;
  wire reset_manager_0_reset_core_n_o;
  wire reset_manager_0_reset_m2m_n_o;
  wire reset_n_i;
  wire sd2_cd_i;
  wire sd2_clk_o;
  wire sd2_miso_i;
  wire sd2_mosi_o;
  wire sd2_reset_o;
  wire sd_cd_i;
  wire sd_clk_o;
  wire sd_miso_i;
  wire sd_mosi_o;
  wire sd_reset_o;
  wire tmds_clk_n_o;
  wire tmds_clk_p_o;
  wire [2:0]tmds_data_n_o;
  wire [2:0]tmds_data_p_o;
  wire uart_rxd_i;
  wire uart_txd_o;
  wire vdac_blank_n_o;
  wire vdac_clk_o;
  wire vdac_sync_n_o;
  wire [7:0]vga_blue_o;
  wire [7:0]vga_green_o;
  wire vga_hs_o;
  wire [7:0]vga_red_o;
  wire vga_vs_o;
  wire [7:0]video_blue_i;
  wire video_ce_i;
  wire video_ce_ovl_i;
  wire video_clk_i;
  wire [7:0]video_green_i;
  wire video_hblank_i;
  wire video_hs_i;
  wire video_out_clock_0_clko;
  wire [7:0]video_red_i;
  wire video_rst_i;
  wire video_vblank_i;
  wire video_vs_i;

  M2M_AV_Pipeline_imp_LBLVSW M2M_AV_Pipeline
       (.VGA_BLUE(vga_blue_o),
        .VGA_GREEN(vga_green_o),
        .VGA_HS(vga_hs_o),
        .VGA_RED(vga_red_o),
        .VGA_VS(vga_vs_o),
        .audio_clk_i(clk_m2m_0_audio_clk_o),
        .audio_clk_o(audio_clk_o),
        .audio_left_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,M2M_CDC_Stable_main2Audio_dst_data_o}),
        .audio_left_o(audio_left_o),
        .audio_reset_o(audio_reset_o),
        .audio_right_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,M2M_CDC_Stable_main2Audio_dst_data_o}),
        .audio_right_o(audio_right_o),
        .audio_rst_i(clk_m2m_0_audio_rst_o),
        .hdmi_clk_i(1'b0),
        .hdmi_rst_i(1'b0),
        .hr_address_o(M2M_AV_Pipeline_hr_address_o),
        .hr_burstcount_o(M2M_AV_Pipeline_hr_burstcount_o),
        .hr_byteenable_o(M2M_AV_Pipeline_hr_byteenable_o),
        .hr_clk_i(clk_m2m_0_hr_clk_o),
        .hr_high_o(hr_high_o),
        .hr_low_o(hr_low_o),
        .hr_read_o(M2M_AV_Pipeline_hr_read_o),
        .hr_readdata_i(hyperram_0_avm_readdata_o),
        .hr_readdatavalid_i(hyperram_0_avm_readdatavalid_o),
        .hr_rst_i(clk_m2m_0_hr_rst_o),
        .hr_waitrequest_i(hyperram_0_avm_waitrequest_o),
        .hr_write_o(M2M_AV_Pipeline_hr_write_o),
        .hr_writedata_o(M2M_AV_Pipeline_hr_writedata_o),
        .qnice_address_i({1'b0,1'b0,1'b0,1'b0,qnice_ramrom_addr_o}),
        .qnice_ascal_mode_i(M2M_Qnice_Wrapper_qnice_ascal_mode_o),
        .qnice_audio_filter_i(qnice_audio_filter_i),
        .qnice_audio_mute_i(qnice_audio_mute_i),
        .qnice_byteenable_i({1'b0,1'b0}),
        .qnice_clk_i(clk_m2m_0_qnice_clk_o),
        .qnice_csync_i(qnice_csync_i),
        .qnice_data_i(qnice_ramrom_data_out_o),
        .qnice_dvi_i(qnice_dvi_i),
        .qnice_h_bp_o(M2M_AV_Pipeline_qnice_h_bp_o),
        .qnice_h_fp_o(qnice_h_fp_i_1),
        .qnice_h_freq_o(qnice_h_freq_i_1),
        .qnice_h_pixels_o(qnice_h_pixels_i_1),
        .qnice_h_pulse_o(qnice_h_pulse_i_1),
        .qnice_hdmax_o(qnice_hdmax_i_1),
        .qnice_osm_cfg_dxdy_i(qnice_osm_cfg_dxdy_i_1),
        .qnice_osm_cfg_enable_i(M2M_Qnice_Wrapper_qnice_osm_cfg_enable_o),
        .qnice_osm_cfg_scaling_i(qnice_osm_cfg_scaling_i),
        .qnice_osm_cfg_xy_i(M2M_Qnice_Wrapper_qnice_osm_cfg_xy_o),
        .qnice_poly_a_i(qnice_ramrom_addr_o[9:0]),
        .qnice_poly_clk_i(clk_m2m_0_qnice_clk_o),
        .qnice_poly_dw_i(qnice_ramrom_data_out_o[9:0]),
        .qnice_poly_wr_i(M2M_Qnice_Wrapper_qnice_poly_wr_o),
        .qnice_q_o(qnice_vram_data_i_1),
        .qnice_retro15kHz_i(qnice_retro15kHz_i),
        .qnice_rst_i(clk_m2m_0_qnice_rst_o),
        .qnice_scandoubler_i(qnice_scandoubler_i),
        .qnice_v_bp_o(qnice_v_bp_i_1),
        .qnice_v_fp_o(M2M_AV_Pipeline_qnice_v_fp_o),
        .qnice_v_pixels_o(M2M_AV_Pipeline_qnice_v_pixels_o),
        .qnice_v_pulse_o(M2M_AV_Pipeline_qnice_v_pulse_o),
        .qnice_vdmax_o(M2M_AV_Pipeline_qnice_vdmax_o),
        .qnice_video_mode_i({qnice_video_mode_i,qnice_video_mode_i,qnice_video_mode_i,qnice_video_mode_i}),
        .qnice_wren_i(1'b0),
        .qnice_zoom_crop_i(qnice_zoom_crop_i),
        .sys_clk_i(clk_i),
        .sys_pps_i(clk_m2m_0_sys_pps_o),
        .tmds_clk_i(1'b0),
        .tmds_clk_n_o(tmds_clk_n_o),
        .tmds_clk_p_o(tmds_clk_p_o),
        .tmds_data_n_o(tmds_data_n_o),
        .tmds_data_p_o(tmds_data_p_o),
        .vdac_blank_n(vdac_blank_n_o),
        .vdac_clk(vdac_clk_o),
        .vdac_sync_n(vdac_sync_n_o),
        .video_blue_i(video_blue_i),
        .video_ce_i(video_ce_i),
        .video_ce_ovl_i(video_ce_ovl_i),
        .video_clk_i(video_clk_i),
        .video_green_i(video_green_i),
        .video_hblank_i(video_hblank_i),
        .video_hs_i(video_hs_i),
        .video_red_i(video_red_i),
        .video_rst_i(video_rst_i),
        .video_vblank_i(video_vblank_i),
        .video_vs_i(video_vs_i));
  M2M_CDC_Stable_hr2QNICE_imp_1UZ8Y4M M2M_CDC_Stable_hr2QNICE
       (.dst_clk_i(clk_m2m_0_qnice_clk_o),
        .dst_data_o(M2M_CDC_Stable_hr2QNICE_dst_data_o),
        .src_clk_i(clk_m2m_0_hr_clk_o),
        .src_data_i({1'b0,1'b0}));
  M2M_CDC_Stable_main2Audio_imp_1LOO3M8 M2M_CDC_Stable_main2Audio
       (.dst_clk_i(clk_m2m_0_audio_clk_o),
        .dst_data_o(M2M_CDC_Stable_main2Audio_dst_data_o),
        .src_clk_i(main_clk_i),
        .src_data_i(main_audio_l_i[1:0]));
  M2M_Keyboard_imp_X3WX39 M2M_Keyboard
       (.clk_main_i(main_clk_i),
        .clk_main_speed_i(1'b0),
        .drive_led_col_i(main_drive_led_col_i),
        .drive_led_i(main_drive_led_i),
        .enable_core_i(1'b0),
        .key_num_o(main_key_num_o),
        .key_pressed_n_o(main_key_pressed_n_o),
        .kio10_i(kb_io2_i),
        .kio8_o(kb_io0_o),
        .kio9_o(kb_io1_o),
        .power_led_col_i(main_power_led_col_i),
        .power_led_i(main_power_led_i));
  M2M_Qnice_Wrapper_imp_19TFD0K M2M_Qnice_Wrapper
       (.clk_i(clk_m2m_0_qnice_clk_o),
        .paddle_drain_o(paddle_drain_o),
        .paddle_i(paddle_i),
        .qnice_ascal_mode_i({qnice_ascal_mode_i,qnice_ascal_mode_i}),
        .qnice_ascal_mode_o(M2M_Qnice_Wrapper_qnice_ascal_mode_o),
        .qnice_ascal_polyphase_i(qnice_ascal_polyphase_i),
        .qnice_ascal_triplebuf_i(qnice_ascal_triplebuf_i),
        .qnice_avm_address_o(M2M_Qnice_Wrapper_qnice_avm_address_o),
        .qnice_avm_burstcount_o(M2M_Qnice_Wrapper_qnice_avm_burstcount_o),
        .qnice_avm_byteenable_o(M2M_Qnice_Wrapper_qnice_avm_byteenable_o),
        .qnice_avm_read_o(M2M_Qnice_Wrapper_qnice_avm_read_o),
        .qnice_avm_readdata_i(avm_fifo_0_s_avm_readdata_o),
        .qnice_avm_readdatavalid_i(avm_fifo_0_s_avm_readdatavalid_o),
        .qnice_avm_waitrequest_i(avm_fifo_0_s_avm_waitrequest_o),
        .qnice_avm_write_o(M2M_Qnice_Wrapper_qnice_avm_write_o),
        .qnice_avm_writedata_o(M2M_Qnice_Wrapper_qnice_avm_writedata_o),
        .qnice_flip_joyports_i(qnice_flip_joyports_i),
        .qnice_gp_reg_o(qnice_gp_reg_o),
        .qnice_h_bp_i(M2M_AV_Pipeline_qnice_h_bp_o),
        .qnice_h_fp_i(qnice_h_fp_i_1),
        .qnice_h_freq_i(qnice_h_freq_i_1[11:0]),
        .qnice_h_pixels_i(qnice_h_pixels_i_1),
        .qnice_h_pulse_i(qnice_h_pulse_i_1),
        .qnice_hdmax_i(qnice_hdmax_i_1),
        .qnice_hdmi_clk_freq_i(clock_counter_0_cnt_o),
        .qnice_hr_count_long_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,M2M_CDC_Stable_hr2QNICE_dst_data_o}),
        .qnice_hr_count_short_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,M2M_CDC_Stable_hr2QNICE_dst_data_o}),
        .qnice_i2c_ce_o(M2M_Qnice_Wrapper_qnice_i2c_ce_o),
        .qnice_i2c_rd_data_i(qnice_i2c_rd_data_i_1),
        .qnice_i2c_wait_i(qnice_i2c_wait_i_1),
        .qnice_i2c_we_o(M2M_Qnice_Wrapper_qnice_i2c_we_o),
        .qnice_osm_cfg_dxdy_o(qnice_osm_cfg_dxdy_i_1),
        .qnice_osm_cfg_enable_o(M2M_Qnice_Wrapper_qnice_osm_cfg_enable_o),
        .qnice_osm_cfg_xy_o(M2M_Qnice_Wrapper_qnice_osm_cfg_xy_o),
        .qnice_osm_control_m_o(qnice_osm_control_m_o),
        .qnice_poly_wr_o(M2M_Qnice_Wrapper_qnice_poly_wr_o),
        .qnice_pps_i(1'b0),
        .qnice_qnice_keys_n_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .qnice_ramrom_addr_o(qnice_ramrom_addr_o),
        .qnice_ramrom_ce_o(qnice_ramrom_ce_o),
        .qnice_ramrom_data_in_i(qnice_ramrom_data_in_i),
        .qnice_ramrom_data_out_o(qnice_ramrom_data_out_o),
        .qnice_ramrom_dev_o(qnice_ramrom_dev_o),
        .qnice_ramrom_wait_i(qnice_ramrom_wait_i),
        .qnice_ramrom_we_o(qnice_ramrom_we_o),
        .qnice_rtc_ce_o(M2M_Qnice_Wrapper_qnice_rtc_ce_o),
        .qnice_rtc_rd_data_i(qnice_rtc_rd_data_i_1),
        .qnice_rtc_wait_i(qnice_rtc_wait_i_1),
        .qnice_rtc_we_o(M2M_Qnice_Wrapper_qnice_rtc_we_o),
        .qnice_v_bp_i(qnice_v_bp_i_1),
        .qnice_v_fp_i(M2M_AV_Pipeline_qnice_v_fp_o),
        .qnice_v_pixels_i(M2M_AV_Pipeline_qnice_v_pixels_o),
        .qnice_v_pulse_i(M2M_AV_Pipeline_qnice_v_pulse_o),
        .qnice_vdmax_i(M2M_AV_Pipeline_qnice_vdmax_o),
        .qnice_vram_data_i(qnice_vram_data_i_1),
        .rst_i(clk_m2m_0_qnice_rst_o),
        .sd2_cd_i(sd2_cd_i),
        .sd2_clk_o(sd2_clk_o),
        .sd2_miso_i(sd2_miso_i),
        .sd2_mosi_o(sd2_mosi_o),
        .sd2_reset_o(sd2_reset_o),
        .sd_cd_i(sd_cd_i),
        .sd_clk_o(sd_clk_o),
        .sd_miso_i(sd_miso_i),
        .sd_mosi_o(sd_mosi_o),
        .sd_reset_o(sd_reset_o),
        .uart_rxd_i(uart_rxd_i),
        .uart_txd_o(uart_txd_o));
  Mega65_R6_avm_arbit_general_0_0 avm_arbit_general_0
       (.clk_i(clk_m2m_0_hr_clk_o),
        .m_avm_readdata_i(1'b0),
        .m_avm_readdatavalid_i(1'b0),
        .m_avm_waitrequest_i(1'b0),
        .rst_i(clk_m2m_0_hr_rst_o),
        .s_avm_address_i(1'b0),
        .s_avm_burstcount_i(1'b0),
        .s_avm_byteenable_i(1'b0),
        .s_avm_read_i(1'b0),
        .s_avm_write_i(1'b0),
        .s_avm_writedata_i(1'b0));
  Mega65_R6_avm_fifo_0_0 avm_fifo_0
       (.m_avm_readdata_i(1'b0),
        .m_avm_readdatavalid_i(1'b0),
        .m_avm_waitrequest_i(1'b0),
        .m_clk_i(clk_m2m_0_hr_clk_o),
        .m_rst_i(clk_m2m_0_hr_rst_o),
        .s_avm_address_i(M2M_Qnice_Wrapper_qnice_avm_address_o[0]),
        .s_avm_burstcount_i(M2M_Qnice_Wrapper_qnice_avm_burstcount_o),
        .s_avm_byteenable_i(M2M_Qnice_Wrapper_qnice_avm_byteenable_o[0]),
        .s_avm_read_i(M2M_Qnice_Wrapper_qnice_avm_read_o),
        .s_avm_readdata_o(avm_fifo_0_s_avm_readdata_o),
        .s_avm_readdatavalid_o(avm_fifo_0_s_avm_readdatavalid_o),
        .s_avm_waitrequest_o(avm_fifo_0_s_avm_waitrequest_o),
        .s_avm_write_i(M2M_Qnice_Wrapper_qnice_avm_write_o),
        .s_avm_writedata_i(M2M_Qnice_Wrapper_qnice_avm_writedata_o[0]),
        .s_clk_i(clk_m2m_0_qnice_clk_o),
        .s_rst_i(clk_m2m_0_qnice_rst_o));
  Mega65_R6_cdc_pulse_0_0 cdc_pulse_0
       (.dst_clk_i(clk_m2m_0_qnice_clk_o),
        .dst_pulse_o(cdc_pulse_0_dst_pulse_o),
        .src_clk_i(clk_i),
        .src_pulse_i(1'b0));
  Mega65_R6_clk_m2m_0_0 clk_m2m_0
       (.audio_clk_o(clk_m2m_0_audio_clk_o),
        .audio_rst_o(clk_m2m_0_audio_rst_o),
        .core_rstn_i(reset_manager_0_reset_core_n_o),
        .hr_clk_del_o(clk_m2m_0_hr_clk_del_o),
        .hr_clk_o(clk_m2m_0_hr_clk_o),
        .hr_delay_refclk_o(clk_m2m_0_hr_delay_refclk_o),
        .hr_rst_o(clk_m2m_0_hr_rst_o),
        .qnice_clk_o(clk_m2m_0_qnice_clk_o),
        .qnice_rst_o(clk_m2m_0_qnice_rst_o),
        .sys_clk_i(clk_i),
        .sys_pps_o(clk_m2m_0_sys_pps_o),
        .sys_rstn_i(reset_manager_0_reset_m2m_n_o));
  Mega65_R6_clock_counter_0_0 clock_counter_0
       (.clk_i(clk_m2m_0_qnice_clk_o),
        .cnt_o(clock_counter_0_cnt_o),
        .mon_clk_i(video_out_clock_0_clko),
        .pps_i(cdc_pulse_0_dst_pulse_o));
  Mega65_R6_debouncer_0_0 debouncer_0
       (.clk(main_clk_i),
        .dbnce_joy1_down_n(joy_1_down_n_o),
        .dbnce_joy1_fire_n(joy_1_fire_n_o),
        .dbnce_joy1_left_n(joy_1_left_n_o),
        .dbnce_joy1_right_n(joy_1_right_n_o),
        .dbnce_joy1_up_n(joy_1_up_n_o),
        .dbnce_joy2_down_n(joy_2_down_n_o),
        .dbnce_joy2_fire_n(joy_2_fire_n_o),
        .dbnce_joy2_left_n(joy_2_left_n_o),
        .dbnce_joy2_right_n(joy_2_right_n_o),
        .dbnce_joy2_up_n(joy_2_up_n_o),
        .flip_joys_i(1'b0),
        .joy_1_down_n(joy_1_down_n_i),
        .joy_1_fire_n(joy_1_fire_n_i),
        .joy_1_left_n(joy_1_left_n_i),
        .joy_1_on(1'b0),
        .joy_1_right_n(joy_1_right_n_i),
        .joy_1_up_n(joy_1_up_n_i),
        .joy_2_down_n(joy_2_down_n_i),
        .joy_2_fire_n(joy_2_fire_n_i),
        .joy_2_left_n(joy_2_left_n_i),
        .joy_2_on(1'b0),
        .joy_2_right_n(joy_2_right_n_i),
        .joy_2_up_n(joy_2_up_n_i),
        .reset_n(main_rst_i));
  Mega65_R6_hyperram_0_0 hyperram_0
       (.avm_address_i(M2M_AV_Pipeline_hr_address_o),
        .avm_burstcount_i(M2M_AV_Pipeline_hr_burstcount_o),
        .avm_byteenable_i(M2M_AV_Pipeline_hr_byteenable_o),
        .avm_read_i(M2M_AV_Pipeline_hr_read_o),
        .avm_readdata_o(hyperram_0_avm_readdata_o),
        .avm_readdatavalid_o(hyperram_0_avm_readdatavalid_o),
        .avm_waitrequest_o(hyperram_0_avm_waitrequest_o),
        .avm_write_i(M2M_AV_Pipeline_hr_write_o),
        .avm_writedata_i(M2M_AV_Pipeline_hr_writedata_o),
        .clk_del_i(clk_m2m_0_hr_clk_del_o),
        .clk_i(clk_m2m_0_hr_clk_o),
        .delay_refclk_i(clk_m2m_0_hr_delay_refclk_o),
        .hr_ck_o(hr_clk_p_o),
        .hr_csn_o(hr_cs0_o),
        .hr_dq_in_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .hr_resetn_o(hr_reset_o),
        .hr_rwds_in_i(1'b0),
        .rst_i(clk_m2m_0_hr_rst_o));
  Mega65_R6_reset_manager_0_0 reset_manager_0
       (.CLK(clk_i),
        .RESET_N(reset_n_i),
        .reset_core_n_o(reset_manager_0_reset_core_n_o),
        .reset_m2m_n_o(reset_manager_0_reset_m2m_n_o));
  Mega65_R6_rtc_wrapper_0_0 rtc_wrapper_0
       (.clk_i(clk_m2m_0_qnice_clk_o),
        .i2c_addr_i(qnice_ramrom_addr_o),
        .i2c_ce_i(M2M_Qnice_Wrapper_qnice_i2c_ce_o),
        .i2c_rd_data_o(qnice_i2c_rd_data_i_1),
        .i2c_wait_o(qnice_i2c_wait_i_1),
        .i2c_we_i(M2M_Qnice_Wrapper_qnice_i2c_we_o),
        .i2c_wr_data_i(qnice_ramrom_data_out_o),
        .rst_i(clk_m2m_0_qnice_rst_o),
        .rtc_addr_i(qnice_ramrom_addr_o[7:0]),
        .rtc_ce_i(M2M_Qnice_Wrapper_qnice_rtc_ce_o),
        .rtc_rd_data_o(qnice_rtc_rd_data_i_1),
        .rtc_wait_o(qnice_rtc_wait_i_1),
        .rtc_we_i(M2M_Qnice_Wrapper_qnice_rtc_we_o),
        .rtc_wr_data_i(qnice_ramrom_data_out_o),
        .scl_in_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .sda_in_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  Mega65_R6_video_out_clock_0_0 video_out_clock_0
       (.clki(clk_i),
        .clko(video_out_clock_0_clko),
        .rsti(1'b0),
        .sel({1'b0,1'b0,1'b0}));
endmodule

module M2M_Keyb_Matrix_to_Keynum_imp_1IXAKOB
   (Clk,
    ascii_key,
    ascii_key_valid,
    bucky_key,
    clock_frequency,
    m65_key_num,
    m65_key_status_n,
    matrix_col,
    matrix_col_idx,
    reset_in,
    suppress_key_glitches,
    suppress_key_retrigger);
  input Clk;
  output [7:0]ascii_key;
  output ascii_key_valid;
  output [6:0]bucky_key;
  input clock_frequency;
  output m65_key_num;
  output m65_key_status_n;
  input [7:0]matrix_col;
  input matrix_col_idx;
  input reset_in;
  input suppress_key_glitches;
  input suppress_key_retrigger;

  wire Clk;
  wire [7:0]matrix_col;
  wire matrix_col_idx;

  Mega65_R6_kb_matrix_ram_0_1 current_kmm
       (.ClkA(Clk),
        .addressa({matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx,matrix_col_idx}),
        .addressb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dia(matrix_col),
        .wea({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  Mega65_R6_kb_matrix_ram_0_2 debounce_kmm
       (.ClkA(Clk),
        .addressa({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .addressb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dia({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .wea({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  Mega65_R6_kb_matrix_ram_0_3 last_kmm
       (.ClkA(Clk),
        .addressa({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .addressb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dia({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .wea({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

module M2M_Keyboard_imp_X3WX39
   (clk_main_i,
    clk_main_speed_i,
    drive_led_col_i,
    drive_led_i,
    enable_core_i,
    key_num_o,
    key_pressed_n_o,
    kio10_i,
    kio8_o,
    kio9_o,
    power_led_col_i,
    power_led_i,
    qnice_keys_n_o);
  input clk_main_i;
  input clk_main_speed_i;
  input [23:0]drive_led_col_i;
  input drive_led_i;
  input enable_core_i;
  output key_num_o;
  output key_pressed_n_o;
  input kio10_i;
  output kio8_o;
  output kio9_o;
  input [23:0]power_led_col_i;
  input power_led_i;
  output [15:0]qnice_keys_n_o;

  wire [7:0]M2M_Keyboard_to_Matrix_matrix_col;
  wire clk_main_i;
  wire clk_main_speed_i;
  wire [23:0]drive_led_col_i;
  wire drive_led_i;
  wire kio10_i;
  wire kio8_o;
  wire kio9_o;
  wire [23:0]power_led_col_i;
  wire power_led_i;

  M2M_Keyb_Matrix_to_Keynum_imp_1IXAKOB M2M_Keyb_Matrix_to_Keynum
       (.Clk(clk_main_i),
        .clock_frequency(clk_main_speed_i),
        .matrix_col(M2M_Keyboard_to_Matrix_matrix_col),
        .matrix_col_idx(1'b0),
        .reset_in(1'b0),
        .suppress_key_glitches(1'b0),
        .suppress_key_retrigger(1'b0));
  M2M_Keyboard_to_Matrix_imp_10MWDDC M2M_Keyboard_to_Matrix
       (.clock_frequency(clk_main_speed_i),
        .driveled_blinking(1'b0),
        .driveled_col(drive_led_col_i),
        .driveled_steady(drive_led_i),
        .ioclock(clk_main_i),
        .kio10(kio10_i),
        .kio8(kio8_o),
        .kio9(kio9_o),
        .matrix_col(M2M_Keyboard_to_Matrix_matrix_col),
        .matrix_col_idx({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .powerled_col(power_led_col_i),
        .powerled_steady(power_led_i));
endmodule

module M2M_Keyboard_to_Matrix_imp_10MWDDC
   (capslock_out,
    clock_frequency,
    delete_out,
    driveled_blinking,
    driveled_col,
    driveled_steady,
    fastkey_out,
    ioclock,
    kio10,
    kio8,
    kio9,
    leftkey,
    matrix_col,
    matrix_col_idx,
    powerled_col,
    powerled_steady,
    restore,
    return_out,
    upkey);
  output capslock_out;
  input clock_frequency;
  output delete_out;
  input driveled_blinking;
  input [23:0]driveled_col;
  input driveled_steady;
  output fastkey_out;
  input ioclock;
  input kio10;
  output kio8;
  output kio9;
  output leftkey;
  output [7:0]matrix_col;
  input [0:9]matrix_col_idx;
  input [23:0]powerled_col;
  input powerled_steady;
  output restore;
  output return_out;
  output upkey;

  wire ioclock;
  wire [7:0]matrix_col;
  wire [0:9]matrix_col_idx;

  Mega65_R6_kb_matrix_ram_0_0 kb_matrix_ram_0
       (.ClkA(ioclock),
        .addressa({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .addressb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,matrix_col_idx[0],matrix_col_idx[1],matrix_col_idx[2],matrix_col_idx[3],matrix_col_idx[4],matrix_col_idx[5],matrix_col_idx[6],matrix_col_idx[7],matrix_col_idx[8],matrix_col_idx[9]}),
        .dia({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dob(matrix_col),
        .wea({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

module M2M_QNICE_CPU_imp_U2C5QX
   (ADDR,
    CLK,
    DATA_DIR,
    DATA_IN,
    DATA_OUT,
    DATA_VALID,
    HALT,
    IGRANT_N,
    INS_CNT_STROBE,
    INT_N,
    RESET,
    WAIT_FOR_DATA);
  output [15:0]ADDR;
  input CLK;
  output DATA_DIR;
  input [15:0]DATA_IN;
  output [15:0]DATA_OUT;
  output DATA_VALID;
  output HALT;
  output IGRANT_N;
  output INS_CNT_STROBE;
  input INT_N;
  input RESET;
  input WAIT_FOR_DATA;

  wire CLK;

  Mega65_R6_alu_0_0 alu_0
       (.c_in(1'b0),
        .input1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .input2({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .opcode({1'b0,1'b0,1'b0,1'b0}),
        .x_in(1'b0));
  Mega65_R6_register_file_0_0 register_file_0
       (.PC({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .SP({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .SR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clk(CLK),
        .read_addr1({1'b0,1'b0,1'b0,1'b0}),
        .read_addr2({1'b0,1'b0,1'b0,1'b0}),
        .sel_rbank({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .write_addr({1'b0,1'b0,1'b0,1'b0}),
        .write_data({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .write_en(1'b0));
endmodule

module M2M_QNICE_SOC_BUS_UART_imp_105KZE4
   (clk,
    cpu_data_in,
    cpu_data_out,
    cts,
    reset,
    rts,
    rx,
    tx,
    uart_cpu_ws,
    uart_en,
    uart_reg,
    uart_we);
  input clk;
  input [15:0]cpu_data_in;
  output [15:0]cpu_data_out;
  output cts;
  input reset;
  input rts;
  input rx;
  output tx;
  output uart_cpu_ws;
  input uart_en;
  input [1:0]uart_reg;
  input uart_we;

  wire clk;
  wire reset;
  wire rx;
  wire tx;

  Mega65_R6_basic_uart_0_0 basic_uart_0
       (.clk(clk),
        .reset(reset),
        .rx(rx),
        .tx(tx),
        .tx_data({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .tx_enable(1'b0));
  Mega65_R6_ring_buffer_0_0 ring_buffer_0
       (.clk(clk),
        .rd_en(1'b0),
        .rst(reset),
        .wr_data(1'b0),
        .wr_en(1'b0));
endmodule

module M2M_QNICE_SOC_imp_11A88RY
   (ascal_mode_i,
    ascal_mode_o,
    clk50_i,
    control_d_o,
    control_m_o,
    csr_joy1_o,
    csr_joy2_o,
    csr_keyboard_o,
    csr_osm_o,
    csr_pause_o,
    csr_reset_o,
    general_i,
    keys_n_i,
    osm_dxdy_o,
    osm_xy_o,
    ramrom_addr_o,
    ramrom_ce_o,
    ramrom_data_i,
    ramrom_data_o,
    ramrom_dev_o,
    ramrom_wait_i,
    ramrom_we_o,
    reset_n_i,
    sd2_cd_i,
    sd2_clk_o,
    sd2_miso_i,
    sd2_mosi_o,
    sd2_reset_o,
    sd_cd_i,
    sd_clk_o,
    sd_miso_i,
    sd_mosi_o,
    sd_reset_o,
    special_i,
    uart_rxd_i,
    uart_txd_o);
  input [4:0]ascal_mode_i;
  output [4:0]ascal_mode_o;
  input clk50_i;
  output [255:0]control_d_o;
  output [255:0]control_m_o;
  output csr_joy1_o;
  output csr_joy2_o;
  output csr_keyboard_o;
  output csr_osm_o;
  output csr_pause_o;
  output csr_reset_o;
  input [15:0]general_i;
  input [15:0]keys_n_i;
  output [15:0]osm_dxdy_o;
  output [15:0]osm_xy_o;
  output [27:0]ramrom_addr_o;
  output ramrom_ce_o;
  input [15:0]ramrom_data_i;
  output [15:0]ramrom_data_o;
  output [15:0]ramrom_dev_o;
  input ramrom_wait_i;
  output ramrom_we_o;
  input reset_n_i;
  input sd2_cd_i;
  output sd2_clk_o;
  input sd2_miso_i;
  output sd2_mosi_o;
  output sd2_reset_o;
  input sd_cd_i;
  output sd_clk_o;
  input sd_miso_i;
  output sd_mosi_o;
  output sd_reset_o;
  input [15:0]special_i;
  input uart_rxd_i;
  output uart_txd_o;

  wire clk50_i;
  wire ramrom_wait_i;
  wire reset_n_i;
  wire sd2_cd_i;
  wire sd2_clk_o;
  wire sd2_miso_i;
  wire sd2_mosi_o;
  wire sd2_reset_o;
  wire sd_cd_i;
  wire sd_clk_o;
  wire sd_miso_i;
  wire sd_mosi_o;
  wire sd_reset_o;
  wire uart_rxd_i;
  wire uart_txd_o;

  Mega65_R6_BRAM_0_0 BRAM_0
       (.address({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ce(1'b0),
        .clk(clk50_i),
        .data_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .we(1'b0));
  Mega65_R6_BROM_0_0 BROM_0
       (.address({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ce(1'b0),
        .clk(clk50_i));
  Mega65_R6_EAE_0_0 EAE_0
       (.clk(clk50_i),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .en(1'b0),
        .\reg ({1'b0,1'b0,1'b0}),
        .reset(1'b0),
        .we(1'b0));
  M2M_QNICE_CPU_imp_U2C5QX M2M_QNICE_CPU
       (.CLK(clk50_i),
        .DATA_IN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INT_N(1'b0),
        .RESET(1'b0),
        .WAIT_FOR_DATA(ramrom_wait_i));
  M2M_QNICE_SOC_BUS_UART_imp_105KZE4 M2M_QNICE_SOC_BUS_UART
       (.clk(clk50_i),
        .cpu_data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reset(1'b0),
        .rts(1'b0),
        .rx(uart_rxd_i),
        .tx(uart_txd_o),
        .uart_en(1'b0),
        .uart_reg({1'b0,1'b0}),
        .uart_we(1'b0));
  Mega65_R6_cycle_counter_0_0 cycle_counter_0
       (.clk(clk50_i),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .en(1'b0),
        .impulse(1'b0),
        .\reg ({1'b0,1'b0}),
        .reset(1'b0),
        .we(1'b0));
  Mega65_R6_mmio_mux_0_0 mmio_mux_0
       (.CLK(clk50_i),
        .HW_RESET(reset_n_i),
        .addr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .cpu_halt(1'b0),
        .cpu_igrant_n(1'b0),
        .data_dir(1'b0),
        .data_valid(1'b0),
        .hram_cpu_ws(1'b0),
        .pore_rom_busy(1'b0),
        .ram_busy(1'b0),
        .rom_busy(1'b0),
        .uart_cpu_ws(1'b0));
  Mega65_R6_sdcard_0_0 sdcard_0
       (.clk(clk50_i),
        .data_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .en(1'b0),
        .\reg ({1'b0,1'b0,1'b0}),
        .reset(1'b0),
        .sd_miso(1'b0),
        .we(1'b0));
  Mega65_R6_sdmux_0_0 sdmux_0
       (.ctrl_sd_clk_i(1'b0),
        .ctrl_sd_mosi_i(1'b0),
        .ctrl_sd_reset_i(1'b0),
        .force_i(1'b0),
        .mode_i(1'b0),
        .sd_back_clk_o(sd_clk_o),
        .sd_back_detect_i(sd_cd_i),
        .sd_back_miso_i(sd_miso_i),
        .sd_back_mosi_o(sd_mosi_o),
        .sd_back_reset_o(sd_reset_o),
        .sd_tray_clk_o(sd2_clk_o),
        .sd_tray_detect_i(sd2_cd_i),
        .sd_tray_miso_i(sd2_miso_i),
        .sd_tray_mosi_o(sd2_mosi_o),
        .sd_tray_reset_o(sd2_reset_o),
        .sysclk50Mhz_i(clk50_i),
        .sysreset_i(1'b0));
endmodule

module M2M_Qnice_Wrapper_imp_19TFD0K
   (clk_i,
    paddle_drain_o,
    paddle_i,
    qnice_ascal_mode_i,
    qnice_ascal_mode_o,
    qnice_ascal_polyphase_i,
    qnice_ascal_triplebuf_i,
    qnice_avm_address_o,
    qnice_avm_burstcount_o,
    qnice_avm_byteenable_o,
    qnice_avm_read_o,
    qnice_avm_readdata_i,
    qnice_avm_readdatavalid_i,
    qnice_avm_waitrequest_i,
    qnice_avm_write_o,
    qnice_avm_writedata_o,
    qnice_csr_joy1_on_o,
    qnice_csr_joy2_on_o,
    qnice_csr_keyboard_on_o,
    qnice_csr_pause_o,
    qnice_csr_reset_o,
    qnice_flip_joyports_i,
    qnice_gp_reg_o,
    qnice_h_bp_i,
    qnice_h_fp_i,
    qnice_h_freq_i,
    qnice_h_pixels_i,
    qnice_h_pulse_i,
    qnice_hdmax_i,
    qnice_hdmi_clk_freq_i,
    qnice_hr_count_long_i,
    qnice_hr_count_short_i,
    qnice_i2c_ce_o,
    qnice_i2c_rd_data_i,
    qnice_i2c_wait_i,
    qnice_i2c_we_o,
    qnice_osm_cfg_dxdy_o,
    qnice_osm_cfg_enable_o,
    qnice_osm_cfg_xy_o,
    qnice_osm_control_m_o,
    qnice_poly_wr_o,
    qnice_pot1_x_n_o,
    qnice_pot1_y_n_o,
    qnice_pot2_x_n_o,
    qnice_pot2_y_n_o,
    qnice_pps_i,
    qnice_qnice_keys_n_i,
    qnice_ramrom_addr_o,
    qnice_ramrom_ce_o,
    qnice_ramrom_data_in_i,
    qnice_ramrom_data_out_o,
    qnice_ramrom_dev_o,
    qnice_ramrom_wait_i,
    qnice_ramrom_we_o,
    qnice_rtc_ce_o,
    qnice_rtc_rd_data_i,
    qnice_rtc_wait_i,
    qnice_rtc_we_o,
    qnice_v_bp_i,
    qnice_v_fp_i,
    qnice_v_pixels_i,
    qnice_v_pulse_i,
    qnice_vdmax_i,
    qnice_vram_attr_we_o,
    qnice_vram_data_i,
    qnice_vram_we_o,
    rst_i,
    sd2_cd_i,
    sd2_clk_o,
    sd2_miso_i,
    sd2_mosi_o,
    sd2_reset_o,
    sd_cd_i,
    sd_clk_o,
    sd_miso_i,
    sd_mosi_o,
    sd_reset_o,
    uart_rxd_i,
    uart_txd_o);
  input clk_i;
  output paddle_drain_o;
  input [3:0]paddle_i;
  input [1:0]qnice_ascal_mode_i;
  output [4:0]qnice_ascal_mode_o;
  input qnice_ascal_polyphase_i;
  input qnice_ascal_triplebuf_i;
  output [31:0]qnice_avm_address_o;
  output [7:0]qnice_avm_burstcount_o;
  output [1:0]qnice_avm_byteenable_o;
  output qnice_avm_read_o;
  input [0:0]qnice_avm_readdata_i;
  input qnice_avm_readdatavalid_i;
  input qnice_avm_waitrequest_i;
  output qnice_avm_write_o;
  output [15:0]qnice_avm_writedata_o;
  output qnice_csr_joy1_on_o;
  output qnice_csr_joy2_on_o;
  output qnice_csr_keyboard_on_o;
  output qnice_csr_pause_o;
  output qnice_csr_reset_o;
  input qnice_flip_joyports_i;
  output [255:0]qnice_gp_reg_o;
  input [11:0]qnice_h_bp_i;
  input [11:0]qnice_h_fp_i;
  input [11:0]qnice_h_freq_i;
  input [11:0]qnice_h_pixels_i;
  input [11:0]qnice_h_pulse_i;
  input [11:0]qnice_hdmax_i;
  input [27:0]qnice_hdmi_clk_freq_i;
  input [31:0]qnice_hr_count_long_i;
  input [31:0]qnice_hr_count_short_i;
  output qnice_i2c_ce_o;
  input [15:0]qnice_i2c_rd_data_i;
  input qnice_i2c_wait_i;
  output qnice_i2c_we_o;
  output [15:0]qnice_osm_cfg_dxdy_o;
  output qnice_osm_cfg_enable_o;
  output [15:0]qnice_osm_cfg_xy_o;
  output [255:0]qnice_osm_control_m_o;
  output qnice_poly_wr_o;
  output [7:0]qnice_pot1_x_n_o;
  output [7:0]qnice_pot1_y_n_o;
  output [7:0]qnice_pot2_x_n_o;
  output [7:0]qnice_pot2_y_n_o;
  input qnice_pps_i;
  input [15:0]qnice_qnice_keys_n_i;
  output [27:0]qnice_ramrom_addr_o;
  output qnice_ramrom_ce_o;
  input [15:0]qnice_ramrom_data_in_i;
  output [15:0]qnice_ramrom_data_out_o;
  output [15:0]qnice_ramrom_dev_o;
  input qnice_ramrom_wait_i;
  output qnice_ramrom_we_o;
  output qnice_rtc_ce_o;
  input [15:0]qnice_rtc_rd_data_i;
  input qnice_rtc_wait_i;
  output qnice_rtc_we_o;
  input [11:0]qnice_v_bp_i;
  input [11:0]qnice_v_fp_i;
  input [11:0]qnice_v_pixels_i;
  input [11:0]qnice_v_pulse_i;
  input [11:0]qnice_vdmax_i;
  output qnice_vram_attr_we_o;
  input [15:0]qnice_vram_data_i;
  output qnice_vram_we_o;
  input rst_i;
  input sd2_cd_i;
  output sd2_clk_o;
  input sd2_miso_i;
  output sd2_mosi_o;
  output sd2_reset_o;
  input sd_cd_i;
  output sd_clk_o;
  input sd_miso_i;
  output sd_mosi_o;
  output sd_reset_o;
  input uart_rxd_i;
  output uart_txd_o;

  wire clk_i;
  wire paddle_drain_o;
  wire [3:0]paddle_i;
  wire [4:0]qnice_ascal_mode_o;
  wire qnice_ascal_triplebuf_i;
  wire [31:0]qnice_avm_address_o;
  wire [7:0]qnice_avm_burstcount_o;
  wire [1:0]qnice_avm_byteenable_o;
  wire qnice_avm_read_o;
  wire [0:0]qnice_avm_readdata_i;
  wire qnice_avm_readdatavalid_i;
  wire qnice_avm_waitrequest_i;
  wire qnice_avm_write_o;
  wire [15:0]qnice_avm_writedata_o;
  wire qnice_csr_joy1_on_o;
  wire qnice_csr_joy2_on_o;
  wire qnice_csr_keyboard_on_o;
  wire qnice_csr_pause_o;
  wire qnice_csr_reset_o;
  wire [255:0]qnice_gp_reg_o;
  wire [15:0]qnice_osm_cfg_dxdy_o;
  wire qnice_osm_cfg_enable_o;
  wire [15:0]qnice_osm_cfg_xy_o;
  wire [255:0]qnice_osm_control_m_o;
  wire [15:0]qnice_qnice_keys_n_i;
  wire [27:0]qnice_ramrom_addr_o;
  wire qnice_ramrom_ce_o;
  wire [15:0]qnice_ramrom_data_in_i;
  wire [15:0]qnice_ramrom_data_out_o;
  wire [15:0]qnice_ramrom_dev_o;
  wire qnice_ramrom_we_o;
  wire rst_i;
  wire sd2_cd_i;
  wire sd2_clk_o;
  wire sd2_miso_i;
  wire sd2_mosi_o;
  wire sd2_reset_o;
  wire sd_cd_i;
  wire sd_clk_o;
  wire sd_miso_i;
  wire sd_mosi_o;
  wire sd_reset_o;
  wire uart_rxd_i;
  wire uart_txd_o;

  M2M_QNICE_SOC_imp_11A88RY M2M_QNICE_SOC
       (.ascal_mode_i({qnice_ascal_triplebuf_i,qnice_ascal_triplebuf_i,qnice_ascal_triplebuf_i,qnice_ascal_triplebuf_i,qnice_ascal_triplebuf_i}),
        .ascal_mode_o(qnice_ascal_mode_o),
        .clk50_i(clk_i),
        .control_d_o(qnice_gp_reg_o),
        .control_m_o(qnice_osm_control_m_o),
        .csr_joy1_o(qnice_csr_joy1_on_o),
        .csr_joy2_o(qnice_csr_joy2_on_o),
        .csr_keyboard_o(qnice_csr_keyboard_on_o),
        .csr_osm_o(qnice_osm_cfg_enable_o),
        .csr_pause_o(qnice_csr_pause_o),
        .csr_reset_o(qnice_csr_reset_o),
        .general_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .keys_n_i(qnice_qnice_keys_n_i),
        .osm_dxdy_o(qnice_osm_cfg_dxdy_o),
        .osm_xy_o(qnice_osm_cfg_xy_o),
        .ramrom_addr_o(qnice_ramrom_addr_o),
        .ramrom_ce_o(qnice_ramrom_ce_o),
        .ramrom_data_i(qnice_ramrom_data_in_i),
        .ramrom_data_o(qnice_ramrom_data_out_o),
        .ramrom_dev_o(qnice_ramrom_dev_o),
        .ramrom_wait_i(1'b0),
        .ramrom_we_o(qnice_ramrom_we_o),
        .reset_n_i(rst_i),
        .sd2_cd_i(sd2_cd_i),
        .sd2_clk_o(sd2_clk_o),
        .sd2_miso_i(sd2_miso_i),
        .sd2_mosi_o(sd2_mosi_o),
        .sd2_reset_o(sd2_reset_o),
        .sd_cd_i(sd_cd_i),
        .sd_clk_o(sd_clk_o),
        .sd_miso_i(sd_miso_i),
        .sd_mosi_o(sd_mosi_o),
        .sd_reset_o(sd_reset_o),
        .special_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .uart_rxd_i(uart_rxd_i),
        .uart_txd_o(uart_txd_o));
  Mega65_R6_config_0_0 config_0
       (.address_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clk_i(clk_i));
  Mega65_R6_mouse_input_0_0 mouse_input_0
       (.amiga_mouse_assume_a(1'b0),
        .amiga_mouse_assume_b(1'b0),
        .amiga_mouse_enable_a(1'b0),
        .amiga_mouse_enable_b(1'b0),
        .clk(clk_i),
        .fa_down(1'b0),
        .fa_fire(1'b0),
        .fa_left(1'b0),
        .fa_potx(paddle_i[0]),
        .fa_poty(paddle_i[0]),
        .fa_right(1'b0),
        .fa_up(1'b0),
        .fb_down(1'b0),
        .fb_fire(1'b0),
        .fb_left(1'b0),
        .fb_potx(paddle_i[0]),
        .fb_poty(paddle_i[0]),
        .fb_right(1'b0),
        .fb_up(1'b0),
        .pot_drain(paddle_drain_o));
  Mega65_R6_qnice2hyperram_0_0 qnice2hyperram_0
       (.clk_i(clk_i),
        .m_avm_address_o(qnice_avm_address_o),
        .m_avm_burstcount_o(qnice_avm_burstcount_o),
        .m_avm_byteenable_o(qnice_avm_byteenable_o),
        .m_avm_read_o(qnice_avm_read_o),
        .m_avm_readdata_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,qnice_avm_readdata_i}),
        .m_avm_readdatavalid_i(qnice_avm_readdatavalid_i),
        .m_avm_waitrequest_i(qnice_avm_waitrequest_i),
        .m_avm_write_o(qnice_avm_write_o),
        .m_avm_writedata_o(qnice_avm_writedata_o),
        .rst_i(rst_i),
        .s_qnice_address_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_qnice_byteenable_i({1'b0,1'b0}),
        .s_qnice_cs_i(1'b0),
        .s_qnice_write_i(1'b0),
        .s_qnice_writedata_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

module MEGA65_Core_imp_1YXRWYV
   (cart_a_i,
    cart_a_o,
    cart_addr_oe_o,
    cart_ba_i,
    cart_ba_o,
    cart_ctrl_oe_o,
    cart_d_i,
    cart_d_o,
    cart_data_oe_o,
    cart_dma_i,
    cart_dotclock_o,
    cart_en_o,
    cart_exrom_i,
    cart_exrom_o,
    cart_exrom_oe_o,
    cart_game_i,
    cart_game_o,
    cart_game_oe_o,
    cart_io1_i,
    cart_io1_o,
    cart_io2_i,
    cart_io2_o,
    cart_irq_i,
    cart_irq_o,
    cart_irq_oe_o,
    cart_nmi_i,
    cart_nmi_o,
    cart_nmi_oe_o,
    cart_phi2_o,
    cart_reset_i,
    cart_reset_o,
    cart_reset_oe_o,
    cart_romh_i,
    cart_romh_o,
    cart_romh_oe_o,
    cart_roml_i,
    cart_roml_o,
    cart_roml_oe_o,
    cart_rw_i,
    cart_rw_o,
    clk_i,
    hr_clk_i,
    hr_core_address_o,
    hr_core_burstcount_o,
    hr_core_byteenable_o,
    hr_core_read_o,
    hr_core_readdata_i,
    hr_core_readdatavalid_i,
    hr_core_waitrequest_i,
    hr_core_write_o,
    hr_core_writedata_o,
    hr_high_i,
    hr_low_i,
    hr_rst_i,
    iec_atn_n_o,
    iec_clk_en_o,
    iec_clk_n_i,
    iec_clk_n_o,
    iec_data_en_o,
    iec_data_n_i,
    iec_data_n_o,
    iec_reset_n_o,
    iec_srq_en_o,
    iec_srq_n_i,
    iec_srq_n_o,
    main_audio_left_o,
    main_audio_right_o,
    main_clk_o,
    main_drive_led_col_o,
    main_drive_led_o,
    main_joy_1_down_n_i,
    main_joy_1_down_n_o,
    main_joy_1_fire_n_i,
    main_joy_1_fire_n_o,
    main_joy_1_left_n_i,
    main_joy_1_left_n_o,
    main_joy_1_right_n_i,
    main_joy_1_right_n_o,
    main_joy_1_up_n_i,
    main_joy_1_up_n_o,
    main_joy_2_down_n_i,
    main_joy_2_down_n_o,
    main_joy_2_fire_n_i,
    main_joy_2_fire_n_o,
    main_joy_2_left_n_i,
    main_joy_2_left_n_o,
    main_joy_2_right_n_i,
    main_joy_2_right_n_o,
    main_joy_2_up_n_i,
    main_joy_2_up_n_o,
    main_kb_key_num_i,
    main_kb_key_pressed_n_i,
    main_osm_control_i,
    main_pause_core_i,
    main_pot1_x_i,
    main_pot1_y_i,
    main_pot2_x_i,
    main_pot2_y_i,
    main_power_led_col_o,
    main_power_led_o,
    main_qnice_gp_reg_i,
    main_reset_core_i,
    main_reset_m2m_i,
    main_rst_o,
    main_rtc_i,
    qnice_ascal_mode_o,
    qnice_ascal_polyphase_o,
    qnice_ascal_triplebuf_o,
    qnice_audio_filter_o,
    qnice_audio_mute_o,
    qnice_clk_i,
    qnice_csync_o,
    qnice_dev_addr_i,
    qnice_dev_ce_i,
    qnice_dev_data_i,
    qnice_dev_data_o,
    qnice_dev_id_i,
    qnice_dev_wait_o,
    qnice_dev_we_i,
    qnice_dvi_o,
    qnice_flip_joyports_o,
    qnice_gp_reg_i,
    qnice_osm_cfg_scaling_o,
    qnice_osm_control_i,
    qnice_retro15kHz_o,
    qnice_rst_i,
    qnice_scandoubler_o,
    qnice_video_mode_o,
    qnice_zoom_crop_o,
    video_blue_o,
    video_ce_o,
    video_ce_ovl_o,
    video_clk_o,
    video_green_o,
    video_hblank_o,
    video_hs_o,
    video_red_o,
    video_rst_o,
    video_vblank_o,
    video_vs_o);
  input [15:0]cart_a_i;
  output [15:0]cart_a_o;
  output cart_addr_oe_o;
  input cart_ba_i;
  output cart_ba_o;
  output cart_ctrl_oe_o;
  input [7:0]cart_d_i;
  output [7:0]cart_d_o;
  output cart_data_oe_o;
  input cart_dma_i;
  output cart_dotclock_o;
  output cart_en_o;
  input cart_exrom_i;
  output cart_exrom_o;
  output cart_exrom_oe_o;
  input cart_game_i;
  output cart_game_o;
  output cart_game_oe_o;
  input cart_io1_i;
  output cart_io1_o;
  input cart_io2_i;
  output cart_io2_o;
  input cart_irq_i;
  output cart_irq_o;
  output cart_irq_oe_o;
  input cart_nmi_i;
  output cart_nmi_o;
  output cart_nmi_oe_o;
  output cart_phi2_o;
  input cart_reset_i;
  output cart_reset_o;
  output cart_reset_oe_o;
  input cart_romh_i;
  output cart_romh_o;
  output cart_romh_oe_o;
  input cart_roml_i;
  output cart_roml_o;
  output cart_roml_oe_o;
  input cart_rw_i;
  output cart_rw_o;
  input clk_i;
  input hr_clk_i;
  output [31:0]hr_core_address_o;
  output [7:0]hr_core_burstcount_o;
  output [1:0]hr_core_byteenable_o;
  output hr_core_read_o;
  input [15:0]hr_core_readdata_i;
  input hr_core_readdatavalid_i;
  input hr_core_waitrequest_i;
  output hr_core_write_o;
  output [15:0]hr_core_writedata_o;
  input hr_high_i;
  input hr_low_i;
  input hr_rst_i;
  output iec_atn_n_o;
  output iec_clk_en_o;
  input iec_clk_n_i;
  output iec_clk_n_o;
  output iec_data_en_o;
  input iec_data_n_i;
  output iec_data_n_o;
  output iec_reset_n_o;
  output iec_srq_en_o;
  input iec_srq_n_i;
  output iec_srq_n_o;
  output [15:0]main_audio_left_o;
  output [15:0]main_audio_right_o;
  output main_clk_o;
  output [23:0]main_drive_led_col_o;
  output main_drive_led_o;
  input main_joy_1_down_n_i;
  output main_joy_1_down_n_o;
  input main_joy_1_fire_n_i;
  output main_joy_1_fire_n_o;
  input main_joy_1_left_n_i;
  output main_joy_1_left_n_o;
  input main_joy_1_right_n_i;
  output main_joy_1_right_n_o;
  input main_joy_1_up_n_i;
  output main_joy_1_up_n_o;
  input main_joy_2_down_n_i;
  output main_joy_2_down_n_o;
  input main_joy_2_fire_n_i;
  output main_joy_2_fire_n_o;
  input main_joy_2_left_n_i;
  output main_joy_2_left_n_o;
  input main_joy_2_right_n_i;
  output main_joy_2_right_n_o;
  input main_joy_2_up_n_i;
  output main_joy_2_up_n_o;
  input main_kb_key_num_i;
  input main_kb_key_pressed_n_i;
  input [255:0]main_osm_control_i;
  input main_pause_core_i;
  input [7:0]main_pot1_x_i;
  input [7:0]main_pot1_y_i;
  input [7:0]main_pot2_x_i;
  input [7:0]main_pot2_y_i;
  output [23:0]main_power_led_col_o;
  output main_power_led_o;
  input [255:0]main_qnice_gp_reg_i;
  input main_reset_core_i;
  input main_reset_m2m_i;
  output main_rst_o;
  input [64:0]main_rtc_i;
  output [1:0]qnice_ascal_mode_o;
  output qnice_ascal_polyphase_o;
  output qnice_ascal_triplebuf_o;
  output qnice_audio_filter_o;
  output qnice_audio_mute_o;
  input qnice_clk_i;
  output qnice_csync_o;
  input [27:0]qnice_dev_addr_i;
  input qnice_dev_ce_i;
  input [15:0]qnice_dev_data_i;
  output [15:0]qnice_dev_data_o;
  input [15:0]qnice_dev_id_i;
  output qnice_dev_wait_o;
  input qnice_dev_we_i;
  output qnice_dvi_o;
  output qnice_flip_joyports_o;
  input [255:0]qnice_gp_reg_i;
  output [8:0]qnice_osm_cfg_scaling_o;
  input [255:0]qnice_osm_control_i;
  output qnice_retro15kHz_o;
  input qnice_rst_i;
  output qnice_scandoubler_o;
  output qnice_video_mode_o;
  output qnice_zoom_crop_o;
  output [7:0]video_blue_o;
  output video_ce_o;
  output video_ce_ovl_o;
  output video_clk_o;
  output [7:0]video_green_o;
  output video_hblank_o;
  output video_hs_o;
  output [7:0]video_red_o;
  output video_rst_o;
  output video_vblank_o;
  output video_vs_o;

  wire clk_0_main_clk_o;
  wire clk_0_main_rst_o;
  wire clk_i;
  wire [15:0]main_audio_left_o;
  wire [15:0]main_audio_right_o;
  wire main_joy_1_down_n_i;
  wire main_joy_1_fire_n_i;
  wire main_joy_1_left_n_i;
  wire main_joy_1_right_n_i;
  wire main_joy_1_up_n_i;
  wire main_joy_2_down_n_i;
  wire main_joy_2_fire_n_i;
  wire main_joy_2_left_n_i;
  wire main_joy_2_right_n_i;
  wire main_joy_2_up_n_i;
  wire main_kb_key_num_i;
  wire main_kb_key_pressed_n_i;
  wire main_pause_core_i;
  wire [7:0]main_pot1_x_i;
  wire [7:0]main_pot1_y_i;
  wire [7:0]main_pot2_x_i;
  wire [7:0]main_pot2_y_i;
  wire main_reset_m2m_i;
  wire [7:0]video_blue_o;
  wire video_ce_o;
  wire video_ce_ovl_o;
  wire [7:0]video_green_o;
  wire video_hblank_o;
  wire video_hs_o;
  wire [7:0]video_red_o;
  wire video_vblank_o;
  wire video_vs_o;

  CORE_Main_imp_HPA42T CORE_Main
       (.audio_left_o(main_audio_left_o),
        .audio_right_o(main_audio_right_o),
        .clk_main_i(clk_0_main_clk_o),
        .clk_main_speed_i(1'b0),
        .joy_1_down_n_i(main_joy_1_down_n_i),
        .joy_1_fire_n_i(main_joy_1_fire_n_i),
        .joy_1_left_n_i(main_joy_1_left_n_i),
        .joy_1_right_n_i(main_joy_1_right_n_i),
        .joy_1_up_n_i(main_joy_1_up_n_i),
        .joy_2_down_n_i(main_joy_2_down_n_i),
        .joy_2_fire_n_i(main_joy_2_fire_n_i),
        .joy_2_left_n_i(main_joy_2_left_n_i),
        .joy_2_right_n_i(main_joy_2_right_n_i),
        .joy_2_up_n_i(main_joy_2_up_n_i),
        .kb_key_num_i(main_kb_key_num_i),
        .kb_key_pressed_n_i(main_kb_key_pressed_n_i),
        .pause_i(main_pause_core_i),
        .pot1_x_i(main_pot1_x_i),
        .pot1_y_i(main_pot1_y_i),
        .pot2_x_i(main_pot2_x_i),
        .pot2_y_i(main_pot2_y_i),
        .reset_hard_i(clk_0_main_rst_o),
        .reset_soft_i(main_reset_m2m_i),
        .video_blue_o(video_blue_o),
        .video_ce_o(video_ce_o),
        .video_ce_ovl_o(video_ce_ovl_o),
        .video_green_o(video_green_o),
        .video_hblank_o(video_hblank_o),
        .video_hs_o(video_hs_o),
        .video_red_o(video_red_o),
        .video_vblank_o(video_vblank_o),
        .video_vs_o(video_vs_o));
  Mega65_R6_clk_0_0 clk_0
       (.main_clk_o(clk_0_main_clk_o),
        .main_rst_o(clk_0_main_rst_o),
        .sys_clk_i(clk_i));
endmodule

/* clk_28 input of 28MHz
Mega65_R6
NB: Ports starting with a 'x' actually start with an underscore
in the orig verilog code.  Cannot name ports starting with an underscore in 
VHDL or the block design.
Only added the 'x' to the name for documentation purposes.
The Source code has a description of the port names. */
(* CORE_GENERATION_INFO = "Mega65_R6,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Mega65_R6,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=69,numReposBlks=44,numNonXlnxBlks=0,numHierBlks=25,maxHierDepth=5,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=44,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "Mega65_R6.hwdef" *) 
module Mega65_R6
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.AUDIO_BICK_O DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.AUDIO_BICK_O, LAYERED_METADATA undef" *) output audio_bick_o;
  output audio_i2cfil_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AUDIO_LRCLK_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AUDIO_LRCLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output audio_lrclk_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AUDIO_MCLK_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AUDIO_MCLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output audio_mclk_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.AUDIO_PDN_N_O RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.AUDIO_PDN_N_O, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) output audio_pdn_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.AUDIO_SCL_IO DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.AUDIO_SCL_IO, LAYERED_METADATA undef" *) inout audio_scl_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.AUDIO_SDA_IO DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.AUDIO_SDA_IO, LAYERED_METADATA undef" *) inout audio_sda_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.AUDIO_SDTI_O DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.AUDIO_SDTI_O, LAYERED_METADATA undef" *) output audio_sdti_o;
  inout [15:0]cart_a_io;
  output cart_addr_en_o;
  inout cart_ba_io;
  output cart_ctrl_dir_o;
  output cart_ctrl_en_o;
  inout [7:0]cart_d_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.CART_DATA_DIR_O DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.CART_DATA_DIR_O, LAYERED_METADATA undef" *) output cart_data_dir_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.CART_DATA_EN_O DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.CART_DATA_EN_O, LAYERED_METADATA undef" *) output cart_data_en_o;
  input cart_dma_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CART_DOTCLOCK_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CART_DOTCLOCK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output cart_dotclock_o;
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.CART_RESET_IO RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.CART_RESET_IO, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) inout cart_reset_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.CART_RESET_OE_N_O RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.CART_RESET_OE_N_O, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) output cart_reset_oe_n_o;
  inout cart_romh_io;
  output cart_romh_oe_n_o;
  inout cart_roml_io;
  output cart_roml_oe_n_o;
  inout cart_rw_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_I CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_I, CLK_DOMAIN Mega65_R6_clk_i, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk_i;
  inout dbg_io_11;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ETH_CLOCK_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ETH_CLOCK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output eth_clock_o;
  output eth_led2_o;
  output eth_mdc_o;
  inout eth_mdio_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ETH_RESET_O RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ETH_RESET_O, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) output eth_reset_o;
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.F_RDATA_I DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.F_RDATA_I, LAYERED_METADATA undef" *) input f_rdata_i;
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.HR_CLK_P_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.HR_CLK_P_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output hr_clk_p_o;
  output hr_cs0_o;
  inout [7:0]hr_d_io;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.HR_RESET_O RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.HR_RESET_O, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) output hr_reset_o;
  inout hr_rwds_io;
  inout i2c_scl_io;
  inout i2c_sda_io;
  output iec_atn_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.IEC_CLK_EN_N_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.IEC_CLK_EN_N_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output iec_clk_en_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 CE.IEC_CLK_N_I CE" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CE.IEC_CLK_N_I, POLARITY ACTIVE_LOW" *) input iec_clk_n_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.IEC_CLK_N_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.IEC_CLK_N_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output iec_clk_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.IEC_DATA_EN_N_O DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.IEC_DATA_EN_N_O, LAYERED_METADATA undef" *) output iec_data_en_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.IEC_DATA_N_I DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.IEC_DATA_N_I, LAYERED_METADATA undef" *) input iec_data_n_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.IEC_DATA_N_O DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.IEC_DATA_N_O, LAYERED_METADATA undef" *) output iec_data_n_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.IEC_RESET_N_O RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.IEC_RESET_N_O, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) output iec_reset_n_o;
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_BUTTON_I RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_BUTTON_I, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset_button_i;
  input sd2_cd_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SD2_CLK_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SD2_CLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output sd2_clk_o;
  input sd2_d1_i;
  input sd2_d2_i;
  input sd2_miso_i;
  output sd2_mosi_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.SD2_RESET_O RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.SD2_RESET_O, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) output sd2_reset_o;
  input sd2_wp_i;
  input sd_cd_i;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SD_CLK_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SD_CLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output sd_clk_o;
  input sd_d1_i;
  input sd_d2_i;
  input sd_miso_i;
  output sd_mosi_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.SD_RESET_O RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.SD_RESET_O, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) output sd_reset_o;
  output [12:0]sdram_a_o;
  output [1:0]sdram_ba_o;
  output sdram_cas_n_o;
  output sdram_cke_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SDRAM_CLK_O CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SDRAM_CLK_O, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output sdram_clk_o;
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

  wire M2M_Framework_audio_clk_o;
  wire [15:0]M2M_Framework_audio_left_o;
  wire M2M_Framework_audio_reset_o;
  wire [15:0]M2M_Framework_audio_right_o;
  wire M2M_Framework_hr_clk_o;
  wire [15:0]M2M_Framework_hr_core_readdata_o;
  wire M2M_Framework_hr_core_readdatavalid_o;
  wire M2M_Framework_hr_core_waitrequest_o;
  wire M2M_Framework_hr_high_o;
  wire M2M_Framework_hr_low_o;
  wire M2M_Framework_hr_rst_o;
  wire M2M_Framework_main_joy1_down_n_o;
  wire M2M_Framework_main_joy1_fire_n_o;
  wire M2M_Framework_main_joy1_left_n_o;
  wire M2M_Framework_main_joy1_right_n_o;
  wire M2M_Framework_main_joy1_up_n_o;
  wire M2M_Framework_main_joy2_down_n_o;
  wire M2M_Framework_main_joy2_fire_n_o;
  wire M2M_Framework_main_joy2_left_n_o;
  wire M2M_Framework_main_joy2_right_n_o;
  wire M2M_Framework_main_joy2_up_n_o;
  wire M2M_Framework_main_key_num_o;
  wire M2M_Framework_main_key_pressed_n_o;
  wire [255:0]M2M_Framework_main_osm_control_m_o;
  wire [7:0]M2M_Framework_main_pot1_x_o;
  wire [7:0]M2M_Framework_main_pot1_y_o;
  wire [7:0]M2M_Framework_main_pot2_x_o;
  wire [7:0]M2M_Framework_main_pot2_y_o;
  wire [255:0]M2M_Framework_main_qnice_gp_reg_o;
  wire M2M_Framework_main_reset_core_o;
  wire M2M_Framework_main_reset_m2m_o;
  wire M2M_Framework_main_rtc_o;
  wire M2M_Framework_qnice_clk_o;
  wire [255:0]M2M_Framework_qnice_gp_reg_o;
  wire [255:0]M2M_Framework_qnice_osm_control_m_o;
  wire [27:0]M2M_Framework_qnice_ramrom_addr_o;
  wire M2M_Framework_qnice_ramrom_ce_o;
  wire [15:0]M2M_Framework_qnice_ramrom_data_out_o;
  wire [15:0]M2M_Framework_qnice_ramrom_dev_o;
  wire M2M_Framework_qnice_ramrom_we_o;
  wire M2M_Framework_qnice_rst_o;
  wire [15:0]MEGA65_Core_main_audio_left_o;
  wire [15:0]MEGA65_Core_main_audio_right_o;
  wire MEGA65_Core_main_clk_o;
  wire [23:0]MEGA65_Core_main_drive_led_col_o;
  wire MEGA65_Core_main_drive_led_o;
  wire MEGA65_Core_main_joy_1_down_n_o;
  wire MEGA65_Core_main_joy_1_fire_n_o;
  wire MEGA65_Core_main_joy_1_left_n_o;
  wire MEGA65_Core_main_joy_1_right_n_o;
  wire MEGA65_Core_main_joy_1_up_n_o;
  wire MEGA65_Core_main_joy_2_down_n_o;
  wire MEGA65_Core_main_joy_2_fire_n_o;
  wire MEGA65_Core_main_joy_2_left_n_o;
  wire MEGA65_Core_main_joy_2_right_n_o;
  wire MEGA65_Core_main_joy_2_up_n_o;
  wire [23:0]MEGA65_Core_main_power_led_col_o;
  wire MEGA65_Core_main_power_led_o;
  wire MEGA65_Core_main_rst_o;
  wire [1:0]MEGA65_Core_qnice_ascal_mode_o;
  wire MEGA65_Core_qnice_ascal_triplebuf_o;
  wire MEGA65_Core_qnice_audio_filter_o;
  wire MEGA65_Core_qnice_csync_o;
  wire MEGA65_Core_qnice_dev_wait_o;
  wire [8:0]MEGA65_Core_qnice_osm_cfg_scaling_o;
  wire MEGA65_Core_qnice_video_mode_o;
  wire [7:0]MEGA65_Core_video_blue_o;
  wire MEGA65_Core_video_ce_o;
  wire MEGA65_Core_video_ce_ovl_o;
  wire MEGA65_Core_video_clk_o;
  wire [7:0]MEGA65_Core_video_green_o;
  wire MEGA65_Core_video_hblank_o;
  wire MEGA65_Core_video_hs_o;
  wire [7:0]MEGA65_Core_video_red_o;
  wire MEGA65_Core_video_rst_o;
  wire MEGA65_Core_video_vblank_o;
  wire MEGA65_Core_video_vs_o;
  wire audio_bick_o;
  wire audio_lrclk_o;
  wire audio_mclk_o;
  wire audio_pdn_n_o;
  wire audio_scl_io;
  wire audio_sda_io;
  wire audio_sdti_o;
  wire cart_addr_en_o;
  wire cart_dma_i;
  wire cart_dotclock_o;
  wire cart_en_o;
  wire cart_game_oe_n_o;
  wire cart_irq_oe_n_o;
  wire cart_nmi_oe_n_o;
  wire cart_phi2_o;
  wire cart_reset_oe_n_o;
  wire cart_romh_oe_n_o;
  wire cart_roml_oe_n_o;
  wire clk_i;
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
  wire hdmi_scl_io;
  wire hdmi_sda_io;
  wire hr_clk_p_o;
  wire [31:0]hr_core_address_i_1;
  wire [7:0]hr_core_burstcount_i_1;
  wire [1:0]hr_core_byteenable_i_1;
  wire hr_core_read_i_1;
  wire hr_core_write_i_1;
  wire [15:0]hr_core_writedata_i_1;
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
  wire kb_io0_o;
  wire kb_io1_o;
  wire kb_io2_i;
  wire main_pause_core_i_1;
  wire paddle_drain_o;
  wire [3:0]paddle_i;
  wire qnice_ascal_polyphase_i_1;
  wire qnice_audio_mute_i_1;
  wire qnice_dvi_i_1;
  wire qnice_flip_joyports_i_1;
  wire [15:0]qnice_ramrom_data_in_i_1;
  wire qnice_retro15kHz_i_1;
  wire qnice_scandoubler_i_1;
  wire qnice_zoom_crop_i_1;
  wire reset_button_i;
  wire sd2_cd_i;
  wire sd2_clk_o;
  wire sd2_miso_i;
  wire sd2_mosi_o;
  wire sd2_reset_o;
  wire sd_cd_i;
  wire sd_clk_o;
  wire sd_miso_i;
  wire sd_mosi_o;
  wire sd_reset_o;
  wire tmds_clk_n_o;
  wire tmds_clk_p_o;
  wire [2:0]tmds_data_n_o;
  wire [2:0]tmds_data_p_o;
  wire uart_rxd_i;
  wire uart_txd_o;
  wire vdac_blank_n_o;
  wire vdac_clk_o;
  wire vdac_sync_n_o;
  wire [7:0]vga_blue_o;
  wire [7:0]vga_green_o;
  wire vga_hs_o;
  wire [7:0]vga_red_o;
  wire vga_scl_io;
  wire vga_sda_io;
  wire vga_vs_o;

  M2M_Framework_imp_PNB7X9 M2M_Framework
       (.audio_clk_o(M2M_Framework_audio_clk_o),
        .audio_left_o(M2M_Framework_audio_left_o),
        .audio_reset_o(M2M_Framework_audio_reset_o),
        .audio_right_o(M2M_Framework_audio_right_o),
        .audio_scl_io(audio_scl_io),
        .audio_sda_io(audio_sda_io),
        .clk_i(clk_i),
        .fpga_scl_io(grove_scl_io),
        .fpga_sda_io(grove_sda_io),
        .grove_scl_io(fpga_scl_io),
        .grove_sda_io(fpga_sda_io),
        .hdmi_scl_io(hdmi_scl_io),
        .hdmi_sda_io(hdmi_sda_io),
        .hr_clk_o(M2M_Framework_hr_clk_o),
        .hr_clk_p_o(hr_clk_p_o),
        .hr_core_address_i(hr_core_address_i_1),
        .hr_core_burstcount_i(hr_core_burstcount_i_1),
        .hr_core_byteenable_i(hr_core_byteenable_i_1),
        .hr_core_read_i(hr_core_read_i_1),
        .hr_core_readdata_o(M2M_Framework_hr_core_readdata_o),
        .hr_core_readdatavalid_o(M2M_Framework_hr_core_readdatavalid_o),
        .hr_core_waitrequest_o(M2M_Framework_hr_core_waitrequest_o),
        .hr_core_write_i(hr_core_write_i_1),
        .hr_core_writedata_i(hr_core_writedata_i_1),
        .hr_cs0_o(hr_cs0_o),
        .hr_d_io(hr_d_io),
        .hr_high_o(M2M_Framework_hr_high_o),
        .hr_low_o(M2M_Framework_hr_low_o),
        .hr_reset_o(hr_reset_o),
        .hr_rst_o(M2M_Framework_hr_rst_o),
        .hr_rwds_io(hr_rwds_io),
        .i2c_scl_io(i2c_scl_io),
        .i2c_sda_io(i2c_sda_io),
        .joy_1_down_n_i(fa_down_n_i),
        .joy_1_down_n_o(fa_down_n_o),
        .joy_1_fire_n_i(fa_fire_n_i),
        .joy_1_fire_n_o(fa_fire_n_o),
        .joy_1_left_n_i(fa_left_n_i),
        .joy_1_left_n_o(fa_left_n_o),
        .joy_1_right_n_i(fa_right_n_i),
        .joy_1_right_n_o(fa_right_n_o),
        .joy_1_up_n_i(fa_up_n_i),
        .joy_1_up_n_o(fa_up_n_o),
        .joy_2_down_n_i(fb_down_n_i),
        .joy_2_down_n_o(fb_down_n_o),
        .joy_2_fire_n_i(fb_fire_n_i),
        .joy_2_fire_n_o(fb_fire_n_o),
        .joy_2_left_n_i(fb_left_n_i),
        .joy_2_left_n_o(fb_left_n_o),
        .joy_2_right_n_i(fb_right_n_i),
        .joy_2_right_n_o(fb_right_n_o),
        .joy_2_up_n_i(fb_up_n_i),
        .joy_2_up_n_o(fb_up_n_o),
        .kb_io0_o(kb_io0_o),
        .kb_io1_o(kb_io1_o),
        .kb_io2_i(kb_io2_i),
        .main_audio_l_i(MEGA65_Core_main_audio_left_o),
        .main_audio_r_i(MEGA65_Core_main_audio_right_o),
        .main_clk_i(MEGA65_Core_main_clk_o),
        .main_drive_led_col_i(MEGA65_Core_main_drive_led_col_o),
        .main_drive_led_i(MEGA65_Core_main_drive_led_o),
        .main_joy1_down_n_i(MEGA65_Core_main_joy_1_down_n_o),
        .main_joy1_down_n_o(M2M_Framework_main_joy1_down_n_o),
        .main_joy1_fire_n_i(MEGA65_Core_main_joy_1_fire_n_o),
        .main_joy1_fire_n_o(M2M_Framework_main_joy1_fire_n_o),
        .main_joy1_left_n_i(MEGA65_Core_main_joy_1_left_n_o),
        .main_joy1_left_n_o(M2M_Framework_main_joy1_left_n_o),
        .main_joy1_right_n_i(MEGA65_Core_main_joy_1_right_n_o),
        .main_joy1_right_n_o(M2M_Framework_main_joy1_right_n_o),
        .main_joy1_up_n_i(MEGA65_Core_main_joy_1_up_n_o),
        .main_joy1_up_n_o(M2M_Framework_main_joy1_up_n_o),
        .main_joy2_down_n_i(MEGA65_Core_main_joy_2_down_n_o),
        .main_joy2_down_n_o(M2M_Framework_main_joy2_down_n_o),
        .main_joy2_fire_n_i(MEGA65_Core_main_joy_2_fire_n_o),
        .main_joy2_fire_n_o(M2M_Framework_main_joy2_fire_n_o),
        .main_joy2_left_n_i(MEGA65_Core_main_joy_2_left_n_o),
        .main_joy2_left_n_o(M2M_Framework_main_joy2_left_n_o),
        .main_joy2_right_n_i(MEGA65_Core_main_joy_2_right_n_o),
        .main_joy2_right_n_o(M2M_Framework_main_joy2_right_n_o),
        .main_joy2_up_n_i(MEGA65_Core_main_joy_2_up_n_o),
        .main_joy2_up_n_o(M2M_Framework_main_joy2_up_n_o),
        .main_key_num_o(M2M_Framework_main_key_num_o),
        .main_key_pressed_n_o(M2M_Framework_main_key_pressed_n_o),
        .main_osm_control_m_o(M2M_Framework_main_osm_control_m_o),
        .main_pot1_x_o(M2M_Framework_main_pot1_x_o),
        .main_pot1_y_o(M2M_Framework_main_pot1_y_o),
        .main_pot2_x_o(M2M_Framework_main_pot2_x_o),
        .main_pot2_y_o(M2M_Framework_main_pot2_y_o),
        .main_power_led_col_i(MEGA65_Core_main_power_led_col_o),
        .main_power_led_i(MEGA65_Core_main_power_led_o),
        .main_qnice_gp_reg_o(M2M_Framework_main_qnice_gp_reg_o),
        .main_qnice_pause_o(main_pause_core_i_1),
        .main_reset_core_o(M2M_Framework_main_reset_core_o),
        .main_reset_m2m_o(M2M_Framework_main_reset_m2m_o),
        .main_rst_i(MEGA65_Core_main_rst_o),
        .main_rtc_o(M2M_Framework_main_rtc_o),
        .paddle_drain_o(paddle_drain_o),
        .paddle_i(paddle_i),
        .qnice_ascal_mode_i(MEGA65_Core_qnice_ascal_mode_o[0]),
        .qnice_ascal_polyphase_i(qnice_ascal_polyphase_i_1),
        .qnice_ascal_triplebuf_i(MEGA65_Core_qnice_ascal_triplebuf_o),
        .qnice_audio_filter_i(MEGA65_Core_qnice_audio_filter_o),
        .qnice_audio_mute_i(qnice_audio_mute_i_1),
        .qnice_clk_o(M2M_Framework_qnice_clk_o),
        .qnice_csync_i(MEGA65_Core_qnice_csync_o),
        .qnice_dvi_i(qnice_dvi_i_1),
        .qnice_flip_joyports_i(qnice_flip_joyports_i_1),
        .qnice_gp_reg_o(M2M_Framework_qnice_gp_reg_o),
        .qnice_osm_cfg_scaling_i(MEGA65_Core_qnice_osm_cfg_scaling_o),
        .qnice_osm_control_m_o(M2M_Framework_qnice_osm_control_m_o),
        .qnice_ramrom_addr_o(M2M_Framework_qnice_ramrom_addr_o),
        .qnice_ramrom_ce_o(M2M_Framework_qnice_ramrom_ce_o),
        .qnice_ramrom_data_in_i(qnice_ramrom_data_in_i_1),
        .qnice_ramrom_data_out_o(M2M_Framework_qnice_ramrom_data_out_o),
        .qnice_ramrom_dev_o(M2M_Framework_qnice_ramrom_dev_o),
        .qnice_ramrom_wait_i(MEGA65_Core_qnice_dev_wait_o),
        .qnice_ramrom_we_o(M2M_Framework_qnice_ramrom_we_o),
        .qnice_retro15kHz_i(qnice_retro15kHz_i_1),
        .qnice_rst_o(M2M_Framework_qnice_rst_o),
        .qnice_scandoubler_i(qnice_scandoubler_i_1),
        .qnice_video_mode_i(MEGA65_Core_qnice_video_mode_o),
        .qnice_zoom_crop_i(qnice_zoom_crop_i_1),
        .reset_n_i(reset_button_i),
        .sd2_cd_i(sd2_cd_i),
        .sd2_clk_o(sd2_clk_o),
        .sd2_miso_i(sd2_miso_i),
        .sd2_mosi_o(sd2_mosi_o),
        .sd2_reset_o(sd2_reset_o),
        .sd_cd_i(sd_cd_i),
        .sd_clk_o(sd_clk_o),
        .sd_miso_i(sd_miso_i),
        .sd_mosi_o(sd_mosi_o),
        .sd_reset_o(sd_reset_o),
        .tmds_clk_n_o(tmds_clk_n_o),
        .tmds_clk_p_o(tmds_clk_p_o),
        .tmds_data_n_o(tmds_data_n_o),
        .tmds_data_p_o(tmds_data_p_o),
        .uart_rxd_i(uart_rxd_i),
        .uart_txd_o(uart_txd_o),
        .vdac_blank_n_o(vdac_blank_n_o),
        .vdac_clk_o(vdac_clk_o),
        .vdac_sync_n_o(vdac_sync_n_o),
        .vga_blue_o(vga_blue_o),
        .vga_green_o(vga_green_o),
        .vga_hs_o(vga_hs_o),
        .vga_red_o(vga_red_o),
        .vga_scl_io(vga_scl_io),
        .vga_sda_io(vga_sda_io),
        .vga_vs_o(vga_vs_o),
        .video_blue_i(MEGA65_Core_video_blue_o),
        .video_ce_i(MEGA65_Core_video_ce_o),
        .video_ce_ovl_i(MEGA65_Core_video_ce_ovl_o),
        .video_clk_i(MEGA65_Core_video_clk_o),
        .video_green_i(MEGA65_Core_video_green_o),
        .video_hblank_i(MEGA65_Core_video_hblank_o),
        .video_hs_i(MEGA65_Core_video_hs_o),
        .video_red_i(MEGA65_Core_video_red_o),
        .video_rst_i(MEGA65_Core_video_rst_o),
        .video_vblank_i(MEGA65_Core_video_vblank_o),
        .video_vs_i(MEGA65_Core_video_vs_o));
  MEGA65_Core_imp_1YXRWYV MEGA65_Core
       (.cart_a_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .cart_ba_i(1'b0),
        .cart_ctrl_oe_o(cart_addr_en_o),
        .cart_d_i({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .cart_dma_i(cart_dma_i),
        .cart_dotclock_o(cart_dotclock_o),
        .cart_en_o(cart_en_o),
        .cart_exrom_i(1'b0),
        .cart_game_i(1'b0),
        .cart_game_oe_o(cart_game_oe_n_o),
        .cart_io1_i(1'b0),
        .cart_io2_i(1'b0),
        .cart_irq_i(1'b0),
        .cart_irq_oe_o(cart_irq_oe_n_o),
        .cart_nmi_i(1'b0),
        .cart_nmi_oe_o(cart_nmi_oe_n_o),
        .cart_phi2_o(cart_phi2_o),
        .cart_reset_i(1'b0),
        .cart_reset_oe_o(cart_reset_oe_n_o),
        .cart_romh_i(1'b0),
        .cart_romh_oe_o(cart_romh_oe_n_o),
        .cart_roml_i(1'b0),
        .cart_roml_oe_o(cart_roml_oe_n_o),
        .cart_rw_i(1'b0),
        .clk_i(clk_i),
        .hr_clk_i(M2M_Framework_hr_clk_o),
        .hr_core_address_o(hr_core_address_i_1),
        .hr_core_burstcount_o(hr_core_burstcount_i_1),
        .hr_core_byteenable_o(hr_core_byteenable_i_1),
        .hr_core_read_o(hr_core_read_i_1),
        .hr_core_readdata_i(M2M_Framework_hr_core_readdata_o),
        .hr_core_readdatavalid_i(M2M_Framework_hr_core_readdatavalid_o),
        .hr_core_waitrequest_i(M2M_Framework_hr_core_waitrequest_o),
        .hr_core_write_o(hr_core_write_i_1),
        .hr_core_writedata_o(hr_core_writedata_i_1),
        .hr_high_i(M2M_Framework_hr_high_o),
        .hr_low_i(M2M_Framework_hr_low_o),
        .hr_rst_i(M2M_Framework_hr_rst_o),
        .iec_atn_n_o(iec_atn_n_o),
        .iec_clk_en_o(iec_clk_en_n_o),
        .iec_clk_n_i(iec_clk_n_i),
        .iec_clk_n_o(iec_clk_n_o),
        .iec_data_en_o(iec_data_en_n_o),
        .iec_data_n_i(iec_data_n_i),
        .iec_data_n_o(iec_data_n_o),
        .iec_reset_n_o(iec_reset_n_o),
        .iec_srq_en_o(iec_srq_en_n_o),
        .iec_srq_n_i(iec_srq_n_i),
        .iec_srq_n_o(iec_srq_n_o),
        .main_audio_left_o(MEGA65_Core_main_audio_left_o),
        .main_audio_right_o(MEGA65_Core_main_audio_right_o),
        .main_clk_o(MEGA65_Core_main_clk_o),
        .main_drive_led_col_o(MEGA65_Core_main_drive_led_col_o),
        .main_drive_led_o(MEGA65_Core_main_drive_led_o),
        .main_joy_1_down_n_i(M2M_Framework_main_joy1_down_n_o),
        .main_joy_1_down_n_o(MEGA65_Core_main_joy_1_down_n_o),
        .main_joy_1_fire_n_i(M2M_Framework_main_joy1_fire_n_o),
        .main_joy_1_fire_n_o(MEGA65_Core_main_joy_1_fire_n_o),
        .main_joy_1_left_n_i(M2M_Framework_main_joy1_left_n_o),
        .main_joy_1_left_n_o(MEGA65_Core_main_joy_1_left_n_o),
        .main_joy_1_right_n_i(M2M_Framework_main_joy1_right_n_o),
        .main_joy_1_right_n_o(MEGA65_Core_main_joy_1_right_n_o),
        .main_joy_1_up_n_i(M2M_Framework_main_joy1_up_n_o),
        .main_joy_1_up_n_o(MEGA65_Core_main_joy_1_up_n_o),
        .main_joy_2_down_n_i(M2M_Framework_main_joy2_down_n_o),
        .main_joy_2_down_n_o(MEGA65_Core_main_joy_2_down_n_o),
        .main_joy_2_fire_n_i(M2M_Framework_main_joy2_fire_n_o),
        .main_joy_2_fire_n_o(MEGA65_Core_main_joy_2_fire_n_o),
        .main_joy_2_left_n_i(M2M_Framework_main_joy2_left_n_o),
        .main_joy_2_left_n_o(MEGA65_Core_main_joy_2_left_n_o),
        .main_joy_2_right_n_i(M2M_Framework_main_joy2_right_n_o),
        .main_joy_2_right_n_o(MEGA65_Core_main_joy_2_right_n_o),
        .main_joy_2_up_n_i(M2M_Framework_main_joy2_up_n_o),
        .main_joy_2_up_n_o(MEGA65_Core_main_joy_2_up_n_o),
        .main_kb_key_num_i(M2M_Framework_main_key_num_o),
        .main_kb_key_pressed_n_i(M2M_Framework_main_key_pressed_n_o),
        .main_osm_control_i(M2M_Framework_main_osm_control_m_o),
        .main_pause_core_i(main_pause_core_i_1),
        .main_pot1_x_i(M2M_Framework_main_pot1_x_o),
        .main_pot1_y_i(M2M_Framework_main_pot1_y_o),
        .main_pot2_x_i(M2M_Framework_main_pot2_x_o),
        .main_pot2_y_i(M2M_Framework_main_pot2_y_o),
        .main_power_led_col_o(MEGA65_Core_main_power_led_col_o),
        .main_power_led_o(MEGA65_Core_main_power_led_o),
        .main_qnice_gp_reg_i(M2M_Framework_main_qnice_gp_reg_o),
        .main_reset_core_i(M2M_Framework_main_reset_core_o),
        .main_reset_m2m_i(M2M_Framework_main_reset_m2m_o),
        .main_rst_o(MEGA65_Core_main_rst_o),
        .main_rtc_i({M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o,M2M_Framework_main_rtc_o}),
        .qnice_ascal_mode_o(MEGA65_Core_qnice_ascal_mode_o),
        .qnice_ascal_polyphase_o(qnice_ascal_polyphase_i_1),
        .qnice_ascal_triplebuf_o(MEGA65_Core_qnice_ascal_triplebuf_o),
        .qnice_audio_filter_o(MEGA65_Core_qnice_audio_filter_o),
        .qnice_audio_mute_o(qnice_audio_mute_i_1),
        .qnice_clk_i(M2M_Framework_qnice_clk_o),
        .qnice_csync_o(MEGA65_Core_qnice_csync_o),
        .qnice_dev_addr_i(M2M_Framework_qnice_ramrom_addr_o),
        .qnice_dev_ce_i(M2M_Framework_qnice_ramrom_ce_o),
        .qnice_dev_data_i(M2M_Framework_qnice_ramrom_data_out_o),
        .qnice_dev_data_o(qnice_ramrom_data_in_i_1),
        .qnice_dev_id_i(M2M_Framework_qnice_ramrom_dev_o),
        .qnice_dev_wait_o(MEGA65_Core_qnice_dev_wait_o),
        .qnice_dev_we_i(M2M_Framework_qnice_ramrom_we_o),
        .qnice_dvi_o(qnice_dvi_i_1),
        .qnice_flip_joyports_o(qnice_flip_joyports_i_1),
        .qnice_gp_reg_i(M2M_Framework_qnice_gp_reg_o),
        .qnice_osm_cfg_scaling_o(MEGA65_Core_qnice_osm_cfg_scaling_o),
        .qnice_osm_control_i(M2M_Framework_qnice_osm_control_m_o),
        .qnice_retro15kHz_o(qnice_retro15kHz_i_1),
        .qnice_rst_i(M2M_Framework_qnice_rst_o),
        .qnice_scandoubler_o(qnice_scandoubler_i_1),
        .qnice_video_mode_o(MEGA65_Core_qnice_video_mode_o),
        .qnice_zoom_crop_o(qnice_zoom_crop_i_1),
        .video_blue_o(MEGA65_Core_video_blue_o),
        .video_ce_o(MEGA65_Core_video_ce_o),
        .video_ce_ovl_o(MEGA65_Core_video_ce_ovl_o),
        .video_clk_o(MEGA65_Core_video_clk_o),
        .video_green_o(MEGA65_Core_video_green_o),
        .video_hblank_o(MEGA65_Core_video_hblank_o),
        .video_hs_o(MEGA65_Core_video_hs_o),
        .video_red_o(MEGA65_Core_video_red_o),
        .video_rst_o(MEGA65_Core_video_rst_o),
        .video_vblank_o(MEGA65_Core_video_vblank_o),
        .video_vs_o(MEGA65_Core_video_vs_o));
  Mega65_R6_audio_0_0 audio_0
       (.audio_bick_o(audio_bick_o),
        .audio_clk_i(M2M_Framework_audio_clk_o),
        .audio_left_i(M2M_Framework_audio_left_o),
        .audio_lrclk_o(audio_lrclk_o),
        .audio_mclk_o(audio_mclk_o),
        .audio_pdn_n_o(audio_pdn_n_o),
        .audio_reset_i(M2M_Framework_audio_reset_o),
        .audio_right_i(M2M_Framework_audio_right_o),
        .audio_sdti_o(audio_sdti_o));
endmodule
