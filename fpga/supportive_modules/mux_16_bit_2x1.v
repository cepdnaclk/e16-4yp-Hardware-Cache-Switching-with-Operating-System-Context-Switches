module mux_16_bit_2x1(input [31:0]in,input select,output reg [15:0]out);

always @(*)
begin
	if(!select)begin
		out<=in[15:0];
	end
	else begin
		out <=in[31:16];
	end
end

endmodule