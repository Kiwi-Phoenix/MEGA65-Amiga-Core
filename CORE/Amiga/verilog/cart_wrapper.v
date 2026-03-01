// Wrapper for the cart module.
// Wrapper required so that it can be instantated within a VHDL architecture.
// Some of the port names in in the verilog module start with an underscore (_) character which is not permitted in VHDL.
// The wrapper will rename these ports with an "x" prefix.
//
// 27th July 2025    David Raynor (Kiwi)
//


module cart_wrapper (
	 input         clk
	,input         clk7_en
	,input         clk7n_en
	,input         cpu_rst
	,input  [23:1] cpu_address_in
	,input         x_cpu_as
	,input         cpu_rd
	,input         cpu_hwr
	,input         cpu_lwr
	,input  [31:0] nmi_addr
	,input   [8:1] reg_address_in
	,input  [15:0] reg_data_in
	,input         dbr
	,input         ovl
	,input         freeze 
	,input         cpuhlt
	,output [15:0] cart_data_out
	,output        int7
	,output        sel_cart
	,output        ovr    
);


cart
(
   .clk                      (clk)
  ,.clk7_en                  (clk7_en)
  ,.clk7n_en                 (clk7n_en)
  ,.cpu_rst                  (cpu_rst)
  ,.cpu_address_in           (cpu_address_in)
  ,._cpu_as                  (x_cpu_as)
  ,.cpu_rd                   (cpu_rd)
  ,.cpu_hwr                  (cpu_hwr)
  ,.cpu_lwr                  (cpu_lwr)
  ,.nmi_addr                 (nmi_addr)
  ,.reg_address_in           (reg_address_in)
  ,.reg_data_in              (reg_data_in)
  ,.dbr                      (dbr)
  ,.ovl                      (ovl)
  ,.freeze                   (freeze)
  ,.cart_data_out            (cart_data_out)
  ,.int7                     (int7)
  ,.sel_cart                 (sel_cart)
  ,.ovr                      (ovr)
  ,.cpuhlt                   (cpuhlt)
);


endmodule
