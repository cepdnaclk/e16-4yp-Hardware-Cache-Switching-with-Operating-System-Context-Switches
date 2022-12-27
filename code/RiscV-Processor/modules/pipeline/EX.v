module EX(
  d_mem_r_in, 
	d_mem_w_in,
  mux_d_mem_in,
  write_reg_en_in,
  write_address_in,
  fun_3_in,
  data_2_in,
  result_mux_4_in,
  reset,
  clk,
  busywait,
  data_2_out, 
  result_mux_4_out,
  mux_d_mem_out, 
  write_reg_en_out, 
  d_mem_r_out, 
  d_mem_w_out,
  fun_3_out,
  write_address_out
  );

  input [31:0] data_2_in, result_mux_4_in;
  output reg [31:0] data_2_out, result_mux_4_out;

  input mux_d_mem_in, write_reg_en_in, reset, clk, d_mem_r_in, d_mem_w_in,busywait;
  output reg mux_d_mem_out, write_reg_en_out, d_mem_r_out, d_mem_w_out;

  input [2:0] fun_3_in;
  output reg [2:0] fun_3_out;

  input [4:0] write_address_in;
  output reg [4:0] write_address_out;
  

  always @(posedge clk,posedge reset)
  begin


    if(reset)begin
      data_2_out <= 31'd0;
      result_mux_4_out <= 31'd0;

      mux_d_mem_out <= 1'b0;
      write_reg_en_out <= 1'b0;
      d_mem_r_out <= 1'b0;
      d_mem_w_out <= 1'b0;

      fun_3_out<= 3'b000;
      write_address_out <= 5'd0;

    end else if (!busywait) begin
      data_2_out <=data_2_in;
      result_mux_4_out <=result_mux_4_in;

      mux_d_mem_out <=mux_d_mem_in;
      write_reg_en_out <=write_reg_en_in;
      d_mem_r_out <= d_mem_r_in;
      d_mem_w_out <= d_mem_w_in;

      fun_3_out<=fun_3_in;
      write_address_out <=write_address_in;
      
    end

  end

endmodule