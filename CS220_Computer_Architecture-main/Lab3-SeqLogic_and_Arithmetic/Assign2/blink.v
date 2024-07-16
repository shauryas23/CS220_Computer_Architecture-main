`timescale 1ns / 1ps

`define OFF_TIME 25000000
`define ON_TIME (`OFF_TIME*2)



module blink(clk, led0);

input clk;
output led0;

reg led0;
reg [31:0] count;

initial begin
	count<=0;
	led0<=1'b1;
end

always @(posedge clk) begin
	count<=count+1;
		if(count==`OFF_TIME) begin
			led0<=1'b0;
		end
		else if(count==`ON_TIME) begin
			led0<=1'b1;
			count<=0;
		end
	end

endmodule
