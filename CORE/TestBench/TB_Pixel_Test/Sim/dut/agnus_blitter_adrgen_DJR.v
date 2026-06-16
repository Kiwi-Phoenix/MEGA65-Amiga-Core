// Blitter address generator
// It can increment or decrement selected pointer register or add or substract any selected modulo register
//
// May 2026 - David Raynor (Kiwi)
//            Update reset of signals.  Fixes the problem with address_out.

module agnus_blitter_adrgen_DJR
(
	 input	clk  					// bus clock
	,input  clk7_en
	,input	reset					// reset
	,input	[1:0] ptrsel			// pointer register selection
	,input	[1:0] modsel			// modulo register selection
	,input	enaptr					// enable pointer selection and update
	,input	incptr					// increase selected pointer register
	,input	decptr					// decrease selected pointer register
	,input	addmod					// add selected modulo register to selected pointer register
	,input	submod					// substract selected modulo register from selected pointer register
	,output	sign_out				// sign output (used for line mode)
	,input	[15:0] data_in			// bus data in
	,input	[8:1] reg_address_in	// register address input
	,output	[20:1] address_out		// generated address out
);

//register names and addresses
parameter BLTAMOD = 9'h064;
parameter BLTBMOD = 9'h062;
parameter BLTCMOD = 9'h060;
parameter BLTDMOD = 9'h066;
parameter BLTAPTH = 9'h050;
parameter BLTAPTL = 9'h052;
parameter BLTBPTH = 9'h04c;
parameter BLTBPTL = 9'h04e;
parameter BLTCPTH = 9'h048;
parameter BLTCPTL = 9'h04a;
parameter BLTDPTH = 9'h054;
parameter BLTDPTL = 9'h056;

//channel select codes
parameter CHA = 2'b10;			// channel A
parameter CHB = 2'b01;			// channel B
parameter CHC = 2'b00;			// channel C
parameter CHD = 2'b11;			// channel D

//local signals
wire 	[1:0]	bltptr_sel;		// blitter pointer select
wire 	[20:1]	bltptr_in;		// blitter pointer registers input
reg		[20:16] bltpth [3:0];	// blitter pointer register bank (high)
wire	[20:16] bltpth_out;		// blitter pointer register bank output (high)
reg		[15:1]  bltptl [3:0];	// blitter pointer register bank (low)
wire	[15:1]  bltptl_out;		// blitter pointer register bank output (low)
wire	[20:1]	bltptr_out;		// blitter pointer register bank output

wire 	[1:0]	bltmod_sel;		// blitter modulo register select
reg		[15:1]  bltmod [3:0];	// blitter modulo register bank
wire	[15:1]  bltmod_out;		// blitter modulo register bank output

reg		[20:1]  newptr;			// new pointer value
reg 	[20:1]	t_newptr; 		// temporary pointer value

//reg     [20:1]  address_out_reg;

//--------------------------------------------------------------------------------------

//pointer register bank

assign bltptr_in[20:1] = enaptr ? newptr[20:1] : {data_in[4:0], data_in[15:1]};

//wire [20:1] data_in_ptr = {data_in[4:0], data_in[15:1]};
//assign bltptr_in[20:1] = enaptr ? newptr[20:1] : data_in_ptr;

assign bltptr_sel = enaptr ? ptrsel : {reg_address_in[4],reg_address_in[2]};

//always @(posedge clk)
//  if (clk7_en) begin
 
//  	if (enaptr || reg_address_in[8:1]==BLTAPTH[8:1] || reg_address_in[8:1]==BLTBPTH[8:1] || reg_address_in[8:1]==BLTCPTH[8:1] || reg_address_in[8:1]==BLTDPTH[8:1])
//  		bltpth[bltptr_sel] <= bltptr_in[20:16];
//  end

// pointer register bank (high)
integer i;
always @(posedge clk) begin
  if (reset) begin
    for (i = 0; i < 4; i = i + 1) begin
      bltpth[i] <= 5'h00;   // high 5 bits (20:16)
    end
  end else if (clk7_en) begin
    if (enaptr || reg_address_in[8:1]==BLTAPTH[8:1] || reg_address_in[8:1]==BLTBPTH[8:1] || reg_address_in[8:1]==BLTCPTH[8:1] || reg_address_in[8:1]==BLTDPTH[8:1])
      bltpth[bltptr_sel] <= bltptr_in[20:16];
  end
end


assign bltpth_out = bltpth[bltptr_sel];		
		
//always @(posedge clk)
//  if (clk7_en) begin
//  	if (enaptr || reg_address_in[8:1]==BLTAPTL[8:1] || reg_address_in[8:1]==BLTBPTL[8:1] || reg_address_in[8:1]==BLTCPTL[8:1] || reg_address_in[8:1]==BLTDPTL[8:1])
//  		bltptl[bltptr_sel] <= bltptr_in[15:1];
//  end

// pointer register bank (low)
always @(posedge clk) begin
  if (reset) begin
    for (i = 0; i < 4; i = i + 1) begin
      bltptl[i] <= 15'h0000; // low 15 bits (15:1)
    end
  end else if (clk7_en) begin
    if (enaptr || reg_address_in[8:1]==BLTAPTL[8:1] || reg_address_in[8:1]==BLTBPTL[8:1] || reg_address_in[8:1]==BLTCPTL[8:1] || reg_address_in[8:1]==BLTDPTL[8:1])
      bltptl[bltptr_sel] <= bltptr_in[15:1];
  end
end

assign bltptl_out = bltptl[bltptr_sel];

assign bltptr_out = {bltpth_out, bltptl_out};	
	
//always @(posedge clk) begin
//    if (reset) begin
//        address_out_reg <= 20'h00000;
//    end else if (clk7_en) begin
//        address_out_reg <= bltptr_out;
//    end    
//end	
	
//assign address_out = address_out_reg;	
//DJR
assign address_out = bltptr_out;
    
//--------------------------------------------------------------------------------------

//modulo register bank

assign bltmod_sel = enaptr ? modsel : reg_address_in[2:1];

always @(posedge clk)
  if (reset) begin
    for (i = 0; i < 4; i = i + 1) begin
        bltmod[i] <= 15'h0000;
    end
  end else if (clk7_en) begin
  	if (reg_address_in[8:3]==BLTAMOD[8:3])
  		bltmod[bltmod_sel] <= data_in[15:1];
  end
assign bltmod_out = bltmod[modsel];

//--------------------------------------------------------------------------------------

// pointer arithmetic unit

// increment or decrement selected pointer
always @(*) begin
    t_newptr = bltptr_out;      // Default

	if (incptr && !decptr)
		t_newptr = bltptr_out + 20'h1; // increment selected pointer
	else if (!incptr && decptr)
		t_newptr = bltptr_out - 20'h1; // decrement selected pointer
	else
		t_newptr = bltptr_out;
end

// add or substract modulo
always @(*) begin
    newptr = t_newptr;      // Default
    
	if (addmod && !submod)
		newptr = t_newptr + {{5{bltmod_out[15]}},bltmod_out[15:1]}; // add modulo (sign extended)
	else if (!addmod && submod)
		newptr = t_newptr - {{5{bltmod_out[15]}},bltmod_out[15:1]}; // substract modulo (sign extended)
	else
		newptr = t_newptr;
end

//sign output
assign sign_out = newptr[15]; // used in line mode as the sign of Bresenham's error accumulator (channel A pointer acts as an accumulator)

//--------------------------------------------------------------------------------------------
// Debug Report
/*
// insert the register Parameters here!!!
initial begin
    $display("BLT: ADRGEN CONSTS,BLTAMOD=%03h,BLTBMOD=%03h,BLTCMOD=%03h,BLTDMOD=%03h,BLTAPTH=%03h,BLTAPTL=%03h,BLTBPTH=%03h,BLTBPTL=%03h,BLTCPTH=%03h,BLTCPTL=%03h,BLTDPTH=%03h,BLTDPTL=%03h",
            BLTAMOD[8:0], BLTBMOD[8:0], BLTCMOD[8:0], BLTDMOD[8:0], BLTAPTH[8:0], BLTAPTL[8:0], BLTBPTH[8:0], BLTBPTL[8:0], BLTCPTH[8:0], BLTCPTL[8:0], BLTDPTH[8:0], BLTDPTL[8:0]
            );
    $display("BLT: ADRGEN CONSTS 8_1,BLTAMOD=%03h,BLTBMOD=%03h,BLTCMOD=%03h,BLTDMOD=%03h,BLTAPTH=%03h,BLTAPTL=%03h,BLTBPTH=%03h,BLTBPTL=%03h,BLTCPTH=%03h,BLTCPTL=%03h,BLTDPTH=%03h,BLTDPTL=%03h",
            BLTAMOD[8:1], BLTBMOD[8:1], BLTCMOD[8:1], BLTDMOD[8:1], BLTAPTH[8:1], BLTAPTL[8:1], BLTBPTH[8:1], BLTBPTL[8:1], BLTCPTH[8:1], BLTCPTL[8:1], BLTDPTH[8:1], BLTDPTL[8:1]
            );
end



always @(posedge clk) begin
    if (clk7_en) begin
      $display("BLT: ADRGEN INOUT,t=%0t,ptrsel=%b,modsel=%b,enaptr=%b,incptr=%b,decptr=%b,addmod=%b,submod=%b,reg_address_in=%03h,data_in=%04h,address_out=%05h,sign_out=%b",
                $time, ptrsel, modsel, enaptr, incptr, decptr, addmod, submod, reg_address_in, data_in, address_out, sign_out
      );
      
      //$display("BLT: ADRGEN,t=%0t,sel=%b,enaptr=%b,bltptr_sel=%b,bltptr_out=%05h,newptr=%05h,reg_address_in[4]=%b,reg_address_in[2]=%b,address_out_reg=%05h",
      //         $time, enaptr, enaptr, bltptr_sel, bltptr_out, newptr, reg_address_in[4], reg_address_in[2], address_out_reg);
      $display("BLT: ADRGEN,t=%0t,sel=%b,enaptr=%b,bltptr_sel=%b,bltptr_out=%05h,newptr=%05h,reg_address_in[4]=%b,reg_address_in[2]=%b",
               $time, enaptr, enaptr, bltptr_sel, bltptr_out, newptr, reg_address_in[4], reg_address_in[2]);               
      
      $display("BLT: ADRGEN PTRS,t=%0t,bltptr_sel=%b,bltpth=%02h,bltptl=%04h,bltptr_out=%05h,bltpth_out=%0h,bltptl_out=%0h",
         $time, bltptr_sel, bltpth[bltptr_sel], bltptl[bltptr_sel], bltptr_out, bltpth_out, bltptl_out);

    end
end
*/
/*
always @(posedge clk) begin
  if (clk7_en && !reset) begin
    if (reg_address_in == BLTAPTH[8:1] ||
        reg_address_in == BLTAPTL[8:1] ||
        reg_address_in == BLTBPTH[8:1] ||
        reg_address_in == BLTBPTL[8:1] ||
        reg_address_in == BLTCPTH[8:1] ||
        reg_address_in == BLTCPTL[8:1] ||
        reg_address_in == BLTDPTH[8:1] ||
        reg_address_in == BLTDPTL[8:1]
        ) begin
      $display("BLT ADRGEN: POINTER WRITE,reg=%03h,data=%04h,ptrsel=%b", reg_address_in, data_in, bltptr_sel);
    end
  end
end
*/

endmodule

