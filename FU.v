module FU(

input clk,
input [3:0]opcode,
input [15:0] a,b,imm,
input [15:0] pc_in,
input [2:0]dest_tag_in,

output reg [15:0] sum,
output reg [15:0]pc_out,
output reg [2:0] dest_tag_out,

output reg [15:0]st_value,

output reg[1:0]type_value,
output  broadcast
);


 always@(posedge clk)
begin
		st_value <=16'bz;
		type_value <= 2'b00;//ALU
	if(opcode==4'b0101) // STORE
		begin
		type_value <= 2'b01;
		st_value <= a;
		end
		
	else if(opcode==4'b0100) //LOAD
		type_value<= 2'b10;
end


 always@(posedge clk)
 begin
 
 if((opcode===4'b0101)|(opcode===4'b0100))
 
 
			if((imm===16'bz)|(b===16'bz)|(imm===16'bx)|(b===16'bx))
				begin
				 sum<=16'bz;
				 dest_tag_out<=3'bz;
				 pc_out<=16'bz;

				end
			else
			 begin
				 sum <= b+imm;
				 dest_tag_out <= dest_tag_in; 
				 pc_out<=pc_in;
			 end
			 
			 
 else
 
 
		 if((a===16'bz)|(b===16'bz)|(a===16'bx)|(b===16'bx))
						begin
						 sum<=16'bz;
						 dest_tag_out<=3'bz;
						 pc_out<=16'bz;

						end
					else
					 begin
						 sum <= a+b;
						 dest_tag_out <= dest_tag_in; 
						 pc_out<=pc_in;
					 end
		 
 
 
	 
 end


assign broadcast=((sum===16'bz)|(sum===16'bx))?1'b0:1'b1;
 
 endmodule
 