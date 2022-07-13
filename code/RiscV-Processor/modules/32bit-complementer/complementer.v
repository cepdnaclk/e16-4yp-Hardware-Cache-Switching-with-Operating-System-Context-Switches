module complementer (
    input [31:0]in,
    output [31:0]out
);

wire [31:0]notout;
assign notout=in^32'b11111111111111111111111111111111;
assign out=notout+1;
    
endmodule