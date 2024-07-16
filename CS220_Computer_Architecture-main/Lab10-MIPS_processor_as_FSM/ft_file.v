`timescale 1ns / 1ps

// Define states of the fetch module
`define FETCH_STATE_INSTRUCTION_FETCH    0
`define FETCH_STATE_INSTRUCTION_DECODE   1
`define FETCH_STATE_REGISTER_FETCH       2
`define FETCH_STATE_EXECUTE              3
`define FETCH_STATE_MEMORY_ACCESS        4
`define FETCH_STATE_WRITE_BACK           5
`define FETCH_STATE_OUTPUT_RESULT        6

module fetch(
    input clk,
    input [2:0] current_state,
    input [7:0] program_counter,
    output reg [31:0] output_instruction
);

    reg [31:0] instruction_memory [0:10]; // Instruction memory with 11 entries

    // Initialize instruction memory with reverse order instructions
    initial begin
        instruction_memory[10] = 32'b000101_00110_00000_1111111111111101;
        instruction_memory[9]  = 32'b000000_00101_00010_00110_00000_101010;
        instruction_memory[8]  = 32'b000000_00101_00011_00101_00000_100001;
        instruction_memory[7]  = 32'b000000_00100_00101_00100_00000_100001;
        instruction_memory[6]  = 32'b000100_00110_00000_0000000000000101;
        instruction_memory[5]  = 32'b000000_00101_00010_00110_00000_101010;
        instruction_memory[4]  = 32'b001001_00001_00105_0000000000000000;
        instruction_memory[3]  = 32'b001001_00000_00100_0000000000000000;
        instruction_memory[2]  = 32'b100011_00000_00011_0000000000000010;
        instruction_memory[1]  = 32'b100011_00000_00010_0000000000000001;
        instruction_memory[0]  = 32'b100011_00000_00001_0000000000000000;
    end

    // Output the instruction based on the current state
    always @ (posedge clk) begin
        if (current_state == `FETCH_STATE_INSTRUCTION_FETCH) begin
            output_instruction <= instruction_memory[program_counter];
        end
    end

endmodule
