`timescale 1ns / 1ps

module seven_bit_adder_sch;

	// Inputs
	reg KNOB1;
	reg KNOB2;
	reg KNOB3;
	reg KNOB4;
	reg [3:0] num;

	// Outputs
	wire [6:0] sum;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	seven_bit_adder uut (
		.KNOB1(KNOB1), 
		.KNOB2(KNOB2), 
		.KNOB3(KNOB3), 
		.KNOB4(KNOB4), 
		.num(num), 
		.sum(sum), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
		KNOB1 = 0;
		KNOB2 = 0;
		KNOB3 = 0;
		KNOB4 = 0;
		num = 0;
        
		// Add stimulus here

	end
	always @(c or cout) begin
	$display("time=%d: %b + %b = %b, cout = %b\n", $time, a, b, c, cout);
	end
	initial begin
	a = 7'b0000001; b = 7'b0000000; 
	#10
	a = 7'b0000001; b = 7'b0000001; 
	#10
	a = 7'b0000010; b = 7'b0010001; 
	#10
	a = 7'b0100000; b = 7'b01000000;  
	#10
	$finish;
	end
      
endmodule

