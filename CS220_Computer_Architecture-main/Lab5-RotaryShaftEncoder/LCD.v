`timescale 1ns / 1ps

module rotary_encoder_module(clock, input_A, input_B, output_led0,
output_led1, output_led2, output_led3, output_led4, output_led5,
output_led6, output_led7);
    input clock; // Input clock signal
    input input_A; // Input signal A from the encoder
    input input_B; // Input signal B from the encoder
    output output_led0; // Output LED 0
    output output_led1; // Output LED 1
    output output_led2; // Output LED 2
    output output_led3; // Output LED 3
    output output_led4; // Output LED 4
    output output_led5; // Output LED 5
    output output_led6; // Output LED 6
    output output_led7; // Output LED 7
    wire output_led0; // Internal wire for LED 0
    wire output_led1; // Internal wire for LED 1
    wire output_led2; // Internal wire for LED 2
    wire output_led3; // Internal wire for LED 3
    wire output_led4; // Internal wire for LED 4
    wire output_led5; // Internal wire for LED 5
    wire output_led6; // Internal wire for LED 6
    wire output_led7; // Internal wire for LED 7
    wire rotation_event; // Signal indicating a rotation event
    wire rotation_direction; // Signal indicating the direction of rotation

    // Instantiate rotation event detector module
    rotation_event_detector_module RED(clock, input_A, input_B,
rotation_event, rotation_direction);
    // Instantiate shift register module
    shift_register_module SR(clock, rotation_event, rotation_direction,
output_led0, output_led1, output_led2, output_led3, output_led4,
output_led5, output_led6, output_led7);
endmodule

// Module for detecting rotation events and direction
module rotation_event_detector_module(clock, input_A, input_B,
rotation_event, rotation_direction);
    input clock; // Input clock signal
    input input_A; // Input signal A from the encoder
    input input_B; // Input signal B from the encoder
    output rotation_event; // Output signal indicating a rotation event
    output rotation_direction; // Output signal indicating the direction of rotation
    reg rotation_event; // Internal register for rotation event
    reg rotation_direction; // Internal register for rotation direction

    // Logic to detect rotation events and direction
    always @(posedge clock) begin
        case ({input_A, input_B})
            2'b00: begin
                rotation_event <= 0; // No rotation event
            end
            2'b01: begin
                rotation_direction <= 1; // Clockwise rotation
            end
            2'b10: begin
                rotation_direction <= 0; // Counterclockwise rotation
            end
            2'b11: begin
                rotation_event <= 1; // Rotation event detected
            end
        endcase
    end
endmodule

// Module for the shift register functionality
module shift_register_module(clock, rotation_event, rotation_direction,
output_led0, output_led1, output_led2, output_led3, output_led4,
output_led5, output_led6, output_led7);
    input clock; // Input clock signal
    input rotation_event; // Input signal indicating a rotation event
    input rotation_direction; // Input signal indicating the direction of rotation
    output reg output_led0; // Output LED 0
    output reg output_led1; // Output LED 1
    output reg output_led2; // Output LED 2
    output reg output_led3; // Output LED 3
    output reg output_led4; // Output LED 4
    output reg output_led5; // Output LED 5
    output reg output_led6; // Output LED 6
    output reg output_led7; // Output LED 7
    reg previous_rotation_event; // Internal register for previous rotation event

    // Logic to shift LEDs based on rotation events and direction
    always @(posedge clock) begin
        if (previous_rotation_event == 0 && rotation_event == 1) begin
            if (rotation_direction == 1) begin
                output_led1 <= output_led0;
                output_led2 <= output_led1;
                output_led3 <= output_led2;
                output_led4 <= output_led3;
                output_led5 <= output_led4;
                output_led6 <= output_led5;
                output_led7 <= output_led6;
                output_led0 <= output_led7;
            end
            else begin
                output_led0 <= output_led1;
                output_led1 <= output_led2;
                output_led2 <= output_led3;
                output_led3 <= output_led4;
                output_led4 <= output_led5;
                output_led5 <= output_led6;
                output_led6 <= output_led7;
                output_led7 <= output_led0;
            end
        end
    end
endmodule