# Day 01 — Types of Modeling in Verilog

> Part of my **#100DaysOfVLSI** learning streak. I post daily on [LinkedIn](#) — follow along!

---

## What I learned today

In Verilog, any digital circuit can be described in **3 different ways** (modeling styles).  
Understanding all three is fundamental to RTL design.

| Modeling Type | Keyword used | Output type | Best used for |
|---|---|---|---|
| Gate-level | `and`, `or`, `not`, `xor` | `wire` | Netlist-level, post-synthesis |
| Dataflow | `assign` | `wire` | Combinational logic, concise expressions |
| Behavioral | `always @(*)` | `reg` | Most RTL, sequential + combinational |

---

## Circuit — Half Adder

A **Half Adder** takes two 1-bit inputs (A, B) and produces:
- **SUM** = A XOR B
- **CARRY** = A AND B

### Truth table

| A | B | SUM | CARRY |
|---|---|-----|-------|
| 0 | 0 |  0  |   0   |
| 0 | 1 |  1  |   0   |
| 1 | 0 |  1  |   0   |
| 1 | 1 |  0  |   1   |

---

## Files in this folder

```
day01-modeling-types/
├── half_adder_gate.v         ← Gate-level model
├── half_adder_dataflow.v     ← Dataflow model
├── half_adder_behavioral.v   ← Behavioral model
├── tb_half_adder.v           ← Unified testbench (tests all 3)
└── README.md                 ← This file
```

---

## Code — all 3 modeling types

### 1. Gate-level modeling
Uses Verilog built-in primitives (`xor`, `and`). Most verbose. Mirrors actual gate topology.

```verilog
module half_adder_gate (
    input  wire A, B,
    output wire SUM, CARRY
);
    xor g1 (SUM,   A, B);
    and g2 (CARRY, A, B);
endmodule
```

### 2. Dataflow modeling
Uses continuous `assign` statement. Runs always — not a function call. Clean and concise.

```verilog
module half_adder_dataflow (
    input  wire A, B,
    output wire SUM, CARRY
);
    assign SUM   = A ^ B;
    assign CARRY = A & B;
endmodule
```

### 3. Behavioral modeling
Uses `always @(*)` block with procedural statements. Output must be `reg`. Most flexible.

```verilog
module half_adder_behavioral (
    input  wire A, B,
    output reg  SUM, CARRY
);
    always @(*) begin
        SUM   = A ^ B;
        CARRY = A & B;
    end
endmodule
```

---

## Testbench

Single testbench that instantiates **all 3 models** simultaneously and auto-checks outputs match.

```verilog
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
            $display("%b %b | SUM=%b CARRY=%b | %s",
                A, B, SUM_g, CARRY_g, ok ? "PASS" : "FAIL");
        end
    endtask
endmodule
```

---

## Simulation results

```
A B | SUM CARRY | Match?
----+----------+-------
0 0 |  0    0   | PASS
0 1 |  1    0   | PASS
1 0 |  1    0   | PASS
1 1 |  0    1   | PASS
```

All 4/4 test cases passed. All 3 modeling styles produce identical outputs. ✓

---

## How to simulate

### Using Icarus Verilog (free, open source)

```bash
# Install (Ubuntu/Debian)
sudo apt install iverilog

# Compile all files
iverilog -o sim half_adder_gate.v half_adder_dataflow.v half_adder_behavioral.v tb_half_adder.v

# Run simulation
vvp sim

# View waveform (optional)
gtkwave half_adder.vcd
```

---
##you can also use EDAplayground which is free, browser based IDE

---

## Key takeaways

- `assign` is **concurrent** — it always reflects the current input, not a one-time execution
- Output must be `reg` when driven inside an `always` block, `wire` for `assign` or gate primitives
- `@(*)` automatically infers the full sensitivity list — always use this for combinational `always` blocks
- All 3 styles synthesize to the **same gate-level netlist** — the modeling style is just how you describe it
- Behavioral is what you'll write 90% of the time in real RTL work; gate-level is almost never hand-written

---

## Tools used

- **Simulator:** Icarus Verilog (iverilog + vvp)
- **Waveform viewer:** GTKWave
- **Language:** Verilog (IEEE 1364-2001)

---

## Connect with me

- LinkedIn: [www.linkedin.com/in/
neha-g-677293269
](#)
- Follow my daily #100DaysOfVLSI posts for more

---

*Day 01 / 100 — #VLSI #Verilog #RTLDesign #100DaysOfVLSI*
