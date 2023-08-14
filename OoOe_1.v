module OoOe_1

(
input clk,rst,
input [15:0] pc0,pc1,

input [3:0] op0,
input [2:0] rs1,rs2,rd1,   

input [3:0] op1,
input [2:0] rs3,rs4,rd2, 
//
input [15:0] imm0,imm1,
//input [2:0] func0,func1,



//RS

output [0:7]free_RS ,

output [3:0]opcode_0 ,
output [3:0]opcode_1 ,
output [3:0]opcode_2 ,
output [3:0]opcode_3 ,
output [3:0]opcode_4 ,
output [3:0]opcode_5 ,
output [3:0]opcode_6 ,
output [3:0]opcode_7 ,



output [0:7]v1_RS ,

output [2:0]rs_tag1_0 ,
output [2:0]rs_tag1_1 ,
output [2:0]rs_tag1_2 ,
output [2:0]rs_tag1_3 ,
output [2:0]rs_tag1_4 ,
output [2:0]rs_tag1_5 ,
output [2:0]rs_tag1_6 ,
output [2:0]rs_tag1_7 ,

output [15:0]rs_src1_0 ,
output [15:0]rs_src1_1 ,
output [15:0]rs_src1_2 ,
output [15:0]rs_src1_3 ,
output [15:0]rs_src1_4 ,
output [15:0]rs_src1_5 ,
output [15:0]rs_src1_6 ,
output [15:0]rs_src1_7 ,


output [0:7]v2_RS ,

output [2:0]rs_tag2_0 ,
output [2:0]rs_tag2_1 ,
output [2:0]rs_tag2_2 ,
output [2:0]rs_tag2_3 ,
output [2:0]rs_tag2_4 ,
output [2:0]rs_tag2_5 ,
output [2:0]rs_tag2_6 ,
output [2:0]rs_tag2_7 ,

output [15:0]rs_src2_0 ,
output [15:0]rs_src2_1 ,
output [15:0]rs_src2_2 ,
output [15:0]rs_src2_3 ,
output [15:0]rs_src2_4 ,
output [15:0]rs_src2_5 ,
output [15:0]rs_src2_6 ,
output [15:0]rs_src2_7 ,


output [2:0]dest_tag_0 ,
output [2:0]dest_tag_1 ,
output [2:0]dest_tag_2 ,
output [2:0]dest_tag_3 ,
output [2:0]dest_tag_4 ,
output [2:0]dest_tag_5 ,
output [2:0]dest_tag_6 ,
output [2:0]dest_tag_7 ,

//RRF

output[0:7] free_RRF ,

output[0:7] v_RRF ,

output [15:0]rrf_data0 ,
output [15:0]rrf_data1 ,
output [15:0]rrf_data2 ,
output [15:0]rrf_data3 ,
output [15:0]rrf_data4 ,
output [15:0]rrf_data5 ,
output [15:0]rrf_data6 ,
output [15:0]rrf_data7 ,

//ARF


output[0:7] v_ARF ,

output [2:0]arf_tag0 ,
output [2:0]arf_tag1 ,
output [2:0]arf_tag2 ,
output [2:0]arf_tag3 ,
output [2:0]arf_tag4 ,
output [2:0]arf_tag5 ,
output [2:0]arf_tag6 ,
output [2:0]arf_tag7 ,

output [15:0]arf_data0 ,
output [15:0]arf_data1 ,
output [15:0]arf_data2 ,
output [15:0]arf_data3 ,
output [15:0]arf_data4 ,
output [15:0]arf_data5 ,
output [15:0]arf_data6 ,
output [15:0]arf_data7 ,



//ROB

output[0:15] busy_ROB     ,
output[0:15] finished_ROB ,

output [2:0]dest_tag_ROB0 ,
output [2:0]dest_tag_ROB1 ,
output [2:0]dest_tag_ROB2 ,
output [2:0]dest_tag_ROB3 ,
output [2:0]dest_tag_ROB4 ,
output [2:0]dest_tag_ROB5 ,
output [2:0]dest_tag_ROB6 ,
output [2:0]dest_tag_ROB7 ,
output [2:0]dest_tag_ROB8 ,
output [2:0]dest_tag_ROB9 ,
output [2:0]dest_tag_ROB10 ,
output [2:0]dest_tag_ROB11 ,
output [2:0]dest_tag_ROB12 ,
output [2:0]dest_tag_ROB13 ,
output [2:0]dest_tag_ROB14 ,
output [2:0]dest_tag_ROB15 

);

// SIGNALS FOR FU 

wire[2:0] broadcasted_dest_tag_1,broadcasted_dest_tag_2;
wire broadcast1,broadcast2;
wire [15:0] result1,result2;


//ARF ( each entry listed explicitly)

reg [0:7] v_arf;

reg [15:0] arf_data[0:7];
reg [2:0] arf_tag[0:7];
integer i;  

initial begin
 for (i=0; i<8;i=i+1)
 begin
 v_arf[i]<=1'b1;
 arf_data[i]<=i;
 end
 end
 

//RRF ( each entry listed explicitly)

reg [0:7]free_rrf;
initial free_rrf = 8'hFF;



//initial free_rrf = 8'hff;
reg [0:7] v_rrf;
initial v_rrf = 8'h00;
reg [15:0] rrf_data[0:7];


 

// Reservation Table ( each entry listed explicitly)(8 ENTRIES)

reg [0:7] free_rs;
initial free_rs = 8'hFF;
	
reg [15:0] pc_rs[0:7];	

reg [3:0] opcode [0:7];


reg [0:7] v1_rs;
initial v1_rs=8'b0;
reg [15:0] rs_src1 [0:7];
reg [2:0] rs_tag1 [0:7];  

reg [0:7] v2_rs;
initial v2_rs=8'b0;
reg [15:0] rs_src2 [0:7];
reg [2:0] rs_tag2 [0:7]; 

reg [2:0] dest_tag [0:7];

reg [15:0] imm_rs[0:7];


// ROB ( each entry listed explicitly)(16 ENTRIES)


//ROB: control signals
reg rob_full;
reg[3:0] head,tail;
initial 
	begin
	head =4'b0;tail=4'b0;
	end

//ROB: entries
reg [15:0] pc_rob [0:15];
reg [0:15] busy,finished;
reg [2:0] dest_tag_ROB [0:15];
initial busy = 16'h0000;
initial finished = 16'h0000;

//issuing signals
wire [15:0] pc_in [0:1];
wire [15:0] pc_out [0:1];
wire [3:0] op [0:1];
wire [15:0] rsrc1 [0:1];
wire [15:0] rsrc2 [0:1];
wire [15:0] imm [0:1];

wire [2:0] dest  [0:1];
wire [1:0] type_value_FU[0:1];

wire [15:0] st_value_FU [0:1];


//D_cache signals
wire [15:0] read_addr0,read_addr1,data0,data1;
reg [15:0]ld_addr[0:1];
reg [15:0]ld_value[0:1];
reg ld_pending;


/////////////////////////////////////////////////////////////////////


//REGISTER RENAMING LOGIC

wire [2:0]rr0;
wire [2:0]rr1;
wire rrf_full;

reg_rename_unit inst0 (free_rrf,rr0,rr1,rrf_full);
always@(posedge clk)
	begin
	 free_rrf[rr0]<=(op0!==4'b0101)?1'b0:1'b1;
	 free_rrf[rr1]<=(op1!==4'b0101)?1'b0:1'b1;
	 
	 if((finished[head]==1'b1))
			free_rrf[dest_tag_ROB[head]]<=1'b1;
			
	if((finished[head]==1'b1)&(finished[head+1]==1'b1))
			free_rrf[dest_tag_ROB[head+1]]<=1'b1;
	end

////////////////////////////////////////////////////////////////

//ALLOCATE AND ISSUE LOGIC

wire [2:0]rs_entry0;
wire [2:0]rs_entry1;
wire [2:0]rs_issue0;
wire [2:0]rs_issue1;
wire rs_full;
wire [0:7] rdy;
assign rdy = v1_rs & v2_rs;

//	
allocate_issue_unit inst1 (free_rs,rdy,rs_entry0,rs_entry1,rs_issue0,rs_issue1,rs_full);


always @(posedge clk)
	begin
		if(op0!==4'bz)
			free_rs[rs_entry0] <= 1'b0;
		if(op1!==4'bz)
			free_rs[rs_entry1] <= 1'b0;
	
		free_rs[rs_issue0] <= 1'b1;
		free_rs[rs_issue1] <= 1'b1;
	
	end
	
////////////////////////////////////////////////////////////////	


// Filling of Reservation Table 
integer l;
always @(posedge clk)
	begin
	
//SOURCE READ
		// first instruction RS entry
		if(op0===4'b0100)
			v1_rs     [rs_entry0] <= 1'b1;
		
		
	if((free_rs[rs_entry0]==1'b1)&(op0!==4'bz))
	begin
		opcode    [rs_entry0] <= op0;
		pc_rs     [rs_entry0] <= pc0;
		
		
		
		
			if(op0===4'b0100)
				begin
					v1_rs     [rs_entry0] <= 1'b1;
					rs_src1   [rs_entry0] <= 16'bz;
					rs_tag1   [rs_entry0] <= 3'bz;
				end
			else
				begin
		
					if(v_arf[rs1])
						begin
							v1_rs     [rs_entry0] <= 1'b1;
				//				rs_tag1   [rs_entry0] <= 3'bz;
							rs_src1   [rs_entry0] <= arf_data[rs1];
						end
					else
						begin
						
							if(v_rrf[arf_tag[rs1]])
								begin
									v1_rs     [rs_entry0] <= 1'b1;
				//						rs_tag1   [rs_entry0] <= 3'bz;
									rs_src1   [rs_entry0] <= rrf_data[rs1];
								end
							else
								begin
									v1_rs     [rs_entry0] <= 1'b0;
									rs_tag1   [rs_entry0] <= arf_tag[rs1];
				//						rs_src1   [rs_entry0] <= 16'bz;
								end
						end
					end
			
	///////////////////////


// for load and store instruction second source is immediate field
	if((op0===4'b0101)|(op0===4'b0100))
			begin
				
				imm_rs   [rs_entry0] <= imm0;
				
		   end
	
					
		if(v_arf[rs2])
			begin
				v2_rs     [rs_entry0] <= 1'b1;
	//				rs_tag2   [rs_entry0] <= 3'bz;
				rs_src2   [rs_entry0] <= arf_data[rs2];
			end
		else
			begin
			
				if(v_rrf[arf_tag[rs2]])
					begin
						v2_rs     [rs_entry0] <= 1'b1;
	//						rs_tag2   [rs_entry0] <= 3'bz;
						rs_src2   [rs_entry0] <= rrf_data[rs2];
					end
				else
					begin
						v2_rs     [rs_entry0] <= 1'b0;
						rs_tag2   [rs_entry0] <= arf_tag[rs2];
	//						rs_src2   [rs_entry0] <= 16'bz;
					end
			end

		
			
			
		if((op0!==4'b0101))	
		dest_tag  [rs_entry0] <= rr0;
		
end
		
		

		
		// second instruction RS entry
		
		
		
		if((free_rs[rs_entry1]==1'b1)&(op1!==4'bz))
		begin
			opcode    [rs_entry1] <= op1;
			pc_rs     [rs_entry1] <= pc1;
		
		
			if(op1===4'b0100)
				begin
					v1_rs     [rs_entry1] <= 1'b1;
					rs_src1   [rs_entry1] <= 16'bz;
					rs_tag1   [rs_entry1] <= 3'bz;
				end
			else
				begin
		
							if(rs3==rd1)
								begin
								
												v1_rs     [rs_entry1] <= 1'b0;
												rs_tag1   [rs_entry1] <= rr0;
					//							rs_src1   [rs_entry1] <= 16'bz;
								end
							else
							
								begin
								
										
										if(v_arf[rs3])
											begin
												v1_rs     [rs_entry1] <= 1'b1;
					//							rs_tag1   [rs_entry1] <= 3'bz;
												rs_src1   [rs_entry1] <= arf_data[rs3];
											end
										else
											begin
											
												if(v_rrf[arf_tag[rs3]])
													begin
														v1_rs     [rs_entry1] <= 1'b1;
					//									rs_tag1   [rs_entry1] <= 3'bz;
														rs_src1   [rs_entry1] <= rrf_data[rs3];
													end
												else
													begin
														v1_rs     [rs_entry1] <= 1'b0;
														rs_tag1   [rs_entry1] <= arf_tag[rs3];
					//									rs_src1   [rs_entry1] <= 16'bz;
													end
											end
								
								 end
					end
		
		//////////////////////////////
		
		// for load and store instruction second source is immediate field
		
		if((op1===4'b0101)|(op1===4'b0100))
			begin
				
				imm_rs   [rs_entry1] <= imm1;
				
		   end
	
		

	if(rs4==rd1)
		begin
		
						v2_rs     [rs_entry1] <= 1'b0;
						rs_tag2   [rs_entry1] <= rr0;
//							rs_src1   [rs_entry1] <= 16'bz;
		end
	else
		begin
	
				if(v_arf[rs4])
				begin
					v2_rs     [rs_entry1] <= 1'b1;
//						rs_tag2   [rs_entry1] <= 3'bz;
					rs_src2   [rs_entry1] <= arf_data[rs4];
				end
			else
				begin
				
					if(v_rrf[arf_tag[rs4]])
						begin
							v2_rs     [rs_entry1] <= 1'b1;
//								rs_tag2   [rs_entry1] <= 3'bz;
							rs_src2   [rs_entry1] <= rrf_data[rs4];
						end
					else
						begin
							v2_rs     [rs_entry1] <= 1'b0;
							rs_tag2   [rs_entry1] <= arf_tag[rs4];
//								rs_src2   [rs_entry1] <= 16'bz;
						end
				end
		 end
	
		
		
		if((op1!==4'b0101))
		dest_tag  [rs_entry1] <= rr1;
	end
	

		
		







	
	
		
		
	if((broadcast1|broadcast2))
		begin
				for(l=0;l<8;l=l+1)
					begin
						if(((rs_tag1[l]===broadcasted_dest_tag_1)|(rs_tag1[l]===broadcasted_dest_tag_2))&((type_value_FU[0]===2'b00)|(type_value_FU[1]===2'b00)))
							begin
								v1_rs[l]<=1'b1;
								rs_src1[l]<=(rs_tag1[l]===broadcasted_dest_tag_1)?result1:result2;
							end
						if(((rs_tag2[l]===broadcasted_dest_tag_1)|(rs_tag2[l]===broadcasted_dest_tag_2))&((type_value_FU[0]===2'b00)|(type_value_FU[1]===2'b00)))
							begin
								v2_rs[l]<=1'b1;
								rs_src2[l]<=(rs_tag2[l]===broadcasted_dest_tag_1)?result1:result2;
							end
					end	
		
		end
		
		
		if(ld_pending)
			begin
			for(l=0;l<8;l=l+1)
					begin
						if((rs_tag1[l]===ld_addr[0])|(rs_tag1[l]===ld_addr[1]))
							begin
								v1_rs[l]<=1'b1;
								rs_src1[l]<=(rs_tag1[l]===ld_addr[0])?ld_value[0]:ld_value[1];
							end
						if((rs_tag2[l]===ld_addr[0])|(rs_tag2[l]===ld_addr[1]))
							begin
								v2_rs[l]<=1'b1;
								rs_src2[l]<=(rs_tag2[l]===ld_addr[0])?ld_value[0]:ld_value[1];
							end
					end	
			
			end
		
		
		
		
		
end

// RRF UPDATE :updating state of RRF 




integer k;

always @(posedge clk)
begin
		
	///////////////////////////////////
	if((broadcast1|broadcast2))
	 begin
		for(k=0;k<8;k=k+1)
		 begin
			if(((arf_tag[k]===broadcasted_dest_tag_1)|(arf_tag[k]===broadcasted_dest_tag_2))&((type_value_FU[0]===2'b00)|(type_value_FU[1]===2'b00)))
				begin
					v_rrf[arf_tag[k]]<=1'b1;
					rrf_data[arf_tag[k]]<= (arf_tag[k]===broadcasted_dest_tag_1)?result1:result2;
				end
	
	
		 end
	end
	
	
	///////////////////////
		 
	if(ld_pending)
		begin
		for(k=0;k<8;k=k+1)
				begin
					if((arf_tag[k]===ld_addr[0])|(arf_tag[k]===ld_addr[1]))
						begin
							v_rrf[arf_tag[k]]<=1'b1;
							rrf_data[arf_tag[k]]<= (arf_tag[k]===ld_addr[0])?ld_value[0]:ld_value[1];
							
						end
				end	
		
		end 
		 
		 
	///////////////////////
	
	
	if((finished[head]==1'b1))
			v_rrf[dest_tag_ROB[head]]<=1'b0;
			
	if((finished[head]==1'b1)&(finished[head+1]==1'b1))
			v_rrf[dest_tag_ROB[head+1]]<=1'b0;
	

	
end






//ISSUING LOGIC (OLDEST FIRST POLICY)(SELECTION LOGIC)




assign		pc_in[0] =pc_rs   [rs_issue0];
assign		op   [0] =opcode  [rs_issue0];
assign		rsrc1[0] =rs_src1 [rs_issue0];
assign		rsrc2[0] =rs_src2 [rs_issue0];
assign      imm  [0] =imm_rs  [rs_issue0]; 
assign		dest [0] =dest_tag[rs_issue0];

assign		pc_in[1] =pc_rs   [rs_issue1];
assign		op   [1] =opcode  [rs_issue1];
assign		rsrc1[1] =rs_src1 [rs_issue1];
assign		rsrc2[1] =rs_src2 [rs_issue1];
assign      imm  [1] =imm_rs  [rs_issue1]; 
assign		dest [1] =dest_tag[rs_issue1];
	


FU inst3 (clk,op[0],rsrc1[0],rsrc2[0],imm[0],pc_in[0],dest[0],result1,pc_out[0],broadcasted_dest_tag_1,st_value_FU[0],type_value_FU[0],broadcast1);
FU inst4 (clk,op[1],rsrc1[1],rsrc2[1],imm[1],pc_in[1],dest[1],result2,pc_out[1],broadcasted_dest_tag_2,st_value_FU[1],type_value_FU[1],broadcast2);




///////////////////////////////ROB//////////////////////////////////////////



	
//Logic for setting finished entry, after any instruction completes execution	

always@(posedge clk)
	begin
		
		if((broadcast1|broadcast2))
		begin
//		
//				for(l=0;l<16;l=l+1)
//					begin
//						if((dest_tag_ROB[l]===broadcasted_dest_tag_1))
//								finished[l]<=1'b1;
//							
//						if((dest_tag_ROB[l]===broadcasted_dest_tag_2))
//								finished[l]<=1'b1;
//					end
					
					
				for(l=0;l<16;l=l+1)
					begin
						if((pc_rob[l]===pc_out[0]))
								finished[l]<=1'b1;
							
						if((pc_rob[l]===pc_out[1]))
								finished[l]<=1'b1;
					end	
					
		
		end	
		
		
//		for(l=0;l<16;l=l+1)
//			begin
//				if((finished[l]===1'b1))
//					if(l===head)
//							finished[head]<=1'b0;
//					if(l===head+1)
//							finished[head]<=1'b0;
					
		
		
		
		
		
		
		
		
		
		
		
		
	  if((finished[head]==1'b1))
		finished[head]<=1'b0;
		
	  if((finished[head]==1'b1)&(finished[head+1]==1'b1))
		finished[head+1]<=1'b0;
		
		
		
		
	end
	
//Logic for making entries in ROB && Logic for Commiting instructions from ROB

always@(posedge clk)
	begin

	//Logic for making entries in ROB
	
	
	rob_full<=1'b0;
	
		
		if((head==0 & tail ==15)|(head == tail+1))
			rob_full<=1'b1;
		else
			begin
				if((busy[tail]==1'b0)&(busy[tail+1]==1'b0))
					begin
						if(op0!==4'bz)
							begin
							if((op0!==4'b0101))
								 dest_tag_ROB[tail]  <=rr0;  
								 
							 busy[tail]  <=1'b1           ;
							 pc_rob[tail]<=pc0            ;
							 tail<=tail+4'b0001           ;	
								
							end	
						if(op1!==4'bz)
							begin
							if((op1!==4'b0101))
								 dest_tag_ROB[tail+1] <=rr1;
								 
							 busy[tail+1]  <=1'b1        ;
							 pc_rob[tail+1]<=pc1         ;
							 tail<=tail+4'b0010          ;	 
							end	 
						
					end
			end	
	

	
	////DESTINATION ALLOCATE (rename dest reg if its not a store instr.)
	
	if(op0!==4'b0101)
		if(v_arf[rd1])
			begin
			 v_arf[rd1]	  <=1'b0;
			 arf_tag[rd1] <= rr0;
			end
		
	if(op1!==4'b0101)
		if(v_arf[rd2])
		begin
		 v_arf[rd2]	  <=1'b0;
		 arf_tag[rd2] <= rr1;
		end		
	
	

	//Logic for Commiting instructions from ROB
	
	
	if((finished[head]==1'b1))
		begin
			for(i=0;i<8;i=i+1)
				if((dest_tag_ROB[head]==arf_tag[i]))
					begin
						arf_data[i]	<= rrf_data[dest_tag_ROB[head]];
						v_arf[i]<=1'b1;
						
					end
				
			
			busy[head]<=1'b0;
			head<=head+4'b0001;

		end
					

					
	if((finished[head]==1'b1)&(finished[head+1]==1'b1))
			begin
				for(i=0;i<8;i=i+1)
					if(dest_tag_ROB[head+1]==arf_tag[i])
						begin
							arf_data[i]	<= rrf_data[dest_tag_ROB[head+1]];
							v_arf[i]<=1'b1;
							
						end
					
				
				busy[head+1]<=1'b0;
				head<=head+4'b0010;
			end
								
	end	







////////////////////////////////////////STORE BUFFER////////////////////////////////////////////////////////////////

//SB entries

reg [0:7] comp_SB;
initial comp_SB = 8'h00;
reg [15:0] pc_SB[0:7];
reg [0:7] busy_SB;
initial busy_SB = 8'h00;

reg [15:0] straddr_SB[0:7];

reg [15:0] strdata_SB[0:7];


// SB pointers (for filling pc_SB field)

reg [2:0] head_SB,tail_SB;
initial tail_SB=0;
initial head_SB=0;
reg SB_full;

//wire [15:0] pc0,pc1;



always@(posedge clk)
	begin

	//Logic for making entries in SB
	
	
	SB_full<=1'b0;
	
		
		if((head_SB==0 & tail_SB ==7)|(head_SB == tail_SB+1))
			SB_full<=1'b1;
		else
			begin
			
				if((busy_SB[tail_SB]==1'b0)&(busy_SB[tail_SB+1]==1'b0)&(op0===4'b0101)&(op1===4'b0101))
					begin
					
					 pc_SB[tail_SB]  <=pc0;  
					 busy_SB[tail_SB]  <=1'b1  ;
						
					 pc_SB[tail_SB+1] <=pc1 ;
					 busy_SB[tail_SB+1]  <=1'b1 ;
					 
					 tail_SB<=tail_SB+4'b0010;				 
					end	
					
				else if((busy_SB[tail_SB]==1'b0)&(op0===4'b0101)&(op1!==4'b0101))
					begin
						 pc_SB[tail_SB] <=pc0 ;
						 busy_SB[tail_SB]  <=1'b1 ;
						 
						 tail_SB<=tail_SB+4'b0001;	 
					end
					
				else if((busy_SB[tail_SB]==1'b0)&(op0!==4'b0101)&(op1===4'b0101))
					begin
						 pc_SB[tail_SB] <=pc1 ;
						 busy_SB[tail_SB]  <=1'b1 ;
						 
						 tail_SB<=tail_SB+4'b0001;	 
					end
			end
		end



//Logic for storing store address and data in store buffer.

always@(posedge clk)
	begin
		
		if((broadcast1|broadcast2))
		begin
				for(l=0;l<8;l=l+1)
					begin
						if(((pc_SB[l]===pc_out[0])|(pc_SB[l]===pc_out[1]))&((type_value_FU[0]===2'b01)|(type_value_FU[1]===2'b01)))
							begin
								straddr_SB[l]<=(pc_SB[l]===pc_out[0])?result1:result2;
								strdata_SB[l]<=(pc_SB[l]===pc_out[0])?st_value_FU[0]:st_value_FU[1];
								comp_SB[l]<=1'b0;
								
							end
					end
		end	
		
		
		
		//Logic for completeing instructions in store buffer
		
		if((finished[head]==1'b1))
			begin
				for(l=0;l<8;l=l+1)
					begin
						if(pc_rob[head]==pc_SB[l])
								comp_SB[l]<=1'b1;
						if(pc_rob[head+1]==pc_SB[l])
								comp_SB[l]<=1'b1;
					end
						
			end
		

		
		
	end
	





///////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////ACCESSING DATA CACHE/////////////////////////////////////////////////////////



assign read_addr0 = (type_value_FU[0]===2'b10)?result1:16'bz;
assign read_addr1 = (type_value_FU[1]===2'b10)?result2:16'bz;

D_cache inst_unit (clk,1'b0,read_addr0,read_addr1,16'b0,16'b0,data0,data1);




always@(posedge clk)
	begin
		ld_value[0]<=data0;
		ld_value[1]<=data1;
		
		ld_pending<=1'b0;
		if((type_value_FU[0]==2'b10)|(type_value_FU[1]==2'b10))
			ld_pending<=1'b1;
		
		if(type_value_FU[0]==2'b10)
		ld_addr[0]<=broadcasted_dest_tag_1;
		
		if(type_value_FU[1]==2'b10)
		ld_addr[1]<=broadcasted_dest_tag_2;
		




	end

















assign v_ARF = v_arf;

assign arf_data0 = arf_data[0];
assign arf_data1 = arf_data[1];
assign arf_data2 = arf_data[2];
assign arf_data3 = arf_data[3];
assign arf_data4 = arf_data[4];
assign arf_data5 = arf_data[5];
assign arf_data6 = arf_data[6];
assign arf_data7 = arf_data[7];

assign arf_tag0 = arf_tag[0];
assign arf_tag1 = arf_tag[1];
assign arf_tag2 = arf_tag[2];
assign arf_tag3 = arf_tag[3];
assign arf_tag4 = arf_tag[4];
assign arf_tag5 = arf_tag[5];
assign arf_tag6 = arf_tag[6];
assign arf_tag7 = arf_tag[7];





//RRF
assign free_RRF = free_rrf;

assign v_RRF = v_rrf;

assign rrf_data0 = rrf_data[0];
assign rrf_data1 = rrf_data[1];
assign rrf_data2 = rrf_data[2];
assign rrf_data3 = rrf_data[3];
assign rrf_data4 = rrf_data[4];
assign rrf_data5 = rrf_data[5];
assign rrf_data6 = rrf_data[6];
assign rrf_data7 = rrf_data[7];

//RESERVATION STATION

assign free_RS = free_rs;

assign opcode_0 = opcode[0];
assign opcode_1 = opcode[1];
assign opcode_2 = opcode[2];
assign opcode_3 = opcode[3];
assign opcode_4 = opcode[4];
assign opcode_5 = opcode[5];
assign opcode_6 = opcode[6];
assign opcode_7 = opcode[7];



assign v1_RS = v1_rs;

assign rs_tag1_0 = rs_tag1[0];
assign rs_tag1_1 = rs_tag1[1];
assign rs_tag1_2 = rs_tag1[2];
assign rs_tag1_3 = rs_tag1[3];
assign rs_tag1_4 = rs_tag1[4];
assign rs_tag1_5 = rs_tag1[5];
assign rs_tag1_6 = rs_tag1[6];
assign rs_tag1_7 = rs_tag1[7];

assign rs_src1_0 = rs_src1[0];
assign rs_src1_1 = rs_src1[1];
assign rs_src1_2 = rs_src1[2];
assign rs_src1_3 = rs_src1[3];
assign rs_src1_4 = rs_src1[4];
assign rs_src1_5 = rs_src1[5];
assign rs_src1_6 = rs_src1[6];
assign rs_src1_7 = rs_src1[7];


assign v2_RS = v2_rs;

assign rs_tag2_0 = rs_tag2[0];
assign rs_tag2_1 = rs_tag2[1];
assign rs_tag2_2 = rs_tag2[2];
assign rs_tag2_3 = rs_tag2[3];
assign rs_tag2_4 = rs_tag2[4];
assign rs_tag2_5 = rs_tag2[5];
assign rs_tag2_6 = rs_tag2[6];
assign rs_tag2_7 = rs_tag2[7];

assign rs_src2_0 = rs_src2[0];
assign rs_src2_1 = rs_src2[1];
assign rs_src2_2 = rs_src2[2];
assign rs_src2_3 = rs_src2[3];
assign rs_src2_4 = rs_src2[4];
assign rs_src2_5 = rs_src2[5];
assign rs_src2_6 = rs_src2[6];
assign rs_src2_7 = rs_src2[7];



assign dest_tag_0 = dest_tag[0];
assign dest_tag_1 = dest_tag[1];
assign dest_tag_2 = dest_tag[2];
assign dest_tag_3 = dest_tag[3];
assign dest_tag_4 = dest_tag[4];
assign dest_tag_5 = dest_tag[5];
assign dest_tag_6 = dest_tag[6];
assign dest_tag_7 = dest_tag[7];



//ROB

assign busy_ROB     = busy;
assign finished_ROB = finished;

assign dest_tag_ROB0 = dest_tag_ROB[0];
assign dest_tag_ROB1 = dest_tag_ROB[1];
assign dest_tag_ROB2 = dest_tag_ROB[2];
assign dest_tag_ROB3 = dest_tag_ROB[3];
assign dest_tag_ROB4 = dest_tag_ROB[4];
assign dest_tag_ROB5 = dest_tag_ROB[5];
assign dest_tag_ROB6 = dest_tag_ROB[6];
assign dest_tag_ROB7 = dest_tag_ROB[7];
assign dest_tag_ROB8 = dest_tag_ROB[8];
assign dest_tag_ROB9 = dest_tag_ROB[9];
assign dest_tag_ROB10 = dest_tag_ROB[10];
assign dest_tag_ROB11 = dest_tag_ROB[11];
assign dest_tag_ROB12 = dest_tag_ROB[12];
assign dest_tag_ROB13 = dest_tag_ROB[13];
assign dest_tag_ROB14 = dest_tag_ROB[14];
assign dest_tag_ROB15 = dest_tag_ROB[15];




endmodule



	