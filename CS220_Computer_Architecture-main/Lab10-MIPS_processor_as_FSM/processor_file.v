`timescale 1ns / 1ps

// Definition of pipeline states
`define PIPELINE_STATE_INSTRUCTION_FETCH 0
`define PIPELINE_STATE_INSTRUCTION_DECODE 1
`define PIPELINE_STATE_REGISTER_FETCH 2
`define PIPELINE_STATE_EXECUTE 3
`define PIPELINE_STATE_MEMORY_ACCESS 4
`define PIPELINE_STATE_WRITE_BACK 5
`define PIPELINE_STATE_OUTPUT_RESULT 6

// Definition of operation codes
`define OP_ADDIU 6'b001001
`define OP_LW    6'b100011
`define OP_BEQ   6'b000100
`define OP_BNE   6'b000101
`define OP_RFORM 6'b000000
`define OP_ADDU  6'b000000
`define OP_SUBU  6'b000000
`define OP_SLT   6'b000000

// Definition of memory operation types
`define MEM_READ  2'b00
`define MEM_WRITE 2'b01
`define MEM_IDLE  2'b10

module processor(
    input clk,
    output reg [7:0] led
);

    wire [7:0] load_data;
    wire is_result_valid;
    wire [7:0] register_source_value;
    wire [7:0] register_target_value;
    wire [7:0] execution_result;
    wire [5:0] function_code;
    wire [15:0] immediate_value;
    wire [4:0] destination_register;
    wire [4:0] target_register;
    wire [4:0] source_register;
    wire [5:0] operation_code;
    wire [31:0] fetched_instruction;
    wire [2:0] pipeline_state;
    wire [7:0] program_counter;

    state_control state_controller(clk, program_counter, pipeline_state);
    instruction_fetcher instruction_fetch_unit(clk, pipeline_state, program_counter, fetched_instruction);
    instruction_decoder instruction_decode_unit(clk, pipeline_state, fetched_instruction, operation_code, source_register, target_register, destination_register, immediate_value, function_code);
    register_file register_file_unit(clk, pipeline_state, source_register, target_register, (operation_code == `OP_RFORM) ? destination_register : target_register, (operation_code == `OP_LW) ? load_data : execution_result, (operation_code == `OP_LW) ? 1'b1 : is_result_valid, register_source_value, register_target_value);
    execution_unit execution_unit_inst(clk, pipeline_state, operation_code, register_source_value, register_target_value, immediate_value, function_code, program_counter, execution_result, is_result_valid);
    data_memory data_memory_unit(clk, pipeline_state, execution_result, (operation_code == `OP_LW) ? `MEM_READ : `MEM_IDLE, register_target_value, load_data);

    always @ (posedge clk) begin
        if (pipeline_state == `PIPELINE_STATE_OUTPUT_RESULT) begin
            led <= register_source_value;
        end
    end

endmodule
