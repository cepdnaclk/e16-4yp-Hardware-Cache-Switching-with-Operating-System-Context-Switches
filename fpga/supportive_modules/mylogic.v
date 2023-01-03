module mylogic(input clock, input reset,output reg out);

always @(posedge clock,posedge reset)
begin 
if(reset)
	out=1'b1;
else
	out=~out;
end

endmodule
