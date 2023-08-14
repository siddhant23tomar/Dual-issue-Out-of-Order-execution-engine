module D_cache (
					  input clk,  
					  input mem_write,
					  
					  input [15:0] mem_access_addr0, 
					  input [15:0] mem_access_addr1,
					  input [15:0] mem_write_data0, 
					  input [15:0] mem_write_data1,
					  
					  
					    
					  output [15:0] mem_read_data0,
					  output [15:0] mem_read_data1
					  );  
						  
	integer i;  
	reg [15:0] data_mem[0:255];
	initial begin  
	  for(i=0; i<256; i=i+1)  
			 data_mem [i] <= i;  
	end
	
	
	
	wire [7:0] addr0 = mem_access_addr0[7:0]; 
	wire [7:0] addr1 = mem_access_addr1[7:0]; 
	
 
	
	

	assign mem_read_data0 = data_mem [addr0] ; 
	assign mem_read_data1 = data_mem [addr1] ; 	
	
	
	
	always @(posedge clk) 
	begin  
	  if (mem_write)  begin
			 data_mem [addr0] <= mem_write_data0;  
			 data_mem [addr1] <= mem_write_data1; 
			end
			
	end  
	
	
 
endmodule 