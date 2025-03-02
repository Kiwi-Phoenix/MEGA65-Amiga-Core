// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Mon Feb 24 20:52:24 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/ip/spram_sz/spram_sz_sim_netlist.v
// Design      : spram_sz
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "spram_sz,blk_mem_gen_v8_4_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_10,Vivado 2024.2.1" *) 
(* NotValidForBitStream *)
module spram_sz
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [7:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
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
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.54005 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
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
  (* C_INIT_FILE = "spram_sz.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
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
  (* C_WRITE_DEPTH_A = "256" *) 
  (* C_WRITE_DEPTH_B = "256" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  spram_sz_blk_mem_gen_v8_4_10 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20800)
`pragma protect data_block
Ct+AmK3SkYgaKSgY9ZPTnLf5LgNvONtUyIJICs6geM7hEBmdf5vAH7Gi+yUNJbOqnZCEViS2fBAG
d45ixaygySW4NKz5pE09O+zEOMorpcUrt8HusgBw9nqGSkQZRH/5LCUJSTV26QYK8/Ed4dR4Lm8a
KG5wEeScsj53EDNn69xmpleObn0BsmgmEPpcrgAtNnQyzmb11mX7x5Bdgnfx7bJnikBRAgq6H5En
7unG0E2jQ+T/xxol33ai6G1thAv6X3AG3bHJ+/Lz8BjX2MJyX2QQ2VxSOHK8ixvB1g/YypW17nMh
y1egeQWPl+BKHEXhIaRdaXknSp2mCOL2LfqX+yhTp9uz1Qpu7iYgQohx5uMtMSqktBuLHbkz663e
5DtMtt5gi48/kWW2vYcnUKyjWGB2sVTZ3kCybLQlXLTar/x7h9zaX3vHc9Jt5ZIJuORUDb7fZT99
R6cwWTmQ8tJSkPbFWvT2iJ/ztvELQfh1VvDQPpI7nlkX+VV8fcOqgpHC6TthSLTyMtYthexR40di
z9iCP5yeaRnCu1kGeOO3sBfbJ6LGE703Ig0XZPqUoNB2xwU+eTm/4hmM8i+ZnYyvq7c6v58CtpF4
IBWCw8LRXWHjjOcJzMeTu9ey4I8vcAZ29JCKr7+Z3VvUC9znBLChv65RQ8+DiuGmcxr4WgmoJf83
yAVr8zU7rQV6N5nkMswhUQuReHS396AV7AGoXDI+HNX6hsOakS1U/I4ywEmarlu/FWkPJ603Ni3b
sHM9eudA0FPug/awcoFoKTf5UF939gRXln/97tH3jVluiQ6vjIVhrpyg8rG7oYzhW6uTPX4+fNnp
ilamFV/ZSjcUYVO4R0C+SU/ClBphoYz6uzoVbYMmFzASwZYhz9BnlmU1aq0sfzrjEA+NcbhQGUO/
rh3GEaofaXc56n8BIH2YzvYHLStoAZXnuzp/HkfAOhtoYDRcUFPYr9RovBHZTFetpUaVyVe1Hwdc
1ayyHJy72wrZeDdmEyYm/p3s4ZFErGLGKo2co20QUwBuz7IQWECjmd7oEG9xG7UVdBIMvs1e1sog
DVNw4sQtEjNRJdZiazA8fS4tzmmF/jSAIz5eQYhI8pGqyeuXpLqqF1NWsn0mvSm0moc1w5oS7oZP
zz/2qALt5MNNbrlEsb9a6q7K31HogheM9f8vFiRgv3VcZ9Xbu5hVkl4ZShyQ2YeoCjJ0nVOEW5NK
lOqMpR8eFob6fZsC3005brVQiUB278ffoR95trv5xd3Boa6GifeiwlomGPgvPeVpI2OUaazniXy+
1Zs46VL+NRoPMzxqpAW7aRyPYT3UapvjxEMlxEXV6z4E7iHj1G/wINjORJotpQLa93nWnBAK8B58
7eU/bUsI7vpJbpSnS6v63R1R6oQWpuZF+DNeAm5GCQn7hnyp6KOnxD96fvdCfqyVxHCfEwWMEQhD
R40c0Xrz782iBZKlJR3k6LI8zuoxcb9R148+vubf2Q/sV2eYXs9tgLAQezxBTKtV5s4PRj8ok6A8
PaEImXSlZRtUczGWSOheQomKY2slA90Mupesnc8bqXaTr2mEQ2faQ0FhvevdPNMsXLCXSQmn0gvK
xSiVji7x6UWAh6nscZVkLUXDUQr1DntftGhUdGaKu9mmsIayB7ugmRihPpnPaFZYlitJq3f8UzKy
KNZ3QjtIaYbnhgf9QL03j6OW53lrUBYtMB1wmMPzbyeErWj2FJwFmr8i0RvUv3qVrG5vrWiATbvg
pMK01YP7eizOE5n9+SP/a1hFsS2hMyDHkyuQtHCfXauP9iO5UNAd7JBeONBySwwypncSSQi3CkVX
p1sDg9MGF2YF9tEDnifDFyxUHzHQpsnSm07geAjVTDDJQIdx0/Ckj5e0OAsJSCtRJoDJBM4/kkpy
AMMgJs8jCpb0qajDTbYqvSGE1IfmOxjQUto/vRbf60iJ12MUM88IAwtCl3fZ+rqx1lm7Ktr9ffhI
p6zNJ4PQl31uLDbWdr1f2Vu6QNzJGFuaJtseo56f45WVgNSz0iv0Vj0sUdBrXGlhV1rw7KI0n0XM
X8xMO0K9jO+hS2+QymuJ81xNQvkB9i2VbTfmLUSAzZkamtXmqSmiY1XBvuJaW7m53lrGNxWe3Wns
9gkTnQ0XQN57BK7cT8eGrOmQEkerwPrqun1VKfN18UOkE406s1AH1J/LOojY1DstTjqV3x14KUad
A2+XpLJ0xsCP1dkWSr6z/d50ioXFKTLdgP1XRiv+pMffEGmtS7W4Ws6weTBxIvhop7TUkhz7D5vn
A0p48i2/HyXI3/6NISv0AHYTkvuM27KLj40rOpFjRCW3ebPdq0zeN7Jo7vAQOrvDQcb2R6xAVEyt
4PvdLJlUESl/e4dZNMaG+uYz/bCD0SNbEfx2p6ZIYB2XOZg8tUXwy3mE3bIfRaHQ1Fyvz22FpfeZ
Wxt5swQTb0ae5m0Q3wDMr0yBMn9VmzS94PWWbdDfjJrgk5cNAhlJav7eahvvO+P0wjiO1EZ832tu
iQRxImkHSJTf/MOZJymZ4bOUCHAXoAV+XnKmCirFuZU7w6nV9UI8L8gfXrd24P4wt+VPOEKbwM32
ojODt1rfJfFzFCYpsxOu0Z3ihUaLTUqfA/TL/xD1euhJUnFXovLFxvh4dPy/x8YXVuzXveaYnyr0
BfKnGz3NrORwa5KqSPM29T3jRxIqRgPGfMufiGqA+zkearx9Zv567FYMTN0f08INDyF93xgXgU8X
J8nRuDpP77TYStNRhAhY1YVcE9yYN/jiiM/7HFHN0ERlJ6TGfmlAvYdXUut3A17z1dlLYGghyn1p
puNIxU5/VwV+HkAfIa9fEfqY+xEXpt/6E5kcMPd+OivnplZOh7sRrzprLy+CRT0QeLGB5jAdGNXV
KU5ZedFb0AtUSWkitYE1eKa9Giklefl/0jyNLYf+xNGh45I0FNGEMC29REQkJ01N8SSa/fjuExHH
IohPYAQYNyHjLcB4JhWo2Q66o3pEGJisxAEtL34EQYegVYbNbH6VTiYySfcHh8srOIpYTH+6o2VI
X0LgEgyZSp8zb/PN9CfctY6G6DQtcVeCcmrmlqtnbDth4zVONqikckytyPQabZ+XIzRwhcaZJ4Cv
Y3arhRnjDDUsY6+qnvyssPg3R11g8XPAWpoG/y51EQcYlTA6GKMYPtYZXbt4Ee8jdPML/zdSf2ot
q01sG/XLXMGeZs+WXkwVIs5S4kEeOs35SDI8e5GDRWKHvx7TimOUKuS+g8pT7GqAFhOqA8+yjkU9
WkbPoHq+o4Z/+4HMnCOvWwv7zuopZQIQcP4B3EnfboswWfQ5ru82XNf65cqoaa3S9L044M+UP3l8
MRIK1hwWp6Fe2uzzMS0W+zexpuCl3fd31mdXJcA1T1FH8yA0haCRbHlC7TuncJ45Ha3ZDO6WNfI1
IU/7Sae9Wh5XX6N3BTHdxVXhqosqKUU5A+UGjOOEDZuKWRWz1IJ2BTHPLPmRMCKQbOpJLt8rS977
jQOpQJpQfJHZRiRgr+z+MS5K5D+cyNXJtAWfstn4hcU/4AuzHPcRv/IcU8TR/dw2FQzlEtkzqCV6
H9+8cc1eFrfus9MTf5cfPSudQE3oaCtYsCm7Hl4wTISjqOL6fVvZq/dIqO6eaAPfZ/Em+OCADVNN
Q25zTpx5dVvp8jD4JARwwIrNFvJ2YZK4wbxXedqgssJ3K+ZjXwx9aTCKvgTVQHVngC3rST8POY9Z
GjK+QG65WteiJY0Tis4znRV6G9PNMqsp7XfYCxjIydmv4M16FP4N85fSvJxJYh6WB1duhym+MgQc
0nusM5ayU2grqbPXRZFbs0JF/WsOgM33fJb5VTDq1vZSMxKgcTUAmQ75GYOBScpDPqYX0ir7HX9I
/U6c76hY5n0OrQshpnvflezpnWLb5qkCxr+uNxHoshzYm0As/mQ3T++E5sH7X8lZesOXgfB/loLa
ZDg5ndFmAF6rh0jygbizpnNp+RX3PGtOUOXAkxFLpBmYtnCo2zUZ2Euxc8RsDtgy8dnFcYC1joA6
cwojSAR+Ub5PweFj7c11afvsoqyz7FaEpo8FXpmlNBzoB/lu5TKnnsSxoaxm3G51ypBPJ+/SCF0/
poI4SUrVwtb6Ad7Vjnir8fzowdAvRsArPyBLQwGab7z+u+G1DARpfIoVva0i2Ejqh771BuBpIZLk
amcmK6JrB/4GX6IcJa3zIquz7psH62/grVi9TzQHX3RhbIqids5dH5tL4SyTrmAvXlm0NOOr4k/G
PkavrYS6FFkRvLEEs/624biSD0rDbl5VB7VWHHJDwMm+aVDV9Cx5UzyV2+dmqBV1t/xi51cXOSrH
DrvbhRpHEfbg4H5VB6N8yQpyeB3Kjo+3KbnChLBZM+16q/RT34HTNMjgDmWmRBY6IxqhbJggwHlE
r+NXZMdSuMXF73HdRUsFT2n+vZqNlHA385vMlUi/oCGz598PUW8CisTNsuzAhK5cCrWB+IchIh08
D+WG2sT8kX2EfhcjnX3SaaT5iL/ZbD37yY+TiP7EonCf60k7KEIjdWfBug1EQm6A9QPrnM3aKuFc
aEe311JGpTGmgdKiHji6yGbqQ92tK3xmF0HnTlV91QXeaGTxdKb874fP3fG7ECZXP6s5oKGZHKOU
wb/OfhkKlm6awTCHlLSIBH+T0SYzoyzlif/kfyGyTf66q/V/edp4HcWIx4g+yvzZzlOUcaMv69NT
ai4x/RoNmqGHNNHgEK+E8K7KkiCFVXKHX3KljOUxrTRdD9OjykOr7mqFwMSTJz2T+ZLsi0qcCnq1
ZBzNc+GMkXLxqxX0cu+xWGHfYQ3Vdv1g4rePiJkcjG0tTYvTTvPd8LAHtznEGqwLbjw7WhK3J5vu
VEnnmhaxtwqBpf+yRLirpXaoAebuOSzazyxdDdXIC6zjsVeaIHkO/qzhukPNBKJhTcvHJv5V1S1+
LkqNOiHORXNPtXL4coHmmNwfs8Obx0O+GtM3wYxb/cDExxM8eVXiO52TaY2DPtvIs0KmTijQ4xiL
y5yohogPOrUfX8+Q68FpN0C8Y4qgLu+eKkIl7eWanOsH3GXKmLgCBqzSLcCJPVpEhtHrD66qX2PT
1qxcGVMYomIqFj4BueWEn/4jOFWs11r4cfqHxBKtgwqpkoyC1yv67DAndy3lKE/UDzYWPEc5yz6w
BI9z+Ax0uBTFjUiLKAZ9wIqhDSgggzBkRRYif867qrzpr7xv0bxlKOJ3jYwN68mjGE8Zs2CNvaT8
8QKgnYIYzXUdKzO7ziS9fESPuMvr+oD09xk/qacQbi9L2qVBmndfUMvlAgUuB7gt7ACgDz0cTHh0
z2UdeCGFFcmW9mkHK0Xhr9dl3Lrgn9SIlxyZvnrbZF9xE1IcXQAcBLxHUZRbCuWCl2drouAVKd1Y
mAT4aBjbLojgrDop0ni0pkFyb4AIrcq0WWIBqLa+fXt0JElqWwlBNYbnFiakCZ9X+gdEqDH3t9Sk
feerhr3pqA5ffrkW0G0uRRA7bYDDNgWqcezMrLdyJlCHLj7UzHuUPlyz7iGEeKyNflSL+No3sLfs
21r8qrNcsTajec6pxE3hzdo3RijCiEY9jFpsJ8RRWQR9eP6Wztxz0GnY65vyZccoK/Ba4WwMKz0I
ZncHS1thrfcs+2oQAyjBYMsOOpM5Nj+/AC/49lAaQdEQmnlaNYeYrmmHtUuo8FM7phiQwwSa44GE
rW7RjLdhNQdlmVoJxkcW2Xc3yq8xSieA5bDqYSTIG0f+/td9K1V6xa/okS7RBFr/j9d+oel2eHcw
+eBGriokAhJDUj9E2RHmj+GF41fqn0x3LA0Cjrwh/uuP+M26NIrkqfkHJG0BC5XsPHj2MTEDwKKY
f1r5X5RLwgqYdreahTbJBMQUtfPfhICR9Ys8a1oIHqR8BwiOpOdP7CDF4uLuymCBud98WXhaMDcw
GVffuj6HEpo5UR+RhNS92/2T7IBNjLqd17LoK0FwElV1U7OuBnrFPJGAEuyddHnpg9/ulzUZM8EV
/cIXnov7oAcuy7C9B/7z4BPI+22HgihwbWfX8HznsBdlORWGOOChkbW0fk1lk3zgW0+sWN9akMwo
RgjE1cjxPgS0GouQoNqz24Zw3+7j7sDgSp/LYKjmqq2XyN+TlIc5Y3a2oeH9NCoW34DFawWCsLMj
MeX0ioTyCEddqGXe/BRXl7E2tQ6KeY6Wl1C9W1ksoYCIa/DDm5nXGxCUp761XmtLuKL4BrlrW6zp
PHc8xUPTq1UfGZqNXOhu2ktt4fieLs4JmM0yBIb/crAvNonZ7fbp+75vynGUlLB4JCsjYSbpByDT
GcDB3jjYviiT8+kr5bJZGK3p4Ipq7psnMW8alZwYX4TGLwhAyauziX3uGp8xjh7Hx09hED3sBY0U
SAuYgLNNuJByUA88Nq8wgzeiywTB/Qr4yleEAFGgphlbslpUOobQ6K8TFHhoVQnYzA2DMIT55CIo
VrJU/0BURcqHC67Nb92KwyYgX5xtYw1LHeyk1sh5HwJGrtEQU/pQZGFsLJO+4TftR1ac919fo6jF
1PHBXPK2Bs4nlS6jfq6vTZJJkFLX4fDFIZPRkXQU89TtBYPhNMG19uQqgSzWshuISTi7IcMFN/xX
2YA8+VeIMS0D9Jp27D8/I5x4cAqVyqw9zdwGbCg8CFCHLmLzRmpV9oi/MBKb+uIHeKkMvNr1H8rQ
LtggpROPgCH+rJM3d2FAOoxrT1N8frX2LlN7pEkU1HfJX9uHGFBUk1l7fw8H7t0vlmiEoDTrpITi
cjc7sUeg2d7npqMT5IzAN9z/sI0Zj/y8g4+VuOfC0Ih4o05tE3bsMqCZiAsnkw9IwxsUF/ABDSVU
Kdavkn9RX4cjv47EqHJv8SJqPUVdjRJ0u834pHbSDZAJz2eY6NalBspAjPJuMY9d3rGcgipAKbfE
6nJDbQkIxPrYp0esRpVYP24Jako6o1lI/isYSI3YoLHFYdLS/nGrbHZAXqhW4nWCIw7TGywYIejG
BbCHZcBSMQR5qoygzElyjDxWAvbug6l+DsOaiGR29BpT6tqNyoHno6D38rd3m3/IkfeqoC8zj9hg
OMijHSGLaLH6lDM+VjEPug4cjmjA4Q7Txwb4ppMKWlxVQggLmCIsMelPnevXMm6LOgeE7+tyDbcJ
G+8G61vAZJeAaqjaWlztQ/GYF4CPPmR+y7LbRNV1Qo60qFD3/kJMap5qdGL330TxZkFLekUTdpB1
g/N70h9sOgTCtWrmHe379SR0e5ZEyFmb7lgJjLBQVwUMiA6Y4G3AeogDSGCBr1WSOGhtJ6FjbYzA
zeXSPYJ2aCoUMArZL6H0Bv0VG+ttZmU5ebknOFR8yq/SfD+//r58yOlMv9fqmtphpAeyoPudNeyn
JmyTljho69aBJxTI89CFavl9EM6MuVns2P+PgSOqabtsu2lyO/P6soYG+1080Zto+EL6pLvtRU+y
G7UyRAjsQjk1A9v68934DcDHIaLFibVA8oIuRe1H2pUulJNK0owaKdeyx0xaKrKzmKEluehK+pnI
7SiqGAyGdFdqukRrgGefuKNpqI9CDip5zh8tGr9rA/NWirQwrpdEFOrvKkuABYsETaYtOnKQ2ZKF
gkpRv44SOgowf0Gul0dH2DzM07IFcUo69ndSqWGT9EwNhNBOn8u4qKHpTIosQ+35mICDHSC2JPa9
OIATKVjubE1zS3YwgkycWjwlCcZKn0TseR04/QPKeRlg2OYTMrWa4izO8ksbVW+GJULd72bQJkVA
+Z3e0smTw1iyv9uX/0SvbQjt3QTe08xX3mHMkGH67qOytoqbcVwPvsafs7batYXaxrV6ykNCDITu
xSYpbvQmOPPSnnIKzEndIRLodoQjroH3kv1nZhYAlMJ98XRiKCrUlEDQits7VlDyuRq3hmbQopi0
eQS4izdxGGgtXAwTYO3zPfnOl8tOUoSFJswLDkbmoNaC9t8JWLf9rJWwLVU37icMHFDuPuFcyO+J
395xeyFvLyuZsOJDzvk8pX4BvG7ZnxCF3QhqVegmElZ+ANibnNsVMOYjTMithc5HSxAnaDG1eCjG
wP66PVNbEwm9IJWFivRDI3PG/U9FboL1Rj0DFuqWo+pxTuSrC/lxZ3cgiQ0CP9vcmF99NLqHMQQV
IMFmrSUToXZXkPsqjL1jYFrWltkUNB1mauHWT0gu84PMrZO2FVILqD/pKrkDbyVSECaUb1RjSo4q
VtcAOKaoUZVi0EmDEWWjEQrVuK/eHpZiKRqCBQmkTfYo8qZtOl1ExELQf15mJmZALG+BJeub0TsY
OXm2cgoe1oaXPjhpEKoJrDiTzRJgdiAJhCJdv/Kusdlzyv/Fypf+JaJd8TdKmKbvXfsEWakyArmf
sCB0WLEPXP6d93XF9v3tcKJ08u5BR9gUSO6jTdP2LRNRc8rVg6UHKXii355x6lWgM1eZBRH+2JgX
N+XhV+FKmXZjeWXOeNB1YDl7oUHrK20xzWAQih+r/+ZBaypSn07esb3jBb+REzRmnmRzDGHYT5SF
+mJXYH7JNxGTj+2aUnVMxCwcQ4Jh2RilR+oTi05t+lBT0odGgMKOy5WURZAEYjaQrkw6VwZzjNAQ
N4Vq9zSrwHM2RDPop9qq+Li1FN2wXPSkIeGgIOffrPa4ZHfY6f0hieGBzqfuxNtbbfIlHmjcNcYK
VhDFJ5eiyvv+wx+z5mO6lvpj5SydYWxDuEgEC7DWEp8PGISBV9OkX0suPy20nyojZYQdAMqzdAHf
BJOIAGd691anzlKWw20I0mftcj1Fs2l0bbUjjRYoZ6EEolqII7DHUYJiKrcuQZnreiAhpvhoHZOP
n4dXdV2BIOttUY51ze9UG/VxnfrtWsSgQL4/+zTeftsNREUOrlUhqYAbPkNtsGLgYXD4XOy79AZy
bqds/3ySVdADSPRfz72mjEjpxxPdx4q6QoAWwRKGD1EnWH0n0qoIw0scvbaV7m9JmovxWxzS3w+3
/oUI2Kamy1vvKqcUMAo+UfBtE9kaVz28HGO4w0LPJQCdu/R6+1FJXypLzNcVo7Yj9D/r4DPNcDdw
jwpY3ygV8KNZOft3XYbfBlbRWmkM+TTFuV2qaIusv+NIjykxY7kR3g9FdKgiqG0GKJkD+urn1ydY
UQMEoFsl2w9trwlx+r1r3ZQu7z9RC+zfwiSu/MfBFK1q0A8EgO5IQnjclvfov4mUu/uMXDSxW80S
3wELqrV78r7d+jntixkU+8r3TTclzddzypfnWmaSf5NbMR0FrurozOK5jtryxuXy5xqlbmPsPRMr
OAspy7kj+SPxNPBUaoAP9yEc+9I2yFeas3jTcmiIe9rQ9lV6Mm4wzlZ9AuxiEXE5i6iEumU5kQLM
AAhvbSYZ2O6vqx5foM3PnEah54zkp2FSfXIzbrLtwCStSYjSSJSYLszJP1gGWjXDKJ4gJrGcVH0U
jJrnrDX9VbyAjEAjnCTVWw4GIj4rXthSYhMhwW9k6pQeFOopq48ZE+Dl75pXWNXdBYcq4MLRP6tT
d0ZPszVJQNI4nTx+auecYgNzLOdszwkRao6A61WDuveqDK2ctrG2EJEly4XK06EbvSMrWvT1P6p4
piNAJREQxFJZGo7x00gBnkSSFXYj820lrfRgH4cLwJijEyN8aejSCQBcI5UTK0zq1VaVEklLJ/UL
RVnq1SHFXPfKBMUru5UDHuuvM4q26xSfXFgSYFoqUBO3thMlCMaYpfza8ihPkmYhW7Lza7Ta141I
x3ZkYR9K8gqkqt+XnxlTme8NpD7dUO74801LsVfGRc29jr6Ojlr3q3vO6UgWps43RjsU4AWNck4+
DqP8dFzyCd/TO3R3PYrAVdyq7mJbOVTDa4eVb1Z/6pT/Rr8yz7GLUJRYcecPQjZOkArNzSzxlNWW
+stKLoyfnhHPKwcgRGJBdybTt/URa7Qb5YD/hUzMPhpQmY3Fwp2CBH7M8q5Fuyp9Sc13E018syRF
bSvbCUoFAZq80WHcLTA5KW8cmYcgsu+xcj20f6l+WLiqY4EzC7aaEBDdd+NeF8Ls9X9yYuCy5Mv2
Wx6TvIlNdZi3jnsWYILw4S1dLFtLXvgFGGv4F/JhkPdcOV7q3yfUWCQmI8Eyx9f7Rzqsp6we/jIE
G/RoWLRhjBUfLwGY0dZIi+ixcdswe9Zf7IBCu8VMW0v5UNG7RaCEJcC1ogclgha1Cs+B6ihj4oIJ
8huUr8/x3yY+Nj96j5RVp3MeW+sSLB1PdTfKUGOqZvD1dZJvcZG4sdi/54aZzq8dQOw/TKEPeqAx
aWeQomF15pbkYJtN+Kl11Xh1cVKAEpkYc47lWkBzAeHQ1WV52ttUTMVKegvyue7n6eBfJNX0KhNH
CBWrWLCnSp7k/X66CC5Ee6ckMhIis0hiEvUmIhKtdi42+DP2tf79hHEceEtBHDEGPzgE3+uxR+LC
2CxqQl1E3GKGdO9TkX7icn+AL+beAl+KCBGJa/QCkcRrGpSbSZyYMI4sAnY354P/g4NUXa5ljGSY
X9VDeWFjWGkNYPvaGieWbQrdEVEnhlHH7BqCutSEuckO4Wg9oLQWTRODbrkdMHARyzc5IHBexZTn
g6Nzqm+RE/kXRbJLd5U5F3u/HYq6gQFUUJlgn9KbH9/E0m2fprxHf/5qhxxV/vp/XhotT2vZ4KDP
F1uwVltwRDkuEmOqDP1wJpY7wQskLx6tHA5KC5mFtzOt9z1uPVNoqo2AnvLwkJGIlLkBa4Qq7fMC
jMqlPYuZQ9IzF+GYY8/WH1NK/BkhPZoPM36XTVzAoXQ77Qv4X9gI4vLHJVtZ1Z0qM1vIiozvMVIa
rY2IS6eRmeHy2gIjv6SYwGwX5ziDWuh+FjKoeN5JlsMdZ6UvFTklaaEo98wyiNw4DZcDbrqh7HsI
mNmz0XdSQvEaLi7b8csQ/rxdZOnOoh8PRR7IhZgZdO0Tus9nPc1+/0ZMQIBI/873vlwZdI2048Pl
8CSxrCArnasMICB+QNF8L84QzWZo0xmzFIVJVYReW01trZQ5QDkZDDoZf3orebMwC6y6qEPk0ut/
pQ9mi/bAzdD52XWRxP3LTXEqIgeObYZPjwNrhP2rOOKkNouz2eVP4UIk9FdqvvaNI5wLclJ/6Qp6
XYkd0pS2m9VkzQQvYniJukYCiQTMhC8IGspR/25s2Bxa70RFyRj+dAEQUn++Vj+ms8i2acTKBy9x
KT64v34cHSTSXG3UO7r6jSzx44fGzImwml0+jLcDJvjgxtYUdvAw0dnwjel6qs9E+K6Prr9hxroP
wRStDWGyK7ZThZ7n4lGyIGb/mgy4ifTUZESwTnLJdIWx/VM242V4AWkhjlsq2h6R2hjti+Zvp118
X1PKiFERVCVS3mQrMOp40zjXmLNxSSxYoKy8qt7UNlnEDbP64d8E2yddQ4YP16HvwKucFy4fX4FM
/SNWq7i2U87k32aLbfbGZVharNGd5+4bVp070YysOmAtEDGRV90h2NrqVEmIgDPA5XCVG4ovMLKi
+LT3DlCCDCgMVZg5WMYELb+SUq3UV1JNKg4+RUI/+Lp/czaFjleQeNTHqSgVa/aqHEPplho1UvAi
1NkDIhc2ulMBksmh4aBsmzJnBjATI4UR79UfX/qf9VQk2K/Sv0eSsDZC89BasRWKKoCvaw38Rkrh
T5gGmdOhdKLvdKIZGDZ3vFmKS7MeIEqDEyAidUJHE/9gLdPwk27f1S2cjaps6vfOxk7BFsQG0MOD
0+0tNWrzi+KpfnwvRH2bAQxw/iE/cVOQdrORLLThWhNadctdqlPr+gtVR+cS9tqESds0pedhjpYO
hytxuIxFetTvvAlAUI5ptgIQEPd6qPyx6X86+LZMCGzLw9HWGdmJD89c6pAacaFwUor2z3SdTM4e
V0L0Y0T8JBATWH9LwvzN5blSpEj8moeEbgRGoLE6U9/sOWAQyP4RXhyY8KctwuQXhXqPxweTHg1W
rTmY65f5n3Y9Q0voViqSf8HvdA2v0qukJh4lwl0dElTHJHBmT+ViYzIOJrSEl9aF1Jm111Qv6JNd
kqPmyFdYAYPZ8qs7FIz3/yseTxM30MIvDlbLGN4CnsWTlRFKH1ueNYB5fEpzYMZ3NGwhtoHRGnOk
BNC1p5M3agiZwLHQOGwba2QTMemEVB1ELxQsBAliamoYemYP2CvdWal5UXGALmaeObhvkKSCX0OY
2/6bgpsVpgaE2YzfGdTghD4rwFmjlOI+ngKIaiBB0Hn5C0i3Ylq854+kvfCMGHtoa6+V6juOod1P
8TQpiRMdSbjk9JjT41cydvimqQxQ8HHF72b/9q6pkOA14WG3oDlY/+04Qs+uxSq4hgKyp/ECMocK
baOF0RZ7gpvharEpTawaehs6Sq00GQH6x7XEDlcO+DMOdBLMy9tHoMwLOqMVaiwPvEe8FnRdMkGd
526Ttz/KUq6Po+avCYP4oqXQIjh+kt1ap9/NmKn8ryYhNhBdrURI/EXu36fJO+oyDujGK0XPvvWG
rtCZRh5+FubMH/MnIQ8Dakszpz5Ku7JJC90sFp2Fc2IMjYQROVzoGejf/b4GcF+938J9lmUKCxEq
ChIQaHG5s3P70Y1V5w/biMzM1i61tiHyI3ft4EhKFkEpBXzrzFEYnkBY69DIM7Z65uLyIYPhzDgw
eBKQi8yYpID69NWmBBrn8aMWVEO5viOCzhs0OzBzM6fE4l7iY6Mohc3XfJ+WH3fNa72h+1tuStXU
3KFZ94gKcuPQ30iTnpqsDLPIn+8wypbxwnrf/OxTLMXfSs4mhRtyWaOej6KdfYpNZKhcDJS8lz90
LAr3f9m1Xez4zjjZuA2HWSYM3/FxfDh5cVkMeekFYVnciV8dZnvZJzbIqbp0KqMOwjsfb4jImg8u
H6ly1jONXLVH78bFvjL/zcZk5MgXREc0hpDYPLS+Pr7AswZc0F7EJRDshYkUUhlVyqFHVWGu7rQn
rnn+Od60lVbKOYa6PSnGIoxdtr+PHkQjYY+ms5Pq6hJYg/8DToE72UQJm9tSQALdWf0sww1WsFK6
rI+tR84fn/Up43tGEsHRUwbBi+lV7uOpXq5hPrnP1gULotNYA/pB1WJcRd8imn5ZDCHkcX5agYr3
wuuYJ4dvlLuzkv0HLukpJMeDjgOKApSj4ltBxK3CdHU/V5yklFBoDG+DoFQ8q6E1th3FwrzdLibs
LmQCqcspg9As6T9qd1L4iP9v/M7ZKnjc8s9tKvATGiUYnfL/41Lg14R8HE+0lpL62WqXkZumY+dR
H6S9LU52RilKMyJGDH8utWmtJ010vgou/P8sTAVssibCPQUJ0hy8CEGeyZtTh9Tm+VhvdDlrpcgL
So8IhRKqcEdMTsgQsoZysxF0+EcRjv2KxHZmCjb4PDthta6oswIm/spCxRRD2KnCkuuCrHyliM+v
RMbMxT9HlcpxGdQBvbf9uwGA4Rh40OG278pvaNKK3LRhUQO5c3bKSESTkFNA6DkEYtc/QWl9ByGP
aEwO+5c30XHNTx/EWORXOUFpO//WzlswGOlM2FkKC5HyZo6F3hFUtD8y2m9amXynyQw8CHCHoCaW
xW2ILTukadzzVqxoqAIdH4B9MSTjJ3JkWHi62XhSeA38wdTfd7w4Wx00zgU3Y4JTbrNvcIFrn5XB
JPYG5LNFYmgU49Oz9hBVhWbKCwUXhY+1guIOTgFHx73PFlpRcq7d7M2iZ7Vezw+KZCaY9iLZg1v3
aT04G8VIQOIy1R2GQr4gzMBdyU2ArrDlIciDqFoCGVYN9XplKmKJf3iFJDtoYYe6JIOp1Qd7Q/in
+SRrD/9IxWWFPjVk0fGY35JOH9HZuxkQgx1GCjkjHzNIV2f1jXngoGzQtBjbu3v5/trap+ycyIUe
62JbON9iul2mZmRrEIxkX1/mAxymQM9iUHKZ6hW5obp3S7HbPvMtK7kgbyP2HcIoynR82dXr4RNF
yOBd9+H0511KJhQjCLA7xJ6B7ESMmqyi1gPct5MO0XGQQNxhJl6rtSQH5qq3sK+PEk7fGTfW8UJy
l4MKqjwTFEB5wkttjo8DWinYf52Xj6r/Ld4d8c8XH7h1hoAsO5LC96XETXeE6Ni3/N5GeubB1jN9
LM4g5TxL/wS+5LaowVCP2P5ghwUUmqq8RYydsr130lbdiMk8+JwSdjM7p5rBZi5ghyQdtKo172KE
dqq9KXIfk9XX++VJBZrHTODwciNNiCg13UDlWM7l7kUvg5llDQUaxRpYj2htway+Xs3N+poeCRRV
bzAylAAoFkDDfMxyc0SNOEiCS3PKHYV3OS7zaOMeBnBqRkvT7x8MbMsa0CHisEk9vw+dMpGIiPl2
tS6Ci9eGPOeOzOX1pLUIb+x6JPjTuWZFQ3ZS70ST94kYd0D+IrR0kNG/eZ27iX9AkaBWgb6iPf30
k1fkadj2VSMxBNdiM7oe0RSktbqKWUCDTUCD5UoYjtkdcDZlHZCbiKruYBZw6rjOr0NSN5TI/dyZ
d39MC0cHS+XS/kIs9g6E1bgwvM9tWM6GvGgqYrzl7LbuoMQ4WUJN34O9gm8XlLF3fIcvocQpdUl4
ILvSnJMS6iCuSR+GoMVcnoNSAo6FGz29QLVgXY3VN9ntXmGz07MeZuQlVtfUh8bKNS9qWqkcuiHw
9fA4TA5Om/7rO030CEkeVoCwEw2ObB3NYs5IqC+KI6OymTETAs1hVViTYBucU5IyNuheqVDY+Jh7
R4QknY/g1D9UAFxdpRRu0hFxpuB8aqBWOh5T1HvTBjAvijIYC3wNTXgXIyn0Wgx2ZIyzXG35P1xm
iefgg6ZJy2KgjOc1kvcOoJXoMCCtkIeSqzelBSOXrT5ypxYg3/gXXjZguQkD+K8aWgkmyWp6TLB+
vYrtVuk3UISAu6WN7mN5YOXNLZmbY/DK2IvHi3GRu6SHSpihiSS9EPg0tj0mtJct+7aycQGZgVWE
EcHWI5AhoJeU37eD6PAnoq7DhNX13e5D5bc32VDo9BZZbTRCsDWMxXAn+QDiCl+bZNUUO1HwqlHc
rDbvjvBhqFIo7aCPS+s9R5XTpy1ZZtEv0ceoSux9wzFFyywIveqWVLAEp761Ly+oBY0/5CoFHxM0
KrJo7hD0G31DnPvHCsNzC8kDfrzL7Q2tZLPtLfVj5e/OBhgDGZac1elF/NA0nX6QWm8HPy7fCMA2
e0h6CYsQrpwEdCJ8M01kt/V1zNQVIgw/fsoZ7IvLmZc5UDI8sK62NuLW0QJAu6JUdVYXg6BnZUZW
zE3f450w2yIscbboP3eW0Li6mxm4sCfVCTUjFGyiwX9L4p+5DgGzMjpMXnj+wSb4/qshKbfInRds
e/au5Y6/ZPjLDf/ofHnAnPeqsBovDNBHjrRNjpJgLJe553T7hSyhOvJcwhep2UHMZHsrobt4NpXH
A1ryj8d4qSYwW5iRLWTOd3cFi6mzInYrouUyQMUSFRMNPVFoqbNgCaVVul7RyhzVjuFd5qkij1bK
fmR4a+40p4C9MuLfOHN6DIClvjgQL36j8q3pRQpnXFuhfHR5+HGOVedXE6xN3DTTi2HdYf33qX9p
25pp3rSGpuPPHgrqAF+mx4JQiYKzAJBaL5OmzgV8ZA1XVzEuh2LwOUM3+/g7B4n0ll+TL5gBLkgD
JwcoF/Apaqqrawq0HAM2J9nW5Seqz/hRPpDH6Jrw4ZTMxi+aqrppjDW4P2+7A67iMfzNiNaQeVZg
DiR0ahGVKQOf6+5QXDLph1TW+7k50akdxbyTgr2KcLnTx4bYKrQ50hjeeEJLxA2lx1Wrrm1Y9Due
wsXcmk3Nc8XQYheO+AwMm42IV3pnsOAJl31ywhHQAl5Xw8N2Mz44TNlabPqYhL4m4F4WBVe+i3qg
75EjgE/rzdcQe76Vl8qaElcSIVRoOWi7FkcGwjkVVmm/PVj7wCT4qbRwHmmJ44y9v7r2e+t9ZbUH
Hmn1L9iiKpGfc00MxZ6tAhyZyuuv6cQdkXfj2j4zDRdF3YrhRbeNvkRgiPa3BBYefE6vCsTLgx4H
PsoQx0dtaV1RyMhI+bp5kKh0l3pI+uBlBFHjEwRrsRQrlpP4t0Njxleiei9kg3qutVhvkhKZouzX
aEQGb8jybiwU74fdRLf4W7MXjyCHKC4xyJuZKA8iu9awiDv4v58D9xQ/wnnqs95xfvwqpBro2Frd
b5u63D/YGJwd/L9br2MvwwY4LixAibERrRFEaKS5A6AWpvmF9q+sqWPtgdnxoB8XTWGI2eJDHhdL
EOQ7HiVHbwxChlSt4RJ5HwHduALuaj4sbLxFPi1ZZp8l/50BUUWz25Q+P0nHpjKDAj6bQ4LkWjx8
L4SgWh2vKylWhBekz4dWmyaFDZ/DL/2E2pS/tfSh+JBPaXpFjwnfrM0hhkZmkefl5/ZFM4ekMKKW
55FlYoc7c8sjXNPKVfj4JQl7FgsBuPZmhJo/3+C7MXMXSWMktIL1oAIHKbElEPGUtC5SZLRGqAGh
v3mOIKyQ6EC7AbBG7COoiBYms8hxmptrhsEMrl35ekzkvQ9jZmBENCxvjAOVL3/igMmt2Dy68o6N
OMMf2i7vAA1Gifibq0iuz6MdkSFQE5T6hLRx5t0PIgmiEB+9yyHxV3U+RaTwbUIsnckb3OTQHWgi
dvgYXPugttfL1oNHmAjcsDSDuc68lCqh+8Yxsjl33tozbzkXQg2+2LBiuDirp+XkSOEo3rq06F19
DrlkD3iJaXCKU4G0sS3dCnOxzaQ5D0YlgLI02j6bdDPHLdSfWiQNBhJ7gPyOZeQgK4W99801xWiM
gRn5flHKZEvy7q5yR6lr/6Mt8xpNkk7MIFOc/jEcK/nnoL5TkkJF5wK7wcuMl2JEKzgn6rhHA1As
uDzfDM+q2lqU3eddwFp4QkVQ2OJaJU6CkOFIIVv6iRjMlhTDkgQlk+4rk3/s4cjLtxQzXJaMw0aH
QPrjQk0vcIedgc1dMpRH+gXBw6NO98JVy8nB6y/ZILPb+0Mpfm+rljbxmvqREGb/bwdv65HUvDem
jIMs0QtcsRKSWOVEWGuOP4aX8NsMoJYnTNIb6txL39FdFbnaemRn/q/AfcMDBmsvFtKdQSRBsZhM
V3/pCNyw6/dLeykw6hUWCQl+mzVRMg4giruM5MiV6or7VJanB3g23MvSBtNyP57qX8kf2kzTcjP3
shlXjrRXe6/MlHO8D3vfhRc4jglC7+RvnViNUJwb77TmAYGB4OSh6MuBKU97Utr6xyZcbUS+M0o6
29GlTsIM7SyLRGoSBza5GPZLS52xIGdldvFxRdgmIkLT9lb8mOYiEbM7D924pDm2PXkXrJzq4YU5
jgsU1cmTmGf4RJ6pYc4Gnr+8G3tZw050NDFvBLVZSbOhAagumiF/TzKQjZx7FqG7jJRdo3Axs3EP
Eiqk5Ej9WIMiLvnfhk58J9eGLj4Qbi65f9Yy4rSt2m1n+PHk1es3N4Y4jfpT/hNPdsyqXvfHClyd
8kRojkx6vB0iny07Wa99lX/4A9zaqgTIwGWHQG/AIPnoYhWE8LPQ3zUMdZceG5FcP231grEZAowt
wBHaGsxbPIM7Wyf09BabofClqJCvToH9izQgFtqXMZcfcvJPPGzrO4catcpKDnYzQcRNRReg9ttK
qGx1ZmhnS9GPdP/OToG7jDC6IkSUTTyt5wVZ006PalWGJpJ3WOnmZ5DRn2BM6QyEHdMCSjmFwYLH
iWXJFQcVkjPMIStlBK9Lz2qJVUZzL0cDzGAEUSkQO4NhxUjtbDPKYwXHRWGNCaxDZQes4AqRwRK/
j29OCsxMAvORM3kTSjJk+9grOCsanjPdJxbAw8b4F+7L6Sjh/87iq2pHFXUbcpCFij91wLgxSw+E
k9OmwHaPOx0idJmnRV7CEFGtmPWpWQnfkMnBP+aZTM+hNLOJQ4RZCdWyiPENhyRJsk2F5TqmNLHz
o2Felbvs7jb2EOKgHQyYc+ocRliJF/ZK69WKdRmfuvDEer4U8XvnooGtDK03oKwruPFXWesHU6vK
IOWyG0biWXU2mpyP/+BHat81OgRMMXFlKJTGYDj5nQVClv6cZkxTSz8P5ql8cQ7OvTNAHpxW95IG
7OM1+Opde3cmSO6eC15jyZxGztEEMGvIGb079JRFB2bdyn+JqheNjC9ckQA/6qsB9wUJM2H2G32w
m7X144sb+lnqOllvEoDeb/9eVdQyIsYlihyfdFNNct9ULWHNuL3rogaZDF4dJH5iUpxmM7uhYBkI
7Yakn9SJ3NrWNsU3BjfIw+560T8dDEzzG0wrFO9RUn6kNEJp+1uFTOP3XsMqgd5nR9fwGPw35VrY
nvNviG6Ge41wgLyfmCxpiAppL0r4hK7/M9kJGsLbK+OWLZtr6opjqUTlkAj7Q7W6ctbgKhv9NQQ+
+xHoFJIKrmXWGw8dKnNRE95cF1YoHKrn7lCqAk5umI6v4wx5iYC0Xa/hzUXJDOSN7k0mK7Ubyc1d
cqDQ86h5KNUC0AcZVRHomox3Ue/o0Yzg+XFnI3Gp61l7is3RuTI5utxmJHFsfcMgTknvILV2LaIp
t2umwtDCOTo+74jc7yXCLFeg4KtG2nn5d+CNraFHc3Sx9JyayrCq687MIq4j3/DlWCyAoQEDJHbE
zSpcGJsZyi8gRUvVlj5fsEdihHwUjQf3kzJLYRDdc0JEoa/ekUjLeRainEFiybxaTm0EI3Ze1ibP
0zJmDBycWh2RQ1UCU3QeQxAnOeK+o9urFlwkxclGolMytuD5OTYvxAsY0ckEJM9a7TngewwOOsaS
idMtgAeCnesY7IeAojGEzi9FDtRjioBR7bL/pCiyfOqlTPZeNDiFnbes/OGSQolzFZx9+mGaDoaQ
+ofplYV6t7eYKyT2ZGFLkIteiOJnr31Vh7PX+0x5135ErvciLzBY9Zw6CoaaDSNtUaXwVN1A5o1U
XK2A9Np5kIeuUchgTzjVMnwpcs43KHM42c9XVQw1zQS6q/B3EIbqbnMKb3AC19eGwES2M9R1Lm2M
9jJBdOogDxgFJsGLpEBK9J8X8wSsMEl/0MtNaes2fQcsT/dqBNjApzcurBDm/fVzn3R4EBELCcbM
f5au5IYOB06T7WTqKTfFkdEanorhrk5tC6exh4ZVEKr5rnWmH25ci0uoFef4xKzBpZg4x1StR1GT
c+k2lhPpB12OSmyiuIfX9O3NOnl8KZ2IHldVLzV5krIglFuUxZPKHDi94fJT2NBt0oRYlfI7rOLn
mucsCRgPXzLb1nFIY3+4zMYyOTJBq5ylsTMERgoT3pl/sOlwSty8mwTiq7vB41dtcCewrCjsdxgw
NHCV2twLITfPursszGYPFWo8nUNhI03AdP+4/O/ePebzAS09pay4XJD3ftm0zXDufcD6nDp7TZe3
Wxqv/Qf7hyJ4EbZOEPi0ZIqRLbpi5JHwZrIYq6WayIEiWmO8GQ68ORo+Ke5FC+JG7XvghkrsK4+C
UZrxDeS93OGLzex84jW/hS9bwyl+L4Xk5yE+0JqTAapMLHejQvfKkQYB+S2JocrCaXi6EyzYgros
o2EQFyYzxPc9+l8y6HWcVegFksK5Ks6MQhIYIAlsuPP2VzLWraBmrDhOywSTO31S+cA3K2kr9KOi
XbJ+RwFvvtbdN7rcMMaVuTqO8UPmhBB40kZwzWN7/YT5zqTALTIUDMmiFOQN8Vhbq/vCz8Sd11y6
JSrFQJJq2rshMhuVXFLRCFQnd7w/vxx0hN9a8aAT/QUtubcN/u1PYPhPZQInMvdcaH/gE30VEaOc
WlvXh0J4V4UpCkIPQYcE2NVKhReAVMp38NTnecdnOXuOtNcv+noyl+y0aOu78U/7mxXlB5O2WtxA
CFSHNdzfwyyGaV9IEgBqrpZd6iVlVM4Fi5E83O7FK/aoRdmjoc9fYmllI+P4027kvyKpjQJTizFf
dwEtQGQquvPiXVsgc6udFU7mSVJo3oTcWKgi86kFCVE9uSorsVzyteALSqZuAUynXJ+0evu1WkCy
wxqbcBRHpJduuD1JiGGy1iNec4RNEk1wmche/C3lTjpvScAlVXA1td+zOQhMD/AiaYDCRFI485na
xz3MFJttsE8wAavqi+CfH9DTBMjWomawhkHi4AAZQ1DCJi5P5S+jlW7rqUGPLmQ2ghK+v9ctKZAz
pfOrGvfc/5RujAzSGiDtdyloUtf82CsLZpywkCMiAXlZg1yshcthg8uCZ7aRBmvSa9AcaXO310/H
TdtUJHcO/IIQB2S2Igc2x4lp3TapxnAAG9xQzhylgd4xwELY3cFTCzTDuCzHRrj0+nkGSkAmMoU6
ZnDYuTW4r5NrguiaZHjDdZTJ0iTNOIk/aoQEeSWU9BZ1vCZz3x+MSC+2TBKjxpwUyaPFMcBozmL3
GJUsXUJZL1PeTNm2HEOTzvuLAgzTqidHiK8v35KPP+A9MK+06DMJsLKR/MY3i4NXbZ4wpcZQt4hx
5JWmSl5cNhzLE+b9x01/qQd8O6WG6JwSpsV+pRxe8RzY3sng4H1KOorHgKW9cA5NPCcWA8rJ/F85
qhhy+2IGYZs7OlTRouQR9+12TTeqKJDgcoNUfO2QyVeUp6xuRL26GceuDdBo/3HJkYDMcgpkrsaJ
hEs2pmtTheFMj72r8/4iOk9SWWy5V3vmhT8CBIoCcjZEsyhJdLiLN/fTfrx68exlRe1gvOCbXU4B
i/botTwjGqZ+BHNQ1SRLOcdJsQBPDgjs73YtK5wYbFyACngu3BIKJD4CgvWZkZfEyEjHkqFnk4Lz
LaeMI0qn3WbGE9F1LmzERAzFjgq9N6EIDSNowvsfHt18DBpH3FYJVppkEXbl0uCpdlJrR6SWT6kl
4SKP8sOIiInRqclm26R3C63W+MXt3P9meY+/DJPvMsTLIUOjGjgUr2HreYrKXx7jjwtSCq2F6VDK
kBteBmcGredfsbSct3x7BO5/uZi8ujT08o4LBd1B6GfR9vVROtgL3wja6ls71mZ3efe7s2vZFchE
0GYqUUrllj07QkJhvVE8bkqxZBloOkblZs/xVjVSAlUTgKCczEMewSMWMyGIUFY8ajSq1yUdqorG
6E2dxLfNicx/U8WCop1zpouk6q4hkVDceIj6CCJWRf0b2GP+TMBtraGEvLUJ5v+3gFRlcEuF3BdI
hBewD1U75T0KG/CDvkONAd8svA6gLj6l3GLtHCmq/TJrzC1K97p2KtDRjg+hriLVcaTwHz38kJgT
gHov0nG90p7+YZHg5W2Zgh17MhhmXQfTU1WMeXxJ72695p+GASQbEGk55k4T9j3aEhnKHpScFeW2
9hRJErU2ZoxgdwHVuJookIkbKcc+8Vb+/q2jiKJwgfVDJHCGwpaRnglua11KoBcpdluf8MQ5hAaV
8LiBInD4NV1Z2RdaI1BWRkWltINdd6HLw/dq4nhf2vwMKKvzt6xoOOeFXo9lAxmup9ELO3+Idy2p
bdSnkna0DvUSltRBUpAGIdFLB93CnRE2GRyKPwDt26Y2TdFDbxFpHkKs+G6UDZtfL5JORcUhIfNh
V2pzIEEOCzTI3rXA+uTYx7QPsSgyUk1BOuf3l1Sv8oZu0RLma/CdG+9bkTb+eV3viSVZCw/cLcxo
j1d2a1yGpp4kGcEZUo4keZgqlQgASX8YZpooIDx/idcco+c9/tlLtCmT4CLrahtqaDj3g5OC5Kun
biVwxOb2fQU87+TR1nWvqUxhvUhfc0UXnvFWAgVwJEEpFQTHMyu2ET+ZU4Ssu6tCU/U5NKDkBHk5
khmYii+86uGllF4yGxPqISpompBSxBC5Q5BqOPD86snjUtwbe3CSqq+rHwyBez9Oq+UJ/RmEZR7H
7HxqVR52Oy2KuH1w7RAmMFDTbzHDKH2xpOA3BeA9ftOP0iH7sGwdy8nTe6bRCmZSbuze2e+yvaIV
smLnSn/KJcVKsi7EWDkJoDGgbBJSivlqVkTpxVl757YLtj/+/kDKAv/i5iw5nMA9/A6MXV7lvkP/
VAQ0/o3qGh9DLFJwg0TDYei4+v51xs2iXL+vH6DXmfMsz7ODhoUB/OmdrGGggOcrEYxCpIKlCzKM
0BKTXsJzy90x1zxS03K5Lyt+mznB+ws5ayIlfjxyfrl20vAdpBPjHI6WSsMzuVUYaNszMApVgJtX
yUhVqKsCLd35Grv+Axz1nsFUIkW5z41d97VE7b+wmEJM19pC9D9YRCdSLOFEi1MUv5P1XWY9cGti
FimgRi4fq82ubPOqhCs1JldDkDoBzh31vhdlkfuPS4WtURpy2FyC9Y5WrX+ULHhw1XgC3gt6x2Cv
mDzTnqjnkQoha+7Cm54rRWRBr7d9mzfczwikGBpZtI7Z9G2MmBfpkO4/H9jRg1j1+W2HPJ73XdQC
JT6rAE289Y7rLe8b2mlRpWxDPc6/AeIHSVGwY/W5R1U/Cd+zwWIeQLFZv8lJ4xwD1+okhJaodLwU
OQ9yvxTB1Eb112lL5VK+emDeojg9NsUDX+DDNltW9Lz2fV0d2HvR0vEs/SaXkN3Bl1nmpqxIOw6z
84c8EWJQtnXNZbHuBBzIR4YHAbGZ5RuoB+V/4UHcwsruVWgGTt6CU72tydwLvPUybbIWR4cZ4A2B
iE0FDgzv6SYfdW0w87CLK61GG0Y88JczFgM3icfoTLYog/6RLkh6NEy0tkJVSBT2FcAN0B/1HDiW
z4cnxdHPWZKQDekRXUyaXSrx26Bt40v0sLqkndspfiouGKMngQ7xsYoeAyMMPQ+sXtyz3ATUQQxT
8WUcCaccYS86b9uEclYk4NxR/IuBuy5ofnpn9BU0fvfFjjxVCZgr042E6/pBtMO+/+einyrX+HZ9
mdSyhSL+GDThZiDMWiShyWiqcQ6wSuK2USXiM6WGQ4na5W2fxyLNLQq4ZA4HqFiATd8zRVLbswpp
4UEIosIDYYgY26G8VcKPXwupWVs2jUn0NQ9wfUYhfYfg42cyx34V/i47GqR9SeOx4dLTWQE+v+Fv
oumdf98U4wN4eK6Tn2rWZtpu9yu6xw5cjRcA3TnlbmxlJJcYbfJdTmRYc2efDiZYqeOR4v7dd8V4
kT4gzYKDuC7iP6p3+UX5RyRX+p812dtXOxx4I+kfhwsKB4KNEvoqMvK9o4d3pJryWBJW+iP0j8rV
VDrtqP2oB6iEWMsX/BFdY4dmCW9Y3wV9xuaM3f7kKbaOeer4CvLYolpmM8cC3QF089GKHbeYfff6
oc7GyYBcoVWndsT+MTuS79a+2E0sWgRgXubCyLFRN9gaiEwyxXSWn46iarhNB5aFsJ+dBW7OSkUO
lrQK/wq5gd0+ba/gT7gbWOJ4woIE6mfw9eI9/cDyq2jvtOdIZgEY9d0o6DrOa5Mhh1jf3BEazZal
hM13AZnbR9PsCPdYILGrW2R2BVlsGK1maTW5BIp3aMpTNMonJcHKRFGdKstHfO1OBB1hsVsjBzth
KUDEq2CqMjdGZmsl0UhtFlaSNxtbh1o9ZK3CDDFNkZ6BlNN/26f/TzJX5oFfg9TFrfxi5YRP9Srb
ydMGeWP3SAHf9HHtSHwPRpptchkh+fxy14LIORKl7sF4mjD19mrNEnG5lhI0I1zCFoAZuTCiBP8s
jikm5AC7kow8vW5rUhNCKyiSciNBLMhAoqDj/yRGkZSG9P/DXa8XlTTfs9IADomD1JVYXw+8vE/V
6PCyW9NqcUbPwlQIeslYUUhU9jiDr1SeDch1T1OCCHYn/Ch55KDBV54Kuiolz4c9NuGyY72B8GnP
uJ7TtqyC1ZfPr8RiJhYAp8BzO2LliDWI5SkbwgbUEurFPtesUKjtX0sHsLujyAaZc3cTK7vmVm96
yNfZqV/N2c55AY8jaCfSxeih8arMzUWFhm+1ElnE45VFGPCNrtJ8WsB12vblDBeI639O9QwFsCR3
laH34IsGtu5lV/jjd7kw0L/9YhTS9xYHQ5QBloLwvYdYBmb4irDDXyWoqeqZU1DhNODNpAq1xTJm
s2iyn8SE3k3pLTaAvcS/P1MBgDHyxkP2V33B9cmn8kpeRqYZVLNl3B1MuovCrh4RfqGnEFYrb3Ws
X09EyTKYWQxl64eLZZvUeqsONqv9qSMNUyaMtTm0d4AxqWHwkd3fPVkcIOWuF8BPV2oRhu1kj6t6
XF+7wCg6qU+1+5CTsjsSf+DBsCTAIN1yUv4tF/0xhotAjCZ2KY9/Bn9irxu1qT1jyhiBhp2MytqT
RGZ83tjuBUEGeueX8WjdLxNhqMLvPqr+lo/o2TfNtVFk2QgALPGzOVOsQF/yRAs+z1xEcBHWefzL
paNiTFWjUMAo4Pz+SlwRW6euArjAfyRUpdboh+ZxtWbLLn4FqbmoZp7orMnl1OyzPqsa5L/yQUAl
m6VCUIbGz2kPsXMmU+YnV04w2IvVxfsQsMOnOoW0pqYzsZfxuzsOosvNh+N4q6pSP1XnIIL/19wt
fbbgLvi/DhEJIrskNBbce/3Z/kXBmpk42c02XS+gZKH9TE5j152/0/9pTEz/kW4oGriMieuhGCrQ
QDC51sl2dWfts2YXLK3zsmQvVOREZp0/leVTA0/xyv9exnPbpLmWOlXwKNA208mRe5kMjJ6WypW4
PECBX5J3qAzvlhbz9rhap6Hd7aoBlA+2980aIhCtqpFJBw/FEwDDOk7KLQPLK79PovMW4aTF3STg
6ZlOMxTaL1ZbvPtG+FDr+MfrWRtjbvAD6XjbNj7fgzSZlpB+L9QWGZVGh+DW8LhSGk+uN+8mqU8W
ODEOXzEzpFEKpeszut9FeDXIQ6f4bSg01vUbzKboku97M7Yg2EwFOYoL2DIaI+201aykLNHh2LiK
R0uZ2nc1W+4fWi++zXA/eGOdboe9webNRBnsnOHRlsTJglY57gCXE3jYABRfJneO0rc3WQDOATle
y2UG2EnI0A2zcrNLswcgQF9/P6Y3dUcHbovSyvxArQWQt3XyS3ypfzGF7oAOm44F6NFQVC9Fp2Gh
WR3+5GUtoAOgq2Fk66GhjOhnzcXJ38RjMpyYMD5l9gEzR/ibo3YyV9O7uVKl/BaW3enNOcBSX1R2
dWAUz7mDwb3DtAbB1pq84OK9Hgz7xhIAWgk6tNdK5fywrijNoiv8tug9s9u8Ucv1wgTjOBlbE7/M
Ow+Vt67stVWDC5FjreXr07zlWKMp/w0uBOMXXzgPdUenavu3WSx3btPypvEjHwPYAKCPTUnvan8L
DFNRCiQt9kL5bv/fgYrLApMZB+rgGeWdwQWRvxX78PmDDPjEggx2CMyBBnMyIGqee+MeM8jlw8QQ
rA5gzw40sF1OCNhF3kEX7bHiX/bYjUaH8syf9l5KxwNl5cv1wxDsR5kRyyNH7LbcbuZ+T992x9ac
yqqC230WyK6E7dey7H2YdHlbkWsuhaovZwTfSrJ6vG0jVH981SLknO5VD4Y2WjLmP5hKf5G0mJ7Z
XWcfmYiMyQsI5dGfKuDUgGhWCFEg6S2tnrzc1ee6MKO05yQAgw9P1Qgc8WiEIFTghOjhcjbpB8YK
Wnl91cRVU7sltIbggzer3PYFJtdVyyMWaHrXJAOCzTnXW1ij7P3yyX0f28kcW7pLVRTX7fGY2Ojf
W8qEGyYqjHKRyKEapIywBsVhsLe6cJXRxSrbv3JlVNOpKFynWxp0psRK/66evjS2ukCvA1eihCOX
Oj4BBBOJYMsbq/HMICahj+yMKqCgKIfAUVD6Z6AGWLL+nXf16jXmqXnphFzoei8dFPwGURNG27hM
ytSDF+N+j69YVUwqdLSu/qgZvzmTgBm/vQb93BkKfly15MO8UdnqhIkzsiQrnN/dUWzmnO4RWP/M
tmwc2ljehnkxmzHgXHIJWBuvCutAKU4kj5yQ7bs4zB/46Y2Q3vbYY+oxVQmlaPfAyFoJ7KS7NcQl
/7fOVfa8U99W5F3qPCbVj9/VUGkcKoXbrrm9irMgyLvjfBUUF4xjZpwcbHvTchgLOSYgajP6d62n
Emo51Oehb5gUnD2fuyMjotj98w3l4ACl4lpiqJrNLm7x/ftacmoIcs9PiNclr05aIFmR5pGUu4ym
qHAvYSFIrfXnIhIfQ5sQf2QHLNkm+tTZwY/th8LM9y1HLiIWWqCk8t8sLjom8f6gcT3PG7u326Nk
aY8VQMGdP4UBDGSdN4sexvMO36Q+kqBv6x+dyn8tIYhWeD2qO3bEAkUqWQjjdPbPR9u93H8p4Pth
CsJL8VF4yYihJnX0Nbl4gO77PgUzM0Vy6bjePRag7/jpgfShLq+lIlZr6QCSxoC6qJOFHYtRpx5d
koSPbm/JIp6OLD9LEpksfCrofn2PvdsEL198/ZPhKUUiE3bGyl8avWy4YZ46GHE5oFLa6NwWBm9i
ltB645f65d1N1Anuqvrh1nOMxmGvK5BnrgKXywSx5GxysP9h/Zs2VONjPG0vXI38LBnXDy5aPO8v
RuIjie7Z+jWdRGdznFqpcCo/EZYrtIVreJROGOH4/AkCrDIt2Wr8JQRYfrwXaT9GmzgnYYLZFgLo
Y1L66tHXWyDFIZNftS3mVyu3Ia/+rlfyxwAdYTCoiPxSCyLPByvaIA65Haog5yIBlTevp6syioZw
zvrlS2AqYOWDuo+K7BNMOxGWpjysBi3+33gjzyM1hLASosA812f0hKLMq4rYP8pGIGcK/2C9gv/C
dOMoA7cnA9WTNhLtk5ISzssAAtT88nd8J6W2lGjNPaUA/kScXD74lky9cNJFiZgWizos2PjB827f
e2k3KNBH4OQ0cwiGf5YlrfzMBDQRT8C4yj83NRTFYoQ+Iml0tGD/EtSSY1A1XtxNilhQ7cy83cva
/w6sCouPNx3Jlaa4MJKBaU7jTltdj5JcyWyQu+qLFseMgbj6XaPl2qd91PzsbX4tRUV0u9WZ815S
MNHMoekuK1L9t+6U6iyzRYaiLcyx3fKb5RrUiY0qj0ziWEkOj8+eDotg9Al8BHFWx0UDhgTgLa3o
vg34ZYXiZcOp/TheSxTUYLYIeTga6xwOfRRRLiu4lCSnDZ9fKht2jfxtK8wwi6e3ApKMrVgVeJDD
eilR04wAqUAY2SQ2Ch6KtMPdhw5SnH40kz6U+PPnTK9fXODRdOTjd4mBMsTbGVPs90GZHmo0geBI
A1u6D+tUukCMEjIq8jjW2MVol1Gk8pJvLHnlYIkXlge75kJXbQTdLD7fP+8dGlBIsIZdGPeU09iZ
Kl+CkxPuSVk0wJWD4vkS7sLGxe7UZEO6qyWk1vf7OruefRHNIRSvCsAiburUlP40jKz3GIre8zME
LAQihApC8yBdH9rcCULw5C4ZigPIK8wQiuSx/pT8cS2X8XQ4uLPVh6EcozP6dpIAU1n7IGhOC220
cpPBD6Mw1vqdIkIB+wCgf7fct7588fF3Erzf3vmF/LpzPTh1YBUPmhljhpHHE9+MkaEy2tC0kwsn
2f9PtMIoNZE1wCCUfW15hc3C60URaQJ0oL8uLMh1ye2k2ND2F6qKk5+gwq+6Rc0eoDEPCfLc/RLx
LJ2txky9JOVLHs/Ag+ic8zwjHnPKxt15pUulKP92GV96VXpaRZ5SKCzxehC2eWccN1LwShsMnf0R
IHRDQbKEjJRJbuBGqamHAi9Ry5vms22hmrV9iyCH+9VmEjub95p75TrS14HY+xhWzfmU6cJu55Pe
zySdxJ7FPHtv5Y+qd0IGMT2VRZ3doAY6aXsfDYlflr4CJmaKkTltAOF4nuDsPnvKHKuMtakXegho
xq67Gp2wOZA1z9pHnBttZeiHN12Zx4habJJKMTTcsHEWUxXsCpVezEENYWmL5MX7PWrSJFyJ5UjZ
HasIG6OwkD7TBcTegfo0i4f9L17P7j8VAVBv2NwuVzDm+IY8Mb/nvlSwVEnGFj5UIupZdQ==
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
