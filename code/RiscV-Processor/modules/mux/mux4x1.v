module mux4x1 (
    input [31:0]in1,
    input [31:0]in2,
    input [31:0]in3,
    input [31:0]in4,
    input [1:0]select,
    output reg [31:0] out
);

always @(*) begin
    case (select)
        2'b00:begin
            out<=in1;
        end
        2'b01:begin
            out<=in2;
        end
        2'b10:begin
            out<=in3;
        end
        2'b11:begin
            out<=in4;
        end
    endcase
end
    
endmodule