// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Mar  1 17:16:19 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test
//               2/CORE/CORE-R6.gen/sources_1/ip/denise_colortable_ram_mf/denise_colortable_ram_mf_sim_netlist.v}
// Design      : denise_colortable_ram_mf
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "denise_colortable_ram_mf,blk_mem_gen_v8_4_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_10,Vivado 2024.2.1" *) 
(* NotValidForBitStream *)
module denise_colortable_ram_mf
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [4:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [4:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [4:0]addra;
  wire [4:0]addrb;
  wire clka;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_douta_UNCONNECTED;
  wire [4:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [4:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "5" *) 
  (* C_ADDRB_WIDTH = "5" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.68455 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "denise_colortable_ram_mf.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "32" *) 
  (* C_READ_DEPTH_B = "32" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "32" *) 
  (* C_WRITE_DEPTH_B = "32" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  denise_colortable_ram_mf_blk_mem_gen_v8_4_10 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[4:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[4:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
udNP8Uje7hpcvCYAXvDW9r2oHQyRipDN507b+1w27rP7xb4Nz9QLRyKQf6hKRcDEOVPPDU4KvXyQ
S7Bed2F6O4Ldaml88+U6QsrNFaZ4fNsTrKjEE3lLix8fjqIyUXKSNeepsabnRAwnPTjGP0ckeQ0z
/6vK6vS6Oh2J5EcQEag=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
AJCFEJ1YmO8l6c55nmqjPHpq03iIwIWhcq4gzpGTG9q8+B6G84WceO3Y0MOwVkIC+rza8yWW4W96
aueSQ6zP9DeJpaQAa5CXah55dY7AxCSywtOyZ62CZYm1RxvTaNigNnppCye+yAHN5Qei2IV4ZMwt
hFhXp7bbKeSQsqyTcPao+XMOfUQgs6uHRQoMvRFgoHByuZ20V72oOw3MoBmzaFgyRicvku2AVEWd
uJDCqcRlHIZZ1c+O+dCjOvRg+9aaQ1DE8gyCtne0FhQEvVnAPjcTzeUg2I0bZrpUQbbS8p5716Jl
/R7teOvv2VpnKxyFvW5lTVImrqIsvdk38CH5aw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
d1PZzLTrVgGa7lAGrEOnBHSkyRph92ENzEYYfBv5ShW44EZ/4/Dy5IpHq0athhXF90+7+EiPDjze
BIUrzaCZjSn3hPfQYuPqbUjXLseT1xBYmtHZtyzpQYUr38hRTWh6IjNX2anC6vrScheJp7oDyY1/
IpdhxPVK/6z5GGw/+fk=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
iXAE+ZmeGhifmLMp5oEFkhP/d/cDFVKwwxydC1lMN6LBRLFXElE5VcBvIEPtGNusskpxv/GPCPge
Az6W1/YbULAD2vlMA71EljrnHet4zg4sh561cjLPQN2DUNHr/8qxlo4ONww5HrNW+aj3zt0V9iXd
LMCR8NG58iQqMP1t5ybi/4urLnu1EF4AFJP8eDrIn+UhiFljJ04qUkg6UteUS1Qbzshw6awFUiey
WBeovfV6FXCJKwHugmJ9lX0v8OpeazDBCdnLiduAGRdSYyvX8gZsv3vJDGtRy/jgipU3YvWtjuVV
YtKThRWW0HDHoUbtraCor3GB7nSBYetgLBhI2w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
CCwrvinvzJ/ig55I5/d/Amnn8e78wAQQ3CZeQChsQV8lNb/2YZzJQqDeIZnIw2PW9XMMQWu1BZ8c
iNYcwzM1UFZoOaZeVnYUYwb2RIF29CtoBJrR/IdRvyNiLiX6yB25jHmLHr0ZI2+HcOU/DUGMCHdj
rXeeb/zWm2+BlGVXo8nZQsBLb7Ax2MZrkpa0MTARS71LcKF7w1t4GoY7bVE/6IqiapBrM+ZEG0G0
A/Ha5M7b0iGDPUjoi9W9dI+/QCxu2Jzm/2Lv/GivvO91GfWy+GtP+BOuITXoh1RMI1r+C0BVFEmZ
cJTPz6NO//KkkLFG9/hmPYFN1LfA2Ba990gqjw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UtpgxYdpPKuSNM+KxM6Sv3Iy4ZOFYPNHS2XNuKmMlCw2QC5U4+i3rdVze9p+UBDrx6Er9G9pm8c7
cuUkBFDSwAo1nmCsTUQkSQOtPXr5uH5HznaUeoa9jW2AL4fdOIyDGx9ybjy86RZqbLwFXSFl5h+u
N7pnU5jSiJzRe2r8HEgZz2gz/hfTN/jzQXetqGKueHxsQ3aoufearKsdAddLj5L+S7JaV0vI1A+I
C0NrqJNr80rSabETlIhyDi8M+O31ACijPvd5lxs/aM4t0hkDuJEjD/4zSMAR4kX6rFuoAaGj+gkL
JNO4LonSwyx9V/aLCUGZvakCGOoTfa8HsXALSg==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bYpkb72jOpiSeCQ5PRip31Y2zumke9hnzyF2MW+IVzPW0m3jVUMoEwgSxAqE+vlQuzZiaESSLPa4
hEofuBzsD/1HhUexhJNB4Y+/VPBvwWtiuiJJBrLU2aBqlxKZznTLdxMXRPgndyi9c3Bm+BaDdRxt
QobwAkJhk6Cy+jZEy/kc8piXqUSO6chEDW5OWt1z8Yp5BR7KL5Wbm2MilK8JLKlm/z19oTOcUu4h
Zc/O6xJcNdqjekuqJ6hg7HEz9U1UKFQudRtsv7J0+tBPchAGiv5TypyI+/t+vNPdEWYYqMpLIvZN
cCSJD0PTRiRj5gWzhCtfKhiGSqaSGSjo2ySroQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
sHfsIbA/GTiYiIhFVT+ta4MYPEvZVn5bzP0L9SmLFYXxtXCWmeDpCp9ZZwtGS9IH6xlOR9TtFG5W
pgKkFb5r5QCZfajiTmrZfPjhvh247eO53zGpnNOd0OD8ieVYpE+zrABiidJQZIJKyypvLU+yKMcK
ieY1rJH9psSNTXb3F5RJBwS7BAIUABNBZQnGq7oy4LEOxgBNofWAIW356JOU+bZ9yTI94wEStpim
5BFs8fstAwWnwM6ZBxHDgmukn8PzlJVxzDFileHS+GIb5lPZJAMfhj/nCnvFAKrsVpYMjDZiwUXS
inHd4rP1QfU6bBAS5qhsBh1LbedSjDIbguzLNaMGqf3V74evgzM0Ps8jg9qHcPLyqUD36zjCw262
gOC0ofer0rkLqaM6oyYN9vLgtccUgx1yvJlD41DPYJxSSgHkRG/5QSwS1sPS1s3Akwg0CFWU6kDJ
IgTusnQGjwO0kd7isRhV5vbprQccIjmYDSkUVuuQ1QKIJdSZNgqBKujv

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ni0skYr41xEhGcERgtNsJJ63OdYzP9ki5X7c3IbnsFCvWxeRQKlubX6N8A/0jpNXOv7aZEKafLZ1
qwbSeUvbN5EGxOtmP500LKoc6ooFVOT30GABYPyplJZQKkOV1gCLsFgwAOvKXk0nzR3DidZfgNmV
WzVuzpauwrR4E5VbDQ5MRanHIv9fUJyWGO5b0vBraafqmyDaWmLnOjDZvy2FLKT8h/g+leYjmoOW
ZJ6PXCZ0Q4ga21Xt6erSGIYPOkEEG6WbpWPjflxT9mjFpLmFZ9GiIu/sAP35ujidUd4QOQ1OhsD2
xotuK4Bk3godsqXIIt4XQ32YzMS3QWkODMZ9tQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Vr9cGi332/lxwY+1s1c/q/QC1iXTtfGX0cX5Ee8iMu9RcXLuTLEJUJMfxD3nNqpTzZPP2uje9SLL
ag4NXGXSpax2KTl6n0ZR19GRYIQeoyuIEObQQuuUjIKIJWfhtOUJl3OTHWIfOKbakya+nCm5WfDr
xgAKiWZOPd4QTtzIfurdl1JtQQHX8Df2qJz7sQ85KbEnr9f0x0Z/P+vOiNCy0ZYtVnvaUhSssVFw
l2tWmTqvL+Cqw0ceq0VyZ+3vpLw66QGWxVHdhMsrsyfNGyr3ihgnG3a7Y1MCMfOZq/SVFUt69F0M
XHyhnqbPQtcHQDzO9skrKwKEzN4uFs0H5KYx8A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
VzSc8XP1P8vnrcckgvVZGDZrGVT26w6xIjvo6a/h45CvlV+9LQYT27zdvXxkL5tmT5FePC9paUrR
foCdInU0kmlUZ759cK2VrUmeyxKT8HXWg6xlTw+mzpcVQ2L5RccoD+x7DUGD5oYrTIKMHhEjKj2t
V5hsm6x8SS58U2hgBj9Mrc9VsyQ5ckv5iHJPaptGNowNckVd/hBogWZomkIxlcUdE/M9DVvqxhVz
Tt6fy92B4AgzzJMfxezRMyx9/CEBICI15TibBxghqNpC23LHFun7+S3oDsoVwo9MdfJEo7qaiix2
uWtEvbP+An3VxhS+5G3uf+JyDLZlNZjjujiAuQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21504)
`pragma protect data_block
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
aoM1m8p+pmPewtHZZCN5
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
