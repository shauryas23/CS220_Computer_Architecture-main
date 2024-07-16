`timescale 1ns / 1ps

module DECTECTOR_MODULE(
    input clk,         // Clock input
    input A,           // Input A
    input B,           // Input B
    output reg rot     // Output rotation signal
);

    always @(posedge clk) begin
        if (A == 1'b0 & B == 1'b0) begin
            rot <= 1'b0; // If A and B are both 0, set rotation signal to 0
        end else if (A == 1'b1 & B == 1'b1) begin
            rot <= 1'b1; // If A and B are both 1, set rotation signal to 1
        end
    end
    
endmodule

module TOP_MODULE(
    input [3:0] drot_Atrot_A_record,  // Input data for rotation
    input clk,                         // Clock input
    input rot_A,                      // Input A for rotation
    input rot_B,                       // Input B for rotation
    input reset,                       // Reset signal
    output lcd_rs,                     // LCD register select signal
    output lcd_w,                      // LCD write signal
    output lcd_e,                      // LCD enable signal
    output lcd_rot_Bus                // LCD rotation bus
);

    wire rot;                          // Rotation signal wire
    wire [127:0] line_1;               // Data wire for LCD line 1
    wire [127:0] line_2;               // Data wire for LCD line 2
    
    // Instantiate rotation detector module
    DECTECTOR_MODULE D0(clk, rot_A, rot_B, rot);
    
    // Instantiate interface module
    INTERFrot_ACE_MODULE I0(drot_Atrot_A_record, clk, rot, reset, line_1, line_2);
    
    // Instantiate LCD driver module
    LCD_DRIVER_MODULE L0(line_1, line_2, clk, lcd_rs, lcd_w, lcd_e, lcd_rot_Bus);
    
endmodule

