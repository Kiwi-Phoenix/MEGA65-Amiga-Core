// Port of the MiniMMig Userio MOUSE always block / logic.
// Putting this in its own module.
// Break down the overall userio module into smaller managable "chunks".
//
// July 2025    David Raynor (Kiwi)
//

module userio_mouse (
        input               clk
       ,input               clk7_en
       ,input               reset
       ,input               test_load
       ,input [15:0]        test_data
       ,input               kms_level
       ,input [7:0]         kbd_mouse_data
       ,input [1:0]         kbd_mouse_type
       ,input [2:0]         mouse_btn
       ,output wire [15:0]  mouse0dat
       ,output reg          x_mleft
       ,output reg          x_mright
       ,output reg          x_mthird
    );


//// mouse ////
reg  [ 7:0] xcount;
reg  [ 7:0] ycount;
reg  [ 7:0] mouse0scr;

// mouse counters
always @(posedge clk) begin : a
	reg old_level;
	reg wheel;
	
	old_level <= kms_level;

	if(reset) begin
		xcount <= 0;
		ycount <= 0;
		mouse0scr <= 0;
		wheel <= 0;
	end else if (test_load && clk7_en) begin
		ycount[7:2] <= test_data[15:10];
		xcount[7:2] <= test_data[7:2];
	end else if (old_level ^ kms_level) begin
		if(kbd_mouse_type == 0) begin
			wheel <= 0;
			xcount[7:0] <= xcount[7:0] + kbd_mouse_data;
		end
		if(kbd_mouse_type == 1) begin
			wheel <= 1;
			if(wheel) mouse0scr <= mouse0scr + kbd_mouse_data;
			else ycount[7:0] <= ycount[7:0] + kbd_mouse_data;
		end
	end
end

// output
assign mouse0dat = {ycount, xcount};

// mouse buttons
assign _mleft  = ~mouse_btn[0];
assign _mright = ~mouse_btn[1];
assign _mthird = ~mouse_btn[2];


endmodule
