`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2026 11:37:03 AM
// Design Name: 
// Module Name: intr_decode
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


module intr_decode(
    input funct7,
    input [2:0] funct3,
    input [6:0] opcode,
    output reg [2:0] imm_ctrl,
    output rf_we,
    output alu_ctrl1,
    output alu_ctrl2,
    output reg [3:0] alu_op,
    output data_read,
    output data_write,
    output reg [2:0] branch_type,
    output reg [1:0] pc_control,
    output reg [1:0] wb_ctrl
    );
    
    assign rf_we = (opcode == `OP_RTYPE) | (opcode == `OP_ITYPE) | (opcode == `OP_LOAD) | (opcode == `OP_JTYPE) | (opcode == `OP_AUIPC) | (opcode == `OP_LUI);
    assign alu_ctrl1 = (opcode == `OP_ITYPE) | (opcode == `OP_AUIPC) | (opcode == `OP_LUI) | (opcode == `OP_STYPE) | (opcode == `OP_LOAD) | (opcode == `OP_JALR);
    assign alu_ctrl2 = (opcode == `OP_AUIPC);
    assign data_read = (opcode == `OP_LOAD);
    assign data_write = (opcode == `OP_STYPE);
    always@(*) begin
        //Immediate Generator Control Signals
        imm_ctrl = `IMM_ITYPE; //default case
        if(opcode == `OP_ITYPE || opcode == `OP_LOAD || opcode == `OP_JALR) imm_ctrl = `IMM_ITYPE;
        else if (opcode == `OP_BTYPE) imm_ctrl = `IMM_BRANCH;
        else if (opcode == `OP_STYPE) imm_ctrl = `IMM_STORE;
        else if (opcode == `OP_LUI || opcode == `OP_AUIPC) imm_ctrl = `IMM_UTYPE;
        else if (opcode == `OP_JTYPE) imm_ctrl = `IMM_JAL;
        
        //ALU Control Signals
        alu_op = `ALU_ADD; //default case
        if(opcode == `OP_RTYPE || opcode == `OP_ITYPE) begin
            case(funct3)
                3'b000: if(funct7 == 0)alu_op = `ALU_ADD;else alu_op = `ALU_SUB;
                3'b001: alu_op = `ALU_SLL;
                3'b010: alu_op = `ALU_SLT;
                3'b011: alu_op = `ALU_SLTU;
                3'b100: alu_op = `ALU_XOR;
                3'b101: if(funct7 == 0)alu_op = `ALU_SRL;else alu_op = `ALU_SRA;
                3'b110: alu_op = `ALU_OR;
                3'b111: alu_op = `ALU_AND;
            endcase 
         end   
         
         else if(opcode == `OP_LOAD || opcode == `OP_STYPE || opcode == `OP_AUIPC) alu_op = `ALU_ADD;
         else if(opcode == `OP_BTYPE) begin
            if(funct3 == 3'b000 || funct3 == 3'b001) alu_op = `ALU_SUB;
            else if(funct3 == 3'b100 || funct3 == 3'b101) alu_op = `ALU_SLT;
            else if(funct3 == 3'b110 || funct3 == 3'b111) alu_op = `ALU_SLTU;
         end  
         else if(opcode == `OP_LUI) alu_op = `ALU_LUI;
         
         //PC Control Control Signals
         
         //Branch Control
         branch_type = `NONE; //default branch type
         if(opcode == `OP_BTYPE) begin
            case(funct3)
                3'b000: branch_type = `BEQ;
                3'b001: branch_type = `BNE;
                3'b100: branch_type = `BLT;
                3'b101: branch_type = `BGE;
                3'b110: branch_type = `BLTU;
                3'b111: branch_type = `BGEU;
                default: branch_type = `NONE;
            endcase
         end
         
         //PC Control
         pc_control = `STANDARD; //default pc control
         if(opcode == `OP_JTYPE) pc_control = `JAL;
         else if(opcode == `OP_JALR) pc_control = `JALR;
         
         //Writeback Control
         wb_ctrl = `WB_ALU;
         if(opcode == `OP_RTYPE || opcode == `OP_ITYPE)wb_ctrl = `WB_ALU;
         else if(opcode == `OP_LOAD) wb_ctrl = `WB_DMEM;
         else if(opcode == `OP_JTYPE || opcode == `OP_JALR) wb_ctrl = `WB_PC;
       end
endmodule
