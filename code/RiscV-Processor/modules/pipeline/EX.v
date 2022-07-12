module EX(
  ex_out,
  d_mem_r, 
	d_mem_w,
  mux_d_mem,
  write_reg_en,
  write_address,
  fun_3,
  data_2,
  alu_result,
  reset,
  clk
  );

  input [31:0] data_2, alu_result;
  input mux_d_mem, write_reg_en, reset, clk, d_mem_r, d_mem_w;
  input [2:0] fun_3;
  input [4:0] write_address;
  output [75:0] ex_out;

  always @(posedge clk)
  begin

    if(reset)begin
      ex_out <= 87'd0;
    end else begin
      ex_out <= {mux_d_mem, write_reg_en, write_address, d_mem_r, d_mem_w, fun_3, data_2, alu_result};
    end

  end

endmodule