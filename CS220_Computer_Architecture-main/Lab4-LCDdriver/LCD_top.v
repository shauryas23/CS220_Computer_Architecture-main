`timescale 1ns / 1ps

module lcd_top(clk,lcd_e,lcd_rs,lcd_w,data);

output wire lcd_e,lcd_rs,lcd_w;
output wire [3:0]data;
wire [127:0]line1,line2;
lcd_welcome_iitk L0(clk,line1,line2, lcd_e, lcd_w, lcd_rs, data);

assign line1=128'h57454C434F4D4520544F204353452C20;
assign line2=128'h494954204B414E505552202020202020;

endmodule

TOP MODULE