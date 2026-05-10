// Half Adder — Gate-Level Modeling
module half_adder_gate (
    input  wire A, B,
    output wire SUM, CARRY
);
    xor g1 (SUM,   A, B);
    and g2 (CARRY, A, B);
endmodule
