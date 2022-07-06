module control(bne, jump, branch, wrten, mux_cmplmnt_select, mux_immd_select, alu_op, opcode);
	
	//input opcode part of the instration
	input [7:0] opcode;
	
	//alu_op is the output which select for the alu
	output reg [3:0] alu_op;
	//wrten is write enable signal 
	//mux_immd_select for select signal for the immediate or register output
	//mux_cmplmnt_select for mux select for whether the negetive or possitive vale
	output reg wrten, mux_immd_select, mux_cmplmnt_select, branch, jump, bne;
	
	//opcode decoding 
			// 0 for add
			// 1 for sub
			// 2 for and
			// 3 for or
			// 4 for mov
			// 5 for lodai
			// 6 for jump
			// 7 for beq
			// 8 for ror
			// 9 for sll
			// 10 for srl
			// 11 for sra
			// 12 for bne
			// 13 for mult
			
			//wrten = 1 means write
			//mux_cmplmnt_select = 1 means regester value , not 2s complemented value
			//mux_immd_select = 1 means get immediate value
			//alu_op is according to the alu operation
			//jump = 1 means jump 
			// branch = 1 means branch
			//bne = 1 means bne 
			
	always @ (opcode)
	begin
		#1	
		case(opcode)
		
			//add
			8'd0: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'b1;		//chose register output
				mux_immd_select = 1'b0;			//chose not immediate
				alu_op = 4'd1;					//1 select to alu
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			//sub
			8'd1: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'b0;		//chose register output's 2s complement
				mux_immd_select = 1'b0;			//chose not immediate
				alu_op = 4'd1;					//select for alu 1
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			//and
			8'd2: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'b1;		//chose register output
				mux_immd_select = 1'b0;			//chose not immediate
				alu_op = 4'd2;					//select for alu 2
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			//or
			8'd3: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'b1;		//chose register output
				mux_immd_select = 1'b0;			//chose not immediate
				alu_op = 4'd3;					//select for alu 3
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			//mov
			8'd4: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'b1;		//chose register output
				mux_immd_select = 1'b0;			//chose not immediate
				alu_op = 4'd0;					//select for alu 0
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			//loadi
			8'd5: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'bx;		//register out is dont care
				mux_immd_select = 1'b1;			//chose immediate
				alu_op = 4'd0;					//select for alu 0
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			//j
			8'd6: begin
				wrten = 1'b0;					//write desable
				mux_cmplmnt_select = 1'bx;		//register out is dont care
				mux_immd_select = 1'bx;			//chose immediate dont care
				alu_op = 4'dx;					//select for alu dont care
				jump = 1'b1;					//jump ennable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			//branch eq
			8'd7: begin
				wrten = 1'b0;					//write desable
				mux_cmplmnt_select = 1'b0;		//register out complement
				mux_immd_select = 1'b0;			//chose immediate 0
				alu_op = 4'd1;					//select for alu 0
				jump = 1'b0;					//jump ennable
				branch = 1'b1;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			
			//ror
			8'd8: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'bx;		//dont care complement or not
				mux_immd_select = 1'b1;			//chose immediate 1
				alu_op = 4'd4;					//select for alu 4
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
			end
			
			//sll
			8'd9: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'bx;		//dont care complement or not
				mux_immd_select = 1'b1;			//chose immediate 1
				alu_op = 4'd5;					//select for alu 5
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
			end
			
			//srl
			8'd10: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'bx;		//dont care complement or not
				mux_immd_select = 1'b1;			//chose immediate 1
				alu_op = 4'd6;					//select for alu 6
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
			end
			
			//sra
			8'd11: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'bx;		//dont care complement or not
				mux_immd_select = 1'b1;			//chose immediate 1
				alu_op = 4'd7;					//select for alu 7
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
			end
			
			//branchnotequal
			8'd12: begin
				wrten = 1'b0;					//write desable
				mux_cmplmnt_select = 1'b0;		//register out complement
				mux_immd_select = 1'b0;			//chose immediate 0
				alu_op = 4'd1;					//select for alu 1
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b1;						//bne enable
				
			end
			
			//mult
			8'd13: begin
				wrten = 1'b1;					//write enable
				mux_cmplmnt_select = 1'b1;		//register out
				mux_immd_select = 1'b0;			//chose immediate 0
				alu_op = 4'd8;					//select for alu 8
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
					  
			//default
			default: begin
				wrten = 1'b0;					//write desable
				mux_cmplmnt_select = 1'bx;		//register out is dont care
				mux_immd_select = 1'bx;			//chose immediate dont care
				alu_op = 4'dx;					//select for alu dont care
				jump = 1'b0;					//jump desable
				branch = 1'b0;					//branch desable
				bne = 1'b0;						//bne desable
				
			end
			
		endcase
	end
			
			
endmodule