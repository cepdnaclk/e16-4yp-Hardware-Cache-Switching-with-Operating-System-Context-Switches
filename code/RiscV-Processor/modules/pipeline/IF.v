module IF(if_out, pc_4, pc, instration, write_reg_en, write_address, write_data, reset, clk);

  input [31:0] pc, pc_4, instration, write_data;
  input write_reg_en, reset, clk;
  input [4:0] write_address;
  output [133:0] if_out;

  always @(posedge clk)
  begin

    if(reset)begin
      if_out <= 133'd0;
    end else begin
      if_out <= {pc, pc_4, instration, write_reg_en, write_address, write_data};
    end

  end

endmodule