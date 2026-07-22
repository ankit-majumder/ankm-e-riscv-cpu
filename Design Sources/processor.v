`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: N/A
// Engineer: Ankit Majumder
// 
// Create Date: 06/09/2026 10:30:05 AM
// Design Name: processor
// Module Name: processor
// Project Name: ankm-risc-v
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

//adder for pc
module adder(input[31:0] pc, val, output[31:0] result);
    assign result = pc + val;
endmodule

//branch/jump select
module mux3(input[31:0] a, b, c, input[1:0] select, output reg[31:0] result);
    always@(*) begin
        case(select)
            2'b00: result = a;
            2'b01: result = b;
            2'b10: result = c;
        endcase
    end        
endmodule

module processor(
    input clk, reset
    );
    
    wire[31:0] pc_next, pc, instruction, pcstandard, pcjal, immediate;
    
    //Control Signals
    wire[3:0] alu_op;
    wire[2:0] imm_ctrl, branch_type, mem_ctrl;
    wire[1:0] pc_ctrl, wb_ctrl;
    wire rf_we, alu_ctrl1, alu_ctrl2, data_read, data_write;
     
    PC ip(.clk(clk), .reset(reset), .pc_next(pc_next), .pc(pc)); // program counter
    adder pcplus4(.pc(pc), .val(32'd4), .result(pcstandard)); //default next instruction pointer
    IMEM imem(.pc(pc), .instruction(instruction)); //instruction memory
    //instruction decoder
    intr_decode controller(.funct7(instruction[31]), .funct3(instruction[14:12]), .opcode(instruction[6:0]), .alu_op(alu_op),
        .imm_ctrl(imm_ctrl), .branch_type(branch_type), .mem_ctrl(mem_ctrl), .pc_ctrl(pc_ctrl), .wb_ctrl(wb_ctrl), .rf_we(rf_we),
        .alu_ctrl1(alu_ctrl1), .alu_ctrl2(alu_ctrl2), .data_read(data_read), .data_write(data_write));
    
    imm_generate(.imm_sel(imm_ctrl), .instruction(instruction), .immediate(immediate)); //immediate generator
    adder pcplusimm(.pc(pc), .val(immediate), .result(pcjal)); //JAL/Branch taken next instruction pointer
    
    
    
    
endmodule
