module mul(RESULT, DATA1, DATA2, SELECT, CLK);

  input [31:0] DATA1, DATA2;
  input [2:0] SELECT;
  input wire CLK;
  // output [63:0] RESULTM;
  output [31:0] RESULT;

  wire [31:0] MUL,MULH,MULHU,MULHSU,DIV,DIVU,REM,REMU;


  //multiplication 
	assign MUL = DATA1 * DATA2;                      // Multiplication
  assign MULH = DATA1 * DATA2;                        // Multiplication (Signed)
  assign MULHU = $unsigned(DATA1) * $unsigned(DATA2);    // Multiplication (Unsigned)
  assign MULHSU = $signed(DATA1) * $unsigned(DATA2);     // Multiplication (Signed x UnSigned)
  
  //and division instructions
	assign DIV = DATA1 / DATA2;                           // Division
  assign DIVU = $unsigned(DATA1) / $unsigned(DATA2);    // Division Unsigned
  assign REM = DATA1 % DATA2;                           // Remainder
  assign REMU = DATA1 % DATA2;                          // Remainder Unsigned

  always @(*) 
  begin
    case (SELECT)
      3'd0: RESULT = MUL;
      3'd1: RESULT = MULH;
      3'd2: RESULT = MULHU;
      3'd3: RESULT = MULHSU;

      3'd4: RESULT = DIV;
      3'd5: RESULT = DIVU;
      3'd6: RESULT = REM;
      3'd7: RESULT = REMU;
    endcase

  end


endmodule