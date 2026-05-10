// ============================================================
// 2:1 MUX — Behavioral Modeling
// ============================================================
// Uses always block with if-else (procedural style)
// Output must be declared as reg since it's driven in always
// ============================================================

module mux_behavioral (
    input  wire A,    // Input 0
    input  wire B,    // Input 1
    input  wire SEL,  // Select line
    output reg  Y     // reg because driven inside always block
);

    // Sensitivity list: re-evaluate whenever A, B, or SEL changes
    // Use @(*) or @(A or B or SEL) — both are equivalent
    always @(*) begin
        if (SEL == 1'b0)
            Y = A;       // Select A when SEL is 0
        else
            Y = B;       // Select B when SEL is 1
    end

    // Alternative using case statement:
    // always @(*) begin
    //     case (SEL)
    //         1'b0: Y = A;
    //         1'b1: Y = B;
    //     endcase
    // end

endmodule
