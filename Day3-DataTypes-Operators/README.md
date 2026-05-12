
# 📘 Day [X] – Data Types & Operators in Verilog

> Part of my **Everyday Verilog Learning** series — one topic a day, documented with notes and examples.

---

## 🧠 What I Learned Today

Verilog has a rich set of data types and operators that form the foundation of any hardware description. Today I explored the two main categories of data types and all the key operators used in RTL design.

---

## 🔷 Data Types

### 1. Net Types (Physical Connections)
Net types represent physical wires — they carry values driven by continuous assignments or module outputs.

| Type | Description |
|------|-------------|
| `wire` | Most common net type; models a physical wire |
| `tri` | Tri-state wire; multiple drivers allowed |
| `supply0` | Constant logic 0 (GND) |
| `supply1` | Constant logic 1 (VCC) |

```verilog
wire a, b;
wire [7:0] data_bus;   // 8-bit bus
tri enable;
```

### 2. Variable Types (Store Values)
Variable types hold values and are used inside `always` and `initial` blocks.

| Type | Description |
|------|-------------|
| `reg` | Stores a value; does NOT always mean a flip-flop |
| `integer` | 32-bit signed integer |
| `real` | Floating-point number (simulation only) |
| `time` | Stores simulation time |

```verilog
reg [3:0] count;       // 4-bit register
integer i;             // loop variable
real delay_val;        // simulation use only
time t_start;
```

> ⚠️ **Key Insight:** `wire` vs `reg` is about *how a signal is driven*, not its hardware implementation.
> - Use `wire` for `assign` statements and module output connections.
> - Use `reg` inside `always` and `initial` blocks.

---

## ⚙️ Operators

### Arithmetic
```verilog
a + b    // Addition
a - b    // Subtraction
a * b    // Multiplication
a / b    // Division
a % b    // Modulus
```

### Relational
```verilog
a == b   // Equal
a != b   // Not equal
a >  b   // Greater than
a <  b   // Less than
a >= b   // Greater than or equal
a <= b   // Less than or equal
```

### Logical
```verilog
a && b   // Logical AND
a || b   // Logical OR
!a       // Logical NOT
```
> Returns 1-bit result (1 or 0)

### Bitwise
```verilog
a & b    // Bitwise AND
a | b    // Bitwise OR
a ^ b    // Bitwise XOR
~a       // Bitwise NOT
a ~^ b   // Bitwise XNOR (equivalence)
```

### Shift
```verilog
a << 2   // Logical left shift by 2
a >> 2   // Logical right shift by 2
a <<< 2  // Arithmetic left shift (preserves sign)
a >>> 2  // Arithmetic right shift (preserves sign)
```

### Reduction (Single Operand)
Reduces all bits of a vector to a single bit.
```verilog
&a       // AND of all bits
|a       // OR of all bits
^a       // XOR of all bits (parity)
~&a      // NAND of all bits
~|a      // NOR of all bits
```

### Conditional (Ternary)
```verilog
assign out = (sel) ? a : b;   // if sel=1 → a, else → b
```

### Concatenation & Replication
```verilog
{a, b}         // Join two signals
{4{a}}         // Replicate 'a' 4 times
{a, 3{b}, c}   // Mix of both
```

---

## 💻 Example: Using Data Types & Operators Together

```verilog
module data_ops_demo (
    input  wire [3:0] a, b,
    input  wire       sel,
    output reg  [4:0] sum,
    output wire [3:0] bitwise_and,
    output wire       parity,
    output wire [3:0] mux_out
);

    // Arithmetic: 5-bit sum to avoid overflow
    always @(*) begin
        sum = a + b;
    end

    // Bitwise AND
    assign bitwise_and = a & b;

    // Reduction XOR: even parity check of 'a'
    assign parity = ^a;

    // Conditional (MUX)
    assign mux_out = sel ? a : b;

endmodule
```

---

## 📌 Quick Reference Table

| Operator Type | Symbols |
|---|---|
| Arithmetic | `+` `-` `*` `/` `%` |
| Relational | `==` `!=` `>` `<` `>=` `<=` |
| Logical | `&&` `\|\|` `!` |
| Bitwise | `&` `\|` `^` `~` `~^` |
| Shift | `<<` `>>` `<<<` `>>>` |
| Reduction | `&` `\|` `^` `~&` `~\|` |
| Conditional | `? :` |
| Concatenation | `{ , }` |
| Replication | `{n{}}` |

---

## 🔗 Resources
- [IEEE Verilog Standard (1364-2005)](https://ieeexplore.ieee.org/document/1620780)
- [ASIC World – Verilog Tutorial](http://www.asic-world.com/verilog/veritut.html)
- [HDLBits – Practice Problems](https://hdlbits.01xz.net/)
- [Chip Verify](https://chipverify.com/verilog/verilog-data-types)

---

## 📅 Series Index
| Day | Topic |
|-----|-------|
| Day 1 | Introduction to Verilog & Module Structure |
| Day [X] | **Data Types & Operators** ← You are here |
| ... | More coming soon! |

---

*Learning in public. One day, one concept. 🚀*
