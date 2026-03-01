// Wrapper for the minimig_sram_bridge module.
// Wrapper required so that it can be instantated within a VHDL architecture.
// Some of the port names in in the verilog module start with an underscore (_) character which is not permitted in VHDL.
// The wrapper will rename these ports with an "x" prefix.
//
// 27th July 2025    David Raynor (Kiwi)
//

module minimig_sram_bridge_wrapper (
	//clocks
//   input         clk			// 28 MHz system clock
//	,input         c1		    // clock enable signal
//	,input         c3			// clock enable signal	

	//chipset internal port
	 input  [7:0] bank			// memory bank select (512KB)
	,input  [23:1] address_in	// bus address
	,input  [15:0] data_in		// bus data in
	,output [15:0] data_out	    // bus data out
	,input         rd			// bus read
	,input         hwr			// bus high byte write
	,input         lwr			// bus low byte write

	//RAM external signals
	,output        x_bhe		// sram upper byte
	,output        x_ble      	// sram lower byte
	,output        x_we    	    // sram write enable
	,output        x_oe    		// sram output enable
	,output [22:1] address		// sram address bus
	,output [15:0] data    	  	// sram data das
	,input  [15:0] ramdata_in	// sram data das in
);

//instantiate sram bridge
minimig_sram_bridge
(
//	 .clk                   (clk)
//	,.c1                    (c1)
//	,.c3                    (c3)	
	 .bank                  (bank)
	,.address_in            (address_in)
	,.data_in               (data_in)
	,.data_out              (data_out)
	,.rd                    (rd)
	,.hwr                   (hwr)
	,.lwr                   (lwr)
	,._bhe                  (x_bhe)
	,._ble                  (x_ble)
	,._we                   (x_we)
	,._oe                   (x_oe)
	,.address               (address)
	,.data                  (data)
	,.ramdata_in            (ramdata_in)	
);

endmodule
