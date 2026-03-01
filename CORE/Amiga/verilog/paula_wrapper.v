// Wrapper for the Paula module.
// Wrapper required so that it can be instantated within a VHDL architecture.
// Some of the port names in in the verilog module start with an underscore (_) character which is not permitted in VHDL.
// The wrapper will rename these ports with an "x" prefix.
//
// July 2025    David Raynor (Kiwi)
//

module paula_wrapper (
// system bus interface
	 input                  clk                     // 28 MHz system clock
	,input                  clk7_en
	,input                  clk7n_en
	,input                  cck		    		    //colour clock enable
	,input                  reset			   		//reset 
	,input  [8:1]           reg_address_in	        //register address inputs
	,input  [15:0]          data_in			        //bus data in
	,output [15:0]          data_out		        //bus data out
	//serial (uart) 
	,output                 txd					    //serial port transmitted data
	,input                  rxd			  		    //serial port received data
	//interrupts and dma
	,input                  ntsc                    // PAL/NTSC mode
	,input                  sof                     // start of vertical frame
	,input                  strhor					//start of video line (latches audio DMA requests)
	,input                  vblint                  // vertical blanking interrupt trigger
	,input                  int2					//level 2 interrupt
	,input                  int3					//level 3 interrupt
	,input                  int6					//level 6 interrupt
	,output  [2:0]          x_ipl				    //m68k interrupt request
	,output  [3:0]          audio_dmal		        //audio dma data transfer request (to Agnus)
	,output  [3:0]          audio_dmas		        //audio dma location pointer restart (to Agnus)
	,output                 disk_dmal				//disk dma data transfer request (to Agnus)
	,output                 disk_dmas				//disk dma special request (to Agnus)
	//disk control signals from cia and user
	,input                  x_step					//step heads of disk
	,input                  direc					//step heads direction
	,input  [3:0]           x_sel			       	//disk select 	
	,input	                side					//upper/lower disk head
	,input	                x_motor					//disk motor control
	,output                 x_track0				//track zero detect
	,output                 x_change				//disk has been removed from drive
	,output                 x_ready					//disk is ready
	,output                 x_wprot					//disk is write-protected
	,output                 index                   // disk index pulse
	,output                 fdd_led				    //disk activity LED, active when DMA is on
	//flash drive host controller interface	(SPI)
	,input                  IO_ENA
	,input                  IO_STROBE
	,output                 IO_WAIT
	,input  [15:0]          IO_DIN
	,output [15:0]          IO_DOUT
	//audio outputs
	,output [14:0]          ldata			       //left DAC data
	,output [14:0]          rdata 		           //right DAC data
	,output [8:0]           ldata_okk		       //left DAC data (PWM volume)
	,output [8:0]           rdata_okk 	           //right DAC data (PWM volume)
	// system configuration
	,input  [1:0]           floppy_drives	       //number of extra floppy drives
	// fifo / track display
	,output  [7:0]          trackdisp
	,output [13:0]          secdisp
	,output                 floppy_fwr
	,output                 floppy_frd    
);

//instantiate paula
paula
(
	 .clk                           (clk)
	,.clk7_en                       (clk7_en)
	,.clk7n_en                      (clk7n_en)
	,.cck                           (cck)
	,.reset                         (reset)
	,.reg_address_in                (reg_address_in)
	,.data_in                       (data_in)
	,.data_out                      (data_out)
	,.txd                           (txd)
	,.rxd                           (rxd)
	,.ntsc                          (ntsc)
	,.sof                           (sof)
	,.strhor                        (strhor)
	,.vblint                        (vblint)
	,.int2                          (int2)
	,.int3                          (int3)
	,.int6                          (int6)
	,._ipl                          (x_ipl)
	,.audio_dmal                    (audio_dmal)
	,.audio_dmas                    (audio_dmas)
	,.disk_dmal                     (disk_dmal)
	,.disk_dmas                     (disk_dmas)
	,._step                         (x_step)
	,.direc                         (direc)
	,._sel                          (x_sel)
	,.side                          (side)
	,._motor                        (x_motor)
	,._track0                       (x_track0)
	,._change                       (x_change)
	,._ready                        (x_ready)
	,._wprot                        (x_wprot)
	,.index                         (index)
	,.fdd_led                       (fdd_led)
	,.IO_ENA                        (IO_ENA)
	,.IO_STROBE                     (IO_STROBE)
	,.IO_WAIT                       (IO_WAIT)
	,.IO_DIN                        (IO_DIN)
	,.IO_DOUT                       (IO_DOUT)
	,.ldata                         (ldata)
	,.rdata                         (rdata)
	,.ldata_okk                     (ldata_okk)
	,.rdata_okk                     (rdata_okk)
	,.floppy_drives                 (floppy_drives)
	,.trackdisp                     (trackdisp)
	,.secdisp                       (secdisp)
	,.floppy_fwr                    (floppy_fwr)
	,.floppy_frd                    (floppy_frd)
);

endmodule
