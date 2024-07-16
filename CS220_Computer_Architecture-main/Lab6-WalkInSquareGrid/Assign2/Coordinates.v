`timescale 1ns / 1ps

module Coordinates(x, y, num, sum_x, sum_y);
  // x and y coorinates are represented in 4 bits each
  // num is the operation, the first two bits are the number of the steps while the next two are direction
  input [3:0] x, y, num;		
  output [4:0] sum_x, sum_y;
  wire [4:0] sum_x, sum_y;

  wire op;
  wire [1:0] addx, addy;
  wire [4:0] coutx, couty;

  // Extracting operation bit, this explains whether we are increasing or decreasing the coordinates
  assign op = num[1];

  // num[0] decides whether we are going along x or y
  assign addx = {num[3] & num[0], num[2] & num[0]};
  assign addy = {num[3] & (~num[0]), num[2] & (~num[0])};

  // Add the addx and addy values which are calculate above
  FullAdder FA0(x[0], addx[0], op, op, sum_x[0], coutx[0]);
  FullAdder FA1(y[0], addy[0], op, op, sum_y[0], couty[0]);

  FullAdder FA3(x[1], addx[1], coutx[0], op, sum_x[1], coutx[1]);
  FullAdder FA4(y[1], addy[1], couty[0], op, sum_y[1], couty[1]);

  FullAdder FA5(x[2], 0, coutx[1], op, sum_x[2], coutx[2]);
  FullAdder FA6(y[2], 0, couty[1], op, sum_y[2], couty[2]);

  FullAdder FA7(x[3], 0, coutx[2], op, sum_x[3], coutx[3]);
  FullAdder FA8(y[3], 0, couty[2], op, sum_y[3], couty[3]);

  FullAdder FA9(1'b0, 0, coutx[3], op, sum_x[4], coutx[4]);
  FullAdder FA10(1'b0, 0, couty[3], op, sum_y[4], couty[4]);

endmodule
