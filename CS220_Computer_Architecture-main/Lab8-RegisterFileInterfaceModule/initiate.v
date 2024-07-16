`timescale 1ns / 1ps



module RIGHT_SHIFT_MODULE(input clk,input[15:0] a, input[3:0]  shift,output reg[15:0] res
    );
	 
	 always@(posedge clk)begin
	 res <= ($signed(a) >>> shift);
	 end


endmodule


module INTERFACE_MODULE(input [3:0]  data,input clk,input rot,input reset,output inlinedata_1,output inlinedata_2);
	
	reg [127:0]inlinedata_1;
	reg [127:0]inlinedata_2;

    //! To detect positive rot
	reg prev;
    initial begin
        prev <= 1;
    end

	reg [4:0]stateofthedata; // 32 states of the data
	reg [3:0]cnt;

	reg [15:0]data_readed_1;
	reg [15:0]data_readed_2;
	wire [15:0]greater;
	wire [15:0]xorvalue;
	wire [15:0]result00s;
	reg [15:0]write_data;
	


	reg [3:0]shift;
	reg [15:0]reg_file[0:31];
	
	reg [4:0]read_addr_1;
	reg [4:0]read_addr_2;
	reg [4:0]add;

	 // Initializing reg_file with zeros
	initial begin
		reg_file[0]<=0;reg_file[1]<=0;reg_file[2]<=0;reg_file[3]<=0;
      reg_file[4]<=0;reg_file[5]<=0;reg_file[6]<=0;reg_file[7]<=0;
      reg_file[8]<=0;reg_file[9]<=0;reg_file[10]<=0;reg_file[11]<=0;
      reg_file[12]<=0;reg_file[13]<=0;reg_file[14]<=0;reg_file[15]<=0;
      
      reg_file[28]<=0;reg_file[29]<=0;reg_file[30]<=0;reg_file[31]<=0;
		stateofthedata<=0;
		cnt<=0;
		data_readed_1<=0;
		add<=0;
		shift<=0;
		inlinedata_1<=0;
		data_readed_2<=0;
		write_data<=0;
		reg_file[16]<=0;reg_file[17]<=0;reg_file[18]<=0;reg_file[19]<=0;
      reg_file[20]<=0;reg_file[21]<=0;reg_file[22]<=0;reg_file[23]<=0;
      reg_file[24]<=0;reg_file[25]<=0;reg_file[26]<=0;reg_file[27]<=0;
		read_addr_1<=0;
		read_addr_2<=0;
		inlinedata_2<=0;
		
	end

    
	always@(posedge clk) begin
		prev<=rot;
		if(reset==1) begin
			cnt<=0;
			stateofthedata<=0;
		end
		if(prev==0 & rot==1) begin
			// Your state machine transitions go here
            // I've omitted these for brevity
			if(stateofthedata==0) begin
                stateofthedata <= data[2:0] + 1;
			end
			
			else if(stateofthedata==1) begin
				if(cnt==0) begin
					add[3:0]<=data[3:0];
					cnt<=1;
				end
				else if(cnt==1) begin
					add[4]<=data[0];
					cnt<=2;
				end
				else if(cnt==2) begin
					write_data[3:0]<=data[3:0];
					cnt<=3;
				end
				else if(cnt==3) begin
					write_data[7:4]<=data[3:0];
					cnt<=4;
				end
				else if(cnt==4) begin
					write_data[11:8]<=data[3:0];
					cnt<=5;
				end
				
				else if(cnt==5) begin
					write_data[15:12]<=data[3:0];
					cnt<=0;
					stateofthedata<=9;
				end
			end
			
			
			else if(stateofthedata==2) begin
				if(cnt==0) begin
					read_addr_1[3:0]<=data[3:0];
					cnt<=1;
				end
				if(cnt==1) begin
					read_addr_1[4]<=data[0];
					cnt<=0;
					stateofthedata<=10;
				end
			end
			
			
			
			else if(stateofthedata==3) begin
				if(cnt==0) begin
					read_addr_1[3:0]<=data[3:0];
					cnt<=1;
				end
				if(cnt==1) begin
					read_addr_1[4]<=data[0];
					cnt<=2;
				end
				if(cnt==2) begin
					read_addr_2[3:0]<=data[3:0];
					cnt<=3;
				end
				if(cnt==3) begin
					read_addr_2[4]<=data[0];
					cnt<=0;
					stateofthedata<=11;
				end
			end

			else if(stateofthedata==4) begin
				if(cnt==0) begin
					read_addr_1[3:0]<=data[3:0];
					cnt<=1;
				end
				if(cnt==1) begin
					read_addr_1[4]<=data[0];
					cnt<=2;
				end
				if(cnt==2) begin
					add[3:0]<=data[3:0];
					cnt<=3;
				end
				if(cnt==3) begin
					add[4]<=data[0];
					cnt<=4;
				end
				if(cnt==4) begin
					write_data[3:0]<=data[3:0];
					cnt<=5;
				end
				if(cnt==5) begin
					write_data[7:4]<=data[3:0];
					cnt<=6;
				end
				if(cnt==6) begin
					write_data[11:8]<=data[3:0];
					cnt<=7;
				end
				if(cnt==7) begin
					write_data[15:12]<=data[3:0];
					cnt<=0;
					stateofthedata<=12;
				end
			end


			else if(stateofthedata==5) begin
				if(cnt==0) begin
					read_addr_1[3:0]<=data[3:0];
					cnt<=1;
				end
				if(cnt==1) begin
					read_addr_1[4]<=data[0];
					cnt<=2;
				end
				if(cnt==2) begin
					read_addr_2[3:0]<=data[3:0];
					cnt<=3;
				end
				if(cnt==3) begin
					read_addr_2[4]<=data[0];
					cnt<=4;
				end
				if(cnt==4) begin
					add[3:0]<=data[3:0];
					cnt<=5;
				end
				if(cnt==5) begin
					add[4]<=data[0];
					cnt<=6;
				end
				if(cnt==6) begin
					write_data[3:0]<=data[3:0];
					cnt<=7;
				end
				if(cnt==7) begin
					write_data[7:4]<=data[3:0];
					cnt<=8;
				end
				if(cnt==8) begin
					write_data[11:8]<=data[3:0];
					cnt<=9;
				end
				if(cnt==9) begin
					write_data[15:12]<=data[3:0];
					cnt<=0;
					stateofthedata<=13;
				end
			end


			else if(stateofthedata==6) begin
				if(cnt==0) begin
					read_addr_1[3:0]<=data[3:0];
					cnt<=1;
				end
				if(cnt==1) begin
					read_addr_1[4]<=data[0];
					cnt<=2;
				end
				if(cnt==2) begin
					read_addr_2[3:0]<=data[3:0];
					cnt<=3;
				end
				if(cnt==3) begin
					read_addr_2[4]<=data[0];
					cnt<=4;
				end
				if(cnt==4) begin
					add[3:0]<=data[3:0];
					cnt<=5;
				end
				if(cnt==5) begin
					add[4]<=data[0];
					cnt<=0;
					stateofthedata<=14;
				end
			end


			else if(stateofthedata==7) begin
				if(cnt==0) begin
					read_addr_1[3:0]<=data[3:0];
					cnt<=1;
				end
				if(cnt==1) begin
					read_addr_1[4]<=data[0];
					cnt<=2;
				end
				if(cnt==2) begin
					read_addr_2[3:0]<=data[3:0];
					cnt<=3;
				end
				if(cnt==3) begin
					read_addr_2[4]<=data[0];
					cnt<=4;
				end
				if(cnt==4) begin
					add[3:0]<=data[3:0];
					cnt<=5;
				end
				if(cnt==5) begin
					add[4]<=data[0];
					cnt<=0;
					stateofthedata<=15;
				end
			end


			else if(stateofthedata==8) begin
				if(cnt==0) begin
					read_addr_1[3:0]<=data[3:0];
					cnt<=1;
				end
				if(cnt==1) begin
					read_addr_1[4]<=data[0];
					cnt<=2;
				end
				if(cnt==2) begin
					add[3:0]<=data[3:0];
					cnt<=3;
				end
				if(cnt==3) begin
					add[4]<=data[0];
					cnt<=4;
				end
				if(cnt==4) begin
					shift[3:0]<=data[3:0];
					cnt<=0;
					stateofthedata<=16;
				end
			end			
			
			else if(stateofthedata==9) begin
				reg_file[add]<=write_data;
				stateofthedata<=17;
			end
			
			
			else if(stateofthedata==10) begin
				data_readed_1<=reg_file[read_addr_1];
				stateofthedata<=18;
			end

			else if(stateofthedata==11) begin
				data_readed_1<=reg_file[read_addr_1];				
				stateofthedata<=25;
			end

			else if(stateofthedata==12) begin
				data_readed_1<=reg_file[read_addr_1];
				reg_file[add]<=write_data;
				stateofthedata<=20;
			end

			else if(stateofthedata==13) begin
				data_readed_1<=reg_file[read_addr_1];
				reg_file[add]<=write_data;
				stateofthedata<=26;
			end

			else if(stateofthedata==14) begin
				data_readed_1<=reg_file[read_addr_1];
				stateofthedata<=27;
			end

			else if(stateofthedata<=15) begin
				data_readed_1<=reg_file[read_addr_1];
				stateofthedata<=28;
			end


			else if(stateofthedata==16) begin
				data_readed_1<=reg_file[read_addr_1];
				stateofthedata<=24;
			end
            
			
    // Continuous assignments for inlinedata_1 and inlinedata_2 based on your conditions
    // You need to fill these with your required logic
    // Example: 
    // assign inlinedata_1[127:120] = 8'b00000000;
    // assign inlinedata_2[79:72] = (greater[9] == 1) ? 8'b11111111 : 8'b00000000;
    // You need to complete these assignments based on your state transitions
			
			else if(stateofthedata==17) begin
				inlinedata_1[127:40]<="00000000";
				
				
				inlinedata_2[127:120]<=write_data[15]?"1":"0";
				inlinedata_2[119:112]<=write_data[14]?"1":"0";
				inlinedata_2[111:104]<=write_data[13]?"1":"0";
				inlinedata_2[103:96]<=write_data[12]?"1":"0";
				inlinedata_1[23:16]<=add[2]?"1":"0";
				inlinedata_2[95:88]<=write_data[11]?"1":"0";
				inlinedata_2[87:80]<=write_data[10]?"1":"0";
				inlinedata_1[15:8]<=add[1]?"1":"0";
				inlinedata_2[79:72]<=write_data[9]?"1":"0";
				inlinedata_2[71:64]<=write_data[8]?"1":"0";
				inlinedata_1[39:32]<=add[4]?"1":"0";
				inlinedata_2[63:56]<=write_data[7]?"1":"0";
				inlinedata_2[55:48]<=write_data[6]?"1":"0";
				inlinedata_2[47:40]<=write_data[5]?"1":"0";
				inlinedata_2[39:32]<=write_data[4]?"1":"0";
				inlinedata_1[31:24]<=add[3]?"1":"0";
				inlinedata_2[31:24]<=write_data[3]?"1":"0";
				inlinedata_1[7:0]<=add[0]?"1":"0";
				inlinedata_2[23:16]<=write_data[2]?"1":"0";
				inlinedata_2[15:8]<=write_data[1]?"1":"0";
				inlinedata_2[7:0]<=write_data[0]?"1":"0";
				stateofthedata<=0;
			end
			
			
			else if(stateofthedata==18) begin
				inlinedata_2[79:72]<=data_readed_1[9]?"1":"0";
				inlinedata_2[71:64]<=data_readed_1[8]?"1":"0";
				inlinedata_2[63:56]<=data_readed_1[7]?"1":"0";
				inlinedata_2[55:48]<=data_readed_1[6]?"1":"0";
				inlinedata_2[47:40]<=data_readed_1[5]?"1":"0";
				inlinedata_1[31:24]<=read_addr_1[3]?"1":"0";
				inlinedata_2[23:16]<=data_readed_1[2]?"1":"0";
				inlinedata_2[39:32]<=data_readed_1[4]?"1":"0";
				inlinedata_2[31:24]<=data_readed_1[3]?"1":"0";
				inlinedata_1[7:0]<=read_addr_1[0]?"1":"0";
				inlinedata_2[127:120]<=data_readed_1[15]?"1":"0";
				inlinedata_2[119:112]<=data_readed_1[14]?"1":"0";
				inlinedata_2[15:8]<=data_readed_1[1]?"1":"0";
				inlinedata_1[23:16]<=read_addr_1[2]?"1":"0";
				inlinedata_1[127:40]<="00000000";
				inlinedata_2[111:104]<=data_readed_1[13]?"1":"0";
				inlinedata_1[15:8]<=read_addr_1[1]?"1":"0";
				inlinedata_2[103:96]<=data_readed_1[12]?"1":"0";
				inlinedata_1[39:32]<=read_addr_1[4]?"1":"0";
				
				inlinedata_2[95:88]<=data_readed_1[11]?"1":"0";
				inlinedata_2[87:80]<=data_readed_1[10]?"1":"0";
			
				inlinedata_2[7:0]<=data_readed_1[0]?"1":"0";
				stateofthedata<=0;
            end
			else if(stateofthedata==19) begin
				inlinedata_1[127:120]<=data_readed_1[15]?"1":"0";
				inlinedata_1[71:64]<=data_readed_1[8]?"1":"0";
				inlinedata_1[63:56]<=data_readed_1[7]?"1":"0";
				inlinedata_1[55:48]<=data_readed_1[6]?"1":"0";
				inlinedata_1[47:40]<=data_readed_1[5]?"1":"0";
				inlinedata_1[111:104]<=data_readed_1[13]?"1":"0";
				inlinedata_2[87:80]<=data_readed_2[10]?"1":"0";
				inlinedata_2[79:72]<=data_readed_2[9]?"1":"0";
				inlinedata_2[71:64]<=data_readed_2[8]?"1":"0";
				inlinedata_2[63:56]<=data_readed_2[7]?"1":"0";
				inlinedata_2[55:48]<=data_readed_2[6]?"1":"0";
				inlinedata_1[103:96]<=data_readed_1[12]?"1":"0";
				
				inlinedata_2[111:104]<=data_readed_2[13]?"1":"0";
				inlinedata_2[103:96]<=data_readed_2[12]?"1":"0";
				inlinedata_2[95:88]<=data_readed_2[11]?"1":"0";
				inlinedata_2[47:40]<=data_readed_2[5]?"1":"0";
				inlinedata_2[39:32]<=data_readed_2[4]?"1":"0";
				inlinedata_2[23:16]<=data_readed_2[2]?"1":"0";
				inlinedata_2[15:8]<=data_readed_2[1]?"1":"0";
				inlinedata_1[95:88]<=data_readed_1[11]?"1":"0";
				inlinedata_1[87:80]<=data_readed_1[10]?"1":"0";
				inlinedata_1[79:72]<=data_readed_1[9]?"1":"0";
				inlinedata_1[39:32]<=data_readed_1[4]?"1":"0";
					inlinedata_1[119:112]<=data_readed_1[14]?"1":"0";
				inlinedata_1[31:24]<=data_readed_1[3]?"1":"0";
				inlinedata_1[23:16]<=data_readed_1[2]?"1":"0";
				inlinedata_1[15:8]<=data_readed_1[1]?"1":"0";
				inlinedata_1[7:0]<=data_readed_1[0]?"1":"0";

				inlinedata_2[127:120]<=data_readed_2[15]?"1":"0";
				inlinedata_2[119:112]<=data_readed_2[14]?"1":"0";
			
				inlinedata_2[7:0]<=data_readed_2[0]?"1":"0";
				inlinedata_2[31:24]<=data_readed_2[3]?"1":"0";
				
				
				
				stateofthedata<=0;
			end
			else if(stateofthedata==20) begin
				inlinedata_1[127:40]<="00000000";
				inlinedata_1[31:24]<=read_addr_1[3]?"1":"0";
				
				inlinedata_2[55:48]<=data_readed_1[6]?"1":"0";
				inlinedata_2[47:40]<=data_readed_1[5]?"1":"0";
				inlinedata_2[39:32]<=data_readed_1[4]?"1":"0";
				inlinedata_2[31:24]<=data_readed_1[3]?"1":"0";
				inlinedata_1[23:16]<=read_addr_1[2]?"1":"0";
				inlinedata_1[15:8]<=read_addr_1[1]?"1":"0";
				inlinedata_2[87:80]<=data_readed_1[10]?"1":"0";
				
				inlinedata_2[111:104]<=data_readed_1[13]?"1":"0";
				inlinedata_2[103:96]<=data_readed_1[12]?"1":"0";
				inlinedata_2[95:88]<=data_readed_1[11]?"1":"0";
				
				inlinedata_2[23:16]<=data_readed_1[2]?"1":"0";
				inlinedata_2[15:8]<=data_readed_1[1]?"1":"0";
				inlinedata_2[79:72]<=data_readed_1[9]?"1":"0";
				inlinedata_1[39:32]<=read_addr_1[4]?"1":"0";
				inlinedata_2[71:64]<=data_readed_1[8]?"1":"0";
				inlinedata_2[63:56]<=data_readed_1[7]?"1":"0";
				inlinedata_1[7:0]<=read_addr_1[0]?"1":"0";
				inlinedata_2[127:120]<=data_readed_1[15]?"1":"0";
				inlinedata_2[119:112]<=data_readed_1[14]?"1":"0";
				inlinedata_2[7:0]<=data_readed_1[0]?"1":"0";
				stateofthedata<=0;
			end
			else if(stateofthedata==21) begin
				inlinedata_1[111:104]<=data_readed_1[13]?"1":"0";
				inlinedata_1[103:96]<=data_readed_1[12]?"1":"0";
			
				inlinedata_1[15:8]<=data_readed_1[1]?"1":"0";
				inlinedata_1[7:0]<=data_readed_1[0]?"1":"0";
				inlinedata_2[127:120]<=data_readed_2[15]?"1":"0";
				inlinedata_1[95:88]<=data_readed_1[11]?"1":"0";
				inlinedata_1[87:80]<=data_readed_1[10]?"1":"0";
				inlinedata_1[47:40]<=data_readed_1[5]?"1":"0";
				inlinedata_1[39:32]<=data_readed_1[4]?"1":"0";
				inlinedata_1[31:24]<=data_readed_1[3]?"1":"0";
			
				inlinedata_2[119:112]<=data_readed_2[14]?"1":"0";
				inlinedata_1[79:72]<=data_readed_1[9]?"1":"0";
				inlinedata_1[71:64]<=data_readed_1[8]?"1":"0";
				inlinedata_1[63:56]<=data_readed_1[7]?"1":"0";
				inlinedata_1[55:48]<=data_readed_1[6]?"1":"0";

				inlinedata_2[111:104]<=data_readed_2[13]?"1":"0";
				inlinedata_2[87:80]<=data_readed_2[10]?"1":"0";
				inlinedata_2[79:72]<=data_readed_2[9]?"1":"0";
				inlinedata_1[127:120]<=data_readed_1[15]?"1":"0";
				inlinedata_1[119:112]<=data_readed_1[14]?"1":"0";
				
				inlinedata_2[71:64]<=data_readed_2[8]?"1":"0";
				inlinedata_2[63:56]<=data_readed_2[7]?"1":"0";
				inlinedata_2[55:48]<=data_readed_2[6]?"1":"0";
				inlinedata_1[23:16]<=data_readed_1[2]?"1":"0";
				inlinedata_2[103:96]<=data_readed_2[12]?"1":"0";
				inlinedata_2[95:88]<=data_readed_2[11]?"1":"0";
			
				inlinedata_2[47:40]<=data_readed_2[5]?"1":"0";
				inlinedata_2[39:32]<=data_readed_2[4]?"1":"0";
				inlinedata_2[31:24]<=data_readed_2[3]?"1":"0";
				inlinedata_2[23:16]<=data_readed_2[2]?"1":"0";
				inlinedata_2[15:8]<=data_readed_2[1]?"1":"0";
				inlinedata_2[7:0]<=data_readed_2[0]?"1":"0";
				stateofthedata<=0;
			end
			else if(stateofthedata==22) begin
				reg_file[add]<=greater;
				inlinedata_1[127:40]<="00000000";
				inlinedata_1[39:32]<=add[4]?"1":"0";
				inlinedata_1[31:24]<=add[3]?"1":"0";
				inlinedata_2[39:32]<=greater[4]?"1":"0";
				inlinedata_2[31:24]<=greater[3]?"1":"0";
				inlinedata_2[23:16]<=greater[2]?"1":"0";
				inlinedata_2[71:64]<=greater[8]?"1":"0";
				inlinedata_2[63:56]<=greater[7]?"1":"0";
				inlinedata_2[103:96]<=greater[12]?"1":"0";
				inlinedata_2[47:40]<=greater[5]?"1":"0";
				inlinedata_2[15:8]<=greater[1]?"1":"0";
				inlinedata_2[95:88]<=greater[11]?"1":"0";
				inlinedata_2[87:80]<=greater[10]?"1":"0";
				inlinedata_1[7:0]<=add[0]?"1":"0";
				inlinedata_2[127:120]<=greater[15]?"1":"0";
				inlinedata_2[119:112]<=greater[14]?"1":"0";
				inlinedata_2[55:48]<=greater[6]?"1":"0";
				inlinedata_1[23:16]<=add[2]?"1":"0";
				inlinedata_1[15:8]<=add[1]?"1":"0";
				inlinedata_2[111:104]<=greater[13]?"1":"0";
				inlinedata_2[79:72]<=greater[9]?"1":"0";
				inlinedata_2[7:0]<=greater[0]?"1":"0";
				stateofthedata<=0;
			end
			else if(stateofthedata==23) begin
				reg_file[add]<=xorvalue;
				inlinedata_1[127:40]<="00000000";
				
				inlinedata_2[79:72]<=xorvalue[9]?"1":"0";
				inlinedata_2[71:64]<=xorvalue[8]?"1":"0";
				inlinedata_1[31:24]<=add[3]?"1":"0";
				inlinedata_1[23:16]<=add[2]?"1":"0";
				inlinedata_1[15:8]<=add[1]?"1":"0";
				inlinedata_2[119:112]<=xorvalue[14]?"1":"0";
				inlinedata_2[15:8]<=xorvalue[1]?"1":"0";
				inlinedata_1[39:32]<=add[4]?"1":"0";
				inlinedata_2[39:32]<=xorvalue[4]?"1":"0";
				
				inlinedata_2[63:56]<=xorvalue[7]?"1":"0";
				inlinedata_2[47:40]<=xorvalue[5]?"1":"0";
				inlinedata_2[55:48]<=xorvalue[6]?"1":"0";
				inlinedata_1[7:0]<=add[0]?"1":"0";
				inlinedata_2[23:16]<=xorvalue[2]?"1":"0";
				inlinedata_2[31:24]<=xorvalue[3]?"1":"0";
				inlinedata_2[111:104]<=xorvalue[13]?"1":"0";
				inlinedata_2[103:96]<=xorvalue[12]?"1":"0";
				inlinedata_2[127:120]<=xorvalue[15]?"1":"0";
				inlinedata_2[95:88]<=xorvalue[11]?"1":"0";
				inlinedata_2[87:80]<=xorvalue[10]?"1":"0";
				inlinedata_2[7:0]<=xorvalue[0]?"1":"0";
				stateofthedata<=0;
			end
			else if(stateofthedata==24) begin


				reg_file[add]<=result00s;
					inlinedata_2[111:104]<=result00s[13]?"1":"0";
				inlinedata_2[39:32]<=result00s[4]?"1":"0";
				inlinedata_2[31:24]<=result00s[3]?"1":"0";
				inlinedata_2[103:96]<=result00s[12]?"1":"0";
				inlinedata_2[95:88]<=result00s[11]?"1":"0";
				inlinedata_2[87:80]<=result00s[10]?"1":"0";
				inlinedata_1[127:40]<="00000000";
				inlinedata_1[39:32]<=add[4]?"1":"0";
				inlinedata_1[31:24]<=add[3]?"1":"0";
				inlinedata_2[7:0]<=result00s[0]?"1":"0";
				inlinedata_1[23:16]<=add[2]?"1":"0";
				inlinedata_1[7:0]<=add[0]?"1":"0";
				inlinedata_2[79:72]<=result00s[9]?"1":"0";
				inlinedata_1[15:8]<=add[1]?"1":"0";
				inlinedata_2[47:40]<=result00s[5]?"1":"0";
			
				inlinedata_2[63:56]<=result00s[7]?"1":"0";
				inlinedata_2[55:48]<=result00s[6]?"1":"0";
				inlinedata_2[127:120]<=result00s[15]?"1":"0";
				inlinedata_2[119:112]<=result00s[14]?"1":"0";
				inlinedata_2[23:16]<=result00s[2]?"1":"0";
				inlinedata_2[15:8]<=result00s[1]?"1":"0";
				inlinedata_2[71:64]<=result00s[8]?"1":"0";
				stateofthedata<=0;
			end
			else if(stateofthedata==25)begin
				data_readed_2<=reg_file[read_addr_2];
				stateofthedata<=19;
			end
			else if(stateofthedata==26)begin
				data_readed_2<=reg_file[read_addr_2];
				stateofthedata<=21;
			end
			else if(stateofthedata==27)begin
				data_readed_2<=reg_file[read_addr_2];
				stateofthedata<=22;			
			end
			else if(stateofthedata==28)begin
				data_readed_2<=reg_file[read_addr_2];
				stateofthedata<=23;			
			end
			
		end
	end
    COMPARATOR_MODULE S0(data_readed_1,data_readed_2,greater);
	assign xorvalue = data_readed_1^data_readed_2;
	RIGHT_SHIFT_MODULE RIGHT(clk,data_readed_1,shift,result00s);
endmodule
