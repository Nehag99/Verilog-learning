// ============================================================
// Unified Testbench — Tests all 3 MUX modeling types together
// ============================================================
// Instantiates gate, dataflow, and behavioral MUX side-by-side
// All 3 outputs should be IDENTICAL for every input combination
// ============================================================

`timescale 1ns / 1ps

module tb_mux_all;

    // ---- Testbench signals ----
    reg  A, B, SEL;          // Common inputs to all 3 DUTs
    wire Y_gate;             // Output from gate-level model
    wire Y_dataflow;         // Output from dataflow model
    wire Y_behavioral;       // Output from behavioral model

    // ---- Instantiate all 3 DUTs ----
    mux_gate       DUT_GATE  (.A(A), .B(B), .SEL(SEL), .Y(Y_gate));
    mux_dataflow   DUT_DF    (.A(A), .B(B), .SEL(SEL), .Y(Y_dataflow));
    mux_behavioral DUT_BEH   (.A(A), .B(B), .SEL(SEL), .Y(Y_behavioral));

    // ---- Test stimulus ----
    initial begin
        // Setup waveform dump (for GTKWave / ModelSim)
        $dumpfile("mux21.vcd");
        $dumpvars(0, tb_mux_all);

        // Print header
        $display("===========================================================");
        $display("  2:1 MUX — All Modeling Types Testbench");
        $display("===========================================================");
        $display("  Time | A  B  SEL | Y_gate  Y_df  Y_beh | Match?");
        $display("-----------------------------------------------------------");

        // Apply all 8 combinations (A, B, SEL are 3 signals)
        // Expected: Y = A when SEL=0, Y = B when SEL=1

        // --- SEL = 0: output should follow A ---
        A=0; B=0; SEL=0; #10; print_result;   // Y = 0
        A=0; B=1; SEL=0; #10; print_result;   // Y = 0 (B ignored)
        A=1; B=0; SEL=0; #10; print_result;   // Y = 1
        A=1; B=1; SEL=0; #10; print_result;   // Y = 1

        // --- SEL = 1: output should follow B ---
        A=0; B=0; SEL=1; #10; print_result;   // Y = 0 (A ignored)
        A=0; B=1; SEL=1; #10; print_result;   // Y = 1
        A=1; B=0; SEL=1; #10; print_result;   // Y = 0
        A=1; B=1; SEL=1; #10; print_result;   // Y = 1

        $display("===========================================================");
        $display("  Simulation complete.");
        $finish;
    end

    // ---- Task: print one row and auto-check ----
    task print_result;
        reg match;
        begin
            match = (Y_gate === Y_dataflow) && (Y_dataflow === Y_behavioral);
            $display("  %4t | %b  %b   %b  |   %b       %b     %b    |  %s",
                $time, A, B, SEL,
                Y_gate, Y_dataflow, Y_behavioral,
                match ? "PASS" : "FAIL ***");
        end
    endtask

endmodule
