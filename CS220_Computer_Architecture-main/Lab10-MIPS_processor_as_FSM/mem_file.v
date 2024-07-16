`timescale 1ns / 1ps

// Memory operation types
`define MEM_READ  2'b00
`define MEM_WRITE 2'b01
`define MEM_IDLE  2'b10

// Processor states
`define STATE_IF 0
`define STATE_ID 1
`define STATE_RF 2
`define STATE_EX 3
`define STATE_MEM 4
`define STATE_WB 5
`define STATE_OUTPUT 6

module memory(
    input clk,
    input [2:0] state,
    input [7:0] address,
    input [1:0] operation,
    input [7:0] data_in,
    output reg [7:0] data_out
);

    reg [7:0] memory_array [0:2]; // 3 memory locations

    // Initialize memory content
    initial begin
        memory_array[0] = 8'b11101100;
        memory_array[1] = 8'b00001010;
        memory_array[2] = 8'b00000010;
    end

    // Memory operation
    always @ (posedge clk) begin
        if (state == `STATE_MEM) begin
            if (operation == `MEM_WRITE) begin
                memory_array[address] <= data_in;
            end
            else if (operation == `MEM_READ) begin
                data_out <= memory_array[address];
            end
        end
    end

endmodule
