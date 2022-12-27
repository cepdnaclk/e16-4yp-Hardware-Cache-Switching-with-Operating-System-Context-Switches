module reg_file (OUT1, OUT2, IN, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET,reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output);
	
	//register file
	
	//initialize input output
	input [31:0] IN;								//input data to write
	input [4:0] OUT1ADDRESS, OUT2ADDRESS;		//address of register that should read
	input [4:0] INADDRESS;						//address of writting register
	input  WRITE, CLK, RESET;					//enable sigle to write, clock, reset signal
	output reg [31:0] OUT1, OUT2;				//output of readed register
	reg [31:0] Register [31:0];					//32bit 32 register
	integer j;									//for for loop
	output [31:0] reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output;
  // always @(*)
  // begin
  //   Register[0] = 32'b00000000000000000000000000000000;
  // end

	//writting part
	always @ (posedge CLK,posedge RESET)			
	begin
		//writting part
		if(RESET)
		begin
				for(j = 0; j <= 31; j = j +1 )
				begin
					Register[j] <= 32'b00000000000000000000000000000000;			//assigning 

				end
		end
		else if(WRITE)
		begin
			Register[INADDRESS] <= IN;		//assign
		end

	end

	//this is reading part
	always @ (OUT1ADDRESS, OUT2ADDRESS)
	begin
		OUT1 <= Register[OUT1ADDRESS];		//assign
		OUT2 <= Register[OUT2ADDRESS];		//assign
	end


	assign reg0_output=Register[0];
	assign reg1_output=Register[1];
	assign reg2_output=Register[2];
	assign reg3_output=Register[3];
	assign reg4_output=Register[4];
	assign reg5_output=Register[5];
	assign reg6_output=Register[6];

endmodule
