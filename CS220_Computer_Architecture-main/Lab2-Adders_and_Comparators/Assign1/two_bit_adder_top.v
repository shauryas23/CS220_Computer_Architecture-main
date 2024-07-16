`timescale 1ns / 1ps

module two_bit_adder_top;

	// Inputs
	reg [1:0] x;
	reg [1:0] y;

	// Outputs
	wire [1:0] z;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	two_bit_adder uut (
		.x(x), 
		.y(y), 
		.z(z), 
		.carry(carry)
	);

	always @(z or carry) begin
	$display("time=%d: %b + %b = %b, carry = %b\n", $time, x, y, z, carry);
	end
	initial begin
	x = 2'b00; y = 2'b00;
	#10
	x = 2'b00; y = 2'b01;
	#10
	x = 2'b01; y = 2'b00;
	#10
	x = 2'b01; y = 2'b01;
	#10
	x = 2'b10; y = 2'b10;
	#10
	x = 2'b10; y = 2'b11;
	#10
	x = 2'b11; y = 2'b10;
	#10
	x = 2'b11; y = 2'b11;
	#10
	$finish;
	end
      
endmodule
