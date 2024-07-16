`timescale 1ns / 1ps

module eight_bit_comparator_top;

	// Inputs
	reg pb1;
	reg pb2;
	reg pb3;
	reg pb4;
	reg [3:0] y;

	// Outputs
	wire lo;
	wire go;
	wire eo;

	// Instantiate the Unit Under Test (UUT)
	eight_bit_comparator uut (
		.pb1(pb1), 
		.pb2(pb2), 
		.pb3(pb3), 
		.pb4(pb4), 
		.y(y), 
		.lo(lo), 
		.go(go), 
		.eo(eo)
	);

	always@(lo, eo, go) begin
		$display("time = %d, lo = %b, eo = %b, go = %b\n", $time, lo, eo, go);
	end
	
	initial begin
		pb1 = 0; pb2 = 0; pb3 = 0; pb4 = 0;
		#5
		y = 4'b0001;
		#1
		pb1 = 1;
		#2
		y = 4'b0000;
		#1
		pb2 = 1;
		#2
		y = 4'b1000;
		#1
		pb3 = 1;
		#2
		y = 4'b0000;
		#1
		pb4 = 1;
		#5
		$finish;
	end
      
endmodule

