timescale 1ns / 1ps


// FullAdder module for the addition of two bits and carry input
// Operation is sent as 1 for subtraction and 0 for addition
// When we are using the FBA as a subtracter, we are using inversion of b in place of b

module FullAdder(input_a, input_b, carry_in, operation, sum, carry_out);
  input input_a, input_b, carry_in, operation;
  output sum, carry_out;
  wire sum, carry_out;

  // Sum bit
  assign sum = input_a ^ (input_b ^ operation) ^ carry_in;

  // Carry-Out bit
  assign carry_out = ((input_a & (input_b ^ operation)) | ((input_b ^ operation) & carry_in) | (input_a & carry_in));
endmodule