`timescale 1ns/100ps


module dcache (
    clock,
    reset,
    read,
    write,
    address,
    writedata,
    readdata,
	busywait,
    mem_read,
    mem_write,
    mem_address,
    mem_writedata,
    mem_readdata,
    mem_busywait
    );

    integer i;
    input reset,read,write,clock,mem_busywait;
    input [31:0] address,writedata;

    output reg busywait,mem_read,mem_write;
    output reg [31:0] readdata;
    

    wire valid,dirty;
    input [127:0] mem_readdata;

    reg hit,write_from_mem;
    reg valid_bits[0:7];
    reg dirty_bits[0:7];
    reg [24:0] tags[0:7];
    reg [31:0] word[0:7][0:3];
    output reg [27:0] mem_address;
    output reg [127:0] mem_writedata;

    
    /*
    Combinational part for indexing, tag comparison for hit deciding, etc.
    ...
    ...
    */
    
    assign  valid=valid_bits[address[6:4]];
    assign  dirty=dirty_bits[address[6:4]];

    always @(*) begin //extrac the data from word 
        if(valid)begin
            readdata <= word[address[6:4]][address[3:2]];
        end
    end

    always @(*) begin //check wheather hit or miss
        if ((tags[address[6:4]] == address[31:7]) && valid) begin
            hit<=1'b1;
        end
        else begin
            hit<=1'b0;
        end
    end

   
    always @(posedge clock,posedge reset) begin
				
		if(reset)begin
				for (i =0 ;i<8 ;i = i + 1) begin
						 valid_bits[i]<=1'b0;
					end

					for (i =0 ;i<8 ;i = i + 1 ) begin
						 dirty_bits[i]<=1'b0;
					end
		end
        else if(hit && write) begin //write data to the block when hit
            dirty_bits[address[6:4]]<=1;
            valid_bits[address[6:4]]<=1;
            word[address[6:4]][address[3:2]]<=writedata;
        end   
        else if (write_from_mem & read) begin //write data get from memory its happen only read miss
            dirty_bits[address[6:4]]<=0;
            valid_bits[address[6:4]]<=1;
            tags[address[6:4]]<=address[31:7];
            {word[address[6:4]][3],word[address[6:4]][2],word[address[6:4]][1],word[address[6:4]][0]}<=mem_readdata;

        end
        else if (write_from_mem & write) begin //write data get from cpu on write miss 
            dirty_bits[address[6:4]]<=1;
            valid_bits[address[6:4]]<=1;
            tags[address[6:4]]<=address[31:7];
            case (address[3:2])
                2'b00:begin
                    {word[address[6:4]][3],word[address[6:4]][2],word[address[6:4]][1]}<=mem_readdata[127:32];
                    word[address[6:4]][address[3:2]]<=writedata;
                end
                2'b01:begin
                    {word[address[6:4]][3],word[address[6:4]][2],word[address[6:4]][0]}<={mem_readdata[127:64],mem_readdata[31:0]};
                    word[address[6:4]][address[3:2]]<=writedata;
                end
                2'b10:begin
                    {word[address[6:4]][3],word[address[6:4]][1],word[address[6:4]][0]}<={mem_readdata[127:96],mem_readdata[63:0]};
                    word[address[6:4]][address[3:2]]<=writedata;
                end
                2'b11:begin
                    {word[address[6:4]][2],word[address[6:4]][1],word[address[6:4]][0]}<=mem_readdata[95:0];
                    word[address[6:4]][address[3:2]]<=writedata;
                end
            endcase
            /*
            {word[address[6:4]][3],word[address[6:4]][2],word[address[6:4]][1],word[address[6:4]][0]}<=mem_readdata;
            word[address[6:4]][address[3:2]]<=writedata;
            //need to handle more effectivly

            /*
            case (address[3:2])
                2'b00:begin
                    {word[address[6:4]][3],word[address[6:4]][2],word[address[6:4]][1]}<=mem_readdata[127:32];
                    word[address[6:4]][address[3:2]]<=writedata;
                end
                2'b01:begin
                    {word[address[6:4]][3],word[address[6:4]][2],word[address[6:4]][0]}<={mem_readdata[127:64],mem_readdata[31:0]};
                    word[address[6:4]][address[3:2]]<=writedata;
                end
                2'b10:begin
                    {word[address[6:4]][3],word[address[6:4]][1],word[address[6:4]][0]}<={mem_readdata[127:96],mem_readdata[63:0]};
                    word[address[6:4]][address[3:2]]<=writedata;
                end
                2'b11:begin
                    {word[address[6:4]][2],word[address[6:4]][1],word[address[6:4]][0]}<=mem_readdata[95:0];
                    word[address[6:4]][address[3:2]]<=writedata;
                end
            endcase
            */

        end

    end
    

    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001,MEM_WRITE=3'b010,CACHE_WRITE=3'b011;
    reg [2:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE: //normal state
                if ((read || write) && !dirty && !hit)  
                    next_state <= MEM_READ;
                else if ((read || write) && dirty && !hit)
                    next_state <= MEM_WRITE;
                else
                    next_state <= IDLE;
            
            MEM_READ: //memory read state
                if (!mem_busywait)
                    next_state <= CACHE_WRITE;
                else    
                    next_state <= MEM_READ;
            CACHE_WRITE: //chache write state
                    next_state <= IDLE;
                
            MEM_WRITE: //memory write state
                if(!mem_busywait)
                    next_state <= MEM_READ;
                else
                    next_state <= MEM_WRITE;
        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin
                mem_read <= 0;
                mem_write <= 0;
                //mem_address <= 28'dx;
                //mem_writedata <= 128'dx;
                busywait <= 0;
                write_from_mem <= 0;  
            end
         
            MEM_READ: 
            begin
                mem_read <= 1;
                mem_write <= 0;
                mem_address <= address[31:4];
                //mem_writedata <= 128'dx;
                busywait <= 1;
                write_from_mem <=0;
            end

            CACHE_WRITE:
            begin
                mem_read <=0;
                mem_write <=0;
                //mem_address <= 28'dx;
                //mem_writedata <= 128'dx;
                busywait <=1;
                write_from_mem <=1;//this signal assert when data block is come from memoey in this state
            end

            MEM_WRITE:
            begin
                mem_read <=0;
                mem_write <=1;
                mem_address <= {tags[address[6:4]],address[6:4]};
                mem_writedata <= {word[address[6:4]][3],word[address[6:4]][2],word[address[6:4]][1],word[address[6:4]][0]};
                busywait<=1;
                write_from_mem<=0;
            end
            
        endcase
    end

    // sequential logic for state transitioning 
   
    always @(posedge clock, posedge reset)
    begin
        if(reset)begin
            state <= IDLE;
            
        end
        else
            state <= next_state;
    end

    /* Cache Controller FSM End */

endmodule