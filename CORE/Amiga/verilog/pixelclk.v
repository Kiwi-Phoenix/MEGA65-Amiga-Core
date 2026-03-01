// Pixel Clock.  Code sourced directly from the MiSTer Minimig / Amiga emu module
//
// June 2025    David Raynor (Kiwi)

module pixelclk (
    input clk
   ,input hblank
   ,input vblank
   ,input [1:0] res
   ,input vs 
   ,input [64:0] status
   ,input scandoubler
   ,output reg ce_out   
);


always @(posedge clk ) begin : a
	reg [3:0] div;
	reg [3:0] add;
	reg [1:0] fs_res;
	reg old_vs;
	
	div <= div + add;
	if(~hblank & ~vblank) fs_res <= fs_res | res;

	old_vs <= vs;
	if(old_vs & ~vs) begin
		fs_res <= 0;
		div <= 0;
		add <= 1; // 7MHz
		if(fs_res[0]) add <= 2; // 14MHz
		if(fs_res[1] | (~status[42] & ~scandoubler)) add <= 4; // 28MHz
	end

	ce_out <= div[3] & !div[2:0];
end



endmodule