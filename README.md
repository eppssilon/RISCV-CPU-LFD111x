# RISC-V CPU Core in TL-Verilog (LFD111x)

A single-cycle RISC-V CPU core (RV32I subset), written in TL-Verilog and simulated in the Makerchip IDE, built while completing the Linux Foundation course [LFD111x: Building a RISC-V CPU Core](https://training.linuxfoundation.org/training/building-a-risc-v-cpu-core-lfd111x/).

The final core is in [`Chapter 5/risc-v_shell.tlv`](Chapter%205/risc-v_shell.tlv). It runs the course test program to completion and reports `Simulation PASSED!!!`.

## What the core does

Every instruction completes in one clock cycle: fetch, decode, register read, execute, memory access and write-back all happen in the same cycle.

- **Program counter:** increments by 4, or takes the branch, JAL or JALR target. Reset to 0.
- **Decode:** identifies the instruction type (R, I, S, B, U, J), extracts the fields (rd, rs1, rs2, funct3, opcode), builds the sign-extended immediate for each format, and decodes each instruction from funct7[5], funct3 and the opcode.
- **ALU:** arithmetic, logic, shifts (including arithmetic right shift through sign extension) and signed and unsigned comparisons.
- **Branches and jumps:** BEQ, BNE, BLT, BGE, BLTU, BGEU, JAL and JALR, with the signed comparisons handled on the sign bits.
- **Loads and stores:** address computed in the ALU (rs1 + imm), word access to a small data memory, and a mux that writes either the ALU result or the loaded data back to the register file.

## Instructions supported

31 of the 47 RV32I base instructions:

- **U-type:** LUI, AUIPC
- **Jumps:** JAL, JALR
- **Branches:** BEQ, BNE, BLT, BGE, BLTU, BGEU
- **Immediate ALU:** ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
- **Register ALU:** ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
- **Memory:** loads and stores, word-aligned (all load and store variants are treated as LW and SW)

Not implemented: byte and halfword memory access, FENCE, ECALL, EBREAK.

## What I wrote and what the course provides

I wrote the PC logic, the instruction decoder, the immediate generation, the ALU, the branch and jump logic, and the wiring between them. The register file, the instruction and data memories, the test program and the visualization are macros from the course library (`risc-v_shell_lib.tlv`), which the file includes.

## Repository layout

- `Chapter 2/`: TL-Verilog basics labs (logic gates, a combinational calculator, then a sequential one)
- `Chapter 4/`: the first working core, running a small program that sums the numbers 1 to 9
- `Chapter 5/`: the completed core, running the full course test program

## Running it

1. Open the [Makerchip IDE](https://makerchip.com/sandbox/).
2. Replace the editor contents with `Chapter 5/risc-v_shell.tlv` and compile.
3. The LOG tab should end with `Simulation PASSED!!!`, and the VIZ tab shows the program executing cycle by cycle, with the registers and data memory.

## Possible next steps

- Pipeline the core and handle the resulting hazards.
- Build a UVM testbench around it.
