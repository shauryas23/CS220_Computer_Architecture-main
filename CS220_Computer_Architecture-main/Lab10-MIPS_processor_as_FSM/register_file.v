`timescale 1ns / 1ps

// States definition
`define STATE_IDLE    0
`define STATE_INSTR_DECODE  1
`define STATE_REG_FETCH     2
`define STATE_EXECUTE   3
`define STATE_MEM_ACCESS    4
`define STATE_WRITE_BACK    5
`define STATE_OUTPUT_RESULT 6

// Output register index
`define OUTPUT_REGISTER_INDEX 4

module register_file(
    input clk,
    input [2:0] state,
    input [4:0] rs_index,
    input [4:0] rt_index,
    input [4:0] rd_index,
    input [7:0] execution_result,
    input result_valid,
    output reg [7:0] rs_value,
    output reg [7:0] rt_value
    );

    reg [7:0] reg_array [31:0]; // 32 8-bit registers

    // Initialize all registers to zero
   initial begin
    reg_array[31] = 8'b0;
    reg_array[30] = 8'b0;
    reg_array[29] = 8'b0;
    reg_array[28] = 8'b0;
    reg_array[27] = 8'b0;
    reg_array[26] = 8'b0;
    reg_array[25] = 8'b0;
    reg_array[24] = 8'b0;
    reg_array[23] = 8'b0;
    reg_array[22] = 8'b0;
    reg_array[21] = 8'b0;
    reg_array[20] = 8'b0;
    reg_array[19] = 8'b0;
    reg_array[18] = 8'b0;
    reg_array[17] = 8'b0;
    reg_array[16] = 8'b0;
    reg_array[15] = 8'b0;
    reg_array[14] = 8'b0;
    reg_array[13] = 8'b0;
    reg_array[12] = 8'b0;
    reg_array[11] = 8'b0;
    reg_array[10] = 8'b0;
    reg_array[9] = 8'b0;
    reg_array[8] = 8'b0;
    reg_array[7] = 8'b0;
    reg_array[6] = 8'b0;
    reg_array[5] = 8'b0;
    reg_array[4] = 8'b0;
    reg_array[3] = 8'b0;
    reg_array[2] = 8'b0;
    reg_array[1] = 8'b0;
    reg_array[0] = 8'b0;
end


    always @ (posedge clk) begin
        case (state)
            `STATE_REG_FETCH: begin
                rs_value <= reg_array[rs_index];
                rt_value <= reg_array[rt_index];
            end
            `STATE_WRITE_BACK: begin
                if ((rd_index != 0) && result_valid) begin
                    reg_array[rd_index] <= execution_result;
                end
            end
            `STATE_OUTPUT_RESULT: begin
                rs_value <= reg_array[`OUTPUT_REGISTER_INDEX];
            end
        endcase
    end

endmodule
