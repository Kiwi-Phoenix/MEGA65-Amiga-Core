// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2.1 (win64) Build 5266912 Sun Dec 15 09:03:24 MST 2024
// Date        : Sat Mar  1 15:23:44 2025
// Host        : Retro-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Retro/Mega65/FPGA_Projects/MEGA65-Amiga-Core-Test/CORE/CORE-R6.gen/sources_1/ip/dtram/dtram_sim_netlist.v
// Design      : dtram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dtram,blk_mem_gen_v8_4_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_10,Vivado 2024.2.1" *) 
(* NotValidForBitStream *)
module dtram
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [39:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [39:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_mode = "slave BRAM_PORTB" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [7:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [39:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [39:0]doutb;

  wire [7:0]addra;
  wire [7:0]addrb;
  wire clka;
  wire clkb;
  wire [39:0]dina;
  wire [39:0]dinb;
  wire [39:0]douta;
  wire [39:0]doutb;
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
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [39:0]NLW_U0_s_axi_rdata_UNCONNECTED;
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
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     8.6716 mW" *) 
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
  (* C_INIT_FILE = "dtram.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "256" *) 
  (* C_READ_DEPTH_B = "256" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "40" *) 
  (* C_READ_WIDTH_B = "40" *) 
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
  (* C_WRITE_WIDTH_A = "40" *) 
  (* C_WRITE_WIDTH_B = "40" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  dtram_blk_mem_gen_v8_4_10 U0
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
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[39:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 41760)
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
