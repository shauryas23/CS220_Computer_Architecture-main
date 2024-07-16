`timescale 1ns / 1ps

`define OFF_TIME 25000000
`define ON_TIME (`OFF_TIME*2)
module blink_top;

reg clk;
wire led0;

blink uut (.clk(clk), .led0(led0));

initial begin
	forever begin
		clk=0;
		#1;
		clk=1;
		#1;
		clk=0;
	end
end

always @(led0) begin
	$display("time=%d: led0 = %b\n", $time, led0); 
end
initial begin
	#(5*`ON_TIME)
	$finish;
end

      
endmodule

