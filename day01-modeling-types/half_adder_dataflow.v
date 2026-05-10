// Half Adder — Dataflow Modeling
module half_adder_dataflow (
    input  wire A, B,
    output wire SUM, CARRY
);
    assign SUM   = A ^ B;
    assign CARRY = A & B;
endmodule
