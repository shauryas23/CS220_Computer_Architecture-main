timescale 1ns / 1ps

module SevenBitAdder(clk, rotation_A, rotation_B, input_num, output_sum, overflow);

  // clk and rotation inputs are the inputs to the rotary shaft
  // clk times the inputs while rotation_A and rotation_B return the shaft rotation as a signal
  input clk, rotation_A, rotation_B;			
  input [3:0] input_num;
  output [6:0] output_sum;
  output overflow;
  wire [6:0] output_sum;
  wire overflow;			//checks for overflow
  reg [6:0] operand_a, operand_b;	//inputs
  wire [6:0] carry_out;
  reg operation;			//operation mode
  wire rotation_event;
  reg prev_rotation_event = 1;		//implements edge triggering for rotory shaft
  reg [2:0] counter = 3'b000;		//sequences the order of inputs given

  // Sequential always block triggered by clock edge
  always @(posedge clk) begin
    // Check for a rising edge on the rotary encoder signal
    if (prev_rotation_event == 0 && rotation_event == 1) begin
      // Perform operations based on the counter value
      case (counter)

	// Set bits of operand_a
        3'b000: operand_a[3:0] <= input_num;      
        3'b001: operand_a[6:4] <= input_num[2:0]; 

	// Set bits of operand_b 
        3'b010: operand_b[3:0] <= input_num;      
        3'b011: operand_b[6:4] <= input_num[2:0]; 

	// Set the operation bit 
        3'b100: operation <= input_num[0];        
        3'b101: counter <= 3'b000;                // Reset the counter after all the inputs are given
      endcase

      // Increment the counter
      counter <= counter + 1;
    end

    // Store the current state of the rotary encoder signal
    // Edge Triggering
    prev_rotation_event <= rotation_event;
  end

  // Instantiate a rotary shaft
  RotoryShaft RS(clk, rotation_A, rotation_B, rotation_event);

  // Sequential Full Adder Curcuits for 7 bit inputs
  // Output of one is the input for another
  FullAdder FA0(operand_a[0], operand_b[0], operation, operation, output_sum[0], carry_out[0]);
  FullAdder FA1(operand_a[1], operand_b[1], carry_out[0], operation, output_sum[1], carry_out[1]);
  FullAdder FA2(operand_a[2], operand_b[2], carry_out[1], operation, output_sum[2], carry_out[2]);
  FullAdder FA3(operand_a[3], operand_b[3], carry_out[2], operation, output_sum[3], carry_out[3]);
  FullAdder FA4(operand_a[4], operand_b[4], carry_out[3], operation, output_sum[4], carry_out[4]);
  FullAdder FA5(operand_a[5], operand_b[5], carry_out[4], operation, output_sum[5], carry_out[5]);
  FullAdder FA6(operand_a[6], operand_b[6], carry_out[5], operation, output_sum[6], carry_out[6]);

  // Overflow is calculated from the last and the second last carry outs
  // Theorem Proved in Class
  assign overflow = ~(carry_out[5] && carry_out[6]);
endmodule
