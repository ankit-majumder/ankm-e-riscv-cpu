`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 11:50:21 AM
// Design Name: 
// Module Name: imm_generate
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_generate(
    input[2:0] imm_sel,
    input[31:0] instruction,
    output reg[31:0] immediate
);

always@(*) begin
    case(imm_sel)
        `IMM_ITYPE: immediate = {{20{instruction[31]}}, instruction[31:20]};
        `IMM_STORE: immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        `IMM_BRANCH: immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        `IMM_UTYPE: immediate = instruction[31:12] << 12;
        `IMM_JAL: immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
    endcase
end

endmodule
