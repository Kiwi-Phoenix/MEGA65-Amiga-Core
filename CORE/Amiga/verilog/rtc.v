// Real-Time clock.
// always logic copied from the Original MiSTer Minimig.v module
//
// 27 July 2025 David Raynor    (kiwi)
//

module rtc (
    input           clk
   ,input  [64:0]   rtc
   ,input           sel_rtc
   ,input           cpu_rd
   ,input [23:1]    cpu_address_out
   ,output [15:0]   rtc_out
);

assign rtc_out = (sel_rtc && cpu_rd) ? {12'h000, rtc_reg[{cpu_address_out[5:2], 2'b00} +:4]} : 16'h0000;

reg [63:0] rtc_reg;
always @(posedge clk) begin : a
	reg old_flg;
	reg [31:0] cnt;
	
	old_flg <= rtc[64];
	if(old_flg ^ rtc[64]) begin
		rtc_reg <= {rtc[63:8], 8'd0};
		cnt <= 0;
	end
	else if(cnt < 28375159) cnt <= cnt + 1;
	else begin
		cnt <= 0;
		if(rtc_reg[3:0] < 9) rtc_reg[3:0] <= rtc_reg[3:0] + 1'd1;
		else if(rtc_reg[7:4] < 5) rtc_reg[7:0] <= {rtc_reg[7:4] + 1'd1, 4'b0000};
	end
end


endmodule
