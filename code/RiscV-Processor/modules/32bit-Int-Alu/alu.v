module alu(ZERO, RESULT, DATA1, DATA2, SELECT, ROTATE,zero_signal,sign_bit_signal,sltu_bit_signal);		//this is alu module
	
	//initial input output
	input [31:0] DATA1,DATA2;
	output reg [31:0] RESULT;
	input [2:0] SELECT;
  input ROTATE;
	output reg ZERO;
	integer i;
  output zero_signal,sign_bit_signal,sltu_bit_signal;
	
	//always block
	always @ (SELECT or DATA1 or DATA2 or ROTATE)
	begin

		case(SELECT)

			//load word
			3'd0 : 
        begin						
					RESULT = DATA1 + DATA2;	//result
				end
			//add
			3'd1 : 
        begin			
          RESULT = DATA1 << DATA2;	//result
        end
			//and
			3'd2 : 
        begin
					RESULT = ($signed(DATA1) < $signed(DATA2)) ? 32'd1 : 32'd0;	//get result
				end
			//or
			3'd3 : 
        begin
					RESULT = ($unsigned(DATA1) < $unsigned(DATA2)) ? 32'd1 : 32'd0;  	//get result
				end
      //xor
      3'd4 : 
        begin
					RESULT = DATA1 ^ DATA2; 	//get result
				end
      3'd5 : 
        begin
					case(ROTATE)
            1'b0:                       //logical
              RESULT = DATA1 << DATA2;
            1'b1:                       //arithmetic
              RESULT = DATA1 <<< DATA2;
					endcase
				end
			3'd6 :
        begin
					RESULT = DATA1 | DATA2;
				end
			3'd7 :
        begin
					RESULT = DATA1 & DATA2;
				end

		endcase
  end
		
  assign zero_signal= ~(|RESULT);                                      //zero flag set when data 1 and data 2 is equal(Z flag)
	assign sign_bit_signal=RESULT[31];                                   //sign bit  (G flag)
	assign sltu_bit_signal=RESULT[0];	

endmodule

