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
  wire [181:0] id_out;

  wire [31:0] branch_jump_addres,
  wire [31:0] result_alu,

  wire [75:0] ex_out;

  wire [31:0] mux5_out_write_data;

  instruction_fetch_unit if_unit(branch_jump_addres, branch_or_jump_signal, data_memory_busywait, reset, clk, pc, incremented_pc_by_four, instruction, busywait);
  
  IF if_reg(if_out,incremented_pc_by_four,pc,instruction,write_reg_en_from_pre,write_address_from_pre,write_data,branch_or_jump_signal,clk);

  instruction_decode_unit id_unit(d_mem_r,d_mem_w,branch,jump,write_reg_en,mux_d_mem,mux_result,mux_inp_2,mux_complmnt,mux_inp_1,alu_op,fun_3,data_1,data_2,mux_1_out,if_out[69:38],if_out[31:0],if_out[37],if_out[36:32]);

  ID id_reg(id_out,if_out[68],d_mem_r,d_mem_w,branch,jump,write_reg_en,mux_d_mem,mux_result,mux_inp_2,mux_complmnt,mux_inp_1,alu_op,fun_3,if_out[49:45],data_1,data_2,mux_1_out,if_out[133:102],if_out[101:70],branch_or_jump_signal,clk);

  // {pc_4, pc118, mux_complmnt, mux_inp_2 116, mux_inp_1 115, mux_d_mem 114, write_reg_en 113, write_address 112:108, d_mem_r, d_mem_w, branch 105, jump 104, alu_op 103:101, fun_3 100:98,97 mux_result, data_1, data_2, mux_1_out};

  instruction_execute_unit iex_unit(id_out[95:64],id_out[63:32],id_out[149:118],id_out[181:150],id_out[31:0],id_out[97:96],id_out[115],id_out[116],id_out[182],id_out[105],id_out[104],id_out[100:98],branch_jump_addres,result_alu,branch_or_jump_signal);

  EX ex_reg(ex_out,id_out[107],id_out[106],id_out[114],id_out[113],id_out[112:108],id_out[100:98],id_out[63:32],result_alu,branch_or_jump_signal,clk);

  assign write_address_from_pre <= ex_out[73:69];
  assign write_reg_en_from_pre <= ex_out[74];
  // {mux_d_mem, write_reg_en 74, write_address 73:69, d_mem_r 68, d_mem_w 67, fun_3 66:64, data_2, result_mux_4};

  memory_access_unit mem_access_unit(clk,reset,ex_out[68],ex_out[67],ex_out[75],ex_out[31:0],ex_out[63:32],ex_out[66:64],data_memory_busywait,write_data);

endmodule
