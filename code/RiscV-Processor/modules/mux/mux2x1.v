module mux2x1 (
    input [31:0]in1,
    input [31:0]in2,
    input select,
    output reg [31:0] out
);

always @(*) begin
    if (!select) begin
        out<=in1;
    end else begin
        out<=in2;
    end
end
    
endmodule