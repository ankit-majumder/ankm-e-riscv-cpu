`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 12:31:15 PM
// Design Name: 
// Module Name: imm_generate_tb
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


module imm_generate_tb(
    
    );
    
    reg[2:0] imm_sel;
    reg[31:0] instruction;
    wire[31:0] immediate;
    
    imm_generate dut(.imm_sel(imm_sel), .instruction(instruction), .immediate(immediate));
    
    initial begin
        instruction = 32'b0; imm_sel = `IMM_ITYPE;
    #10;
    
    instruction = 32'hFFF00000; imm_sel = `IMM_ITYPE;
    #10;
    
    instruction = 32'h00100000; imm_sel = `IMM_ITYPE;
    #10;
    
    instruction = 32'h7FF00000; imm_sel = `IMM_ITYPE;
    #10;
    
    instruction = 32'hFE000F80; imm_sel = `IMM_STORE;
    #10;
    
    instruction = 32'h00000F80; imm_sel = `IMM_STORE;
    #10;
    
    instruction = 32'hFE000F80; imm_sel = `IMM_BRANCH;
    #10;
    
    instruction = 32'h00000F80; imm_sel = `IMM_BRANCH;
    #10;
    
    instruction = 32'hFFFFF000; imm_sel = `IMM_UTYPE;
    #10;
    
    instruction = 32'h010FF347; imm_sel = `IMM_UTYPE;
    #10;
    
    instruction = 32'hFFFFF000; imm_sel = `IMM_JAL;
    #10;
    
    instruction = 32'h000FF000; imm_sel = `IMM_JAL;
    #10;
    
    instruction = 32'h80000000; imm_sel = `IMM_ITYPE;
    #10;
    
    instruction = 32'h80000000; imm_sel = `IMM_STORE;
    #10;
    
    instruction = 32'h80000000; imm_sel = `IMM_BRANCH;
    #10;
    
    instruction = 32'h80000000; imm_sel = `IMM_JAL;
    #10;
    
    $finish;
    
    end
endmodule
