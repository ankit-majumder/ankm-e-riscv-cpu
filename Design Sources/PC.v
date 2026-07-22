`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2026 11:20:38 AM
// Design Name: 
// Module Name: PC
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


module PC(
        input [31:0] pc, input clk, reset, output reg [31:0] pc_next
    );
    
    always@(posedge clk) begin
        if(reset) pc_next <= 32'b0; //synchronous reset
        else pc_next <= pc;
    end
    
endmodule
