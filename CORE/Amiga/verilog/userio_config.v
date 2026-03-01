// Port of the MiniMMig Userio CONFIG always block / logic.
// Putting this in its own module.
// Break down the overall userio module into smaller managable "chunks".
//
// Some Notes:
// IO_WAIT is on required for sending memory config select data, i.e. loading up the ROM data to memory.
// For all other commands, the IO_WAIT can mostly be ignored.
// IO_ENA and IO_STROBE are used to hold and pulse the config data.
//
// July 2025    David Raynor (Kiwi)
//
module userio_config (
        input               clk
       ,input               clk7_en
       ,input               reset
       ,input               IO_ENA
       ,input               IO_STROBE
       ,output reg          IO_WAIT
       ,input [15:0]        IO_DIN
       ,input               host_ack       
       ,output reg [23:0]   host_adr
       ,output reg [15:0]   host_wdat       
       ,output reg          bootrom
       ,output reg          host_cs
       ,output reg          host_we
       ,output reg [7:0]    memory_config
       ,output reg [4:0]    chipset_config
       ,output reg [5:0]    ide_config
       ,output reg [1:0]    cpu_config
       ,output reg [2:0]    cache_config 
	   ,output reg          usrrst
	   ,output reg          cpurst
	   ,output reg          cpuhlt       
	   ,output reg  [2:0]   scanline
	   ,output reg  [1:0]   ar
	   ,output reg  [1:0]   blver
	   ,output reg  [3:0]   floppy_config	   	   
	   ,output reg          cd32pad
       ,output reg          joy_swap
       ,output reg          joy_ana_en
	   ,output reg  [1:0]   aud_mix       
       
       
);

	reg       has_cmd;
	reg       mrx;
	reg       btoggle;
	reg       old_ack;
	reg [2:0] bcnt;
	reg       bootrom_r;


assign host_bs = 2'b11;

reg [7:0] t_memory_config = 8'b0_0_00_01_01;
reg [5:0] t_ide_config = 0;
reg [4:0] t_cpu_config = 0;
reg [4:0] t_chipset_config = 0;

// configuration changes only while reset is active
//	reg [5:0] ide_cfg = 0;
//	reg [1:0] cpu_cfg = 0;
always @(posedge clk) begin : b
//	reg [5:0] ide_cfg = 0;
//	reg [1:0] cpu_cfg = 0;
	reg [5:0] ide_cfg;
	reg [1:0] cpu_cfg;
//	ide_cfg <= 0;
//	cpu_cfg <= 0;

	if (reset) begin
		chipset_config     <= t_chipset_config;
		ide_cfg            <= t_ide_config;
		cpu_cfg            <= t_cpu_config[1:0];
//		ide_config <= t_ide_config;
//		cpu_config <= t_cpu_config[1:0];
		memory_config[5:0] <= t_memory_config[5:0];
		memory_config[7]   <= t_memory_config[7];
	end
	
	ide_config <= ide_cfg;
	cpu_config <= cpu_cfg;
end

always @(posedge clk) begin
	cache_config[2:0] <= t_cpu_config[4:2];
	memory_config[6] <= t_memory_config[6];
end

reg [7:0] cmd;

// reg selects
wire mem_write_sel    = (cmd[3:0] == 0); // A_A_A_A B,B,... || write system memory, A - 32 bit memory address, B - variable number of bytes
wire reset_ctrl_sel   = (cmd[3:0] == 1); // XXXXHRBC || reset control   | H - CPU halt, R - reset, B - reset to bootloader, C - reset control block
wire aud_sel          = (cmd[3:0] == 2);
wire chip_cfg_sel     = (cmd[3:0] == 3); // XXXGEANT || chipset config  | G - AGA, E - ECS, A - OCS A1000, N - NTSC, T - turbo
wire cpu_cfg_sel      = (cmd[3:0] == 4); // XXXXKCTT || cpu config      | K - fast kickstart enable, C - CPU cache enable, TT - CPU type (00=68k, 01=68k10, 10=68k20)
wire memory_cfg_sel   = (cmd[3:0] == 5); // XHFFSSCC || memory config   | H - HRTmon, FF - fast, SS - slow, CC - chip
wire video_cfg_sel    = (cmd[3:0] == 6); // DDHHLLSS || video config    | DD - dither, HH - hires interp. filter, LL - lowres interp. filter, SS - scanline mode
wire floppy_cfg_sel   = (cmd[3:0] == 7); // XXXXXFFS || floppy config   | FF - drive number, S - floppy speed
wire harddisk_cfg_sel = (cmd[3:0] == 8); // XXXXXSMC || harddisk config | S - enable slave HDD, M - enable master HDD, C - enable HDD controler
wire joystick_cfg_sel = (cmd[3:0] == 9); // XXXXSMMX || joystick config | S - swap joysticks, MM - dig/analog/cd32
always @(posedge clk) begin : c
//	reg       has_cmd;
//	reg       mrx;
//	reg       btoggle;
//	reg       old_ack;
//	reg [2:0] bcnt;
//	reg       bootrom_r;

	old_ack <= host_ack;
	if (old_ack & ~host_ack) begin
		IO_WAIT  <= 0;
		host_adr <= host_adr + 24'd2;
	end

	if(~IO_ENA) begin
		IO_WAIT <= 0;
		has_cmd <= 0;
		mrx     <= 0;
		bcnt    <= 0;
        btoggle <= 0;
	end
	else if(IO_STROBE) begin
		has_cmd <= 1;
		if(~has_cmd) cmd <= IO_DIN[7:0];
		else if(&cmd[7:4]) begin
			if(~bcnt[2]) bcnt <= bcnt + 1'd1;

			if(!bcnt) begin
				if (reset_ctrl_sel)   {cpuhlt, cpurst, usrrst}        <= IO_DIN[2:0];
				if (chip_cfg_sel)     t_chipset_config                <= IO_DIN[4:0];
				if (cpu_cfg_sel)      t_cpu_config                    <= IO_DIN[4:0];
				if (memory_cfg_sel)   t_memory_config                 <= IO_DIN[7:0];
				if (video_cfg_sel)    {blver, ar, scanline}           <= {IO_DIN[11:8],IO_DIN[2:0]};
				if (floppy_cfg_sel)   floppy_config                   <= IO_DIN[3:0];
				if (harddisk_cfg_sel) t_ide_config                    <= IO_DIN[5:0];
				if (joystick_cfg_sel) {joy_swap, cd32pad, joy_ana_en} <= {IO_DIN[3], ~IO_DIN[1] & IO_DIN[2], IO_DIN[1]};
				if (aud_sel)          aud_mix                         <= IO_DIN[1:0];
			end
			
			if (mem_write_sel) begin
				case (bcnt)
				  0 : host_adr[ 7: 0] <= IO_DIN[7:0];
				  1 : host_adr[15: 8] <= IO_DIN[7:0];
				  2 : host_adr[23:16] <= IO_DIN[7:0];
				  //3 : mem_page[ 7: 0] <= IO_DIN[7:0];
				endcase

				if(bcnt[2]) begin
				   // If OSD writes to $f80000, it could be a bootrom. When a Kickstart is loaded, $fe0000 is also written.
				   if (host_adr == 24'hF80000) bootrom_r <= 1; 
				   if (host_adr == 24'hFE0000) bootrom_r <= 0;  
					btoggle <= ~btoggle;
					if(btoggle) begin
						host_wdat[7:0] <= IO_DIN[7:0];
						mrx <= 1;
						IO_WAIT <= 1;
					end
					else host_wdat[15:8] <= IO_DIN[7:0];
				end
			end
		end
	end
	else if(clk7_en) begin
		host_cs <= mrx;
		host_we <= mrx;
		if(host_ack) mrx <= 0;
	end
	
	bootrom <= bootrom_r;
end

//`ifndef SYNTHESIS
//  always @(posedge clk) begin
//    // only print when io_ena is high so you're not flooded with idle clocks
//    if (IO_ENA) begin
//      $display("%0t  cmd=%02h  bcnt=%0d  strobe=%b  bt=%b  io_wait=%b",
//               $time, cmd, bcnt, IO_ENA & IO_STROBE, btoggle, IO_WAIT);
//    end
//  end
//`endif

endmodule