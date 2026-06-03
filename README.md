# ANKM-E: Pipelined RV32I Processor
ANKM-E is an educational level pipelined RISC-V processor created by Ankit Majumder

# Overview: 
As a current rising Junior at UT Austin, this self-directed project is my first foray into computer architecture and chip design. RiSC-V is a fast growing ISA which has similarities to the MIPS and LC3 ISA's which I have previously learned, so it seemed like the natural ISA on which to build my microarchitecture and develop my processor. Using previous knowledge on datapaths, verilog, and sequential logic from the ECE316 class taught by Professor Orshansky, and self studying computer architecture lectures by Professor Mutlu, my final goal is a fully functional, pipelined, compliance tested RISC-V CPU with a simulated cache, synthesized onto a BASYS-3 board. 

# Current Status:
Completed:
- ISA Design Doc
- Single Cycle Microarchitecture / RTL Datapath

In Progress:
- Single-Cycle Verilog Implementation

Planned:
- 5-stage pipeline w/ Hazard Handling
- L1 and L2 Cache Simulation
- RISC-V Compliance and Benchmarke suites

# ISA Design:
Link to ISA Design Doc: 

# Datapath/Microarchitecture:
Link to Datapath:

# Design Decisions:
- Seperate Instruction Memory and Data Memory, instructions must be read and memory must be written to in the same cycle for single-cycle implementation
- Control Unit is combinational, not sequential because the control signals depend solely on the instruction encoding, and changing control signals mid-clock cycle does not affect current instruction processing

# Tools/Environment:
- AMD Vivado for final simulation / synthesis
- Icarus Verilog / VS Code / GTKWave for daily testing
- Basys3 FPGA board

# Resources:
- Onur Mutlu Video Lecture Series (Spring 2022)
- RISC-V Unprivileged ISA Specification - Volume 1
- RISC-V Reference Data Green Card
