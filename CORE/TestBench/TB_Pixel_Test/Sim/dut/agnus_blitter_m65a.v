// agnus_blitter - updated, defensive version
// - no 'X' literals in RTL
// - explicit defaults in combinational blocks
// - registers initialized on reset (sampled on clk7_en)
// - removed simulation-only #1 delays
// - deterministic data_out and zero
module agnus_blitter_m65a
(
  input        clk,
  input        clk7_en,
  input        reset,
  input        ecs,
  input        clkena,
  input        enadma,
  output       reqdma,
  input        ackdma,
  output       we,
  output reg   zero,
  output reg   busy,
  output       int3,
  input  [15:0] data_in,
  output [15:0] data_out,
  input  [8:1] reg_address_in,
  output [20:1] address_out,
  output reg [8:1] reg_address_out
);

  // register map parameters
  parameter BLTCON0  = 9'h040;
  parameter BLTCON0L = 9'h05A;
  parameter BLTCON1  = 9'h042;
  parameter BLTAFWM  = 9'h044;
  parameter BLTALWM  = 9'h046;
  parameter BLTADAT  = 9'h074;
  parameter BLTBDAT  = 9'h072;
  parameter BLTCDAT  = 9'h070;
  parameter BLTDDAT  = 9'h000;
  parameter BLTSIZE  = 9'h058;
  parameter BLTSIZH  = 9'h05E;
  parameter BLTSIZV  = 9'h05C;

  // channel encodings
  parameter CHA = 2'b10;
  parameter CHB = 2'b01;
  parameter CHC = 2'b00;
  parameter CHD = 2'b11;

  // states
  parameter BLT_IDLE = 5'b00000;
  parameter BLT_INIT = 5'b00001;
  parameter BLT_A    = 5'b01001;
  parameter BLT_B    = 5'b01011;
  parameter BLT_C    = 5'b01010;
  parameter BLT_D    = 5'b01000;
  parameter BLT_E    = 5'b01100;
  parameter BLT_F    = 5'b00100;
  parameter BLT_L1   = 5'b11001;
  parameter BLT_L2   = 5'b11011;
  parameter BLT_L3   = 5'b11010;
  parameter BLT_L4   = 5'b11000;

  // internal registers
  reg  [15:0] bltcon0;
  reg  [15:0] bltcon1;
  reg  [15:0] bltafwm;
  reg  [15:0] bltalwm;
  reg  [15:0] bltadat;
  reg  [15:0] bltbdat;
  reg  [15:0] bltcdat;
  reg  [15:0] bltaold;
  reg  [15:0] bltbold;
  reg  [15:0] bltahold;
  reg  [15:0] bltbhold;
  reg  [15:0] bltdhold;
  reg  [15:0] bltamask;
  reg  [10:0] width;
  reg  [14:0] height;
  reg  [4:0]  blt_state;
  reg  [4:0]  blt_next;
  reg  [1:0]  chsel;
  reg  [1:0]  ptrsel;
  reg  [1:0]  modsel;
  reg         enaptr;
  reg         incptr;
  reg         decptr;
  reg         addmod;
  reg         submod;
  reg         enad;
  reg         dma_req;
  reg         dma_ack;
  reg         bltbold_init;
  reg         bltbdat_wrtn;
  reg         pipeline_full;
  reg         fcy;
  reg         first_word_del;
  reg         last_word_del;
  reg         first_pixel;
  reg         first_line_pixel;
  reg         start;
  reg         store_result;
  reg  [10:0] width_cnt;
  reg  [14:0] height_cnt;
  reg  [15:0] bltaold_next; // helper
  reg         bltbhold_next; // helper
  reg         bltadat_wr;    // helper

  // wires and derived signals
  wire [3:0] ash;
  wire [3:0] bsh;
  wire       usea;
  wire       useb;
  wire       usec;
  wire       used;
  wire       desc;
  wire       line;
  wire       ife;
  wire       efe;
  wire       enable;
  wire       first_word;
  wire       last_word;
  wire       last_line;
  wire       next_word;
  wire       done;
  wire [15:0] minterm_out;
  wire [15:0] fill_out;
  wire        fci;
  wire        fco;
  wire [15:0] shiftaout;
  wire [15:0] shiftbout;
  wire        lineinc;
  wire        linedec;
  wire        lineadd;
  wire        linesub;

  // simple assignments
  assign ash = bltcon0[15:12];
  assign bsh = bltcon1[15:12];
  assign {usea, useb, usec, used} = {bltcon0[11:9], bltcon0[8] & enad};
  assign line = bltcon1[0];
  assign desc = ~line & bltcon1[1];
  assign efe = ~line & bltcon1[4];
  assign ife = ~line & bltcon1[3];

  // barrel shifters and minterm/fill modules (assumed deterministic)
  agnus_blitter_barrelshifter barrel_shifter_A
  (
    .desc(desc),
    .shift(ash),
    .new_val(bltadat & bltamask),
    .old_val(bltaold),
    .out(shiftaout)
  );

  agnus_blitter_barrelshifter barrel_shifter_B
  (
    .desc(desc),
    .shift(bsh),
    .new_val(bltbdat),
    .old_val(bltbold),
    .out(shiftbout)
  );

  agnus_blitter_minterm bltmt1
  (
    .lf(bltcon0[7:0]),
    .ain(bltahold),
    .bin(bltbhold),
    .cin(bltcdat),
    .out(minterm_out)
  );

  agnus_blitter_fill bltfl1
  (
    .ife(ife),
    .efe(efe),
    .fci(fci),
    .fco(fco),
    .in(minterm_out),
    .out(fill_out)
  );

  assign fci = first_word_del ? bltcon1[2] : fcy;

  // address generator (assumed deterministic)
  agnus_blitter_adrgen address_generator_1
  (
    .clk(clk),
    .clk7_en(clk7_en),
    .reset(reset),
    .ptrsel(ptrsel),
    .modsel(modsel),
    .enaptr(enaptr),
    .incptr(incptr),
    .decptr(decptr),
    .addmod(addmod),
    .submod(submod),
    .sign_out(), // not used here
    .data_in(data_in),
    .reg_address_in(reg_address_in),
    .address_out(address_out)
  );

  // combinational bltamask
  always @(*) begin
    if (first_word && last_word)
      bltamask = bltafwm & bltalwm;
    else if (last_word)
      bltamask = bltalwm;
    else if (first_word)
      bltamask = bltafwm;
    else
      bltamask = 16'hFFFF;
  end

  // synchronous register updates and reset initialization (sampled on clk7_en)
  always @(posedge clk) begin
    if (clk7_en) begin
      if (reset) begin
        // initialize all state/data registers to safe values
        bltcon0       <= 16'h0000;
        bltcon1       <= 16'h0000;
        bltafwm       <= 16'h0000;
        bltalwm       <= 16'h0000;
        bltadat       <= 16'h0000;
        bltbdat       <= 16'h0000;
        bltcdat       <= 16'h0000;
        bltaold       <= 16'h0000;
        bltbold       <= 16'h0000;
        bltahold      <= 16'h0000;
        bltbhold      <= 16'h0000;
        bltdhold      <= 16'h0000;
        bltamask      <= 16'hFFFF;
        width         <= 11'h000;
        height        <= 15'h0000;
        width_cnt     <= 11'h000;
        height_cnt    <= 15'h0000;
        blt_state     <= BLT_IDLE;
        blt_next      <= BLT_IDLE;
        chsel         <= CHA;
        ptrsel        <= 2'b00;
        modsel        <= 2'b00;
        enaptr        <= 1'b0;
        incptr        <= 1'b0;
        decptr        <= 1'b0;
        addmod        <= 1'b0;
        submod        <= 1'b0;
        enad          <= 1'b0;
        dma_req       <= 1'b0;
        dma_ack       <= 1'b0;
        bltbold_init  <= 1'b1;
        bltbdat_wrtn  <= 1'b0;
        pipeline_full <= 1'b0;
        fcy           <= 1'b0;
        first_word_del<= 1'b0;
        last_word_del <= 1'b0;
        first_pixel   <= 1'b0;
        first_line_pixel <= 1'b0;
        start         <= 1'b0;
        store_result  <= 1'b0;
        bltaold_next  <= 16'h0000;
        bltbhold_next <= 1'b0;
        bltadat_wr    <= 1'b0;
        zero          <= 1'b1;
        busy          <= 1'b0;
      end else begin
        // register writes from CPU
        if (reg_address_in[8:1] == BLTCON0[8:1]) begin
          bltcon0[15:12] <= data_in[15:12];
          bltcon0[11:8]  <= data_in[11:8];
          bltcon0[7:0]   <= data_in[7:0];
        end

        if (reg_address_in[8:1] == BLTCON1[8:1]) begin
          bltcon1[15:12] <= data_in[15:12];
          bltcon1[11:0]  <= data_in[11:0];
        end

        if (reg_address_in[8:1] == BLTAFWM[8:1]) bltafwm <= data_in;
        if (reg_address_in[8:1] == BLTALWM[8:1]) bltalwm <= data_in;
        if (reg_address_in[8:1] == BLTADAT[8:1]) bltadat <= data_in;
        if (reg_address_in[8:1] == BLTBDAT[8:1]) begin
          bltbdat <= data_in;
          bltbdat_wrtn <= 1'b1;
          bltbold_init <= 1'b0;
        end
        if (reg_address_in[8:1] == BLTCDAT[8:1]) bltcdat <= data_in;

        // bltold updates on next_word
        if (enable) begin
          if (init) begin
            bltaold <= 16'h0000;
            pipeline_full <= 1'b0;
          end else if (next_word && !line) begin
            bltaold <= bltadat & bltamask;
            pipeline_full <= 1'b1;
          end
        end

        // hold registers updated from shifters
        if (enable) bltahold <= shiftaout;
        if (line) bltbhold <= {16{shiftbout[0]}}; else if (enable) bltbhold <= shiftbout;

        // bltbold behavior
        if (reg_address_in[8:1] == BLTBDAT[8:1]) begin
          if (bltbold_init) bltbold <= 16'h0000;
          else bltbold <= bltbdat;
        end

        // store_result and bltdhold
        if (store_result) begin
          fcy <= fco;
          bltdhold <= fill_out;
        end

        // zero update
        if (enable && init) zero <= 1'b1;
        else if (store_result) zero <= ~(|fill_out);

        // busy
        if (reg_address_in[8:1] == BLTSIZE[8:1] || (reg_address_in[8:1] == BLTSIZH[8:1] && ecs))
          busy <= 1'b1;
        else if (done)
          busy <= 1'b0;

        // start
        if (reset || done) start <= 1'b0;
        else if (clkena && busy) start <= 1'b1;

        // width/height counters and reloads
        if (reg_address_in[8:1] == BLTSIZE[8:1]) begin
          width <= {4'b0000, ~|data_in[5:0], data_in[5:0]};
          height_cnt <= {4'b0000, ~|data_in[15:6], data_in[15:6]};
        end else if (reg_address_in[8:1] == BLTSIZH[8:1] && ecs) begin
          width <= data_in[10:0];
          height_cnt <= height;
        end

        if (reg_address_in[8:1] == BLTSIZV[8:1]) height <= data_in[14:0];

        // pipeline control
        if (enable) begin
          if (init) pipeline_full <= 1'b0;
          else if (next_word) pipeline_full <= 1'b1;
        end

        // first/last word delays
        if (next_word && enable) begin
          last_word_del <= last_word;
          first_word_del <= first_word;
        end

        // blt_state update
        blt_state <= blt_next;
      end
    end
  end

  // combinational state machine outputs with safe defaults
  always @(*) begin
    // defaults
    chsel    = CHA;
    ptrsel   = 2'b00;
    modsel   = 2'b00;
    enaptr   = 1'b0;
    incptr   = 1'b0;
    decptr   = 1'b0;
    addmod   = 1'b0;
    submod   = 1'b0;
    dma_req  = 1'b0;
    blt_next = BLT_IDLE;

    case (blt_state)
      BLT_IDLE: begin
        chsel = CHA;
        ptrsel = 2'b00;
        modsel = 2'b00;
        enaptr = 1'b0;
        incptr = 1'b0;
        decptr = 1'b0;
        addmod = 1'b0;
        submod = 1'b0;
        dma_req = 1'b0;
        if (enable) begin
          if (start) blt_next = BLT_INIT;
          else blt_next = BLT_IDLE;
        end else blt_next = BLT_IDLE;
      end

      BLT_INIT: begin
        if (enable) begin
          if (line) blt_next = BLT_L1;
          else blt_next = BLT_A;
        end else blt_next = BLT_INIT;
      end

      BLT_A: begin
        chsel = CHA;
        ptrsel = CHA;
        modsel = CHA;
        enaptr = dma_ack;
        incptr = ~desc;
        decptr = desc;
        addmod = ~desc & last_word;
        submod = desc & last_word;
        dma_req = usea;
        if (enable) begin
          if (useb) blt_next = BLT_B;
          else if (usec || ife || efe) blt_next = BLT_C;
          else blt_next = BLT_D;
        end else blt_next = BLT_A;
      end

      BLT_B: begin
        chsel = CHB;
        ptrsel = CHB;
        modsel = CHB;
        enaptr = dma_ack;
        incptr = ~desc;
        decptr = desc;
        addmod = ~desc & last_word;
        submod = desc & last_word;
        dma_req = 1'b1;
        if (enable) begin
          if (usec || ife || efe) blt_next = BLT_C;
          else blt_next = BLT_D;
        end else blt_next = BLT_B;
      end

      BLT_C: begin
        chsel = CHC;
        ptrsel = CHC;
        modsel = CHC;
        enaptr = dma_ack;
        incptr = ~desc;
        decptr = desc;
        addmod = ~desc & last_word;
        submod = desc & last_word;
        dma_req = usec;
        if (enable) begin
          if (used) blt_next = BLT_D;
          else if (last_word && last_line) blt_next = BLT_IDLE;
          else blt_next = BLT_A;
        end else blt_next = BLT_C;
      end

      BLT_D: begin
        chsel = CHD;
        ptrsel = CHD;
        modsel = CHD;
        enaptr = dma_ack;
        incptr = ~desc;
        decptr = desc;
        addmod = ~desc & last_word_del;
        submod = desc & last_word_del;
        dma_req = used & pipeline_full;
        if (enable) begin
          if (last_word && last_line) begin
            if (used) blt_next = BLT_E;
            else blt_next = BLT_IDLE;
          end else blt_next = BLT_A;
        end else blt_next = BLT_D;
      end

      BLT_E: begin
        if (clkena) blt_next = BLT_F;
        else blt_next = BLT_E;
      end

      BLT_F: begin
        chsel = CHD;
        ptrsel = CHD;
        modsel = CHD;
        enaptr = dma_ack;
        incptr = ~desc;
        decptr = desc;
        addmod = ~desc & last_word_del;
        submod = desc & last_word_del;
        dma_req = 1'b1;
        if (enable) blt_next = BLT_IDLE;
        else blt_next = BLT_F;
      end

      BLT_L1: begin
        chsel = CHA;
        ptrsel = CHA;
        modsel = sign ? CHB : CHA;
        enaptr = enable;
        incptr = 1'b0;
        decptr = 1'b0;
        addmod = 1'b1;
        submod = 1'b0;
        dma_req = 1'b0;
        if (enable) blt_next = BLT_L2;
        else blt_next = BLT_L1;
      end

      BLT_L2: begin
        chsel = CHC;
        ptrsel = CHC;
        modsel = CHC;
        enaptr = enable;
        incptr = first_line_pixel ? lineinc : 1'b0;
        decptr = first_line_pixel ? linedec : 1'b0;
        addmod = first_line_pixel ? lineadd : 1'b0;
        submod = first_line_pixel ? linesub : 1'b0;
        dma_req = usec;
        if (enable) blt_next = BLT_L3;
        else blt_next = BLT_L2;
      end

      BLT_L3: begin
        chsel = CHA;
        ptrsel = CHD;
        modsel = CHD;
        enaptr = first_line_pixel ? 1'b0 : enable;
        incptr = lineinc;
        decptr = linedec;
        addmod = lineadd;
        submod = linesub;
        dma_req = 1'b0;
        if (enable) blt_next = BLT_L4;
        else blt_next = BLT_L3;
      end

      BLT_L4: begin
        chsel = CHD;
        ptrsel = first_line_pixel ? CHD : CHC;
        modsel = first_line_pixel ? CHD : CHC;
        enaptr = enable;
        incptr = lineinc;
        decptr = linedec;
        addmod = lineadd;
        submod = linesub;
        dma_req = usec & (~bltcon1[1] | ~bltcon1[4] | first_pixel);
        if (enable) begin
          if (last_line) blt_next = BLT_IDLE;
          else blt_next = BLT_L1;
        end else blt_next = BLT_L4;
      end

      default: begin
        // keep defaults
        blt_next = BLT_IDLE;
      end
    endcase
  end

  // derived signals
  assign init = (blt_state == BLT_INIT);
  assign next_word = (blt_state == BLT_C && !used) || (blt_state == BLT_D) || (blt_state == BLT_L2) || (blt_state == BLT_L4);
  assign first_word = (width_cnt == width) ? 1'b1 : 1'b0;
  assign last_word  = (width_cnt == 11'd1) ? 1'b1 : 1'b0;
  assign last_line  = (height_cnt == 15'd1) ? 1'b1 : 1'b0;
  assign done = (((blt_state == BLT_C && !used) || (blt_state == BLT_D)) && last_word && last_line) || (blt_state == BLT_L4 && last_line) ? enable : 1'b0;

  // width/height counters
  assign width_cnt_dec = enable & next_word;
  assign width_cnt_rld = enable & next_word & last_word | init & enable;

  always @(posedge clk) begin
    if (clk7_en) begin
      if (reset) width_cnt <= 11'h000;
      else if (width_cnt_rld) width_cnt <= width;
      else if (width_cnt_dec) width_cnt <= width_cnt - 1'b1;
    end
  end

  // height counter
  always @(posedge clk) begin
    if (clk7_en) begin
      if (reset) height_cnt <= 15'h0000;
      else if (reg_address_in[8:1] == BLTSIZE[8:1]) height_cnt <= {4'b0000, ~|data_in[15:6], data_in[15:6]};
      else if (reg_address_in[8:1] == BLTSIZH[8:1] && ecs) height_cnt <= height;
      else if (enable && next_word && last_word) height_cnt <= height_cnt - 1'b1;
    end
  end

  // line increment/decrement helpers
  assign lineinc = ((bltcon1[4] && !bltcon1[2]) || (!bltcon1[4] && !bltcon1[3] && !sign_del)) && ash == 4'b1111 ? 1'b1 : 1'b0;
  assign linedec = ((bltcon1[4] && bltcon1[2]) || (!bltcon1[4] && bltcon1[3] && !sign_del)) && ash == 4'b0000 ? 1'b1 : 1'b0;
  assign lineadd = (!bltcon1[4] && !bltcon1[2]) || (bltcon1[4] && !bltcon1[3] && !sign_del) ? 1'b1 : 1'b0;
  assign linesub = (!bltcon1[4] && bltcon1[2]) || (bltcon1[4] && bltcon1[3] && !sign_del) ? 1'b1 : 1'b0;

  // sign and sign_del
  always @(posedge clk) begin
    if (clk7_en) begin
      if (reset) sign <= 1'b0;
      else if (reg_address_in[8:1] == BLTCON1[8:1]) sign <= data_in[6];
      else if (enable && blt_state == BLT_L1) sign <= sign_out;
    end
  end

  always @(posedge clk) begin
    if (clk7_en) begin
      if (reset) sign_del <= 1'b0;
      else if (enable && blt_state == BLT_L1) sign_del <= sign;
    end
  end

  // store_result register
  always @(posedge clk) begin
    if (clk7_en) begin
      if (reset) store_result <= 1'b0;
      else store_result <= enable && next_word;
    end
  end

  // blt_state sequential update already handled above

  // reg_address_out combinational (safe default)
  always @(*) begin
    reg_address_out = BLTADAT[8:1];
    case (chsel)
      CHA: reg_address_out = BLTADAT[8:1];
      CHB: reg_address_out = BLTBDAT[8:1];
      CHC: reg_address_out = BLTCDAT[8:1];
      CHD: reg_address_out = BLTDDAT[8:1];
      default: reg_address_out = BLTADAT[8:1];
    endcase
  end

  // data_out and we: deterministic, bltdhold initialized on reset
  assign data_out = (ackdma && chsel == CHD) ? bltdhold : 16'h0000;
  assign we       = (ackdma && chsel == CHD) ? 1'b1 : 1'b0;

  // reqdma and enable
  assign enable = enadma & clkena;
  assign reqdma = dma_req & enable;
  assign dma_ack = ackdma;

endmodule
