// Wrapper for the Agnus module.
// Wrapper required so that it can be instantated within a VHDL architecture.
// Some of the port names in in the verilog module start with an underscore (_) character which is not permitted in VHDL.
// The wrapper will rename these ports with an "x" prefix.
//
// July 2025    David Raynor (Kiwi)
//

module agnus_wrapper
(
	 input             clk             // clock
	,input             clk7_en         
	,input             cck             // colour clock enable, active whenever hpos[0] is high (odd dma slots used by chipset)
	,input             reset           // reset
	,input             aen             // bus adress enable (register bank)
	,input             rd              // bus read
	,input             hwr             // bus high write
	,input             lwr             // bus low write
	,input  [15:0]     data_in         // data bus in
	,output [15:0]     data_out        // data bus out
	,input  [8:1]      address_in      // 256 words (512 bytes) adress input,
	,output [20:1]     address_out     // chip address output,
	,output [8:1]      reg_address_out // 256 words (512 bytes) register address out,
	,output            cpu_custom      // CPU has access to custom chipset (registers and chipRAM / slowRAM)
	,output            dbr             // agnus requests data bus
	,output            dbwe            // agnus does a memory write cycle (only disk and blitter dma channels may do this)
	,output            x_hsync         // horizontal sync
	,output            x_vsync         // vertical sync
	,output            x_csync         // composite sync
	,output            field1
	,output            lace
	,output            hblank          // video blanking
	,output            vblank          // video blanking
	,output            hde             // video horizontal data enable
	,output            sol             // start of video line (active during last pixel of previous line)
	,output            sof             // start of video frame (active during last pixel of previous frame)
	,output            vbl_int         // vertical blanking interrupt request for Paula
	,output            strhor_denise   // horizontal strobe for Denise (due to not cycle exact implementation of Denise it must be delayed by one CCK)
	,output            strhor_paula    // horizontal strobe for Paula
	,output [8:0]      htotal          // video line length
	,output            harddis
	,output            varbeamen
	,output            int3            // blitter finished interrupt (to Paula)
	,input  [3:0]      audio_dmal      // audio dma data transfer request (from Paula)
	,input  [3:0]      audio_dmas      // audio dma location pointer restart (from Paula)
	,input             disk_dmal       // disk dma data transfer request (from Paula)
	,input             disk_dmas       // disk dma special request (from Paula)
	,input             bls             // blitter slowdown
	,input             ntsc            // chip is NTSC
	,input             a1k             // enable A1000 OCS features
	,input             ecs             // enable ECS features
	,input             aga             // enables AGA features
	,input             floppy_speed    // allocates refresh slots for disk DMA
);
 
 //instantiate agnus
agnus
(
	 .clk               (clk)
	,.clk7_en           (clk7_en)
	,.cck               (cck)
	,.reset             (reset)
	,.aen               (aen)
	,.rd                (rd)
	,.hwr               (hwr)
	,.lwr               (lwr)
	,.data_in           (data_in)
	,.data_out          (data_out)
	,.address_in        (address_in)
	,.address_out       (address_out)
	,.reg_address_out   (reg_address_out)
	,.cpu_custom        (cpu_custom)
	,.dbr               (dbr)
	,.dbwe              (dbwe)
	,._hsync            (x_hsync)
	,._vsync            (x_vsync)
	,._csync            (x_csync)
	,.hde               (hde)
	,.field1            (field1)
	,.lace              (lace)
	,.hblank            (hblank)
	,.vblank            (vblank)
	,.sol               (sol)
	,.sof               (sof)
	,.vbl_int           (vbl_int)
	,.strhor_denise     (strhor_denise)
	,.strhor_paula      (strhor_paula)
	,.htotal            (htotal)
	,.harddis           (harddis)
	,.varbeamen         (varbeamen)
	,.int3              (int3)
	,.audio_dmal        (audio_dmal)
	,.audio_dmas        (audio_dmas)
	,.disk_dmal         (disk_dmal)
	,.disk_dmas         (disk_dmas)
	,.bls               (bls)
	,.ntsc              (ntsc)
	,.a1k               (a1k)
	,.ecs               (ecs)
	,.aga               (aga)
	,.floppy_speed      (floppy_speed)
);
 
endmodule
 