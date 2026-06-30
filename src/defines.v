`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 01:00:57 PM
// Design Name: defines
// Module Name: defines
// Project Name: ANKM
// Target Devices: 
// Tool Versions: 
// Description: Header File w/ global variables
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//ALU Ops:
`define ALU_ADD  4'b0000
`define ALU_SUB  4'b0001
`define ALU_AND  4'b0010
`define ALU_OR   4'b0011
`define ALU_XOR  4'b0100
`define ALU_SLL  4'b0101
`define ALU_SRL  4'b0110
`define ALU_SRA  4'b0111
`define ALU_SLT  4'b1000
`define ALU_SLTU 4'b1001

//Opcode Encodings:
`define OP_RTYPE  7'b0110011
`define OP_ITYPE  7'b0010011
`define OP_LOAD   7'b0000011
`define OP_STYPE  7'b0100011
`define OP_BTYPE 7'b1100011
`define OP_JTYPE    7'b1101111
`define OP_JALR   7'b1100111
`define OP_LUI    7'b0110111
`define OP_AUIPC  7'b0010111