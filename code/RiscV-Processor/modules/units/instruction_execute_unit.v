`include "../mux/mux2x1.v"
`include "../mux/mux4x1.v"
`include "../32bit-Int-Mul/mul.v"
`include "../32bit-Int-Alu/alu.v"
`include "../branch-jump-controller/Branch_jump_controller.v"

module instruction_execute_unit (
    input [31:0] data1,data2,PC,INCREMENTED_PC_by_four,mux1out,
    input [1:0]mux4signal,
    input mux2signal,mux3signal,rotate_signal,branch_signal,jump_signal,
    input [2:0]func3,
    output [31:0] branch_jump_addres,
    output [31:0] result,
    output branch_or_jump_signal
);

wire [31:0]input1,input2,alu_result,mul_div_result;
wire zero_signal,sign_bit_signal,sltu_bit_signal;
reg [31:0] branch_adress;

mux2x1 mux2(data1,PC,mux2signal,input1);
mux2x1 mux3(data2,mux1out,mux3signal,input2);
mul mul_unit(mul_div_result,input1,input2,func3);
alu alu_unit(alu_result,input1,input2,func3,rotate_signal,zero_signal,sign_bit_signal,sltu_bit_signal);
mux4x1 mux4(mul_div_result,mux1out,alu_result,INCREMENTED_PC_by_four,mux4signal,result);
Branch_jump_controller bjunit(branch_adress,alu_result,func3,branch_signal,jump_signal,zero_signal,sign_bit_signal,sltu_bit_signal,branch_jump_addres,branch_or_jump_signal);



always @(*) begin
    branch_adress<=PC+mux1out;
end




    
endmodule