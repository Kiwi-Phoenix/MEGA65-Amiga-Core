// Wrapper for the minimig_m68k_bridge module.
// Wrapper required so that it can be instantated within a VHDL architecture.
// Some of the port names in in the verilog module start with an underscore (_) character which is not permitted in VHDL.
// The wrapper will rename these ports with an "x" prefix.
//
// 27th July 2025    David Raynor (Kiwi)
//

module minimig_m68k_bridge_wrapper (
     input	             clk                // 28 MHz system clock
	,input               clk7_en
	,input               clk7n_en
	,input	             c1                 // clock enable signal
	,input	             c3                 // clock enable signal
	,input  [9:0]        eclk               // ECLK enable signal
	,input	             vpa                // valid peripheral address (CIAs)
	,input	             dbr                // data bus request, Gary keeps CPU off the bus (custom chips transfer data)
	,input	             dbs                // data bus slowdown (access to chip ram or custom registers)
	,input	             xbs                // cross bridge access (active dbr holds off CPU access)
	,input               nrdy               // target device is not ready
	,output              bls                // blitter slowdown, tells the blitter that CPU wants the bus
	,input	             cck                // colour clock enable, active when dma can access the memory bus
	,input  [3:0]        memory_config      // system memory config
	,input	             x_as               // m68k address strobe
	,input	             x_lds              // m68k lower data strobe d0-d7
	,input	             x_uds              // m68k upper data strobe d8-d15
	,input	             r_w                // m68k read / write
	,output              x_dtack            // m68k data acknowledge to cpu
	,output              rd                 // bus read 
	,output              hwr                // bus high write
	,output              lwr                // bus low write
	,input  [23:1]       address            // external cpu address bus
	,output [23:1]       address_out        // internal cpu address bus output
	,output [15:0]       data               // external cpu data bus
	,input  [15:0]       cpudatain
	,output [15:0]       data_out           // internal data bus output
	,input  [15:0]       data_in            // internal data bus input
	,output              rd_cyc             // early rd signal can be used to delay DTACK

	// UserIO interface
	,input                x_cpu_reset
	,input                cpu_halt
	,input                host_cs
	,input  [23:1]        host_adr
	,input                host_we
	,input  [1:0]         host_bs
	,input  [15:0]        host_wdat
	,output [15:0]        host_rdat
	,output               host_ack
);

//instantiate cpu bridge
minimig_m68k_bridge m68k_bridge
(
	 .clk                   (clk)
	,.clk7_en               (clk7_en)
	,.clk7n_en              (clk7n_en)
	,.c1                    (c1)
	,.c3                    (c3)
	,.cck                   (cck)
	,.eclk                  (eclk)
	,.vpa                   (vpa)
	,.dbr                   (dbr)
	,.dbs                   (dbs)
	,.xbs                   (xbs)
	,.nrdy                  (nrdy)
	,.bls                   (bls)
	,.memory_config         (memory_config)
	,._as                   (x_as)
	,._lds                  (x_lds)
	,._uds                  (x_uds)
	,.r_w                   (r_w)
	,._dtack                (x_dtack)
	,.rd                    (rd)
	,.rd_cyc                (rd_cyc)
	,.hwr                   (cpu_hwr)
	,.lwr                   (lwr)
	,.address               (address)
	,.address_out           (address_out)
	,.cpudatain             (cpudatain)
	,.data                  (data)
	,.data_out              (data_out)
	,.data_in               (data_in)
	,._cpu_reset            (x_cpu_reset)
	,.cpu_halt              (cpu_halt)
	,.host_cs               (host_cs)
	,.host_adr              (host_adr)
	,.host_we               (host_we)
	,.host_bs               (host_bs)
	,.host_wdat             (host_wdat)
	,.host_rdat             (host_rdat)
	,.host_ack              (host_ack)
);


endmodule
