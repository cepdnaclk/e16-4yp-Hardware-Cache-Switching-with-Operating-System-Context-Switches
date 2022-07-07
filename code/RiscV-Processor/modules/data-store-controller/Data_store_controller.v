module Data_store_controller (
    func3,
    to_data_memory,
    data2
);

input [2:0] func3;
input [31:0] data2;
output reg [31:0] to_data_memory;
wire [31:0] sh,sb;

assign sb ={{24{1'b0}},data2[7:0]};
assign sh ={{16{1'b0}},data2[15:0]};

//block which check which data that should be stored in the cache memory
always @(*)begin
    case(func3)
        3'b000: begin    //store byte
            to_data_memory <= sb;
        end
        3'b001: begin   //store half word
            to_data_memory <= sh;
        end
        3'b010:begin       //store full word
            to_data_memory <= data2;
        end
    endcase
end
endmodule