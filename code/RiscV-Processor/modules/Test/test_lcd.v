module mux_lcd_test(
  input [31:0] reg1,
  input [31:0] reg2,
  output [47:0] out	
);

    assign out[47:0]={reg1, reg2[15:0]};
endmodule