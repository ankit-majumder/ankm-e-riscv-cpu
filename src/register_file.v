`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2026 11:15:45 AM
// Design Name: 
// Module Name: register_file
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


module register_file(
    input [4:0] rs1, rs2, rd, 
    input [31:0] data_write,
    input rf_we, clk,
    output [31:0] rs1_out, rs2_out
    );
    
    reg[31:0] registers[31:0];
    
    
    assign rs1_out = (rs1 != 5'b0) ? registers[rs1] : 32'b0;
    assign rs2_out = (rs2 != 5'b0) ? registers[rs2] : 32'b0;
    integer i;
    
    
    always@(posedge clk) begin
        if(rf_we) begin
            registers[rd] <= (rd != 5'b0) ? data_write : 32'b0; 
        end
    end
    
    
endmodule
