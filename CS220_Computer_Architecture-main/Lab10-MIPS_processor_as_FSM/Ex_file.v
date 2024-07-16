`timescale 1ns / 1ps

// Define states of the execute module
`define EXECUTE_STATE_INSTRUCTION_FETCH 0
`define EXECUTE_STATE_INSTRUCTION_DECODE 1
`define EXECUTE_STATE_REGISTER_FETCH 2
`define EXECUTE_STATE_EXECUTE 3
`define EXECUTE_STATE_MEMORY_ACCESS 4
`define EXECUTE_STATE_WRITE_BACK 5
`define EXECUTE_STATE_OUTPUT_RESULT 6

// Define operation codes
`define OP_ADDIU 6'b001001
`define OP_LW    6'b100011
`define OP_BEQ   6'b000100
`define OP_BNE   6'b000101
`define OP_RFORM 6'b000000
`define OP_ADDU  6'b000000
`define OP_SUBU  6'b000000
`define OP_SLT   6'b000000

// Define memory operation types
`define MEM_READ  2'b00
`define MEM_WRITE 2'b01
`define MEM_IDLE  2'b10

module execute(
    input clk,
    input [2:0] current_state,
    input [5:0] operation_code,
    input [7:0] register_source_value,
    input [7:0] register_target_value,
    input [15:0] immediate_value,
    input [5:0] function_code,
    output [7:0] updated_program_counter,
    output [7:0] execution_result,
    output execution_result_valid
);

    reg [7:0] execution_result;
    reg execution_result_valid;
    reg [7:0] updated_program_counter;

    // Initialize variables
    initial begin
        updated_program_counter = 8'b00000000;
        execution_result_valid = 1'b0;
    end

    // Execute instructions based on the current state
    always @ (posedge clk) begin
        if (current_state == `EXECUTE_STATE_EXECUTE) begin
            case (operation_code)
                // Add unsigned
                `OP_ADDU:
                    if (function_code == `FUNC_ADDU) begin
                        execution_result <= register_source_value + register_target_value;
                        execution_result_valid <= 1;
                        updated_program_counter <= updated_program_counter + 1;
                    end
                // Branch not equal
                `OP_BNE:
                    begin
                        execution_result_valid <= 0;
                        updated_program_counter <= (register_source_value != register_target_value) ? 
                                                    (updated_program_counter + immediate_value[7:0]) : 
                                                    (updated_program_counter + 1);
                    end
                // Branch equal
                `OP_BEQ:
                    begin
                        execution_result_valid <= 0;
                        updated_program_counter <= (register_source_value == register_target_value) ? 
                                                    (updated_program_counter + immediate_value[7:0]) : 
                                                    (updated_program_counter + 1);
                    end
                // Add immediate unsigned or load word
                `OP_ADDIU, `OP_LW:
                    begin
                        execution_result_valid <= 1;
                        updated_program_counter <= updated_program_counter + 1;
                        execution_result <= register_source_value + immediate_value[7:0];
                    end
                // Set on less than
                `OP_SLT:
                    begin
                        execution_result_valid <= 1;
                        updated_program_counter <= updated_program_counter + 1;
                        execution_result <= ($signed(register_source_value) < $signed(register_target_value)) ? 
                                            8'b00000001 : 
                                            8'b00000000;
                    end
                // Subtract unsigned
                `OP_SUBU:
                    begin
                        updated_program_counter <= updated_program_counter + 1;
                        execution_result <= register_source_value - register_target_value;
                        execution_result_valid <= 1;
                    end
                // Default case
                default:
                    begin
                        execution_result_valid <= 0;
                        updated_program_counter <= updated_program_counter + 1;
                    end
            endcase
        end
    end

endmodule
