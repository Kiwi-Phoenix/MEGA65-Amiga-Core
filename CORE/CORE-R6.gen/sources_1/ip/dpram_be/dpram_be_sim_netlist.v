// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Mar  1 15:59:07 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/ip/dpram_be/dpram_be_sim_netlist.v
// Design      : dpram_be
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dpram_be,blk_mem_gen_v8_4_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_10,Vivado 2024.2.1" *) 
(* NotValidForBitStream *)
module dpram_be
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [9:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [7:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [9:0]addra;
  wire [9:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]dinb;
  wire [7:0]douta;
  wire [7:0]doutb;
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
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.7033 mW" *) 
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
  (* C_INIT_FILE = "dpram_be.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
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
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  dpram_be_blk_mem_gen_v8_4_10 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 22064)
`pragma protect data_block
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
baGiZGo=
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
