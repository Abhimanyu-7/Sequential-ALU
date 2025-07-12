# 🧮 Sequential ALU 

A synthesizable, clocked Arithmetic Logic Unit (ALU) written in Verilog HDL with support for core arithmetic, logic, shift, and comparison operations. This ALU is **parameterized** for width and includes **status flags** such as Carry, Zero, Negative, and Overflow. It is designed for easy integration into processor datapaths, RTL testbenches, or SoC modules.

## 📚 Table of Contents

- [🔧 RTL Design](#-rtl-design)
- [🧪 Simulation](#-simulation-using-icarus-verilog--gtkwave)
- [⚙️ Synthesis using Yosys](#️-synthesis-using-yosys)
- [🏁 Gate-Level Simulation (GLS)](#-gate-level-simulation-gls)
- [📐 Area Estimation](#-area-estimation)
- [📷 Netlist Visualization (DOT)](#-netlist-visualization-dot)
- [🧠 Testbench and Verification Strategy](#-testbench-and-verification-strategy)
- [🧰 Project Structure](#-project-structure)
- [📎 References and Resources](#-references-and-resources)
- [✍️ Author](#️-author)
- [📬 Contact](#-contact)

## 🔧 RTL Design

- ✅ **Parameterizable** input/output width (default: 8 bits)
- ✅ **Synchronous operation** (clock + active-high reset)
- ✅ **Supported ALU Operations:**

| Op Code | Operation | Description                      |
|--------:|-----------|----------------------------------|
| `0000`  | ADD       | A + B (signed/unsigned)          |
| `0001`  | SUB       | A − B (signed/unsigned)          |
| `0010`  | AND       | Bitwise AND                      |
| `0011`  | OR        | Bitwise OR                       |
| `0100`  | XOR       | Bitwise XOR                      |
| `0101`  | SLL       | Logical left shift               |
| `0110`  | SRL       | Logical right shift              |
| `0111`  | SRA       | Arithmetic right shift           |
| `1000`  | SLT       | Set Less Than (signed comparison)|

- ✅ **Status Flags:**
  - `Zero`: Result is zero  
  - `Carry`: Carry-out or borrow  
  - `Negative`: MSB of result  
  - `Overflow`: Signed overflow detection


## 🛠️ Architecture

The ALU is divided into two key blocks:

1. **Combinational Logic Block**  
   Computes the result and status flags based on `A`, `B`, and `ALU_sel`.

2. **Sequential Output Block**  
   Registers outputs synchronously on the rising edge of `clk` or clears them during an active-high `reset`.

   ### Additional Features
      - **Reset Type:** Active-high synchronous reset  
      - **Clock Edge:** Positive-edge triggered  
      - **Output Update:** All outputs are updated at `posedge clk`, unless `reset` is high

---
## 🧪 Simulation using Icarus Verilog + GTKWave

- Testbench written in SystemVerilog
- Uses `$dumpfile`, `$dumpvars` for waveform output
- Simulated using:

```bash
iverilog -o alu_sim alu.v alu_tb.sv
vvp alu_sim
gtkwave waveform.vcd
```

## 📁 Project Structure
```
.
├── alu.v # ALU RTL module
├── alu_tb.sv # SystemVerilog testbench (WIP)
├── waveform.vcd # Sample VCD file for GTKWave
├── yosys_synth.ys # Yosys synthesis script
└── README.md # This file
```
---

## ⚙️ Synthesis using Yosys

Uses sky130_fd_sc_hd__tt_025C_1v80.lib standard cell library

  ### 1.  
    https://yosyshq.net/yosys/

  ### 2. Write Synthesis Script (`yosys_synth.ys`)

```yosys
# Load the Liberty file with area info
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Read your Verilog RTL
read_verilog alu.v

# Run synthesis
synth -top ALU

# Map to standard cells from Liberty
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# Generate area/timing report
stat -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

#Write netlist to alu_synth.v
write_verilog alu_synth.v

#Show netlist (.dot file) using Graphviz
show -format dot -prefix alu_netlist
```

## 🏁 Gate-Level Simulation (GLS)

    Simulate the synthesized netlist using original testbench:

iverilog -o alu_gls alu_synth.v alu_tb.sv
vvp alu_gls

    Use GTKWave to view post-synthesis waveform and confirm logic equivalence

## 📐 Area Estimation

    Total cells used: 258

    Synthesized area: 1669.10 µm²

    Technology: Sky130 standard cell library

    Includes flip-flops, MUXes, logic gates

## 📷 Netlist Visualization (DOT)

Yosys command:
```
show -format dot -prefix alu_netlist
```
Render using Graphviz:
```
dot -Tpng alu_netlist.dot -o alu_netlist.png
```

## 🧠 Testbench and Verification Strategy

    Random stimulus generation (planned)

    Edge case testing: overflow, SLT, carry

    Functional coverage (WIP)

    Formal assertions (future work)

## 📎 References and Resources

    Sky130 PDK

    Yosys HQ

    GTKWave

    Graphviz

## ✍️ Author

Abhimanyu Kumar
3rd Year ENC Student | Thapar Institute
Aspiring VLSI Engineer | Passion for RTL Design, Computer Architecture, SoCs

## 📬 Contact



