`timescale 1ns / 1ps

module GridMovement (clk, ROT_A, ROT_B, StepOperation, x_coordinates, y_coordinates);

  // rotor mechanical input signals
  input clk, ROT_A, ROT_B;
  input [3:0] StepOperation;

  // x and y coordinates of the point
  output [3:0] x_coordinates, y_coordinates;

  // We start at Origin
  reg [3:0] x_coordinates = 0, y_coordinates = 0;
  
  // temp variables
  reg [3:0] num;
  wire [4:0] sum_x, sum_y;
  wire rotation_event;
  reg prev_rotation_event = 1;
  reg change = 0;

  // Sequential always block triggered by positive edge of the clock
  always @(posedge clk) begin
    
    // Check if change flag is set
    if (change == 1) begin

      // North
      if (num[1] == 0 && num[0] == 0) begin
        // Check for overflow in sum_y limit is 15
        if (sum_y[4] == 1) begin
          y_coordinates <= 4'b1111;
        end
        else begin
          y_coordinates <= sum_y[3:0];
        end
      end

      // East
      else if (num[1] == 0 && num[0] == 1) begin
        // Check for overflow in sum_x limit is 15
        if (sum_x[4] == 1) begin
          x_coordinates <= 4'b1111;
        end
        else begin
          x_coordinates <= sum_x[3:0];
        end
      end
      // South
      else if (num[1] == 1 && num[0] == 0) begin
        // Check for overflow in sum_y lower limit is 0
        if (sum_y[4] == 1) begin
          y_coordinates <= 0;
        end
        else begin
          y_coordinates <= sum_y[3:0];
        end
      end
      // West
      else if (num[1] == 1 && num[0] == 1) begin
        // Check for overflow in sum_x lower limit is 0
        if (sum_x[4] == 1) begin
          x_coordinates <= 0;
        end
        else begin
          x_coordinates <= sum_x[3:0];
        end
      end

      // Reset change flag
      change <= 0;
    end

    // Check for a rising edge on the rotary encoder signal
    if (prev_rotation_event == 0 && rotation_event == 1) begin

      // Update num with the input value
      num <= StepOperation;

      // Set change flag
      change <= 1;
    end
    // Store the current state of the rotary encoder signal
    prev_rotation_event <= rotation_event;
  end

  // Instantiate a rotary_shaft module to detect rotation events
  RotaryShaft RS(clk, ROT_A, ROT_B, rotation_event);

  // Instantiate CoordinatesModule (previously FiveBitAdder) module for coordinate calculation
  Coordinates FBA(x_coordinates, y_coordinates, num, sum_x, sum_y);

endmodule
