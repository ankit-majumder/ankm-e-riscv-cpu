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

module mux2(input[31:0]  a, b,  input select, output[31:0] result);
    assign result = (select)? b : a;
endmodule

module processor(
    input clk, reset
    );
    
    //Intermediate signals
    wire[31:0] pc_next, pc, instruction, pcstandard, pcjal, immediate, wb_data, rs1out, rs2out, aluA, aluB, alu_result, dmem_out;
    wire[1:0] pc_select;
    wire z;
    
    //Control Signals
    wire[3:0] alu_op;
    wire[2:0] imm_ctrl, branch_type, mem_ctrl;
    wire[1:0] pc_ctrl, wb_ctrl;
    wire rf_we, alu_ctrl1, alu_ctrl2, data_read, data_write;
    
    //Datapath 
    PC ip(.clk(clk), .reset(reset), .pc_next(pc_next), .pc(pc)); // program counter
    adder pcplus4(.pc(pc), .val(32'd4), .result(pcstandard)); //default next instruction pointer
    IMEM imem(.pc(pc), .instruction(instruction)); //instruction memory
    //instruction decoder
    intr_decode controller(.funct7(instruction[31]), .funct3(instruction[14:12]), .opcode(instruction[6:0]), .alu_op(alu_op),
        .imm_ctrl(imm_ctrl), .branch_type(branch_type), .mem_ctrl(mem_ctrl), .pc_ctrl(pc_ctrl), .wb_ctrl(wb_ctrl), .rf_we(rf_we),
        .alu_ctrl1(alu_ctrl1), .alu_ctrl2(alu_ctrl2), .data_read(data_read), .data_write(data_write));
    
    imm_generate(.imm_sel(imm_ctrl), .instruction(instruction), .immediate(immediate)); //immediate generator
    adder pcplusimm(.pc(pc), .val(immediate), .result(pcjal)); //JAL/Branch taken next instruction pointer
    
    register_file rf(.rs1(instruction[19:15]), .rs2(instruction[24:20]), .rd(instruction[11:7]), .data_write(wb_data), .rf_we(rf_we), .clk(clk), .rs1out(rs1out), .rs2out(rs2out)); //register file
    mux2 rs1mux(.a(rs1out), .b(pc), .select(alu_ctrl2), .result(aluA)); //Selector between rs1 and pc (AUIPC instruction)
    mux2 rs2mux(.a(rs2out), .b(immediate), .select(alu_ctrl1), .result(aluB));//Selector between rs2 and immediate (I/S type instructions)
    
    ALU alu(.a(aluA), .b(aluB), .alu_op(alu_op), .result(alu_result), .z(z)); //arithmetic logic unit
    DMEM dmem(.clk(clk), .dmem_write(data_write), .dmem_read(data_read), .write_data(rs2out), .address(alu_result), .mem_ctrl(mem_ctrl), .dmem_out(dmem_out)); //data memory
    
    mux3 wbmux (.a(alu_result), .b(dmem_out), .c(pcstandard), .select(wb_ctrl), .result(wb_data)); //Selector for register file writeback
    pc_ctrl ipcontroller(.branch_check(branch_type), .pc_control(pc_ctrl), .alu_result(alu_result), .z(z), .pc_select(pc_select)); //PC Select Controller
    
    mux3 pcmux (.a(pcstandard), .b(pcjal), .c(alu_result), .select(pc_select), .result(pc_next)); //Selector for next instruction pointer
    
    
endmodule
