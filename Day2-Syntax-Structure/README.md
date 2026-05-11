
# Day 02 — Verilog Syntax & Module Structure

> Part of my **30-day Verilog learning challenge**. One topic per day, notes + code pushed daily.

---

## What I covered today

- Verilog keywords and reserved words overview
- Module anatomy: declaration, port list, internal signals, hardware logic
- Port types: `input`, `output`, `inout`
- Net vs variable types: `wire` vs `reg`
- Signed vs unsigned ports
- Module instantiation and hierarchy basics

---

## Key concepts

### Module structure

```verilog
module module_name (
    input  wire clk,       // clock signal
    input        en,       // enable (implicit wire)
    inout [15:0] data,     // 16-bit bidirectional bus
    output reg   q         // driven from always block → must be reg
);
    // internal logic here
endmodule
```

### Wire vs reg rule
| Driven by         | Declare as |
|-------------------|------------|
| `assign` statement | `wire`    |
| `always` block     | `reg`     |

### Port direction summary
| Port    | Direction       | Typical use               |
|---------|-----------------|---------------------------|
| `input` | into module     | clk, reset, data in       |
| `output`| out of module   | results, status flags     |
| `inout` | bidirectional   | SPI/I2C data bus, mem bus |

### Signed vs unsigned
- All ports are **unsigned by default**
- Use `signed` keyword explicitly when doing arithmetic with negative numbers

```verilog
module signed_example (
    input  signed [7:0] a, b,
    output signed [8:0] sum
);
    assign sum = a + b;
endmodule
```

---

## Notes PDF

Full handwritten notes for Day 2 are in [`Day2_syntax_struct.pdf`](./Day2_syntax_struct.pdf).

---

*30-day challenge — learning Verilog from scratch. Follow along on [LinkedIn](#).*
