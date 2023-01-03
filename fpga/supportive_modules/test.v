module test(input reset,input clock, output reg [31:0]out);

always @(posedge reset,posedge clock)
begin
if(reset)
out=32'd0;
else
out=32'd1;
end
endmodule