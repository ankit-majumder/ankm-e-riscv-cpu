`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2026 11:48:30 AM
// Design Name: 
// Module Name: register_file_tb
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


module register_file_tb();
    reg [4:0] rs1, rs2, rd;
    reg [31:0] data_write;
    reg rf_we, clk;
    
    wire [31:0] rs1_out, rs2_out;
    
    register_file dut(.rs1(rs1), .rs2(rs2), .rd(rd), .data_write(data_write), .rf_we(rf_we), .clk(clk), .rs1_out(rs1_out), .rs2_out(rs2_out));
    
    initial clk = 0;
    always #5 clk  = ~clk;
    
    initial begin
        rf_we = 1; rs1 = 5'd0; rs2 = 5'd0; rd = 5'd14; data_write = 31'd250;
        #10
        rf_we = 1; rs1 = 5'd14; rs2 = 5'd0; rd = 5'd14; data_write = 31'd214;
        #10
        rf_we = 0; rs1 = 5'd14; rs2 = 5'd0; rd = 5'd10; data_write = 31'd210;
        #10
        rf_we = 1; rs1 = 5'd14; rs2 = 5'd0; rd = 5'd10; data_write = 31'd210;
        #10
        rf_we = 1; rs1 = 5'd14; rs2 = 5'd10; rd = 5'd0; data_write = 31'd210;
        #10;
        rf_we = 0; rs1 = 5'd14; rs2 = 5'd0; rd = 5'd14; data_write = 31'd210;
        #10;
        rf_we = 1; rs1 = 5'd14; rs2 = 5'd10; rd = 5'd0; data_write = 31'd210;
        #10;
    end 
    
endmodule
