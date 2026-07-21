`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2026 11:53:05 AM
// Design Name: 
// Module Name: pc_ctrl_tb
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


module pc_ctrl_tb();
reg[2:0] branch_check;
reg[1:0] pc_control;
reg[31:0] alu_result;
reg z;

wire [1:0] pc_select;

pc_ctrl dut(.branch_check(branch_check), .pc_control(pc_control), .alu_result(alu_result), .z(z), .pc_select(pc_select));

initial begin 
    // No branch, standard PC
    branch_check = `NONE; pc_control = `STANDARD; alu_result = 32'b0; z = 0;
    #10;
    
    // BEQ taken (z=1)
    branch_check = `BEQ; pc_control = `STANDARD; z = 1;
    #10;
    
    // BEQ not taken (z=0)
    branch_check = `BEQ; pc_control = `STANDARD; z = 0;
    #10;
    
    // BNE taken (z=0)
    branch_check = `BNE; pc_control = `STANDARD; z = 0;
    #10;
    
    // BNE not taken (z=1)
    branch_check = `BNE; pc_control = `STANDARD; z = 1;
    #10;
    
    // BLT taken (alu_result[0]=1)
    branch_check = `BLT; pc_control = `STANDARD; alu_result = 32'd1; z = 0;
    #10;
    
    // BLT not taken (alu_result[0]=0)
    branch_check = `BLT; pc_control = `STANDARD; alu_result = 32'd0;
    #10;
    
    // BGE taken (alu_result[0]=0)
    branch_check = `BGE; pc_control = `STANDARD; alu_result = 32'd0;
    #10;
    
    // BGE not taken (alu_result[0]=1)
    branch_check = `BGE; pc_control = `STANDARD; alu_result = 32'd1;
    #10;
    
    // BLTU taken (alu_result[0]=1)
    branch_check = `BLTU; pc_control = `STANDARD; alu_result = 32'd1;
    #10;
    
    // BLTU not taken (alu_result[0]=0)
    branch_check = `BLTU; pc_control = `STANDARD; alu_result = 32'd0;
    #10;
    
    // BGEU taken (alu_result[0]=0)
    branch_check = `BGEU; pc_control = `STANDARD; alu_result = 32'd0;
    #10;
    
    // BGEU not taken (alu_result[0]=1)
    branch_check = `BGEU; pc_control = `STANDARD; alu_result = 32'd1;
    #10;
    
    // JAL
    branch_check = `NONE; pc_control = `JAL; alu_result = 32'd0; z = 0;
    #10;
    
    // JALR
    pc_control = `JALR;
    #10;
    
    $finish;
end

endmodule
