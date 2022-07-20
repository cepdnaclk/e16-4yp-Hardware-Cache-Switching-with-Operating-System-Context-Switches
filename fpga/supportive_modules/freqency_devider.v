module frequncy_devider(input in_clk,input reset,output reg out_clk);

reg [2:0]counter;
always @(posedge in_clk,posedge reset)
begin
	if(reset)begin
		counter <=3'b000;
		out_clk <= 1'b0;
	end
	else begin
		if(counter==3'b101)
		begin
			counter <=3'b000;
			out_clk <= ~out_clk;
		end
		else
		begin
			counter <=counter+1;
		end
	end
end

endmodule
