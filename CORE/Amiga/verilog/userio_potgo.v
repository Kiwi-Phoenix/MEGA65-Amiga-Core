// Port of the MiniMMig Userio POTGO always block / logic.
// Putting this in its own module.
// Break down the overall userio module into smaller managable "chunks".
//
// July 2025    David Raynor (Kiwi)
//

module userio_potgo (
        input               clk
       ,input               clk7_en
       ,input               reset       
       ,input [8:0]         POTGO
       ,input [15:0]        data_in
       ,input [8:1]         reg_address_in
       ,input               joy_swap     
       ,input               pot_cnt_en
       ,input [15:0]        x_djoy1       
       ,input [15:0]        x_djoy2
       ,input               x_mright
       ,input               x_mthird
       ,input               cd32pad  
       ,output reg [15:0]   potreg
       ,input [15:0]        joy_ana1
       ,input [15:0]        joy_ana2
       ,input               joy1enable
       ,input [7:0]         cd32pad1_reg       
       ,input [7:0]         cd32pad2_reg
       ,output reg [3:0]    potcap           
       ,output              joy1_pin
       ,output              joy2_pin   
       ,input               joy_ana_en
       ,output [7:0]        pot0x_x
       ,output [7:0]        pot0y_x
       ,output [7:0]        pot1x_x
       ,output [7:0]        pot1y_x
    );

// POTGO register
always @ (posedge clk) begin
	if (reset) potreg <= 0;
	else if (clk7_en) begin
		if (reg_address_in[8:1]==POTGO[8:1]) potreg[15:0] <= data_in[15:0];
		else potreg[0] <= 0;
	end
end

//reg        joy_ana_en;
reg [15:0] ajoy1,ajoy2;

always @(posedge clk) begin
	ajoy1 <= joy_swap ? joy_ana1 : joy_ana2;
	ajoy2 <= joy_swap ? joy_ana2 : joy_ana1;
end

reg   [7:0] pot0x;
reg   [7:0] pot0y;
reg   [7:0] pot1x;
reg   [7:0] pot1y;

assign pot0x_x = pot0x;
assign pot0y_x = pot0y;
assign pot1x_x = pot1x;
assign pot1y_x = pot1y;


// POT[0/1]DAT registers
reg [3:0] potcnt;

// button on the pot pins
always @ (posedge clk) begin
  if (clk7_en) begin
    if (reset) begin
      {pot0x, pot0y, pot1x, pot1y} <= 0;
      potcnt <= 4'b0000;
    end else if (potreg[0]) begin
      {pot0x, pot0y, pot1x, pot1y} <= 0;
      potcnt <= 4'b1111;
    end
    else if (pot_cnt_en) begin
		if (joy_ana_en & joy1enable) begin
        if (potcnt[0] && {~ajoy1[ 7],ajoy1[ 6:0]} != pot1y) pot0y <= pot0y + 1'd1; else potcnt[0] <= 0;
        if (potcnt[1] && {~ajoy1[15],ajoy1[14:8]} != pot1x) pot0x <= pot0x + 1'd1; else potcnt[1] <= 0;
      end else begin
        if (!potcap[0]) pot0x <= pot0x + 1'd1;
        if (!potcap[1]) pot0y <= pot0y + 1'd1;
      end
		if (joy_ana_en) begin
        if (potcnt[2] && {~ajoy2[ 7],ajoy2[ 6:0]} != pot1y) pot1y <= pot1y + 1'd1; else potcnt[2] <= 0;
        if (potcnt[3] && {~ajoy2[15],ajoy2[14:8]} != pot1x) pot1x <= pot1x + 1'd1; else potcnt[3] <= 0;
      end else begin
        if (!potcap[2]) pot1x <= pot1x + 1'd1;
        if (!potcap[3]) pot1y <= pot1y + 1'd1;
      end
    end
  end
end

wire joy2_pin5 = ~(potreg[13] & ~potreg[12]);
wire joy1_pin5 = ~(potreg[9]  & ~potreg[8]);
assign joy1_pin = joy1_pin5;
assign joy2_pin = joy2_pin5;

// potcap reg
//reg  [4-1:0] potcap;
always @ (posedge clk) begin
	if (reset)
		potcap <= 0;
	else if (clk7_en) begin
		if (cd32pad & ~joy2_pin5) begin
			potcap[3] <= cd32pad2_reg[7];
		end else begin
			potcap[3] <= x_djoy2[5] & ~(potreg[15] & ~potreg[14]);
		end
		potcap[2] <= joy2_pin5;

		if(joy1enable & cd32pad & ~joy1_pin5) begin
			potcap[1] <= cd32pad1_reg[7];
		end else begin
			potcap[1] <= x_mright & x_djoy1[5] & ~(potreg[11] & ~potreg[10]);
		end
		potcap[0] <= x_mthird & joy1_pin5;
	end
end


endmodule    
