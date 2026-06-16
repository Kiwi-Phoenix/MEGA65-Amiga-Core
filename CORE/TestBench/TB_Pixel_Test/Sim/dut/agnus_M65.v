// Copyright 2006, 2007 Dennis van Weeren
//
// This file is part of Minimig
//
// Minimig is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// Minimig is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//
//
// This is Agnus
// The copper, blitter and sprite dma have a reqdma output and an ackdma input
// if they are ready for dma they do a dma request by asserting reqdma
// the dma priority logic circuit then checks which module is granted access by
// looking at their priorities and asserting the ackdma signal of the module that
// has the highest priority
//
// Other dma channels (bitplane, audio and disk) only have an enable input (bitplane)
// or only a dma request input from Paula (dmal input, disk and audio)
// and an dma output to indicate that they are using their slot.
// this is because they have the highest priority in the system and cannot be hold up
//
// The bus clock runs at 7.09MHz which is twice as fast as in the original amiga and
// the same as the pixel clock / horizontal beam counter.
//
// general cycle allocation is as follows:
// (lowest 2 bits of horizontal beam counter)
//
// slot 0:  68000 (priority in that order, extra slots because of higher bus speed)
// slot 1:  disk, bitplanes, copper, blitter and 68000 (priority in that order)
// slot 2:  blitter and 68000 (priority in that order, extra slots because of higher bus speed)
// slot 3:  disk, bitplanes, sprites, audio and 68000 (priority in that order)
//
// because only the odd slots are used by the chipset, the chipset runs at the same
// virtual speed as the original. The cpu gets the extra even slots allowing for
// faster cpu's without the need for an extra fastram controller
// Blitter timing is not completely accurate, it uses slot 1 and 2 instead of 1 and 3, this is to let
// the blitter not slow down too much dma contention. (most compatible solution for now)
// Blitter nasty mode activates the buspri signal to indicate to gary to stop access to the chipram/chipregisters.
// Blitter nasty mode is only activated if blitter activates bltpri cause it depends on blitter settings if blitter
// will really block the cpu.
//
// March 2026 - David Raynor (Kiwi)
// Swap out Copper for M65 version.  - Fix for the SKIP instruction.
// 
// April 2026 - David Raynor (Kiwi)
// Make strhor_denise and strhor_paula registered so that they hold their last values.  Important for TB purposes.

module agnus_m65
(
	input         clk,             // clock
	input         clk7_en,         
	input         cck,             // colour clock enable, active whenever hpos[0] is high (odd dma slots used by chipset)
	input         reset,           // reset
	input         aen,             // bus adress enable (register bank)
	input         rd,              // bus read
	input         hwr,             // bus high write
	input         lwr,             // bus low write
	input  [15:0] data_in,         // data bus in
	output [15:0] data_out,        // data bus out
	input   [8:1] address_in,      // 256 words (512 bytes) adress input,
	output reg [20:1] address_out, // chip address output,
	output  [8:1] reg_address_out, // 256 words (512 bytes) register address out,
	output reg    cpu_custom,      // CPU has access to custom chipset (registers and chipRAM / slowRAM)
	output reg    dbr,             // agnus requests data bus
	output reg    dbwe,            // agnus does a memory write cycle (only disk and blitter dma channels may do this)
	output        _hsync,          // horizontal sync
	output        _vsync,          // vertical sync
	output        _csync,          // composite sync
	output        field1,
	output        lace,
	output        hblank,          // video blanking
	output        vblank,          // video blanking
	output        hde,             // video horizontal data enable
	output        sol,             // start of video line (active during last pixel of previous line)
	output        sof,             // start of video frame (active during last pixel of previous frame)
	output        vbl_int,         // vertical blanking interrupt request for Paula
	output        strhor_denise,   // horizontal strobe for Denise (due to not cycle exact implementation of Denise it must be delayed by one CCK)
	output        strhor_paula,    // horizontal strobe for Paula
	output  [8:0] htotal,          // video line length
	output        harddis,
	output        varbeamen,
	output        int3,            // blitter finished interrupt (to Paula)
	input   [3:0] audio_dmal,      // audio dma data transfer request (from Paula)
	input   [3:0] audio_dmas,      // audio dma location pointer restart (from Paula)
	input         disk_dmal,       // disk dma data transfer request (from Paula)
	input         disk_dmas,       // disk dma special request (from Paula)
	input         bls,             // blitter slowdown
	input         ntsc,            // chip is NTSC
	input         a1k,             // enable A1000 OCS features
	input         ecs,             // enable ECS features
	input         aga,             // enables AGA features
	
	output [8:0]  hpos_tb,
	output [10:0] vpos_tb,
	output        copen_tb,
	output        req_cop_tb,
	output [12:0] dmacon_tb,  
	output        cpu_write_pending_tb,
	output [8:1]  reg_address_sync_tb,
	output [15:0] data_in_sync_tb,
    output [4:0] blt_state_tb,
    output blitter_wr_valid_tb,
    output [8:1] blitter_wr_addr_tb,
    output [15:0] blitter_wr_data_tb,
		
	input         floppy_speed     // allocates refresh slots for disk DMA
 
);

assign hpos_tb = hpos;
assign vpos_tb = vpos;
assign copen_tb = copen;
assign req_cop_tb = req_cop;
assign dmacon_tb = dmacon;
assign cpu_write_pending_tb = cpu_write_pending;
assign reg_address_sync_tb = reg_address_sync;
assign data_in_sync_tb  = data_in_sync;
assign blitter_wr_valid_tb  = blitter_wr_valid;
assign blitter_wr_addr_tb = blitter_wr_addr;
assign blitter_wr_data_tb = blitter_wr_data;

// register names and adresses
localparam DMACON  = 9'h096;
localparam DMACONR = 9'h002;
localparam DIWSTRT = 9'h08e;
localparam DIWSTOP = 9'h090;
localparam DIWHIGH = 9'h1E4;


// Blitter register names and address
// These also get passed thru to Blitter
localparam BLTCON0  = 9'h040;
localparam BLTCON0L = 9'h05A;
localparam BLTCON1  = 9'h042;
localparam BLTAFWM  = 9'h044;
localparam BLTALWM  = 9'h046;
localparam BLTADAT  = 9'h074;
localparam BLTBDAT  = 9'h072;
localparam BLTCDAT  = 9'h070;
localparam BLTDDAT  = 9'h000;
localparam BLTSIZE  = 9'h058;
localparam BLTSIZH  = 9'h05E;
localparam BLTSIZV  = 9'h05C; 

parameter BLS_CNT_MAX = 3;    //when CPU misses the bus for 3 consecutive memory cycles the blitter is blocked until CPU accesses the bus


//--------------------------------------------------------------------------------------

//register address bus output
assign reg_address_out = reg_address;

//data out multiplexer
//assign data_out = data_bmc | dmaconr | data_blt;
//wire [15:0] data_out_comb;

// blitter read condition (true when bus is reading a blitter register)
wire blitter_read_sel;
//assign blitter_read_sel =
//       (reg_address[8:1] == BLTADAT[8:1]) ||
//       (reg_address[8:1] == BLTBDAT[8:1]) ||
//       (reg_address[8:1] == BLTCDAT[8:1]) ||
//       (reg_address[8:1] == BLTDDAT[8:1]) ||
//       (reg_address[8:1] == BLTSIZE[8:1]) ||
//       (reg_address[8:1] == BLTSIZH[8:1]) ||
//       (reg_address[8:1] == BLTSIZV[8:1]);
assign blitter_read_sel =
       (reg_address == BLTADAT[7:0]) ||
       (reg_address == BLTBDAT[7:0]) ||
       (reg_address == BLTCDAT[7:0]) ||
       (reg_address == BLTDDAT[7:0]) ||
       (reg_address == BLTSIZE[7:0]) ||
       (reg_address == BLTSIZH[7:0]) ||
       (reg_address == BLTSIZV[7:0]);
// priority mux for data_out: DMACONR has top priority, then blitter reads, then beamcounter (default)
wire [15:0] data_out_comb;
//assign data_out_comb = (reg_address[8:1] == DMACONR[8:1]) ? dmaconr :
//                       (blitter_read_sel)                 ? data_blt :
//                       data_bmc;
assign data_out_comb = (reg_address == DMACONR[7:0]) ? dmaconr :
                       (blitter_read_sel)                 ? data_blt :
                       data_bmc;

assign data_out = data_out_comb;




//cpu address decoder
//wire [8:1] reg_address_cpu = (aen&(rd|hwr|lwr)) ? address_in : 8'hFF;
wire [8:1] reg_address_cpu = (aen && (rd || hwr || lwr)) ? address_in : 8'hFF;

//--------------------------------------------------------------------------------------


reg       ack_cop;        //copper dma acknowledge
reg       ack_blt;        //blitter dma acknowledge
reg       ack_spr;        //sprite dma acknowledge
reg [8:1] reg_address;    //local register address bus
//reg [7:0] reg_address;    //local register address bus
// DJR
// synchronized copies sampled on clk7_en to avoit combinational sampling races
reg [8:1] reg_address_sync;
//reg [7:0] reg_address_sync;
reg [15:0] data_in_sync;
reg aen_sync;
reg hwr_sync;
reg lwr_sync;
reg rd_sync;
reg cpu_write_pending;

// per-module write strobes
reg blitter_wr_valid;
reg [8:1] blitter_wr_addr;
//reg [7:0] blitter_wr_addr;
reg [15:0] blitter_wr_data;
reg dmacon_wr_valid;
reg [15:0] dmacon_wr_data;

reg routed;


//--------------------------------------------------------------------------------------

reg [12:0] dmacon;
reg [15:0] dmaconr;      //dma control read register

reg dma_bpl_reg, dma_ref_reg, dma_dsk_reg, dma_aud_reg, dma_spr_reg, dma_cop_reg;
reg [1:0] bls_cnt;    //blitter slowdown counter, counts memory cycles when the CPU misses the bus

wire  dma_bpl;        //bitplane dma engine uses it's slot
wire  dma_ref;        //refresh dma slots
wire  dma_dsk;        //disk dma uses its slot
wire  dma_aud;        //audio dma uses its slot

wire dma_spr = req_spr & spren; //sprite dma is using its slot
wire dma_cop = req_cop & copen; //copper dma is using its slot
wire dma_blt = req_blt & blten; //blitter dma is using its slot

//copper dma is enabled only when any higher priority dma channel is inactive
//copper uses dma slots which can be optionally assigned only to bitplane dma (also to blitter but it has lower priority than copper)
//it is ok to generate this signal form bitplane dma signal only

wire ena_cop = ~dma_bpl;
//dma enable for blitter tells the blitter that no higher priority dma channel is using the bus
//since blitter has the lowest priority and can use any dma slot (even and odd) all other dma channels block blitter activity
//wire ena_blt = ~(dma_ref | dma_dsk | dma_aud | dma_spr | dma_bpl | dma_cop) && bls_cnt!=BLS_CNT_MAX ? 1'b1 : 1'b0;

wire any_dma_active;
wire ena_blt;

assign any_dma_active = dma_ref_reg | dma_dsk_reg | dma_aud_reg | dma_spr_reg | dma_bpl_reg | dma_cop_reg;
assign ena_blt = (~any_dma_active) && (bls_cnt != BLS_CNT_MAX);

//--------------------------------------------------------------------------------------


always @(posedge clk) begin
    if (clk7_en) begin
        if (reset) begin
            reg_address_sync    <= 8'h00;
            data_in_sync        <= 16'h0000;
            aen_sync            <= 1'b0;
            hwr_sync            <= 1'b0;
            lwr_sync            <= 1'b0;
            rd_sync             <= 1'b0;
            cpu_write_pending   <= 1'b0;
            
            dma_bpl_reg         <= 1'b0;
            dma_ref_reg         <= 1'b0;
            dma_dsk_reg         <= 1'b0;
            dma_aud_reg         <= 1'b0;
            dma_spr_reg         <= 1'b0;
            dma_cop_reg         <= 1'b0;            
                                          
        end else begin
            // keep 1-cycle history of bus strobes
            aen_sync    <= aen;
            hwr_sync    <= hwr;
            lwr_sync    <= lwr;
            rd_sync     <= rd;
            
            dma_bpl_reg <= (dma_bpl == 1'b1);
            dma_ref_reg <= (dma_ref == 1'b1);
            dma_dsk_reg <= (dma_dsk == 1'b1);
            dma_aud_reg <= (dma_aud == 1'b1);
            dma_spr_reg <= (dma_spr == 1'b1);
            dma_cop_reg <= (dma_cop == 1'b1);            
            
            // If CPU is driving the bus now OR irt drove it in the previous sample,
            // and we do not already have an unconsumed CPU write pending,
            // capture the address/data and mark pending.
            if (!cpu_write_pending &&
                ((aen && (hwr || lwr || rd))
                || (aen_sync && (hwr_sync || lwr_sync || rd_sync))) 
                )
                begin
                //Sample the CPU register address (from address_in) and data_in
                //reg_address_sync    <= address_in;
                //data_in_sync        <= data_in;
                reg_address_sync    <= reg_address_cpu;
                data_in_sync        <= data_in;                
                cpu_write_pending   <= 1'b1;
            end
            // otherwise keep previous sampled values (hold)
        end
    end
end


// Combinational readback
wire [15:0] dmaconr_comb;
assign dmaconr_comb = (reg_address[8:1] == DMACONR[8:1]) ? {1'b0, blit_busy, blit_zero, dmacon[12:0]} : 16'h0000;
//assign dmaconr_comb = (reg_address == DMACONR[7:0]) ? {1'b0, blit_busy, blit_zero, dmacon[12:0]} : 16'h0000;

// register the readback on clk7_en to avoid glitches
always @(posedge clk) begin
    if (clk7_en) begin
        if (reset) dmaconr <= 16'h0000;
        else dmaconr <= dmaconr_comb;
    end
end


//assign dma enable bits
wire bltpri = dmacon[10];
wire bplen  = dmacon[8] & dmacon[9];
wire copen  = dmacon[7] & dmacon[9];
wire blten  = dmacon[6] & dmacon[9];
wire spren  = dmacon[5] & dmacon[9];

// -----------------------------------------------------------------------------------------------------------
// Sequential dispatcher (clk7_en gated)
always @(posedge clk) begin
    if (clk7_en) begin
        routed = 1'b0;
     
        if (reset) begin            
            cpu_write_pending <= 1'b0;
            blitter_wr_valid  <= 1'b0;
            dmacon_wr_valid   <= 1'b0;
            blitter_wr_addr   <= {8{1'b0}};     // or 8'h00
            blitter_wr_data   <= 16'h0000;
            dmacon_wr_data    <= 16'h0000;
            dmacon            <= 13'h000;
            routed            <= 1'b0;
        end else begin
            routed = 1'b0;
            
            // if a CPU write is pending, decode and route it once
            if (cpu_write_pending) begin
                if 
                   (reg_address_sync == BLTADAT[8:1] ||
                    reg_address_sync == BLTBDAT[8:1] ||
                    reg_address_sync == BLTCDAT[8:1] ||
                    reg_address_sync == BLTDDAT[8:1] ||
                    reg_address_sync == BLTSIZE[8:1] ||
                    reg_address_sync == BLTSIZH[8:1] ||
                    reg_address_sync == BLTSIZV[8:1] 
                    ) begin
                   
                        blitter_wr_valid <= 1'b1;
                        blitter_wr_addr  <= reg_address_sync;           // forward sampled register index
                        blitter_wr_data  <= data_in_sync;               // forward sampled CPU data
                        cpu_write_pending <= 1'b0;                      // consumed  
                        routed = 1'b1;
                        // Debugging
                        $display("DBG_DISP: ROUTE->BLT,t=%0t,addr=%02h,data=%04h", $time, reg_address_sync, data_in_sync);
                                      
                    end
                    // Route to DMACON and consume immediately (no separate pulse)
                    else if (reg_address_sync == DMACON[8:1]) begin
                    //else if (reg_address_sync == DMACON[7:0]) begin
                        // preserve set/clear semantics: MSB=1 => set bits, else clear bits
                        if (data_in_sync[15]) begin
                            dmacon <= dmacon | data_in_sync[12:0];
                        end else begin
                            dmacon <= dmacon & ~data_in_sync[12:0];
                        end
                        cpu_write_pending <= 1'b0;                  // consumed
                        routed = 1'b1;
                        
                        $display("DBG_DISP: ROUTE->DMACON, t=%0t,data=%03h,dmacon_after=%03h", $time, data_in_sync[12:0], dmacon);
                        $display("DBG_DISP: BLTCON0 write, t=%0t addr=%02h data=%04h", $time, reg_address_sync, data_in_sync);

                    end
                    else begin
                        // other registers: consume to avoid lock
                        cpu_write_pending <= 1'b0;
                    end
                end else begin
                    // clear one-cycle strobes when not used
                    blitter_wr_valid <= 1'b0;
                    dmacon_wr_valid  <= 1'b0;
                end
                
                // (Optional) keep dmacon_wr_valid/dmacon_wr_data for compatibility,
                // but they are not required when consuming DMACON immediately.
                dmacon_wr_valid <= 1'b0;
                dmacon_wr_data  <= 16'h0000;                                  
        end
    end
end


//chip address, register address and control signal multiplexer
//AND dma priority handler
//first item in this if else if list has highest priority
always @(*)
begin
    // default
    cpu_custom  = 1'b1;
    dbr         = 1'b0;
    dbwe        = 1'b0;
    ack_cop     = 1'b0;
    ack_blt     = 1'b0;
    ack_spr     = 1'b0;
    address_out = {20{1'b0}};
    reg_address = 8'hFF;
                     
	if (dma_dsk) begin
		// bus allocated to disk dma engine
		cpu_custom = 0;
		dbr = 1;
		ack_cop = 0;
		ack_blt = 0;
		ack_spr = 0;
		address_out = address_dsk;
		reg_address = reg_address_dsk;
		dbwe = wr_dsk;
	end
	else if (dma_ref) begin
		// bus allocated to refresh dma engine
		cpu_custom = 0;
		dbr = 1;
		ack_cop = 0;
		ack_blt = 0;
		ack_spr = 0;
		address_out = 0;
		reg_address = 8'hFF;
		dbwe = 0;
	end
	else if (dma_aud) begin
		// bus allocated to audio dma engine
		cpu_custom = 0;
		dbr = 1;
		ack_cop = 0;
		ack_blt = 0;
		ack_spr = 0;
		address_out = address_aud;
		reg_address = reg_address_aud;
		dbwe = 0;
	end
	else if (dma_bpl) begin
		// bus allocated to bitplane dma engine
		cpu_custom = 0;
		dbr = 1;
		ack_cop = 0;
		ack_blt = 0;
		ack_spr = 0;
		address_out = address_bpl;
		reg_address = reg_address_bpl;
		dbwe = 0;
	end
	else if (dma_spr) begin
		// bus allocated to sprite dma engine
		cpu_custom = 0;
		dbr = 1;
		ack_cop = 0;
		ack_blt = 0;
		ack_spr = 1;
		address_out = address_spr;
		reg_address = reg_address_spr;
		dbwe = 0;
	end
	else if (dma_cop) begin
		// bus allocated to copper
		cpu_custom = 0;
		dbr = 1;
		ack_cop = 1;
		ack_blt = 0;
		ack_spr = 0;
		address_out = address_cop;
		reg_address = reg_address_cop;
		dbwe = 0;
	end
	else if (dma_blt && bls_cnt!=BLS_CNT_MAX) begin
		// bus allocated to blitter
		cpu_custom = 0;
		dbr = 1;
		ack_cop = 0;
		ack_blt = 1;
		ack_spr = 0;
		address_out = address_blt;
		reg_address = reg_address_blt;
		dbwe = we_blt;
	end
	else begin
		// bus not allocated by agnus
		cpu_custom = 1;
		dbr = 0;
		ack_cop = 0;
		ack_blt = 0;
		ack_spr = 0;
		address_out = 0;
		reg_address = reg_address_cpu; // pass register addresses from cpu address bus
		dbwe = 0;
	end
end

agnus_refresh ref1
(
	.hpos(hpos),
	.dma(dma_ref)
);


wire        wr_dsk;          //disk dma engine write enable out
wire [20:1] address_dsk;     //disk dma engine chip address out
wire  [8:1] reg_address_dsk; //disk dma engine register address out

//instantiate disk dma engine
agnus_diskdma dsk1
(
	.clk(clk),
	.clk7_en(clk7_en),
	.dma(dma_dsk),
	.dmal(disk_dmal),
	.dmas(disk_dmas),
	.speed(floppy_speed),
	.hpos(hpos),
	.wr(wr_dsk),
	.reg_address_in(reg_address),
	.reg_address_out(reg_address_dsk),
	.data_in(data_in),
	.address_out(address_dsk)
);

//--------------------------------------------------------------------------------------


wire [20:1] address_aud;     //audio dma engine chip address out
wire  [8:1] reg_address_aud; //audio dma engine register address out

//instantiate audio dma engine
agnus_audiodma aud1
(
	.clk(clk),
	.clk7_en(clk7_en),
	.dma(dma_aud),
	.audio_dmal(audio_dmal),
	.audio_dmas(audio_dmas),
	.hpos(hpos),
	.reg_address_in(reg_address),
	.reg_address_out(reg_address_aud),
	.data_in(data_in),
	.address_out(address_aud)
);

//--------------------------------------------------------------------------------------


wire [20:1] address_bpl;     //bitplane dma engine chip address out
wire  [8:1] reg_address_bpl; //bitplane dma engine register address out

//instantiate bitplane dma
agnus_bitplanedma_m65 bpd1
(
	.clk(clk),
	.clk7_en(clk7_en),
	.reset(reset),
	.harddis(harddis),
	.aga(aga),
	.ecs(ecs),
	.a1k(a1k),
	.sof(sof),
	.dmaena(bplen),
	.vpos(vpos),
	.hpos(hpos),
	.hde(hde),
	.dma(dma_bpl), 	
	.reg_address_in(reg_address),
	.reg_address_out(reg_address_bpl),
	.data_in(data_in),
	.address_out(address_bpl)
);

//--------------------------------------------------------------------------------------

wire        req_spr;         //sprite dma request
wire [20:1] address_spr;     //sprite dma engine chip address out
wire  [8:1] reg_address_spr; //sprite dma engine register address out

//instantiate sprite dma engine
agnus_spritedma spr1
(
	.clk(clk),
	.clk7_en(clk7_en),
	.reset(reset),
	.aga(aga),
	.ecs(ecs),
	.reqdma(req_spr),
	.ackdma(ack_spr),
	.hpos(hpos),
	.vpos(vpos),
	.vbl(vbl),
	.vblend(vblend),
	.reg_address_in(reg_address),
	.reg_address_out(reg_address_spr),
	.data_in(data_in),
	.address_out(address_spr)
);

//--------------------------------------------------------------------------------------

wire        req_cop;         //copper dma request
wire [20:1] address_cop;     //copper dma engine chip address out
wire  [8:1] reg_address_cop; //copper dma engine register address out

//instantiate copper
agnus_copper_M65 cp1
(
	.clk(clk),
	.clk7_en(clk7_en),
	.reset(reset),
	.ecs(ecs),
	.reqdma(req_cop),
	.ackdma(ack_cop),
	.enadma(ena_cop),
	.sof(sof),
	.blit_busy(blit_busy),
	.vpos(vpos[7:0]),
	.hpos(hpos),
	.data_in(data_in),
	.reg_address_in(reg_address),
	.reg_address_out(reg_address_cop),
	.address_out(address_cop)
);


//--------------------------------------------------------------------------------------



always @(posedge clk) if (clk7_en) begin
	if (!cck)
		if (!bls || bltpri) bls_cnt <= 2'b00;
		else if (bls_cnt[1:0] != BLS_CNT_MAX) bls_cnt <= bls_cnt + 2'b01;
end

wire        blit_busy;       //blitter busy status
wire        blit_zero;       //blitter zero status
wire        req_blt;         //blitter dma request
wire [20:1] address_blt;     //blitter dma engine chip address out
wire  [8:1] reg_address_blt; //blitter dma engine register address out
wire [15:0] data_blt;        //blitter dma engine data out
//reg  [15:0] data_blt;        //blitter dma engine data out
//wire  [15:0] data_out_blt;
wire        we_blt;          //blitter dma engine write enable out

//assign data_out_blt = data_blt;
 
//wire enadma = blten & ena_blt;
wire bltena = blten & ena_blt;

//instantiate blitter
agnus_blitter_M65 #(
           .BLTCON0(BLTCON0)
          ,.BLTCON0L(BLTCON0L)
          ,.BLTCON1(BLTCON1)
          ,.BLTAFWM(BLTAFWM)
          ,.BLTALWM(BLTALWM)
          ,.BLTADAT(BLTADAT)
          ,.BLTBDAT(BLTBDAT)
          ,.BLTCDAT(BLTCDAT)
          ,.BLTDDAT(BLTDDAT)
          ,.BLTSIZE(BLTSIZE)
          ,.BLTSIZH(BLTSIZH)
          ,.BLTSIZV(BLTSIZV)
   )
 bl1
(
	 .clk              (clk)
	,.clk7_en          (clk7_en)
	,.reset            (reset)
	,.ecs              (ecs)
	,.clkena           (cck)
	//,.enadma           (blten & ena_blt)
	,.enadma           (bltena)
	,.reqdma           (req_blt)
	,.ackdma           (ack_blt)
	,.we               (we_blt)
	,.zero             (blit_zero)
	,.busy             (blit_busy)
	,.int3             (int3)
	//,.data_in          (data_in)
	,.data_in          (data_in_sync)
	,.data_out         (data_blt)
	//,.data_out(data_out_blt)
	//,.reg_address_in   (reg_address)
	,.reg_address_in   (reg_address_sync)
	,.address_out      (address_blt)
	,.reg_address_out  (reg_address_blt)
	,.blt_state_tb     (blt_state_tb)
	// CPU write interface (dispatcher -> blitter)
	,.cpu_wr_valid     (blitter_wr_valid)
	,.cpu_wr_addr      (blitter_wr_addr)
	,.cpu_wr_data      (blitter_wr_data)
);

//--------------------------------------------------------------------------------------

wire  [8:0] hpos;      //alternative horizontal beam counter
wire [10:0] vpos;      //vertical beam counter
wire        vbl;       //JB: vertical blanking
wire        vblend;    //JB: last line of vertical blanking
wire [15:0] data_bmc;  //beam counter data out
//reg [15:0] data_bmc;  //beam counter data out
//wire [15:0] data_out_bmc;
//assign data_out_bmc = data_bmc;

//instantiate beam counters
agnus_beamcounter_m65  bc1
(
	.clk(clk),
	.clk7_en(clk7_en),
	.reset(reset),
	.cck(cck),
	.ntsc(ntsc),
	.aga(aga),
	.ecs(ecs),
	.a1k(a1k),
	.reg_address_in(reg_address),
	.data_in(data_in),
	.data_out(data_bmc),
	//.data_out(data_out_bmc),
	.hpos(hpos),
	.vpos(vpos),
	._hsync(_hsync),
	._vsync(_vsync),
	._csync(_csync),
	.field1(field1),
	.lace(lace),
	.hblank(hblank),
	.vblank(vblank),
	.vbl(vbl),
	.vblend(vblend),
	.eol(sol),
	.eof(sof),
	.vbl_int(vbl_int),
	.htotal_out(htotal),
	.harddis_out(harddis),
	.varbeamen_out(varbeamen)
);

//horizontal strobe for Denise
//in real Amiga Denise's hpos counter seems to be advanced by 4 CCKs in regards to Agnus' one
//Minimig isn't cycle exact and compensation for different data delay in implemented Denise's video pipeline is required
//assign strhor_denise = hpos==(6*2-1) && (vpos > 8 || ecs) ? 1'b1 : 1'b0;
//assign strhor_paula = hpos==(6*2+1) ? 1'b1 : 1'b0; //hack

// Combinational strobe for Denise, matches original Minimig timing
wire strhor_denise_c =
    (hpos == (6*2-1)) && (vpos > 11'd8 || ecs);  // hpos == 11

// Registered strobe for Paula (if you want to keep that)
reg strhor_paula_r;

always @(posedge clk) begin
    if (reset) begin
        strhor_paula_r <= 1'b0;
    end else if (clk7_en) begin
        strhor_paula_r <= (hpos == (6*2+1));     // hpos == 13
    end
end

assign strhor_denise = strhor_denise_c;  // direct to Denise
assign strhor_paula  = strhor_paula_r;

//--------------------------------------------------------------------------------------
// Debug reports.

// in an initial block or on reset (simulation only)
initial begin
  $display("BLT CONSTS:,DMACON=%03h,DMACONR=%03h,DIWSTRT=%03h,DIWSTOP=%03h,DIWHIGH=%03h,BLTADAT=%03h,BLTBDAT=%03h,BLTCDAT=%03h,BLTDDAT=%03h,BLTSIZE=%03h,BLTSIZH=%03h,BLTSIZV=%03h",
           DMACON[8:0],DMACONR[8:0],DIWSTRT[8:0],DIWSTOP[8:0],DIWHIGH[8:0],BLTADAT[8:0], BLTBDAT[8:0], BLTCDAT[8:0], BLTDDAT[8:0], BLTSIZE[8:0], BLTSIZH[8:0], BLTSIZV[8:0]);
  $display("BLT CONSTS_B:,DMACON=%b,DMACONR=%b,DIWSTRT=%b,DIWSTOP=%b,DIWHIGH=%b,BLTADAT=%b,BLTBDAT=%b,BLTCDAT=%b,BLTDDAT=%b,BLTSIZE=%b,BLTSIZH=%b,BLTSIZV=%b",
           DMACON[8:0],DMACONR[8:0],DIWSTRT[8:0],DIWSTOP[8:0],DIWHIGH[8:0],BLTADAT[8:0], BLTBDAT[8:0], BLTCDAT[8:0], BLTDDAT[8:0], BLTSIZE[8:0], BLTSIZH[8:0], BLTSIZV[8:0]);       

  //$display("AGNUS DATA IN:T=%0t,ADDRESS_IN=%02h,DATA_IN=%04h",
  //          $time, address_in, data_in );                
end


always @(posedge clk) begin
    if (clk7_en) begin
        $display ("AGNUS,T=%0t,clk7_en=%b,reset=%b,address_in=%h,data_in=%04h,vpos=%h,hpos=%h,copen=%b,dbr=%0h,address_out=%0h,dbwe=%0h,req_blt=%0h,ack_blt=%0h,blt_state_tb=%0h",
            $time,
            clk7_en, reset, address_in, data_in, vpos, hpos, copen, dbr, address_out, dbwe, req_blt, ack_blt, blt_state_tb
            );        
        //$display("AGNUS DBG: data_bmc=%b dmaconr=%b data_blt=%b", data_bmc, dmaconr, data_blt);
//        $display("DBG DMACONR,T=%0t,dmaconr=%04h,blit_busy=%b,blit_zero=%b,dmacon=%03h,ena_cop=%b",
//            $time, dmaconr, blit_busy, blit_zero, dmacon, ena_cop
//            );

$display("CYCLE_DBG:,t=%0t,cck=%b,reg_addr_sync=%02h,cpu_write_pending=%b,blitter_wr_valid=%b,blitter_wr_addr=%02h,bltena=%b,req_blt=%b,ack_blt=%b,dbr=%b,address_out=%05h",
         $time, cck, reg_address_sync, cpu_write_pending, blitter_wr_valid, blitter_wr_addr, bltena , req_blt, ack_blt, dbr, address_out);



        // inside clk7_en sequential region (DUT)
        $display("BLT_HANDSHAKE AGNUS:, t=%0t,cck=%b,blten=%b,dmacon[6]=%b,dmacon[9]=%b,ena_blt=%b,blit_busy=%b,blt_state_tb=%02b,req_blt=%b,ack_blt=%b,dbr=%b,address_out=%05h",
         $time, cck, blten, dmacon[6], dmacon[9], ena_blt,  blit_busy, blt_state_tb,  req_blt, ack_blt, dbr, address_out);
        
        $display("BLT ENA_BLT:, t=%0t,ena_blt=%b,dma_ref=%b,dma_dsk=%b,dma_aud=%b,dma_spr=%b,dma_bpl=%b,dma_cop=%b,bls_cnt=%0h,BLS_CNT_MAX=%0h",
            $time, ena_blt, dma_ref, dma_dsk, dma_aud, dma_spr, dma_bpl, dma_cop, bls_cnt,BLS_CNT_MAX
                );
        $display("BLT ENA_BLT:, t=%0t,ena_blt=%b,dma_ref_reg=%b,dma_dsk_reg=%b,dma_aud_reg=%b,dma_spr_reg=%b,dma_bpl_reg=%b,dma_cop_reg=%b,bls_cnt=%0h,BLS_CNT_MAX=%0h",
            $time, ena_blt, dma_ref_reg, dma_dsk_reg, dma_aud_reg, dma_spr_reg, dma_bpl_reg, dma_cop_reg, bls_cnt, BLS_CNT_MAX
                );
                
//        if (blitter_wr_valid) begin            
//            $display ("AGNUS BLT,T=%0t,dbr=%0h,address_out=%0h,data_in=%0h,dbwe=%0h,req_blt=%0h,ack_blt=%0h,blt_state_tb=%0h",
//                $time, dbr, address_out, data_in, dbwe, req_blt, ack_blt, blt_state_tb
//                );          
//        end
                
    end;
end;

always @(posedge clk) if (clk7_en) begin
  $display("DBG:,dma_flags=%b%b%b%b%b%b,any=%b,ena_blt=%b, bls_cnt=%0d",
           dma_ref, dma_dsk, dma_aud, dma_spr, dma_bpl, dma_cop,
           any_dma_active, ena_blt, bls_cnt);
end


//always @(posedge clk) begin
//    if (clk7_en) begin
//        $display("BLT_DBG:,t=%0t,blt_state_tb=%0d,dbr=%b,addr_out=%05h,we_blt=%b,data_out=%04h,blit_busy=%b",
//            $time, blt_state_tb, dbr, address_out, we_blt, data_out, blit_busy);
//        $display("AGNUS_DBG:,t=%0t,req_blt=%b,ack_blt=%b,dbr=%b,address_out=%05h", 
//            $time, req_blt, ack_blt, dbr, address_out);

//    end
    
//end

//always @(posedge clk) if (clk7_en && strhor_denise_r)
//always @(posedge clk) if (clk7_en && strhor_denise_c)
//    $display("AGNUS STRHOR_DENISE,T=%0t,hpos=%0d,vpos=%0d", $time, hpos, vpos);


//always @(posedge clk) begin
//  if (clk7_en && strhor_denise) begin
//    $display("DENISE STRHOR @ T=%0t hpos=%h vpos=%h hde=%b hblank=%b vblank=%b",
//             $time, hpos, vpos, hde, hblank, vblank);
//  end
//end

always @(posedge clk) begin
  if (clk7_en) begin
    //if (reg_address_sync[8:1] == DMACON[8:1]) begin
      //$display("DMACON write sampled:,T=%0t,reg_address_sync=%04h,data_in_sync=%04h,dmacon(before)=%03h", $time, reg_address_sync,data_in_sync, dmacon);
      
//      $display("DBG_DMACON:,t=%0t,cpu_write_pending=%0h,reg_address_sync=%0h,reg_address_sync=%b,data_in_sync=%0h,blitter_wr_valid=%b,blitter_wr_addr=%02h,blitter_wr_data=%04h,dmacon_wr_valid=%b,dmacon_wr_data=%04h,dmacon=%0h,dmacon_b=%b,dmacon_bits9=%b,dmacon_bits6=%b",
//                $time, cpu_write_pending,reg_address_sync,reg_address_sync,data_in_sync,blitter_wr_valid,blitter_wr_addr,blitter_wr_data,dmacon_wr_valid,dmacon_wr_data,dmacon,dmacon,dmacon[9],dmacon[6]
//            );
      $display("DBG_DMACON:,t=%0t,cpu_write_pending=%b,reg_address_sync=%02h,reg_address_sync=%b,data_in_sync=%04h,data_in_sync=%b,blitter_wr_valid=%b,blitter_wr_addr=%02h,blitter_wr_data=%04h,dmacon=%04h,dmacon_bits9=%b,dmacon_bits6=%b",
                $time, cpu_write_pending,reg_address_sync,reg_address_sync,data_in_sync,data_in_sync,blitter_wr_valid,blitter_wr_addr,blitter_wr_data,dmacon,dmacon[9],dmacon[6]
            );      
      
    //end
    // after update (next line) you can also print new value
  end
end

//always @(posedge clk) begin
//    if (clk7_en) begin
//      if (reg_address_sync[8:1] == DMACON[8:1]) begin
//        $display("DUT: DMACON write sampled at %0t data=%04h", $time, data_in_sync);
//      end
//    end
//end

always @(posedge clk) begin
    if (clk7_en) begin
        $display("WRITE_SYNC:,t=%0t,clk7_en=%b,cpu_write_pending=%0h,aen=%b,hwr=%b,lwr=%b,rd=%b,aen_sync=%b,hwr_sync=%b,lwr_sync=%b,rd_sync=%b,address_in=%02h,data_in=%04h,reg_address_sync=%02h,data_in_sync=%04h",
         $time, clk7_en, cpu_write_pending, aen, hwr, lwr, rd, aen_sync, hwr_sync, lwr_sync, rd_sync, address_in, data_in, reg_address_sync, data_in_sync);

        $display("BLT_START:,t=%0t,blit_busy=%b,bltena=%b,ena_blt=%b,blten=%b",
         $time, blit_busy, bltena, ena_blt, blten);

        $display("BLT_DMA:,t=%0t,req=%b,ack=%b,dbr=%b,addr=%05h,we=%b",
         $time, req_blt, ack_blt, dbr, address_out, dbwe);

        $display("BLT_DONE:,t=%0t,blit_busy=%b,zero=%b,state=%02b",
         $time, blit_busy, blit_zero, blt_state_tb);

    end
end

endmodule

