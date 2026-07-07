`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2026 11:35:43 AM
// Design Name: 
// Module Name: DMEM_tb
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


module DMEM_tb();

reg dmem_write, dmem_read, clk;
reg[31:0] write_data, address;
reg[2:0] mem_ctrl;
wire[31:0] dmem_out;

DMEM dut(.dmem_write(dmem_write), .dmem_read(dmem_read), .clk(clk), .write_data(write_data), .address(address), .mem_ctrl(mem_ctrl), .dmem_out(dmem_out));

initial clk = 0;
always #5 clk = ~clk;

initial begin
    dmem_write = 0; dmem_read = 0;
    address = 32'b0; write_data = 32'b0;
    mem_ctrl = `MEM_W;
    #10;
    
    dmem_write = 1; dmem_read = 0;
    address = 32'd0; write_data = 32'hAABBCCDD;
    mem_ctrl = `MEM_W;
    @(posedge clk); #1;
    
    dmem_write = 0; dmem_read = 1;
    address = 32'd0;
    mem_ctrl = `MEM_W;
    #10;
    
    dmem_write = 0; dmem_read = 1;
    address = 32'd0;
    mem_ctrl = `MEM_H;
    #10;
    
    mem_ctrl = `MEM_HU;
    #10;
    
    mem_ctrl = `MEM_B;
    #10;
    
    mem_ctrl = `MEM_BU;
    #10;
    
    dmem_write = 1; dmem_read = 0;
    address = 32'd4; write_data = 32'h0000BEEF;
    mem_ctrl = `MEM_H;
    @(posedge clk); #1;
    
    dmem_write = 0; dmem_read = 1;
    address = 32'd4;
    mem_ctrl = `MEM_H;
    #10;
    
    dmem_write = 1; dmem_read = 0;
    address = 32'd8; write_data = 32'h000000F5;
    mem_ctrl = `MEM_B;
    @(posedge clk); #1;
    
    dmem_write = 0; dmem_read = 1;
    address = 32'd8;
    mem_ctrl = `MEM_B;
    #10;
    
    mem_ctrl = `MEM_BU;
    #10;
    
    dmem_write = 0; dmem_read = 0;
    address = 32'd0; write_data = 32'hDEADBEEF;
    mem_ctrl = `MEM_W;
    @(posedge clk); #1;
    
    dmem_read = 1;
    mem_ctrl = `MEM_W;
    #10;
    
    dmem_read = 0;
    mem_ctrl = `MEM_W;
    #10;
    
    
end
endmodule
