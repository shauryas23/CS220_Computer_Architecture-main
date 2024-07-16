`timescale 1ns / 1ps

module LCD( clk, line1, line2, lcd_e, lcd_w, lcd_rs, data);

input clk;
input [127:0]line1,line2;
output wire lcd_e, lcd_w, lcd_rs;
output wire [3:0] data;

reg [22:0] counter;
reg [2:0] inc;

reg lcd_er, lcd_wr, lcd_rsr;
reg [3:0] data_r;
reg [1:0] flag;
reg [7:0] index1,index2,index3,index4;

initial 
begin
lcd_er=0; lcd_wr=0; lcd_rsr =0;flag=0; index1 = 55; counter=0; inc=0;index2=127;index3=7;index4=127;
end

wire[55:0] config_data;
wire[7:0] br;
assign config_data=56'h333228060C0180;
assign br = 8'hC0;

always @(posedge clk)
begin
	counter = counter + 1;
	if(counter == 1000000 && inc==3'b000)
	begin
		if(flag==2'b00)
		begin
			lcd_er=0;
			flag = flag+1;
		end
		else if(flag == 2'b01)
		begin
			data_r[3] = config_data[index1];
			data_r[2] = config_data[index1-1];
			data_r[1] = config_data[index1-2];
			data_r[0] = config_data[index1-3];
			flag=flag+1;	
		end
		else if(flag == 2'b10)
		begin
			
			if (index1 == 3)
			begin
				inc = 3'b001;
				flag=0;
			end
			lcd_er=1;
			flag = 0;
			index1 = index1-4;
		end
		counter = 0;
	end
	else if(inc == 3'b001 && counter == 1000000)
	begin
		
		if(flag==2'b00)
		begin
			lcd_er=0;
			flag = flag+1;
		end
		else if(flag == 2'b01)
		begin
			lcd_rsr =1;
			lcd_wr =0;
			data_r[3] = line1[index2];
			data_r[2] = line1[index2-1];
			data_r[1] = line1[index2-2];
			data_r[0] = line1[index2-3];
			flag=flag+1;
			
		end
		else if(flag == 2'b10)
		begin
			if (index2 ==3)
			begin
				inc = 3'b010;
				flag=0;
			end
			lcd_er=1;
			flag = 0;
			index2 = index2-4;
		end
		counter = 0;
	end
	else if(inc == 3'b010 && counter == 1000000)
	begin
		
		if(flag == 2'b00)
		begin
			lcd_er=0;
			flag = flag+1;
		end
		else if(flag == 2'b01)
		begin
			lcd_rsr=0;
			lcd_wr=0;
			data_r[3] = br[index3];
			data_r[2] = br[index3-1];
			data_r[1] = br[index3-2];
			data_r[0] = br[index3-3];
			flag=flag+1;
		end
		else if(flag == 2'b10)
		begin
			if (index3 ==3)
			begin
				inc = 3'b011;
				flag=0;
			end
			lcd_er=1;
			flag = 0;
			index3 = index3-4;
		end
		counter = 0;
	end
	else if(inc == 3'b011 && counter == 1000000)
	begin
		if(flag==2'b00)
		begin
			lcd_er=0;
			flag = flag+1;
		end
		else if(flag == 2'b01)
		begin
			lcd_rsr=1;
			lcd_wr=0;
			data_r[3] = line2[index4];
			data_r[2] = line2[index4-1];
			data_r[1] = line2[index4-2];
			data_r[0] = line2[index4-3];
			flag=flag+1;	
		end
		else if(flag == 2'b10)
		begin
			if (index4 ==3)
			begin
				inc = 3'b110;
			end
			lcd_er=1;
			flag = 0;
			index4 = index4-4;
		end
		counter = 0;
	end	
end


assign data[3:0] = data_r[3:0];
assign lcd_e = lcd_er;
assign lcd_w = lcd_wr;
assign lcd_rs = lcd_rsr; 

endmodule

