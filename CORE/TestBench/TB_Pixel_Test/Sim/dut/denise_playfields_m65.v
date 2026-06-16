// <<<<< Insert the orig credits and notice here!!!! >>>>>>
//
// March 2026       David Raynor (kiwi)
// Correct the reset defaults on some of the signals.
//

module denise_playfields_m65
(
    input        aga,
    input  [8:1] bpldata,
    input        dblpf,
    input  [2:0] pf2of,
    input  [6:0] bplcon2,
    output reg [2:1] nplayfield,
    output reg [7:0] plfdata
);

    // ------------------------------------------------------------
    // Decode BPLCON2
    // ------------------------------------------------------------
    wire pf2pri = bplcon2[6];      // playfield 2 priority bit
    wire [2:0] pf2p = bplcon2[5:3]; // priority code (used for OCS quirk)

    // ------------------------------------------------------------
    // Playfield 2 offset (AGA only)
    // ------------------------------------------------------------
    reg [7:0] pf2of_val;

    always @(*) begin
        case (pf2of)
            3'd0: pf2of_val = 8'd0;
            3'd1: pf2of_val = 8'd2;
            3'd2: pf2of_val = 8'd4;
            3'd3: pf2of_val = 8'd8;
            3'd4: pf2of_val = 8'd16;
            3'd5: pf2of_val = 8'd32;
            3'd6: pf2of_val = 8'd64;
            3'd7: pf2of_val = 8'd128;
        endcase
    end

    // ------------------------------------------------------------
    // nplayfield generation
    // ------------------------------------------------------------
    // precomputed playfield values
    wire [7:0] pf1 = {4'b0000, bpldata[7], bpldata[5], bpldata[3], bpldata[1]};
    wire [7:0] pf2 = aga
                     ? ({4'b0000, bpldata[8], bpldata[6], bpldata[4], bpldata[2]} + pf2of_val)
                     : {4'b0000, 1'b1, bpldata[6], bpldata[4], bpldata[2]};

    
   // generate playfield valid signals
    always @(*) begin
        if (dblpf) begin
            nplayfield[1] = (bpldata[7] || bpldata[5] || bpldata[3] || bpldata[1]);
            nplayfield[2] = (bpldata[8] || bpldata[6] || bpldata[4] || bpldata[2]);
        end else begin
            nplayfield[1] = 1'b0;
            nplayfield[2] = (bpldata[8:1] != 8'b00000000);
        end
    end

    // playfield priority and output
    always @(*) begin
        if (dblpf) begin
            if (pf2pri) begin
                if (nplayfield[2])
                    plfdata = pf2;
                else if (nplayfield[1])
                    plfdata = pf1;
                else
                    plfdata = 8'h00;
            end else begin
                if (nplayfield[1])
                    plfdata = pf1;
                else if (nplayfield[2])
                    plfdata = pf2;
                else
                    plfdata = 8'h00;
            end
        end else begin
            // OCS/ECS undocumented feature when bpu=5 and pf2pri>5 (Swiv score display)
            if ((pf2p > 5) && bpldata[5] && !aga)
                plfdata = 8'b00010000;
            else
                plfdata = bpldata[8:1];
        end
    end



endmodule
