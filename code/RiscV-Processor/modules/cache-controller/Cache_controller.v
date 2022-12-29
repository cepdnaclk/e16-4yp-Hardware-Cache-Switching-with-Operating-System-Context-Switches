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
    reg mem_read,mem_write;
    wire mem_busywait;
    wire [127:0] mem_readdata;
    reg [127:0] mem_writedata;
    wire [127:0] cache_1_mem_writedata,cache_2_mem_writedata,cache_3_mem_writedata,cache_4_mem_writedata;
    reg [27:0] mem_address;
    wire [27:0] cache_1_mem_address,cache_2_mem_address,cache_3_mem_address,cache_4_mem_address;
    wire cache_1_mem_read,cache_1_mem_write,cache_1_mem_busywait;
    wire cache_2_mem_read,cache_2_mem_write,cache_2_mem_busywait;
    wire cache_3_mem_read,cache_3_mem_write,cache_3_mem_busywait;
    wire cache_4_mem_read,cache_4_mem_write,cache_4_mem_busywait;

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
    and(cache3_write,write,cache3_select);

    and(cache4_read,read,cache4_select);
    and(cache4_write,write,cache4_select);

    and(cache_1_mem_busywait,cache1_select,mem_busywait);
    and(cache_2_mem_busywait,cache2_select,mem_busywait);
    and(cache_3_mem_busywait,cache3_select,mem_busywait);
    and(cache_4_mem_busywait,cache4_select,mem_busywait);

    data_memory my_data_memory(clock,reset,mem_read,mem_write,mem_address,mem_writedata,mem_readdata,mem_busywait);


    dcache dcache1(clock,reset,cache1_read,cache1_write,address,writedata,cache1_read_data,cache1_busywait,cache_1_mem_read,cache_1_mem_write,cache_1_mem_address,cache_1_mem_writedata,mem_readdata,cache_1_mem_busywait);
    dcache dcache2(clock,reset,cache2_read,cache2_write,address,writedata,cache2_read_data,cache2_busywait,cache_2_mem_read,cache_2_mem_write,cache_2_mem_address,cache_2_mem_writedata,mem_readdata,cache_2_mem_busywait);
    dcache dcache3(clock,reset,cache3_read,cache3_write,address,writedata,cache3_read_data,cache3_busywait,cache_3_mem_read,cache_3_mem_write,cache_3_mem_address,cache_2_mem_writedata,mem_readdata,cache_3_mem_busywait);
    dcache dcache4(clock,reset,cache4_read,cache4_write,address,writedata,cache4_read_data,cache4_busywait,cache_4_mem_read,cache_4_mem_write,cache_4_mem_address,cache_2_mem_writedata,mem_readdata,cache_4_mem_busywait);


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
                mem_read <= cache_1_mem_read;
                mem_write <= cache_1_mem_write;
                mem_address <= cache_1_mem_address;
                mem_writedata <= cache_1_mem_writedata;
            end
            3'b010:begin
                readdata <= cache2_read_data;
                busywait <= cache2_busywait;
                mem_read <= cache_2_mem_read;
                mem_write <= cache_2_mem_write;
                mem_address <= cache_2_mem_address;
                mem_writedata <= cache_2_mem_writedata;
            end
            3'b011:begin
                readdata <= cache3_read_data;
                busywait <= cache3_busywait;
                mem_read <= cache_3_mem_read;
                mem_write <= cache_3_mem_write;
                mem_address <= cache_3_mem_address;
                mem_writedata <= cache_3_mem_writedata;
            end
            default:begin
                readdata <= cache4_read_data;
                busywait <= cache4_busywait;
                mem_read <= cache_4_mem_read;
                mem_write <= cache_4_mem_write;
                mem_address <= cache_4_mem_address;
                mem_writedata <= cache_4_mem_writedata;
            end
        endcase
    end

endmodule