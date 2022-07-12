module mul(RESULT, DATA1, DATA2, SELECT);

  input [31:0] DATA1, DATA2;
  input [2:0] SELECT;
  // input wire CLK;
  // output [63:0] RESULTM;
  output reg [31:0] RESULT;

  wire [63:0] MUL,MULH,MULHU,MULHSU;
  wire [31:0] DIV,DIVU,REM,REMU;
  //multiplication 
	assign MUL = $signed(DATA1) * $signed(DATA2);                      // Multiplication
  // assign MULH = (DATA1 * DATA2)[63:32];                      // Multiplication (Signed)
  assign MULHU = $unsigned(DATA1) * $unsigned(DATA2);    // Multiplication (Unsigned)
  assign MULHSU = $signed(DATA1) * $unsigned(DATA2);     // Multiplication (Signed x UnSigned)
  
  //and division instructions
	assign DIV = $signed(DATA1) / $signed(DATA2);                           // Division
  assign DIVU = $unsigned(DATA1) / $unsigned(DATA2);    // Division Unsigned
  assign REM = $signed(DATA1) % $signed(DATA2);                           // Remainder
  assign REMU = DATA1 % DATA2;                          // Remainder Unsigned

  always @(*) 
  begin
    case (SELECT)
      3'd0: RESULT <= MUL[31:0]; //mul
      3'd1: RESULT <= MUL[63:32];  //mulh
      3'd2: RESULT <= MULHSU[63:32];  //mulhsu
      3'd3: RESULT <= MULHU[63:32]; //mulhu

      3'd4: RESULT <= DIV;
      3'd5: RESULT <= DIVU;
      3'd6: RESULT <= REM;
      3'd7: RESULT <= REMU;
    endcase

  end

endmodule