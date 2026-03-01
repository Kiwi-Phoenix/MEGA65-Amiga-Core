// Port of the MiniMMig Userio JOY always block / logic.
// Putting this in its own module.
// Break down the overall userio module into smaller managable "chunks".
//
// July 2025    David Raynor (Kiwi)
//

module userio_joy (
        input               clk
       ,input               clk7_en
       ,input               reset
       ,input [15:0]        x_joy1
       ,input [15:0]        x_joy2    
       ,input               joy_ana_en  
       ,input               joy_swap
       ,input               test_load
       ,input [15:0]        test_data
       ,input               x_mleft
       ,output reg          joy1enable
       ,output reg [15:0]   x_sjoy1
       ,output reg [15:0]   x_djoy1
       ,output reg [15:0]   x_sjoy2
       ,output reg [15:0]   x_djoy2    
       ,output reg [15:0]   dmouse0dat
       ,output reg [15:0]   dmouse1dat                         
);

wire [15:0] joy1 = joy_ana_en ? {{12{1'b1}}, x_joy1[6], 1'b1, x_joy1[4], x_joy1[5]} : x_joy1;
wire [15:0] joy2 = joy_ana_en ? {{12{1'b1}}, x_joy2[6], 1'b1, x_joy2[4], x_joy2[5]} : x_joy2;

// input synchronization of external signals
always @ (posedge clk) begin
	x_sjoy1 <= joy_swap ? joy1 : joy2;
	x_djoy1 <= x_sjoy1;
	x_sjoy2 <= joy_swap ? joy2 : joy1;
	x_djoy2 <= x_sjoy2;
end

// port 1 automatic mouse/joystick switch
always @ (posedge clk) begin
	//when left mouse button pushed, switch to mouse (default)
	if (!x_mleft || reset) joy1enable = 0;
	//when joystick 1 fire pushed, switch to joystick
	else if (!x_sjoy1[4]) joy1enable = 1;
end

// Port 1
always @ (posedge clk) begin
	if (clk7_en) begin
		if (test_load)
			dmouse0dat[7:0] <= 8'h00;
		else if ((!x_djoy1[0] && x_sjoy1[0] && x_sjoy1[2]) || (x_djoy1[0] && !x_sjoy1[0] && !x_sjoy1[2]) || (!x_djoy1[2] && x_sjoy1[2] && !x_sjoy1[0]) || (x_djoy1[2] && !x_sjoy1[2] && x_sjoy1[0]))
			//dmouse0dat[7:0] <= dmouse0dat[7:0] + 1'd1;
			dmouse0dat[7:0] <= dmouse0dat[7:0] + 8'd1;
		else if ((!x_djoy1[0] && x_sjoy1[0] && !x_sjoy1[2]) || (x_djoy1[0] && !x_sjoy1[0] && x_sjoy1[2]) || (!x_djoy1[2] && x_sjoy1[2] && x_sjoy1[0]) || (x_djoy1[2] && !x_sjoy1[2] && !x_sjoy1[0]))
			//dmouse0dat[7:0] <= dmouse0dat[7:0] - 1'd1;
			dmouse0dat[7:0] <= dmouse0dat[7:0] - 8'd1;
		else
			dmouse0dat[1:0] <= {!x_djoy1[0], x_djoy1[0] ^ x_djoy1[2]};
	end
end

always @ (posedge clk) begin
	if (clk7_en) begin
		if (test_load)
			dmouse0dat[15:8] <= 8'h00;
		else if ((!x_djoy1[1] && x_sjoy1[1] && x_sjoy1[3]) || (x_djoy1[1] && !x_sjoy1[1] && !x_sjoy1[3]) || (!x_djoy1[3] && x_sjoy1[3] && !x_sjoy1[1]) || (x_djoy1[3] && !x_sjoy1[3] && x_sjoy1[1]))
			dmouse0dat[15:8] <= dmouse0dat[15:8] + 1'd1;
		else if ((!x_djoy1[1] && x_sjoy1[1] && !x_sjoy1[3]) || (x_djoy1[1] && !x_sjoy1[1] && x_sjoy1[3]) || (!x_djoy1[3] && x_sjoy1[3] && x_sjoy1[1]) || (x_djoy1[3] && !x_sjoy1[3] && !x_sjoy1[1]))
			dmouse0dat[15:8] <= dmouse0dat[15:8] - 1'd1;
		else
			dmouse0dat[9:8] <= {!x_djoy1[1], x_djoy1[1] ^ x_djoy1[3]};
	end
end

// Port 2
always @ (posedge clk) begin
	if (clk7_en) begin
		if (test_load)
			dmouse1dat[7:2] <= test_data[7:2];
		else if ((!x_djoy2[0] && x_sjoy2[0] && x_sjoy2[2]) || (x_djoy2[0] && !x_sjoy2[0] && !x_sjoy2[2]) || (!x_djoy2[2] && x_sjoy2[2] && !x_sjoy2[0]) || (x_djoy2[2] && !x_sjoy2[2] && x_sjoy2[0]))
			dmouse1dat[7:0] <= dmouse1dat[7:0] + 1'd1;			
		else if ((!x_djoy2[0] && x_sjoy2[0] && !x_sjoy2[2]) || (x_djoy2[0] && !x_sjoy2[0] && x_sjoy2[2]) || (!x_djoy2[2] && x_sjoy2[2] && x_sjoy2[0]) || (x_djoy2[2] && !x_sjoy2[2] && !x_sjoy2[0]))
			dmouse1dat[7:0] <= dmouse1dat[7:0] - 1'd1;
		else
			dmouse1dat[1:0] <= {!x_djoy2[0], x_djoy2[0] ^ x_djoy2[2]};
	end
end

always @ (posedge clk) begin
	if (clk7_en) begin
		if (test_load)
			dmouse1dat[15:10] <= test_data[15:10];
		else if ((!x_djoy2[1] && x_sjoy2[1] && x_sjoy2[3]) || (x_djoy2[1] && !x_sjoy2[1] && !x_sjoy2[3]) || (!x_djoy2[3] && x_sjoy2[3] && !x_sjoy2[1]) || (x_djoy2[3] && !x_sjoy2[3] && x_sjoy2[1]))
			dmouse1dat[15:8] <= dmouse1dat[15:8] + 1'd1;
		else if ((!x_djoy2[1] && x_sjoy2[1] && !x_sjoy2[3]) || (x_djoy2[1] && !x_sjoy2[1] && x_sjoy2[3]) || (!x_djoy2[3] && x_sjoy2[3] && x_sjoy2[1]) || (x_djoy2[3] && !x_sjoy2[3] && !x_sjoy2[1]))
			dmouse1dat[15:8] <= dmouse1dat[15:8] - 1'd1;
		else
			dmouse1dat[9:8] <= {!x_djoy2[1], x_djoy2[1] ^ x_djoy2[3]};
	end
end

endmodule
