// Testbench — Half Adder (all 3 models)
`timescale 1ns/1ps
module tb_half_adder;

    reg  A, B;
    wire SUM_g,   CARRY_g;
    wire SUM_df,  CARRY_df;
    wire SUM_beh, CARRY_beh;

    half_adder_gate       DUT1 (.A(A), .B(B), .SUM(SUM_g),   .CARRY(CARRY_g));
    half_adder_dataflow   DUT2 (.A(A), .B(B), .SUM(SUM_df),  .CARRY(CARRY_df));
    half_adder_behavioral DUT3 (.A(A), .B(B), .SUM(SUM_beh), .CARRY(CARRY_beh));

    initial begin
        $dumpfile("half_adder.vcd");
        $dumpvars(0, tb_half_adder);
        $display("A B | SUM CARRY | Match?");
        $display("----+----------+-------");
        A=0; B=0; #10; check;
        A=0; B=1; #10; check;
        A=1; B=0; #10; check;
        A=1; B=1; #10; check;
        $finish;
    end

    task check;
        reg ok;
        begin
            ok = (SUM_g===SUM_df) && (SUM_df===SUM_beh) &&
                 (CARRY_g===CARRY_df) && (CARRY_df===CARRY_beh);
            $display("%b %b |  %b    %b   | %s",
                A, B, SUM_g, CARRY_g, ok ? "PASS" : "FAIL");
        end
    endtask
endmodule
