`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2026 10:32:16 AM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb();
    reg [31:0] a, b;
    reg [3:0] alu_op;
    
    wire signed[31:0] result;
    wire z;
    
    ALU dut(.a(a), .b(b), .alu_op(alu_op), .result(result), .z(z));
    
    initial begin
        alu_op = `ALU_ADD;
        a = 32'd5; b = 32'd3;
        #10;
        a = 32'd10; b = $signed(-32'd7);  
        #10;
        a = -32'sd10; b = -32'sd7;
        #10;
        a = -32'sh7FFFFFFF; b = 32'd1;
        #10;
        a = 32'd0; b = 32'd0;
        #10;
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
        #10;
        
        alu_op = `ALU_SUB;
        a = 32'd10; b = 32'd7;
        #10;
        a = 32'd7; b = 32'd10;
        #10;
        a = 32'd5; b = 32'd5;
        #10;
        a = 32'd5; b = 32'd0;
        #10;
        a = 32'sh80000000; b = 32'd1;
        #10;
        
        alu_op = `ALU_AND;
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
        #10;
        a = 32'hFFFFFFFF; b = 32'h00000000;
        #10;
        a = 32'hAAAAAAAA; b = 32'h55555555;
        #10;
        
        alu_op = `ALU_OR;
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
        #10;
        a = 32'hFFFFFFFF; b = 32'h00000000;
        #10;
        a = 32'hAAAAAAAA; b = 32'h55555555;
        #10;
        
        alu_op = `ALU_XOR;
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
        #10;
        a = 32'hFFFFFFFF; b = 32'h00000000;
        #10;
        a = 32'hAAAAAAAA; b = 32'h55555555;
        #10;
        
        alu_op = `ALU_SLL;
        a = 32'b1; b = 32'd0;
        #10 ;
        a = 32'b1; b = 32'd1;
        #10;
        a = 32'hFFFFFFFF; b = 32'd31;
        #10;
        a = 32'd1; b = 32'd33;
        #10;
        
        alu_op = `ALU_SRL;
        a = 32'b1; b = 32'd0;
        #10 ;
        a = 32'b1; b = 32'd1;
        #10;
        a = 32'hFFFFFFFF; b = 32'd31;
        #10;
        a = 32'd1; b = 32'd33;
        #10;
        a = 32'hFFFFFFFF; b = 32'd4;
        #10;
        alu_op = `ALU_SRA;
        a = 32'b1; b = 32'd0;
        #10; 
        a = 32'b1; b = 32'd1;
        #10;
        a = 32'hFFFFFFFF; b = 32'd31;
        #10;
        a = 32'd1; b = 32'd33;
        #10;
        a = 32'hFFFFFFFF; b = 32'd4;
        #10;
        a = 32'h7FFFFFFF; b = 32'd4;
        #10;
        alu_op = `ALU_SLT;
        a = 32'd0; b = 32'd1;
        #10;
        a = 32'd5; b = 32'd10;
        #10;
        a = 32'd5; b = 32'd5;
        #10;
        a = 32'h80000000; b = 32'h7FFFFFFF;
        #10;
        
        alu_op = `ALU_SLTU;
        a = 32'd0; b = 32'd1;
        #10;
        a = 32'd5; b = 32'd10;
        #10;
        a = 32'd5; b = 32'd5;
        #10;
        a = 32'h80000000; b = 32'h7FFFFFFF;
        #10;
     end
        
endmodule
