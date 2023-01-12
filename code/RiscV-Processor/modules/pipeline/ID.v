module ID(
  rotate_signal_in,
  d_mem_r_in, 
	d_mem_w_in,
  branch_in,
  jump_in,
  write_reg_en_in,
  mux_d_mem_in,
	mux_result_in,
	mux_inp_2_in, 
  mux_complmnt_in,
	mux_inp_1_in,
  alu_op_in,
  fun_3_in,
  write_address_in,
  data_1_in,
  data_2_in,
  mux_1_out_in,
  pc_in,
  pc_4_in,
  reset,
  clk,
  busywait,
  branch_jump_signal,
  rotate_signal_out, mux_complmnt_out, mux_inp_2_out, mux_inp_1_out, mux_d_mem_out, write_reg_en_out,d_mem_r_out, d_mem_w_out, branch_out, jump_out,
  pc_4_out, pc_out, data_1_out, data_2_out, mux_1_out_out,mux_result_out,write_address_out,
  alu_op_out, fun_3_out
  );

  input [31:0] pc_4_in, pc_in, data_1_in, data_2_in, mux_1_out_in;
  output reg [31:0] pc_4_out, pc_out, data_1_out, data_2_out, mux_1_out_out;

  input rotate_signal_in, mux_complmnt_in, mux_inp_2_in, mux_inp_1_in, mux_d_mem_in, write_reg_en_in, reset, clk, d_mem_r_in, d_mem_w_in, branch_in, jump_in;
  output reg rotate_signal_out, mux_complmnt_out, mux_inp_2_out, mux_inp_1_out, mux_d_mem_out, write_reg_en_out,d_mem_r_out, d_mem_w_out, branch_out, jump_out;

  input [2:0] alu_op_in, fun_3_in;
  output reg [2:0] alu_op_out, fun_3_out;

  input busywait,branch_jump_signal;

  input [1:0] mux_result_in;
  output reg [1:0] mux_result_out;

  input [4:0] write_address_in;
  output reg [4:0] write_address_out;


  always @(posedge clk,posedge reset)
  begin
    // #1
    if(reset)begin

      rotate_signal_out <=  1'b0;
      mux_complmnt_out <=  1'b0;
      mux_inp_2_out <= 1'b0;
      mux_inp_1_out <= 1'b0;
      mux_d_mem_out <=  1'b0;
      write_reg_en_out <= 1'b0;
      d_mem_r_out <= 1'b0;
      d_mem_w_out <=1'b0;
      branch_out <=1'b0;
      jump_out <=1'b0;

      alu_op_out <= 3'b000;
      fun_3_out <= 3'b000;

      pc_4_out <= 31'd0;
      pc_out <= 31'd0;
      data_1_out <= 31'd0;
      data_2_out <= 31'd0;
      mux_1_out_out <= 31'd0;

      write_address_out <= 5'd0;
      
    end else if(branch_jump_signal)begin

      rotate_signal_out <=  1'b0;
      mux_complmnt_out <=  1'b0;
      mux_inp_2_out <= 1'b0;
      mux_inp_1_out <= 1'b0;
      mux_d_mem_out <=  1'b0;
      write_reg_en_out <= 1'b0;
      d_mem_r_out <= 1'b0;
      d_mem_w_out <=1'b0;
      branch_out <=1'b0;
      jump_out <=1'b0;

      alu_op_out <= 3'b000;
      fun_3_out <= 3'b000;

      pc_4_out <= 31'd0;
      pc_out <= 31'd0;
      data_1_out <= 31'd0;
      data_2_out <= 31'd0;
      mux_1_out_out <= 31'd0;

      write_address_out <= 5'd0;

    end else if (!busywait) begin
      rotate_signal_out <=rotate_signal_in;
      mux_complmnt_out <=mux_complmnt_in;
      mux_inp_2_out <= mux_inp_2_in;
      mux_inp_1_out <=mux_inp_1_in;
      mux_d_mem_out <=  mux_d_mem_in;
      write_reg_en_out <= write_reg_en_in;
      d_mem_r_out <= d_mem_r_in;
      d_mem_w_out <=d_mem_w_in;
      branch_out <=branch_in;
      jump_out <=jump_in;

      pc_4_out <=pc_4_in;
      pc_out <= pc_in;
      data_1_out <=data_1_in;
      data_2_out <=data_2_in;
      mux_1_out_out <=mux_1_out_in;

      mux_result_out <=mux_result_in;

      write_address_out <=write_address_in;

      alu_op_out <=alu_op_in;
      fun_3_out <=fun_3_in;

    end

  end

endmodule