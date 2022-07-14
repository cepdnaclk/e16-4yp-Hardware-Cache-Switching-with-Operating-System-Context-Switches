module IF(pc_in, pc_4_in, instration_in, reset, clk,busywait,branch_jump_signal,pc_out, pc_4_out, instration_out);

  input [31:0] pc_in, pc_4_in, instration_in;
  output reg [31:0] pc_out, pc_4_out, instration_out;
  input busywait,branch_jump_signal;
  input  reset, clk;
  
  
  always @(posedge clk,posedge reset)
  begin

    if(reset | branch_jump_signal)begin
      pc_out <=32'd0;
      pc_4_out <=32'd0;
      instration_out <=32'd0;
    end else if (!busywait) begin
      pc_out <=pc_in;
      pc_4_out <=pc_4_out;
      instration_out <=instration_out;
    end

  end

endmodule