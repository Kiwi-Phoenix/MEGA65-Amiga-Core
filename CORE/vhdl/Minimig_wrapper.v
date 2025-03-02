//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: David Raynor (Kiwi) 
// 
// Create Date: 22.01.2025 20:02:23
// Design Name: 
// Module Name: Minimig_wrapper
// Project Name: Mega 65 Amiga Core
// Target Devices: 
// Tool Versions: 
// Description: 
// Wrapper for minimig.v file so that it can be referenced using VHDL.
// The minimig.v defines somes port names starting with an underscore, a naming convention that cannot be used in VHDL.
// To preserve the originial MiSTer minimig code base, a wrapper is used to effectively rename / map valid port names. 
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Minimig_wrapper(

//m68k pins
	input  [23:1] cpu_address,      // m68k address bus
	output [15:0] cpu_data,         // m68k data bus
	input  [15:0] cpudata_in,       // m68k data in
	output  [2:0] ami_cpu_ipl,      // m68k interrupt request
	input 	      ami_cpu_as,       // m68k address strobe
	input 	      ami_cpu_uds,      // m68k upper data strobe
	input 	      ami_cpu_lds,      // m68k lower data strobe
	input 	      cpu_r_w,          // m68k read / write
	output 	      ami_cpu_dtack,    // m68k data acknowledge
	output 	      ami_cpu_reset,    // m68k reset
	input 	      ami_cpu_reset_in, // m68k reset in
	input  [31:0] nmi_addr,         // m68k NMI address
	output 	      ovr,              // NMI address decoding override

	//sram pins
	output [15:0] ram_data,         // sram data bus
	input  [15:0] ramdata_in,       // sram data bus in
	output [23:1] ram_address,      // sram address bus
	output 	      ami_ram_bhe,      // sram upper byte select
	output 	      ami_ram_ble,      // sram lower byte select
	output 	      ami_ram_we,       // sram write enable
	output 	      ami_ram_oe,       // sram output enable
	input  [47:0] chip48,           // big chipram read

	//system	pins
	input 	      rst_ext,          // reset from ctrl block
	output 	      rst_out,          // minimig reset status
	input 	      clk,              // 28.37516 MHz clock
	input 	      clk7_en,          // 7MHz clock enable
	input 	      clk7n_en,         // 7MHz negedge clock enable
	input 	      c1,               // clock enable signal
	input 	      c3,               // clock enable signal
	input 	      cck,              // colour clock enable
	input   [9:0] eclk,             // ECLK enable (1/10th of CLK)

	//rs232 pins
	input 	      rxd,              // rs232 receive
	output 	      txd,              // rs232 send
	input 	      cts,              // rs232 clear to send
	output 	      rts,              // rs232 request to send
	output 	      dtr,              // rs232 Data Terminal Ready
	input 	      dsr,              // rs232 Data Set Ready
	input 	      cd,               // rs232 Carrier Detect
	input 	      ri,               // rs232 Ring Indicator

	//I/O
	input  [15:0] ami_joy1,         // joystick 1 [fire2,fire,up,down,left,right] (default mouse port)
	input  [15:0] ami_joy2,         // joystick 2 [fire2,fire,up,down,left,right] (default joystick port)
	input  [15:0] ami_joy3,         // joystick 3 [fire2,fire,up,down,left,right]
	input  [15:0] ami_joy4,         // joystick 4 [fire2,fire,up,down,left,right]
	input  [15:0] joya1,
	input  [15:0] joya2,
	input   [2:0] mouse_btn,        // mouse buttons
	input 	      kms_level,
	input   [1:0] kbd_mouse_type,
	input   [7:0] kbd_mouse_data,
	output 	      pwr_led,         // power led
	output 	      fdd_led,         // disk activity LED, active when DMA is on
	output 	      hdd_led,
	input  [64:0] rtc,

	//host controller interface (SPI)
	input 	      IO_UIO,
	input 	      IO_FPGA,
	input 	      IO_STROBE,
	output 	      IO_WAIT,
	input  [15:0] IO_DIN,
	output [15:0] IO_DOUT,

	//video
	output 	      ami_hsync,      // horizontal sync
	output 	      ami_vsync,      // vertical sync
	output 	      ami_csync,      // composite sync
	output 	      field1,
	output        lace,
	output 	      hblank,
	output 	      vblank,
	output  [7:0] red,
	output  [7:0] green,
	output  [7:0] blue,
	output  [1:0] ar,
	output  [2:0] scanline,
	output 	      ce_pix,
	output  [1:0] res,
//	output reg    ntsc,
    output        ntsc,


	//audio
	output [14:0] ldata,       // left DAC data
	output [14:0] rdata,       // right DAC data
	output [8:0]  ldata_okk,   // left DAC data  (PWM volume)
	output [8:0]  rdata_okk,   // right DAC data (PWM volume)
	output  [1:0] aud_mix,

	// Toccata audio
	input         toccata_ena,
	input   [7:0] toccata_base,
	output [15:0] toccata_aud_left,
	output [15:0] toccata_aud_right,

	//user i/o
	output  [1:0] cpucfg,
	output  [2:0] cachecfg,
	output  [6:0] memcfg,
	output        bootrom,     // enable bootrom magic in gary.v
	output        ide_ena,

	output        ide_fast,
	input         ide_ext_irq,
	output  [5:0] ide_req,
	input   [4:0] ide_address,
	input         ide_write,
	input  [15:0] ide_writedata,
	input         ide_read,
	output [15:0] ide_readdata

    );
    
minimig minimig
(
// Inputs
        .cpu_address(cpu_address),
        .cpudata_in(cpudata_in),
        ._cpu_as(ami_cpu_as),
        ._cpu_uds(ami_cpu_uds),
        ._cpu_lds(ami_cpu_lds),
        .cpu_r_w(cpu_r_w),
        ._cpu_reset_in(ami_cpu_reset_in),
        .nmi_addr(nmi_addr),
        .ramdata_in(ramdata_in),
        .chip48(chip48),
        .rst_ext(rst_ext),
        .clk(clk),
        .clk7_en(clk7_en),
        .clk7n_en(clk7n_en),
        .c1(c1),
        .c3(c3),
        .cck(cck),
        .eclk(eclk),
        .rxd(rxd),
        .cts(cts),
        .dsr(dsr),
        .cd(cd),
        .ri(ri),
        ._joy1(ami_joy1),
        ._joy2(ami_joy2),
        ._joy3(ami_joy3),
        ._joy4(ami_joy4),
        .joya1(joya1),
        .joya2(joya2),
        .mouse_btn(mouse_btn),
        .kms_level(kms_level),
        .kbd_mouse_type(kbd_mouse_type),
        .kbd_mouse_data(kbd_mouse_data),
        .rtc(rtc),
        .IO_UIO(IO_UIO),
        .IO_FPGA(IO_FPGA),
        .IO_STROBE(IO_STROBE),
        .IO_DIN(IO_DIN),
        .toccata_ena(toccata_ena),
        .toccata_base(toccata_base),
        .ide_ext_irq(ide_ext_irq),
        .ide_address(ide_address),
        .ide_write(ide_write),
        .ide_writedata(ide_writedata),
        .ide_read(ide_read),
// Outputs
        .cpu_data(cpu_data),
        ._cpu_ipl(ami_cpu_ipl),
        ._cpu_dtack(ami_cpu_dtack),
        ._cpu_reset(ami_cpu_reset),
        .ovr(ovr),
        .ram_data(ram_data),
        .ram_address(ram_address),
        ._ram_bhe(ami_ram_bhe),
        ._ram_ble(ami_ram_ble),
        ._ram_we(ami_ram_we),
        ._ram_oe(ami_ram_oe),
        .rst_out(rst_out),
        .txd(txd),
        .rts(rts),
        .dtr(dtr),
        .pwr_led(pwr_led),
        .fdd_led(fdd_led),
        .hdd_led(hdd_led),
        .IO_WAIT(IO_WAIT),
        .IO_DOUT(IO_DOUT),
        ._hsync(ami_hsync),
        ._vsync(ami_vsync),
        .field1(field1),
        .lace(lace),
        .hblank(hblank),
        .vblank(vblank),
        .red(red),
        .green(green),
        .blue(blue),
        .ar(ar),
        .scanline(scanline),
        .ce_pix(ce_pix),
        .res(res),
        .ntsc(ntsc),
        .ldata(ldata),
        .rdata(rdata),
        .aud_mix(aud_mix),
        .toccata_aud_left(toccata_aud_left),
        .toccata_aud_right(toccata_aud_right),
        .cpucfg(cpucfg),
        .cachecfg(cachecfg),
        .memcfg(memcfg),
        .bootrom(bootrom),
        .ide_ena(ide_ena),
        .ide_fast(ide_fast),
        .ide_req(ide_req),
        .ide_readdata(ide_readdata)             
);            
    
endmodule
