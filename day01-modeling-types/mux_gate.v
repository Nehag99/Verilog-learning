// ============================================================
// 2:1 MUX — Gate-Level Modeling
// ============================================================
// Circuit: Y = (A & ~SEL) | (B & SEL)
// Built using primitive gates: not, and, or
// ============================================================

module mux_gate (
    input  wire A,    // Input 0 (selected when SEL=0)
    input  wire B,    // Input 1 (selected when SEL=1)
    input  wire SEL,  // Select line
    output wire Y     // Output
);

    wire sel_bar;     // Inverted select
    wire and0_out;    // A & ~SEL
    wire and1_out;    // B &  SEL

    not  g0 (sel_bar,  SEL);          // SEL_BAR = ~SEL
    and  g1 (and0_out, A, sel_bar);   // AND0 = A & ~SEL
    and  g2 (and1_out, B, SEL);       // AND1 = B &  SEL
    or   g3 (Y, and0_out, and1_out);  // Y = AND0 | AND1

endmodule
