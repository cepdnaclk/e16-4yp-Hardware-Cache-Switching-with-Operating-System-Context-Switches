`include "./modules/pipeline/IF.v"
`include "./modules/pipeline/ID.v"
`include "./modules/pipeline/EX.v"
`include "./modules/pipeline/MEM.v"

`include "./modules/units/instruction_fetch_unit.v"
`include "./modules/units/instruction_decode_unit.v"
`include "./modules/units/instruction_execute_unit.v"
`include "./modules/units/memory_access_unit.v"

module cpu(
    input clk,
    input reset,
  );

  wire [31:0] branch_jump_addres;
  wire branch_or_jump_signal;
  wire data_memory_busywait;
  wire [31:0] pc,incremented_pc_by_four, write_data;
  wire [31:0]instruction;
  wire busywait, write_reg_en_from_pre;
  wire [133:0] if_out;
  wire [4:0] write_address_from_pre;

  wire [1:0] mux_result;
  wire d_mem_r, d_mem_w, branch, jump, write_reg_en, mux_d_mem,	mux_inp_2, mux_complmnt, mux_inp_1;
  wire [2:0] alu_op, fun_3;
  wire [31:0] data_1, data_2, mux_1_out;

  instruction_fetch_unit if_unit(branch_jump_addres, branch_or_jump_signal, data_memory_busywait, reset, clk, pc, incremented_pc_by_four, instruction, busywait);
  
  IF if_reg(if_out,incremented_pc_by_four,pc,instruction,write_reg_en_from_pre,write_address_from_pre,write_data,branch_or_jump_signal,clk);

  instruction_decode_unit id_unit(d_mem_r,d_mem_w,branch,jump,write_reg_en,mux_d_mem,mux_result,mux_inp_2,mux_complmnt,mux_inp_1,alu_op,fun_3,data_1,data_2,mux_1_out,if_out[69:38],if_out[31:0],if_out[37],if_out[36:32]);

  ID id_reg(id_out,d_mem_r,d_mem_w,branch,jump,write_reg_en,mux_d_mem,mux_result,mux_inp_2,mux_complmnt,mux_inp_1,alu_op,fun_3,if_out[49:45],data_1,data_2,mux_1_out,if_out[133:102],if_out[101:70],branch_or_jump_signal,clk);

endmodule
