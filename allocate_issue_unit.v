module allocate_issue_unit(
//input clk,
input [0:7]free_rs,
input [0:7]rdy,
output [2:0]rs_entry0,
output [2:0]rs_entry1,
output [2:0]rs_issue0,
output [2:0]rs_issue1,
output rs_full
);

integer j,count,cnt;
reg [2:0] rs_entry[0:1];
reg [2:0] rs_issue[0:1];

always@(free_rs,rdy)
	begin
		 count=0;
		 rs_entry[0]=3'bz;
		 rs_entry[1]=3'bz;
		
		 
		 for(j=0;j<8;j=j+1)
			begin
				if((free_rs[j]==1'b1)&(count<2))
					begin
						
						rs_entry[count]=j;
						count=count+1;
			
					end
			end
		
		
		 cnt=0;
		 rs_issue[0]=3'bz;
		 rs_issue[1]=3'bz;
		 
			for(j=0;j<8;j=j+1)
			begin
				if((rdy[j]==1'b1)&(cnt<2)&(free_rs[j]==1'b0))
					begin
						
						rs_issue[cnt]=j;
						cnt=cnt+1;
			
					end
			end
			

	end
	

	
	
	
assign rs_full = (count==2)?1'b0:1'b1;	
	
assign rs_entry0 =rs_entry[0];
assign rs_entry1 =rs_entry[1];

assign rs_issue0 =rs_issue[0];
assign rs_issue1 =rs_issue[1];

endmodule

