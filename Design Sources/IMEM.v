`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2026 11:28:34 AM
// Design Name: 
// Module Name: IMEM
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


module IMEM(
    input [31:0] pc, output reg [31:0] instruction 
    );

reg [7:0] imem [1023:0];
always@(*) begin
    instruction = {imem[pc + 3], imem[pc+2], imem[pc+1], imem[pc]};
end
    

endmodule
