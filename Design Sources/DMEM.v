`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2026 12:39:00 PM
// Design Name: 
// Module Name: DMEM
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


module DMEM(
    input dmem_write, dmem_read, clk,
    input [31:0] write_data, address,
    input [2:0] mem_ctrl,
    output reg [31:0] dmem_out
    );
    
    reg [7:0] mem [1023:0];
    
    //Memory Writes: Clocked because 
    always@(posedge clk) begin
        if(dmem_write) begin
            case(mem_ctrl)
                `MEM_W: begin
                    mem[address] <= write_data[7:0];
                    mem[address + 1] <= write_data[15:8];
                    mem[address + 2] <= write_data[23:16];
                    mem[address + 3] <= write_data[31:24];
                end
                `MEM_H: begin
                    mem[address] <= write_data[7:0];
                    mem[address + 1] <= write_data[15:8];
                end
                `MEM_B: mem[address] <= write_data[7:0];
                default: begin
                    mem[address] <= write_data[7:0];
                    mem[address + 1] <= write_data[15:8];
                    mem[address + 2] <= write_data[23:16];
                    mem[address + 3] <= write_data[31:24];
                end
            endcase
        end
    end
    
    //Memory reads, lh, lb sign extended
    always@(*) begin
        if(dmem_read) begin
            case(mem_ctrl)
                `MEM_W: dmem_out = {mem[address + 3], mem[address + 2], mem[address + 1], mem[address]};
                `MEM_H: dmem_out = {{16{mem[address + 1][7]}}, mem[address + 1], mem[address]};
                `MEM_B: dmem_out = {{24{mem[address][7]}}, mem[address]};
                `MEM_HU: dmem_out = {16'b0, mem[address + 1], mem[address]};
                `MEM_BU: dmem_out = {24'b0, mem[address]};
                default: dmem_out = 32'b0;
            endcase
        end
        else dmem_out = 32'b0;
    end
endmodule
