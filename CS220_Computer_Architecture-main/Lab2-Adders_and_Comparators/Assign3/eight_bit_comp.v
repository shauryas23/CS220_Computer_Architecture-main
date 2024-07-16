`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:18 01/24/2024 
// Design Name: 
// Module Name:    eight_bit_comp 
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
/////////////////////////////////////////////////////////////////////////////////
module bit_comp(a,b,eq, gt, lt);
	input a,b;
	output eq,gt,lt;
	wire eq, gt, lt;
	
	assign eq = ~(a^b);
	assign gt = a & (~b);
	assign lt = (~a) & b;
	
endmodule

module eight_bit_comp ( PB1,PB2,PB3,PB4,Y,eq, gt, lt
	 ); 
	 
	input PB1,PB2,PB3,PB4;
	input [3:0] Y;
	
	output eq, gt, lt;
	wire eq, gt, lt;
	wire [7:0] eqt, gtt, ltt;
	reg [7:0] a;
	reg [7:0] b;
	
	always @(posedge PB1)begin
		a[3:0]<=Y;
	end
	always @(posedge PB2)begin
		a[7:4]<=Y;
	end
	always @(posedge PB3)begin
		b[3:0]<=Y;
	end
	always @(posedge PB4)begin
		b[7:4]<=Y;
	end
	
	bit_comp BC0(a[0], b[0], eqt[0], gtt[0],ltt[0]);
	bit_comp BC1(a[1], b[1], eqt[1], gtt[1],ltt[1]);
	bit_comp BC2(a[2], b[2], eqt[2], gtt[2],ltt[2]);
	bit_comp BC3(a[3], b[3], eqt[3], gtt[3],ltt[3]);
	bit_comp BC4(a[4], b[4], eqt[4], gtt[4],ltt[4]);
	bit_comp BC5(a[5], b[5], eqt[5], gtt[5],ltt[5]);
	bit_comp BC6(a[6], b[6], eqt[6], gtt[6],ltt[6]);
	bit_comp BC7(a[7], b[7], eqt[7], gtt[7],ltt[7]);
	
	assign eq = eqt[0] & eqt[1] & eqt[2] & eqt[3] & eqt[4] & eqt[5] & eqt[6] & eqt[7];
	assign gt = (gtt[7]) | (eqt[7]&gtt[6]) | (eqt[7]&eqt[6]&gtt[5]) | (eqt[7]&eqt[6]&eqt[5]&gtt[4]) | (eqt[7]&eqt[6]&eqt[5]&eqt[4]&gtt[3]) | (eqt[7]&eqt[6]&eqt[5]&eqt[4]&eqt[3]&gtt[2]) |(eqt[7]&eqt[6]&eqt[5]&eqt[4]&eqt[3]&eqt[2]&gtt[1]) | (eqt[7]&eqt[6]&eqt[5]&eqt[4]&eqt[3]&eqt[2]&eqt[1]&gtt[0]);
	assign lt = ~ (eq | gt);
	
endmodule