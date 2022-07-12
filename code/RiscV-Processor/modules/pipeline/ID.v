module IF(
  id_out,
  d_mem_r, 
	d_mem_w,
  branch,
  jump,
  wrten_reg,
  mux_d_mem,
	mux_result,
	mux_inp_2, 
  mux_complmnt,
	mux_inp_1,
  alu_op,
  fun_3,
  write_address,
  data_1,
  data_2,
  mux_1_out,
  reset,
  clk
  );

  input [31:0] data_1, data_2, mux_1_out;
  input mux_complmnt, mux_inp_2, mux_inp_1, mux_d_mem, write_reg_en, reset, clk, d_mem_r, d_mem_w, branch, jump;
  input [2:0] alu_op, fun_3;
  input [1:0] mux_result;
  input [4:0] write_address;
  output [117:0] if_out;

  always @(posedge clk)
  begin

    if(reset)begin
      id_out <= 120'd0;
    end else begin
      id_out <= {mux_complmnt, mux_inp_2, mux_inp_1, mux_d_mem, write_reg_en, write_address, d_mem_r, d_mem_w, branch, jump, alu_op, fun_3, mux_result, data_1, data_2, mux_1_out};
    end

  end

endmodule