module mux6x1 (
    input [31:0]in01,
    input [31:0]in02,
    input [31:0]in03,
    input [31:0]in04,
    input [31:0]in05,
	 input [31:0]in06,
	 input [31:0]in07,
	 input [31:0]in08,
    input [31:0]in09,
	 input [31:0]in10,
	 input [31:0]in11,
	 input [31:0]in12,
    input [4:0]select,
    output reg [31:0] out
);

always @(*) begin
    case (select)
        5'b00000:begin
            out<=in01;
        end
        5'b00001:begin
            out<=in02;
        end
        5'b00010:begin
            out<=in03;
        end
        5'b00011:begin
            out<=in04;
        end
        5'b00100:begin
            out<=in05;
        end
		  5'b00101:begin
            out<=in06;
        end
		  5'b00110:begin
            out<=in07;
        end
        5'b00111:begin
            out<=in08;
        end
		  5'b01000:begin
            out<=in09;
        end
		  default:begin
            out<=in07;
        end
    endcase
end
    
endmodule