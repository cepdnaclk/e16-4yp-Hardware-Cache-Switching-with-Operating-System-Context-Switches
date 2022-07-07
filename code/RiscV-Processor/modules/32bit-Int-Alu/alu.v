module alu(ZERO, RESULT, DATA1, DATA2, SELECT, ROTATE);		//this is alu module
	
	//initial input output
	input [31:0] DATA1,DATA2;
	output reg [31:0] RESULT;
	input [2:0] SELECT;
    input ROTATE;
	output reg ZERO;
	integer i;
	
	//always block
	always @ (SELECT or DATA1 or DATA2 or ROTATE)
	begin

		case(SELECT)

			//load word
			3'd0 : 
        begin						
					RESULT = DATA2;		//get result
				end
			//add
			3'd1 : 
        begin			
          RESULT = DATA1 + DATA2;	//result
        end
			//and
			3'd2 : 
        begin
					RESULT = DATA1 & DATA2;	//get result
				end
			//or
			3'd3 : 
        begin
					RESULT = DATA1 | DATA2;	//get result
				end
      //xor
      3'd4 : 
        begin
					RESULT = DATA1 ^ DATA2;	//get result
				end
      // //not
      // 3'd5 : 
      //   begin
			// 		RESULT = ~DATA1;	//get result
			// 	end
      //xnor
      3'd5 : 
        begin
					RESULT = DATA1 ~^ DATA2;	//get result
				end
      //rotate right
			3'd6 :
        begin
					case(ROTATE)
            1'b0:                       //logical
              RESULT = DATA1 >> DATA2;
            1'b1:                       //arithmetic
              RESULT = DATA1 >>> DATA2;
					endcase
				end
      //rotate left
			3'd7 :
        begin
					case(ROTATE)
            1'b0:                       //logical
              RESULT = DATA1 << DATA2;
            1'b1:                       //arithmetic
              RESULT = DATA1 <<< DATA2;
					endcase
				end

		endcase
		
    if( RESULT == 0 ) begin
      ZERO = 1'b1;
    end else begin
      ZERO = 1'b0;
    end

    if( RESULT > 0 ) begin
      GT = 1'b1;
    end else begin
      GT = 1'b0;
    end

    if( RESULT < 0 ) begin
      LT = 1'b1;
    end else begin
      LT = 1'b0;
    end

	end

endmodule

