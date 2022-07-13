module IF(
  id_out,
  rotate_signal,
  d_mem_r, 
	d_mem_w,
  branch,
  jump,
  write_reg_en,
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
  pc,
  pc_4,
  reset,
  clk
  );

  input [31:0] pc_4, pc, data_1, data_2, mux_1_out;
  input rotate_signal, mux_complmnt, mux_inp_2, mux_inp_1, mux_d_mem, write_reg_en, reset, clk, d_mem_r, d_mem_w, branch, jump;
  input [2:0] alu_op, fun_3;
  input [1:0] mux_result;
  input [4:0] write_address;
  output [182:0] id_out;

  always @(posedge clk)
  begin

    if(reset)begin
      id_out <= 182'd0;
    end else begin
      id_out <= {rotate_signal, pc_4, pc, mux_complmnt, mux_inp_2, mux_inp_1, mux_d_mem, write_reg_en, write_address, d_mem_r, d_mem_w, branch, jump, alu_op, fun_3, mux_result, data_1, data_2, mux_1_out};
    end

  end

endmodule