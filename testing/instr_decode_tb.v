`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 10:19:54 AM
// Design Name: 
// Module Name: instr_decode_tb
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


module instr_decode_tb();
    reg funct7;
    reg[2:0] funct3;
    reg[6:0] opcode;
    
    wire rf_we, alu_ctrl1, alu_ctrl2, data_read, data_write;
    wire[2:0] imm_ctrl;
    wire[3:0] alu_op;
    wire[2:0] branch_type;
    wire[1:0] pc_control;
    wire[1:0] wb_ctrl;
    
    intr_decode dut(.funct7(funct7), .funct3(funct3), .opcode(opcode), .rf_we(rf_we), .alu_ctrl1(alu_ctrl1), .alu_ctrl2(alu_ctrl2), .data_read(data_read), .data_write(data_write), .imm_ctrl(imm_ctrl),
    .alu_op(alu_op), .branch_type(branch_type), .pc_control(pc_control), .wb_ctrl(wb_ctrl));
    
    initial begin
        //R_type Instructions
        opcode = `OP_RTYPE; 
        
        //Funt3 differentiator;
        funct3 = 3'b000; funct7 = 1'b0; //add
        #10
        funct3 = 3'b010; funct7 = 1'b0; //slt
        #10
        
        //Funct7 differentiator;
        funct3 = 3'b000; funct7 = 1'b1; //sub
        #10
        
        //I_Type Instructions
        opcode = `OP_ITYPE; funct3 = 3'b000; funct7 = 1'b0; //addi, funct7 is placeholder, it will never be read
        #10
        
        //Load Instructions
        opcode = `OP_LOAD; funct3 = 3'b010; funct7 = 1'b0; //lw
        #10
        
        //Store Instructions
        opcode = `OP_STYPE; funct3 = 3'b000; funct7 = 1'b0; //sb
        #10
        
        //Jalr Check
        opcode = `OP_JALR; funct3 = 3'b000; funct7 =  1'b0; //jalr
        #10
        
        //Branch Instructions w/ funct3 diff.
        opcode = `OP_BTYPE; funct7 = 1'b0;
        funct3 = 3'b000; //beq
        #10
        funct3 = 3'b001; //bne
        #10
        funct3 = 3'b100; //blt
        #10
        funct3 = 3'b101; //bge
        #10
        funct3 = 3'b110; //bltu
        #10
        funct3 = 3'b111; //bgeu
        #10
        
        //Jal Check
        opcode = `OP_JTYPE; funct3 = 3'b000; funct7 = 1'b0;
        #10
        
        //U Type instructions
        opcode = `OP_LUI; funct3 = 3'b000; funct7 = 1'b0;
        #10
        opcode = `OP_AUIPC; funct3 = 3'b000; funct7 = 1'b0;
        #10;
    end
endmodule
