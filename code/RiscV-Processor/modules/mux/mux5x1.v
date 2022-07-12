module mux5x1 (
    input [31:0]in1,
    input [31:0]in2,
    input [31:0]in3,
    input [31:0]in4,
    input [31:0]in5,
    input [2:0]select,
    output reg [31:0] out
);

always @(*) begin
    case (select)
        3'b000:begin
            out<=in1;
        end
        3'b001:begin
            out<=in2;
        end
        3'b010:begin
            out<=in3;
        end
        3'b011:begin
            out<=in4;
        end
        3'b100:begin
            out<=in5;
        end
    endcase
end
    
endmodule