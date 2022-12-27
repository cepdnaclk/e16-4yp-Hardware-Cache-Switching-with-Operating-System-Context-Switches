

module instruction_decode_unit (
  switch_cache_w,
  reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,
  write_address_for_current_instruction,
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
  data_1,
  data_2,
  mux_1_out,
  instration,
  data_in,
  write_reg_enable_signal_from_pre,
  write_address_from_pre,
  clk, 
  reset
  );

  output [4:0] write_address_for_current_instruction;
  output [31:0] data_1, data_2, mux_1_out;
  output mux_complmnt, mux_inp_2, mux_inp_1, mux_d_mem, write_reg_en,d_mem_r, d_mem_w, branch, jump,rotate_signal,switch_cache_w;
  output [2:0] alu_op, fun_3;
  output [1:0] mux_result;
  input [31:0] instration, data_in;
  input write_reg_enable_signal_from_pre, clk, reset;
  input [4:0] write_address_from_pre;
  wire [2:0] mux_wire_module;
  wire [31:0] B_imm, J_imm, S_imm, U_imm, I_imm;
  output [31:0] reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output;


  assign write_address_for_current_instruction=instration[11:7];
  assign fun_3=instration[14:12];
  assign rotate_signal=instration[30];
  

  control control_unit(switch_cache_w,d_mem_r, d_mem_w, jump, branch, write_reg_en, mux_d_mem, mux_result, mux_inp_2, mux_complmnt, mux_inp_1, mux_wire_module, alu_op, instration[6:0], instration[14:12], instration[31:25]); 
  reg_file register_file(data_1, data_2, data_in, write_address_from_pre, instration[19:15], instration[24:20], write_reg_enable_signal_from_pre, clk, reset,reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output);
  Wire_module wire_module(instration,B_imm, J_imm, S_imm, U_imm, I_imm);
  mux5x1 mux_1(B_imm, J_imm, S_imm, U_imm, I_imm, mux_wire_module, mux_1_out);

endmodule