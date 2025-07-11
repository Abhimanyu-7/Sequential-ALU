
# 🧮 Sequential ALU in Verilog

A synthesizable, clocked Arithmetic Logic Unit (ALU) designed in Verilog HDL with support for core arithmetic, logic, shift, and comparison operations. It is parameterized for width and includes status flags such as Carry, Zero, Negative, and Overflow. This ALU is designed to integrate cleanly into processor datapaths, RTL testbenches, or SoC modules.

---

## 📌 Features

- ✅ **Parameterizable** input/output width (default: 8 bits)
- ✅ **Synchronous operation** (clock + active-high reset)
- ✅ **ALU Operations Supported:**
  | Op Code | Operation | Description |
  |--------|------------|-------------|
  | `0000` | ADD        | A + B (signed/unsigned addition) |
  | `0001` | SUB        | A − B (signed/unsigned subtraction) |
  | `0010` | AND        | Bitwise A & B |
  | `0011` | OR         | Bitwise A \| B |
  | `0100` | XOR        | Bitwise A ^ B |
  | `0101` | SLL        | Logical left shift |
  | `0110` | SRL        | Logical right shift |
  | `0111` | SRA        | Arithmetic right shift (sign preserved) |
  | `1000` | SLT        | Set Less Than (signed comparison) |

- ✅ **Status Flags:**
  - `Zero`: Result is zero
  - `Carry`: Indicates carry out or borrow
  - `Negative`: MSB of the result
  - `Overflow`: Signed overflow detection

---

## 🛠️ Architecture

The ALU consists of two main components:

1. **Combinational Logic Block:** Calculates the intermediate result (`temp`) and flags (`carry`, `overflow`) based on `A`, `B`, and `ALU_sel`.
2. **Sequential Output Block:** Registers all outputs on the rising edge of the clock or clears them during an active-high reset.

---

## 🔄 Reset and Timing Behavior

- **Reset Type:** Active-high synchronous reset
- **Clock Edge:** Positive-edge triggered
- **Output Update:** Registered at rising edge of `clk` unless reset is high

---

## 📁 Project Structure


# Project Title

A brief description of what this project does and who it's for


---

## 🚧 TODO / Work in Progress

-  Build **SystemVerilog testbench** with:
    - Random stimulus generation
    - Edge cases for overflow, signed vs unsigned ops
    - Coverage report
    - Add waveform dumps using `$dumpfile`, `$dumpvars`
- Add formal assertions and functional coverage
- Integrate with simple RISC-style instruction decode

---

## 📷 Example Waveform (To Be Added)

> A waveform snapshot showing ALU computing a signed SUB with Overflow = 1.

---

## 📜 Synthesis Compatibility

This design is 100% synthesizable and compatible with:

- 🛠️ **Vivado**
- 🛠️ **Quartus**
- 🛠️ **ModelSim / QuestaSim**
- 🛠️ **Synopsys Design Compiler**
- ✅ Works in simulation and hardware targets (FPGA)

---

## ✍️ Author

**Abhimanyu Kumar**  
3rd Year ENC Student | Thapar Institute  
Aspiring VLSI Engineer | Passion for RTL Design, Computer Architecture, SoCs

---

## 📬 Contact

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/)
- [GitHub](https://github.com/)
- Email: abhimanyu.kumar1618@gmail.com

