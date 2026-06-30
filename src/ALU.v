`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Ankit Majumder
// 
// Create Date: 06/16/2026 11:50:57 AM
// Design Name: ALU
// Module Name: ALU
// Project Name: ANKM
// Target Devices: 
// Tool Versions: 
// Description: ALU module for operations in the ANKM processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: alu_op has 10 possible control signals, branches have same control signal as subtraction, also carry out bit is used for unsigned comparison
// because if a borrow occured, then bltu is true and c is set to 1, otherwise bgeu is true and c is set to 0
// use slt and sltu flag for blt, bltu, bge, bgeu because overflow will be handled internally during synthesis, no need to track overflow ourself
// shift only bits 4:0 of rs2 are considered for a shifts, as shifting above 31 bits, just wraps around, so shiftin by 32 actually shifts by 32 mod 32 = 0 bits.
// carry bit only checks for the extra bit of sub, because it tells us whether a wraparound occured, only happens if a<b when a-b. 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [31:0] a, 
    input [31:0] b,
    input [3:0] alu_op,
    output reg signed [31:0] result,
    output z
    );

    always@(*) begin
        case(alu_op)
            `ALU_ADD: result = a + b;
            `ALU_SUB: result = a - b;
            `ALU_AND: result = a & b;
            `ALU_OR: result = a | b;
            `ALU_XOR: result = a ^ b;
            `ALU_SLL: result = a << b[4:0];
            `ALU_SRL: result = a >> b[4:0];
            `ALU_SRA: result = $signed(a) >>> b[4:0];
            `ALU_SLT: result = $signed(a) < $signed(b);
            `ALU_SLTU: result = a < b;
            default: result = 32'b0;         
         endcase         
       end
    assign z = (result == 32'b0);
   
endmodule
