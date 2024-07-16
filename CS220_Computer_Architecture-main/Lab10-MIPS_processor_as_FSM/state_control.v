`timescale 1ns / 1ps

// Definition of pipeline states
`define PIPELINE_STATE_INSTRUCTION_FETCH 0
`define PIPELINE_STATE_INSTRUCTION_DECODE 1
`define PIPELINE_STATE_REGISTER_FETCH 2
`define PIPELINE_STATE_EXECUTE 3
`define PIPELINE_STATE_MEMORY_ACCESS 4
`define PIPELINE_STATE_WRITE_BACK 5
`define PIPELINE_STATE_OUTPUT_RESULT 6

// Maximum program counter value
`define MAX_PROGRAM_COUNTER 11

module state_control(
    input clk,
    input [7:0] program_counter,
    output reg [2:0] pipeline_state
);

    // Initialize pipeline state to instruction fetch
    initial begin
        pipeline_state = `PIPELINE_STATE_INSTRUCTION_FETCH;
    end

    // State transition logic
    always @ (posedge clk) begin
        // Transition to instruction fetch if write back completed and program counter is within limits
        if ((pipeline_state == `PIPELINE_STATE_WRITE_BACK) && (program_counter < `MAX_PROGRAM_COUNTER)) begin
            pipeline_state <= `PIPELINE_STATE_INSTRUCTION_FETCH;
        end
        // Move to next pipeline state if not in output state
        else if (pipeline_state != `PIPELINE_STATE_OUTPUT_RESULT) begin
            pipeline_state <= pipeline_state + 1;
        end
    end

endmodule
