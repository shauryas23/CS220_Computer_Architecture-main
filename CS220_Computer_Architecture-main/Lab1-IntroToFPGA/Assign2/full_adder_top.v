`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:24 01/17/2024 
// Design Name: 
// Module Name:    full_adder_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module full_adder_top(
    );
reg a,b,cin;
wire cout, sum;
full_adder jenil(a,b,cin,sum,cout);


always @(sum or cout) begin 
	$display("time=%d: %b + %b + %b = %b, cout = %b\n", $time, a, b, cin, sum, cout);  
end

initial begin 
	 a = 0; b = 0; cin = 0;
	 #5 
	 a = 0; b = 1; cin = 0;
	 #5 
	 a = 1; b = 0; cin = 1;
	 #5 
	 a = 1; b = 1; cin = 1;
	 #5 
	 $finish;
end

endmodule
