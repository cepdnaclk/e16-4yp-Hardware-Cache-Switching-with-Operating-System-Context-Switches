module control(
	d_mem_r, 
	d_mem_w,
	jump, 
	branch, 
	wrten_reg,
	mux_d_mem,
	mux_result,
	mux_inp_2, 
	mux_inp_1,
	mux_wire_module, 
	alu_op, 
	opcode, 
	fun_3, 
	fun_7
	);
	
	//input opcode part of the instration
	input [6:0] opcode;
	
	//alu_op is the output which select for the alu
	output reg [2:0] alu_op;

	output reg mux_complmnt, mux_inp_1, mux_inp_2, mux_d_mem, wrten_reg, branch, jump, d_mem_r, d_mem_w;
	output reg [2:0] mux_wire_module;
	output reg [1:0] mux_result;
	
	always @ (opcode, fun_3, fun_7)
	begin

		case(opcode)
		
			7'b0110111: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 1'd1;
				mux_inp_2 <= 1'd0;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd3;
				alu_op <= 3'd0;
			end

			7'b0010111: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 1'd2;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd1;
				mux_wire_module <= 3'd3;
				alu_op <= 3'd0;
			end

			7'b1101111: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd1;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 1'd3;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd1;
				mux_wire_module <= 3'd1;
				alu_op <= 3'd0;
			end

			7'b1100111: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd1;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 1'd3;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd4;
				alu_op <= 3'd0;
			end

			7'b1100011: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd1;
				wrten_reg <= 1'd0;
				mux_complmnt <= 1'd1;
				mux_d_mem <= 1'd0;
				mux_result <= 1'd0;
				mux_inp_2 <= 1'd0;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd0;
				alu_op <= 3'd0;
			end

			7'b0000011: begin
				d_mem_r <= 1'd1;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd0;
				mux_result <= 1'd2;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd4;
				alu_op <= 3'd0;
			end

			7'b0100011: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd1;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd0;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd0;
				mux_result <= 1'd2;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd2;
				alu_op <= 3'd0;
			end

			7'b0010011: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 1'd2;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd4;
				alu_op <= fun_3;
			end

			7'b0110011: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= fun_7[5] ? 1'd1 : 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 1'd2;
				mux_inp_2 <= 1'd0;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd0;
				alu_op <= fun_3;
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