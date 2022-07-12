module alu(RESULT, DATA1, DATA2, SELECT, ROTATE,zero_signal,sign_bit_signal,sltu_bit_signal);		//this is alu module
	
	//initial input output
	input [31:0] DATA1,DATA2;
	output reg [31:0] RESULT;
	input [2:0] SELECT;
    input ROTATE;
    output zero_signal,sign_bit_signal,sltu_bit_signal;
	
	wire[31:0] ADD,AND,OR,XOR,SLL,SRL,SRA,SLT,SLTU;
	
	assign  ADD=DATA1 + DATA2;
	assign  AND=DATA1 & DATA2;
	assign  OR=DATA1 | DATA2;
	assign  XOR=DATA1 ^ DATA2;
	assign  SLL = DATA1 << DATA2; 
	assign  SRL = DATA1 >> DATA2;						  
    assign  SRA = DATA1 >>> DATA2;	
	assign  SLT = ($signed(DATA1) < $signed(DATA2)) ? 32'd1 : 32'd0; 
	assign  SLTU = ($unsigned(DATA1) < $unsigned(DATA2)) ? 32'd1 : 32'd0;
	
	//always block
	always @ (SELECT or DATA1 or DATA2 or ROTATE)
	begin

		case(SELECT)
			3'd0 : 
        	begin						
				RESULT <= ADD;
			end
			3'd1 : 
        	begin			
          		RESULT <= SLL;
        	end
			3'd2 : 
       		begin
				RESULT <= SLT;
			end
			3'd3 : 
        	begin
				RESULT <= SLTU;
			end
      		3'd4 : 
        	begin
				RESULT <= XOR;
			end
      		3'd5 : 
        	begin
				case(ROTATE)
            		1'b0:                       
              			RESULT <= SRL;
            		1'b1:                       //arithmetic
              			RESULT <= SRA;
				endcase
				end
			3'd6 :
        	begin
				RESULT <= OR;
			end
			3'd7 :
        	begin
				RESULT <= AND;
			end

		endcase
  end
		
  assign zero_signal= ~(|RESULT);                                      //zero flag set when data 1 and data 2 is equal(Z flag)
  assign sign_bit_signal=RESULT[31];                                   //sign bit  (G flag)
  assign sltu_bit_signal=SLTU[0];	
  
endmodule

