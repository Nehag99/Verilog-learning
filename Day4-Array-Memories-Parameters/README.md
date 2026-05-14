
# Day 4 — Arrays, Memories & Parameters
> 🗓️ 30 Days of Verilog | Week 1

## What I learned

Today I leveled up from writing modules to writing reusable ones.

What clicked today:
▸ Packed vs unpacked arrays — and why the bracket side matters
▸ Modeled RAM using 2D reg arrays + loaded data with $readmemh
▸ parameter makes modules generic; localparam keeps internals safe
▸ One parameterized module → works at 8-bit, 16-bit, 32-bit ✅

The real unlock? Writing reg [7:0] mem [0:255] and realizing you just described a memory chip in one line.

**Arrays**
```verilog
reg [7:0] mem [0:255]; // 256-byte unpacked array (RAM-like)
reg [3:0][7:0] bus;    // packed — single 32-bit vector
```

**Memories**
```verilog
reg [7:0] rom [0:15];
initial $readmemh("data.hex", rom); // load from file
```

**Parameters**
```verilog
module adder #(parameter WIDTH = 8)(
  input  [WIDTH-1:0] a, b,
  output [WIDTH:0]   sum
);
  assign sum = a + b;
endmodule

// Override at instantiation
adder #(.WIDTH(16)) u1 (.a(x), .b(y), .sum(s));
```

## Key insight
`parameter` = configurable from outside · `localparam` = internal constant only
