`timescale 1ns / 1ps

module full_adders_top;

	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg PB5;
	reg [3:0] Y;
	wire [5:0] sum;
	wire carry;

	adder uut (.PB1(PB1), .PB2(PB2), .PB3(PB3), .PB4(PB4), .PB5(PB5), .Y(Y), .sum(sum), .carry(carry));
	always @(sum or carry) begin
	$display("time=%d:sum= %b, cout = %b\n", $time,sum, carry);
	end
	initial begin
		// Initialize Inputs
		PB1=1; Y=4'b1000;
		#5
		PB2=1; Y=4'b1000;
		#5
		PB3=1; Y=4'b1000;
		#5
		PB4=1; Y=4'b1000;
		#5
		PB5=1; Y=4'b1000;
		#5
		$finish;
        
		// Add stimulus here

	end
	
	
      
endmodule

