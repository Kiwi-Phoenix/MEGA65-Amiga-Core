// <<<<< Insert the orig credits and notice here!!!! >>>>>>
//
// March 2026       David Raynor (kiwi)
// Clean-up of original
//


module denise_spritepriority_m65
(
    input  [5:0] bplcon2,       // playfields vs sprites priority setting
    input  [2:1] nplayfield,    // playfields video status
    input  [7:0] nsprite,       // sprites video status
    output reg   sprsel         // sprite select signal output
);

    // ------------------------------------------------------------
    // Group sprites into 4 groups (0/1, 2/3, 4/5, 6/7)
    // ------------------------------------------------------------
    wire [3:0] sprgroup;

    assign sprgroup[0] = (nsprite[1:0] != 2'b00);
    assign sprgroup[1] = (nsprite[3:2] != 2'b00);
    assign sprgroup[2] = (nsprite[5:4] != 2'b00);
    assign sprgroup[3] = (nsprite[7:6] != 2'b00);

    // ------------------------------------------------------------
    // Priority encoder: which sprite group is active?
    // 1 = group0, 2 = group1, 3 = group2, 4 = group3, 7 = none
    // ------------------------------------------------------------
    reg [2:0] sprcode;

    always @(*) begin
        if      (sprgroup[0]) sprcode = 3'd1;
        else if (sprgroup[1]) sprcode = 3'd2;
        else if (sprgroup[2]) sprcode = 3'd3;
        else if (sprgroup[3]) sprcode = 3'd4;
        else                  sprcode = 3'd7; // no sprites
    end

    // ------------------------------------------------------------
    // Playfield priority checks
    // ------------------------------------------------------------
    wire pf1front = (sprcode > bplcon2[2:0]);
    wire pf2front = (sprcode > bplcon2[5:3]);

    // ------------------------------------------------------------
    // Final sprite/playfield selection
    // ------------------------------------------------------------
    always @(*) begin
        // No sprites → choose playfields
        if (sprcode == 3'd7)
            sprsel = 1'b0;

        // PF1 in front and valid
        else if (pf1front && nplayfield[1])
            sprsel = 1'b0;

        // PF2 in front and valid
        else if (pf2front && nplayfield[2])
            sprsel = 1'b0;

        // Otherwise → sprites win
        else
            sprsel = 1'b1;
    end

endmodule
