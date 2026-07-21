`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2026 12:27:16 PM
// Design Name: 
// Module Name: pc_ctrl
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


module pc_ctrl(
    input [2:0] branch_check,
    input [1:0] pc_control,
    input [31:0] alu_result, 
    input z,
    output reg [1:0] pc_select
    );
    
    always@(*) begin
        case(pc_control)
            `STANDARD: begin
                case(branch_check)
                    `NONE: pc_select = `STANDARD;
                    `BEQ: pc_select = (z==1) ? `JAL : `STANDARD;
                    `BNE: pc_select = (z == 0) ? `JAL : `STANDARD;
                    `BLT: pc_select = (alu_result[0] == 1) ? `JAL : `STANDARD;
                    `BGE: pc_select = (alu_result[0] == 0) ? `JAL : `STANDARD;
                    `BLTU: pc_select = (alu_result[0] == 1) ? `JAL : `STANDARD;
                    `BGEU: pc_select = (alu_result[0] == 0) ? `JAL : `STANDARD;
                    default: pc_select = `STANDARD;
                endcase
               end
             `JAL: pc_select = `JAL;
             `JALR: pc_select = `JALR;
             default: pc_select = `STANDARD;      
        endcase
    end
    
endmodule
