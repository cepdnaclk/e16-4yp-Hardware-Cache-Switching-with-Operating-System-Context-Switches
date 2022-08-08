module seven_segment_panel(
    input [31:0]in,
    output [6:0]seven_0_out,
    output [6:0]seven_1_out,
    output [6:0]seven_2_out,
    output [6:0]seven_3_out,
    output [6:0]seven_4_out,
    output [6:0]seven_5_out,
    output [6:0]seven_6_out,
    output [6:0]seven_7_out
);

ss_4bit_generator one(in[3:0],seven_0_out);
ss_4bit_generator two(in[7:4],seven_1_out);
ss_4bit_generator three(in[11:8],seven_2_out);
ss_4bit_generator four(in[15:12],seven_3_out);
ss_4bit_generator five(in[19:16],seven_4_out);
ss_4bit_generator six(in[23:20],seven_5_out);
ss_4bit_generator seven(in[27:24],seven_6_out);
ss_4bit_generator eight(in[31:28],seven_7_out);


endmodule