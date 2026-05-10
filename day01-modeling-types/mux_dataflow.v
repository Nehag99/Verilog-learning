// ============================================================
// 2:1 MUX — Dataflow Modeling
// ============================================================
// Uses continuous assign statement with conditional operator
// Runs continuously — any change on inputs updates output
// ============================================================

module mux_dataflow (
    input  wire A,    // Input 0
    input  wire B,    // Input 1
    input  wire SEL,  // Select line
    output wire Y     // Output
);

    // Conditional expression — equivalent to a hardware MUX
    assign Y = SEL ? B : A;

    // Alternative using Boolean expression:
    // assign Y = (A & ~SEL) | (B & SEL);

endmodule
