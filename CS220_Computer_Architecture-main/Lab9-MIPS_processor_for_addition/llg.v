`timescale 1ns / 1ps

module MAIN_MODULE(
    input CLOCK,
    input TRIGG_SWITCH,
    output reg [7:0] LED_LIGHT_8BITS
);
    reg [15:0] reMEM [0:7];  // Memory array to store 16-bit values, 8 elements
    reg [3:0] COUNT, CORRECT_ONES;  // Counters for loop and number of correct ones
    reg [15:0] DATABITS;  // Register to store 16-bit data
    reg [7:0] summation, idx;  // Registers for summation and index calculation
    

    // Initialization block
    initial begin
        DATABITS <= 0;  // Initialize DATABITS to 0
        CORRECT_ONES <= 0;  // Initialize CORRECT_ONES to 0
        idx <= 0;  // Initialize idx to 0
        summation <= 0;  // Initialize summation to 0
        LED_LIGHT_8BITS <= 8'b11111111;  // Initialize LED_LIGHT_8BITS to all 1's
        
        // Initialize memory array with given values
        reMEM[7] = 16'h0080;
        reMEM[6] = 16'h8110;
        reMEM[5] = 16'h0800;
        reMEM[4] = 16'h0001;
        reMEM[3] = 16'h8000;
        reMEM[2] = 16'h0100;
        reMEM[1] = 16'h8800;
        reMEM[0] = 16'h0000;
    end

    // Always block triggered by clock edge
    always@(posedge CLOCK) begin
        // Terminated
        if (COUNT == 8) begin
            if (TRIGG_SWITCH == 0) begin
                LED_LIGHT_8BITS <= summation;  // Output summation value to LED_LIGHT_8BITS
            end
            else begin
                // Compute parity bit and set other bits to 0
                LED_LIGHT_8BITS[0] <= summation[0] ^ summation[1] ^ summation[2] ^ summation[3] ^ summation[4] ^ summation[5] ^ summation[6] ^ summation[7];
                LED_LIGHT_8BITS[7:1] <= 7'b0;
            end
        end
        else begin
            // Input data from memory based on COUNT
            case (COUNT)
                7: DATABITS = reMEM[7];
                6: DATABITS = reMEM[6];
                5: DATABITS = reMEM[5];
                4: DATABITS = reMEM[4];
                3: DATABITS = reMEM[3];
                2: DATABITS = reMEM[2];
                1: DATABITS = reMEM[1];
                0: DATABITS = reMEM[0];
            endcase

            // Compute number of correct ones and index
            CORRECT_ONES = DATABITS[0] + DATABITS[1] + DATABITS[2] + DATABITS[3] + DATABITS[4] + DATABITS[5] + DATABITS[6] + DATABITS[7] + DATABITS[8] + DATABITS[9] + DATABITS[10] + DATABITS[11] + DATABITS[12] + DATABITS[13] + DATABITS[14] + DATABITS[15];
            idx = 1*DATABITS[1] + 2*DATABITS[2] + 3*DATABITS[3] + 4*DATABITS[4] + 5*DATABITS[5] + 6*DATABITS[6] + 7*DATABITS[7] + 8*DATABITS[8] + 9*DATABITS[9] + 10*DATABITS[10] + 11*DATABITS[11] + 12*DATABITS[12] + 13*DATABITS[13] + 14*DATABITS[14] + 15*DATABITS[15];
         
            // Reset CORRECT_ONES and idx to 0
            CORRECT_ONES = 8'b0;
            idx = 8'b0;

            // Update summation based on CORRECT_ONES
            if (CORRECT_ONES > 1 || CORRECT_ONES == 0) begin
                if (summation == 8'h00) begin
                    summation <= 8'b11111111;
                end
                else begin
                    summation <= summation - 1;
                end
            end
            else begin
                summation <= summation + idx;
            end

            // Increment COUNT
            COUNT <= COUNT + 1;
        end
    end
endmodule

