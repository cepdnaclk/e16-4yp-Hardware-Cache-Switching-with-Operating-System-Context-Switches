`include "../32bit-Int-controller/controller.v"
`include "../32bit-regfile/reg_file.v"
`include "../wire-module/Wire_module.v"
`include "../mux/mux5x1.v"

module instruction_decode_unit (
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
  instration,
  data_in,
  write_reg_en_from_pre
  );

  output [31:0] data_1, data_2, mux_1_out;
  output mux_complmnt, mux_inp_2, mux_inp_1, mux_d_mem, write_reg_en, reset, clk, d_mem_r, d_mem_w, branch, jump;
  output [2:0] alu_op, fun_3;
  output [1:0] mux_result;
  output [4:0] write_address;
  input [31:0] instration, data_in;
  input write_reg_en_from_pre, clk, reset;
  wire [2:0] mux_wire_module;
  
  control control_unit(d_mem_r, d_mem_w, jump, branch, wrten_reg, mux_d_mem, mux_result, mux_inp_2, mux_complmnt, mux_inp_1, mux_wire_module, alu_op, instration[6:0], instration[14:12], instration[31:25]); 
  reg_file register_file(data_1, data_2, data_in, write_address, instration[19:15], instration[24:20], write_reg_en_from_pre, clk, reset);
  Wire_module wire_module(B_imm, J_imm, S_imm, U_imm, I_imm, instration);
  mux5x1 mux_1(B_imm, J_imm, S_imm, U_imm, I_imm, mux_wire_module, mux_1_out);

endmodule