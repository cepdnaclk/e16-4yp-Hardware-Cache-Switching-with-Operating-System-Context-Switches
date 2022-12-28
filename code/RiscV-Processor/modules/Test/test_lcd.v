module mux_lcd_test(
  input [31:0] reg1,
  input [31:0] reg2,
  output reg [47:0] out	
);

  always@(*)
  begin
    out[47:0] = {reg2[15:0], reg1};
  end

    // assign out[47:0]={reg1, reg2[15:0]};
endmodule