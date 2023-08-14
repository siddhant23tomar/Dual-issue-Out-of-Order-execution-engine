module reg_rename_unit(
//input clk,
input [0:7]free_rrf,
output [2:0]rr0,
output [2:0]rr1,
output rrf_full
);

integer j,count,cnt;
reg [2:0] rr[0:1];

always@(free_rrf)
	begin
		 count=0;
		 rr[0]=3'bz;
		 rr[1]=3'bz;
		 
		 for(j=0;j<8;j=j+1)
			begin
				if((free_rrf[j]==1'b1)&(count<2))
					begin
						
						rr[count]=j;
						count=count+1;
			
					end
			end
		
			
	end
	
	
	
assign rrf_full = (count==2)?1'b0:1'b1;	
	
assign rr0 =rr[0];
assign rr1 =rr[1];

endmodule

