// Half Adder — Behavioral Modeling
module half_adder_behavioral (
    input  wire A, B,
    output reg  SUM, CARRY
);
    always @(*) begin
        SUM   = A ^ B;
        CARRY = A & B;
    end
endmodule
