`timescale 1ns / 1ps

module full_adders(PB1,PB2,PB3,PB4,PB5,Y,sum,carry);
	 input PB1;
	 input PB2;
	 input PB3;
	 input PB4;
	 input PB5;
	 input[3:0] Y;
	 output sum;
	 output carry;

	 wire [5:0] sum;
	 wire carry;
	 reg [3:0] a;
	 reg [3:0] b;
	 reg [3:0] c;
	 reg [3:0] d;
	 reg [5:0] e;
	 always @(posedge PB1) begin
			a<=Y;
	 end
	 always @(posedge PB2) begin
			b<=Y;
	 end
	 always @(posedge PB3) begin
			c<=Y;
	 end
	 always @(posedge PB4) begin
			d<=Y;
	 end
	 always @(posedge PB5) begin
			e<=6'b 000000;
			e[3:0]<=Y;
	 end
	 
	 wire [4:0] x;
	 wire [4:0] y;
	 wire [5:0] z;
	 four_bit_adder F1(a,b,x[3:0],x[4]);
	 four_bit_adder F2(c,d,y[3:0],y[4]);
	 five_bit_adder F3(x,y,z[4:0],z[5]);
	 six_bit_adder F4(z,e,sum,carry);
	 


endmodule

module full_adder(a, b, cin, sum, cout);
input a;
input b;
input cin;
output sum;
output cout;
wire sum;
wire cout;
assign sum = a^b^cin;
assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

module four_bit_adder(a,b,sum,carry);
input [3:0] a;
input [3:0] b;
output sum;
output carry;
wire[3:0] sum;
wire carry;

wire [2:0] temp;

full_adder F1(a[0],b[0],1'b0,sum[0],temp[0]);
full_adder F2(a[1],b[1],temp[0],sum[1],temp[1]);
full_adder F3(a[2],b[2],temp[1],sum[2],temp[2]);
full_adder F4(a[3],b[3],temp[2],sum[3],carry);
endmodule

module five_bit_adder(a,b,sum,carry);
input [4:0] a;
input [4:0] b;
output sum;
output carry;
wire[4:0] sum;
wire carry;

wire [3:0] temp;

full_adder F1(a[0],b[0],1'b0,sum[0],temp[0]);
full_adder F2(a[1],b[1],temp[0],sum[1],temp[1]);
full_adder F3(a[2],b[2],temp[1],sum[2],temp[2]);
full_adder F4(a[3],b[3],temp[2],sum[3],temp[3]);
full_adder F5(a[4],b[4],temp[3],sum[4],carry);
endmodule

module six_bit_adder(a,b,sum,carry);
input [5:0] a;
input [5:0] b;
output sum;
output carry;
wire[5:0] sum;
wire carry;

wire [4:0] temp;

full_adder F1(a[0],b[0],1'b0,sum[0],temp[0]);
full_adder F2(a[1],b[1],temp[0],sum[1],temp[1]);
full_adder F3(a[2],b[2],temp[1],sum[2],temp[2]);
full_adder F4(a[3],b[3],temp[2],sum[3],temp[3]);
full_adder F5(a[4],b[4],temp[3],sum[4],temp[4]);
full_adder F6(a[5],b[5],temp[4],sum[5],carry);
endmodule


