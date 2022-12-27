module Cache_controller (
    clock,
    reset,
    read,
    write,
    address,
    writedata,
    readdata,
	busywait,
    func3_cache_select_reg_value,
    write_cache_select_reg
);
    input reset,read,write,clock,write_cache_select_reg;
    input [31:0] address,writedata;
    input [2:0] func3_cache_select_reg_value;
    
    output reg busywait;
    output reg [31:0] readdata;

    reg [2:0] cache_switching_reg;
    reg cache1_select,cache2_select,cache3_select,cache4_select;

    wire [31:0] cache1_read_data,cache2_read_data,cache3_read_data,cache4_read_data;
    wire cache1_busywait,cache1_read,cache1_write,cache2_busywait,cache2_read,cache2_write,cache3_busywait,cache3_read,cache3_write,cache4_busywait,cache4_read,cache4_write;

    always @(posedge clock,posedge reset) begin
        if (reset) begin
            cache_switching_reg <= 3'd0;
        end
        else if(write_cache_select_reg) begin
            cache_switching_reg <= func3_cache_select_reg_value;
        end
    end

    and(cache1_read,read,cache1_select);
    and(cache1_write,write,cache1_select);

    and(cache2_read,read,cache2_select);
    and(cache2_write,write,cache2_select);

    and(cache3_read,read,cache3_select);
    and(cache1_write,write,cache1_select);

    and(cache4_read,read,cache4_select);
    and(cache4_write,write,cache4_select);

    dcache dcache1(clock,reset,cache1_read,cache1_write,address,writedata,cache1_read_data,cache1_busywait);
    dcache dcache2(clock,reset,cache2_read,cache2_write,address,writedata,cache2_read_data,cache2_busywait);
    dcache dcache3(clock,reset,cache3_read,cache3_write,address,writedata,cache3_read_data,cache3_busywait);
    dcache dcache4(clock,reset,cache4_read,cache4_write,address,writedata,cache4_read_data,cache4_busywait);

    always @(*) begin
        case(cache_switching_reg)
            3'b001:begin
                cache1_select <= 1'b1;
                cache2_select <= 1'b0;
                cache3_select <= 1'b0;
                cache4_select <= 1'b0;
            end
            3'b010:begin
                cache1_select <= 1'b0;
                cache2_select <= 1'b1;
                cache3_select <= 1'b0;
                cache4_select <= 1'b0;
            end
            3'b011:begin
                cache1_select <= 1'b0;
                cache2_select <= 1'b0;
                cache3_select <= 1'b1;
                cache4_select <= 1'b0;
            end
            default:begin
                cache1_select <= 1'b0;
                cache2_select <= 1'b0;
                cache3_select <= 1'b0;
                cache4_select <= 1'b1;
            end
        endcase
    end

    always @(*) begin
        case(cache_switching_reg)
            3'b001:begin
                readdata <= cache1_read_data;
                busywait <= cache1_busywait;
            end
            3'b010:begin
                readdata <= cache2_read_data;
                busywait <= cache2_busywait;
            end
            3'b011:begin
                readdata <= cache3_read_data;
                busywait <= cache3_busywait;
            end
            default:begin
                readdata <= cache4_read_data;
                busywait <= cache4_busywait;
            end
        endcase
    end

endmodule