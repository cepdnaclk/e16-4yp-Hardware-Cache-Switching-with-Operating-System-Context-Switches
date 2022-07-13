// module MEM(
//   mem_out,
//   write_reg_en,
//   write_address,
//   write_data,
//   reset,
//   clk
//   );

//   input [31:0] write_data;
//   input write_reg_en, reset, clk;
//   input [4:0] write_address;
//   output [37:0] mem_out;

//   always @(posedge clk)
//   begin

//     if(reset)begin
//       mem_out <= 37'd0;
//     end else begin
//       mem_out <= {write_reg_en, write_address, write_data};
//     end

//   end

// endmodule