// Port of the MiniMMig Userio CD32PAD always block / logic.
// Putting this in its own module.
// Break down the overall userio module into smaller managable "chunks".
//
// July 2025    David Raynor (Kiwi)
//

module userio_cd32pad (
        input clk
       ,input reset
       ,input x_fire0_dat
       ,input x_fire1_dat
       ,input joy1_pin5
       ,input joy2_pin5
       ,input [15:0] x_djoy1
       ,input [15:0] x_djoy2     
       ,output wire fire1_dx  
       ,output wire fire2_dx
       ,output reg [7:0] cd32pad1_reg
       ,output reg [7:0] cd32pad2_reg
                
);


// cd32pad1 reg
reg fire1_d;
always @ (posedge clk) begin
	if (reset) fire1_d <= 1;
	else fire1_d <= x_fire0_dat;
end

wire cd32pad1_reg_load  = joy1_pin5;
wire cd32pad1_reg_shift = x_fire0_dat && !fire1_d;
//reg [8-1:0] cd32pad1_reg;

always @ (posedge clk) begin
	if (reset)                   cd32pad1_reg <= 8'hff;
	else if (cd32pad1_reg_load)  cd32pad1_reg <= {x_djoy1[5], x_djoy1[4], x_djoy1[6], x_djoy1[7], x_djoy1[8], x_djoy1[9], x_djoy1[10], 1'b1};
	else if (cd32pad1_reg_shift) cd32pad1_reg <= {cd32pad1_reg[6:0], 1'b0};
end

// cd32pad2 reg
reg fire2_d;
always @ (posedge clk) begin
	if (reset) fire2_d <= 1;
	else fire2_d <= x_fire1_dat;
end

wire cd32pad2_reg_load  = joy2_pin5;
wire cd32pad2_reg_shift = x_fire1_dat && !fire2_d;
//reg [8-1:0] cd32pad2_reg;

always @ (posedge clk) begin
	if (reset)                   cd32pad2_reg <= 8'hff;
	else if (cd32pad2_reg_load)  cd32pad2_reg <= {x_djoy2[5], x_djoy2[4], x_djoy2[6], x_djoy2[7], x_djoy2[8], x_djoy2[9], x_djoy2[10], 1'b1};
	else if (cd32pad2_reg_shift) cd32pad2_reg <= {cd32pad2_reg[6:0], 1'b0};
end


assign fire1_dx = fire1_d;
assign fire2_dx = fire2_d;


endmodule
