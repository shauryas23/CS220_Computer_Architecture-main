`timescale 1ns / 1ps

// Define states for the decode module
`define DECODE_STATE_INSTRUCTION_FETCH 0
`define DECODE_STATE_INSTRUCTION_DECODE 1
`define DECODE_STATE_REGISTER_FETCH 2
`define DECODE_STATE_EXECUTE 3
`define DECODE_STATE_MEMORY_ACCESS 4
`define DECODE_STATE_WRITE_BACK 5
`define DECODE_STATE_OUTPUT_RESULT 6

module decode(
    input clk,                // Clock signal
    input [2:0] state,        // Current state of the module
    input [31:0] instruction, // Input instruction to decode
    output reg [5:0] opcode,  // Output opcode
    output reg [4:0] rs,      // Output register source
    output reg [5:0] rt,      // Output register target
    output reg [4:0] rd,      // Output register destination
    output reg [15:0] imm,    // Output immediate value
    output reg [5:0] func     // Output function code
);

    // Decode instruction based on the current state
    always @ (posedge clk) begin
        if (state == `DECODE_STATE_INSTRUCTION_DECODE) begin
            rd <= instruction[15:11];    // Extract destination register
            imm <= instruction[15:0];    // Extract immediate value
            func <= instruction[5:0];    // Extract function code
            opcode <= instruction[31:26];// Extract opcode
            rs <= instruction[25:21];     // Extract source register
            rt <= instruction[20:16];     // Extract target register
        end
    end

endmodule
