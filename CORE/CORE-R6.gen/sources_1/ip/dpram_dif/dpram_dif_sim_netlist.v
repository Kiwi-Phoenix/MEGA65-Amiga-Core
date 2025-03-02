// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Mon Feb 24 21:13:52 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top dpram_dif -prefix
//               dpram_dif_ dpram_dif_sim_netlist.v
// Design      : dpram_dif
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dpram_dif,blk_mem_gen_v8_4_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_10,Vivado 2024.2.1" *) 
(* NotValidForBitStream *)
module dpram_dif
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    enb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [11:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [15:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [15:0]doutb;

  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire [15:0]dina;
  wire [15:0]dinb;
  wire [15:0]douta;
  wire [15:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire [0:0]web;
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
  wire [11:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     9.85545 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
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
  (* C_INIT_FILE = "dpram_dif.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "4096" *) 
  (* C_READ_DEPTH_B = "4096" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
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
  (* C_WRITE_DEPTH_A = "4096" *) 
  (* C_WRITE_DEPTH_B = "4096" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  dpram_dif_blk_mem_gen_v8_4_10 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[11:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 46496)
`pragma protect data_block
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
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
