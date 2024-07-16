timescale 1ns / 1ps

// RotaryShaft module detects rotation events based on the rotor signals ROT_A and ROT_B.
module RotaryShaft(clk, ROT_A, ROT_B, rotation_event);
  input clk, ROT_A, ROT_B;
  output rotation_event;
  reg rotation_event;

  // Sequential always block triggered by the positive edge of the clock
  always @(posedge clk) begin

    if (ROT_A == 1 & ROT_B == 1) begin
      rotation_event <= 1;
    end
    else if (ROT_A == 0 & ROT_B == 0) begin
      // Reset rotation_event to 0 when both signals are low
      rotation_event <= 0;
    end
  end
endmodule
