`timescale 1ns/100ps



module icache (clock,
    reset,
    address,
    instruction,
	busywait
    );

    input reset,clock;
    input [31:0] address;

    output reg busywait;
    output reg [31:0] instruction;
    

    wire valid,mem_busywait;
    wire [1:0] offset;
    wire [2:0] index; 
    wire [127:0] mem_readdata;
    wire [24:0]tag;

    reg hit,mem_read,write_from_mem;
    reg valid_bits[0:7];
    reg [24:0] tags[0:7];
    reg [31:0] word[0:7][0:3];
    reg [27:0] mem_address;
    

    
    /*
    Combinational part for indexing, tag comparison for hit deciding, etc.
    ...
    ...
    */
    Instruction_memory my_i_memory(reset,clock,mem_read,mem_address,mem_readdata,mem_busywait);

    
    assign valid=valid_bits[address[6:4]];
    assign tag=tags[address[6:4]];
    assign index=address[6:4];
    assign offset=address[3:2];

    always @(*) begin //extrac the data from word 

        
        instruction <= word[index][offset];
        
    end

    always @(*) begin //check wheather hit or miss
        
        if ((tag == address[31:7]) && valid) begin
            hit <= 1'b1;
        end
        else begin
            hit <= 1'b0;
        end
    end

   
    always @(negedge clock,posedge reset) begin
        if(reset)begin
			for (i =0 ;i<8 ;i = i+1 ) begin
                valid_bits[i] <= 1'b0;
            end
		  end
        else if (write_from_mem) begin //write data get from instruction memory
            valid_bits[index] <= 1;
            tags[index] <= address[31:7];
            {word[index][3],word[index][2],word[index][1],word[index][0]} <= mem_readdata;
        end

    end
    

    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001,CACHE_WRITE=3'b011;
    reg [2:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)

            IDLE: //normal state
                if ( !hit)  
                    next_state <= MEM_READ;
                else
                    next_state <= IDLE;
            
            MEM_READ: //memory read state
                if (!mem_busywait)
                    next_state <= CACHE_WRITE;
                else    
                    next_state <= MEM_READ;
            CACHE_WRITE: //chache write state
                    next_state <= IDLE;

        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)

            IDLE:
            begin
                mem_read <= 0;
                //mem_address <= 28'dx;
                busywait <= 0;
                write_from_mem <= 0;  
            end
         
            MEM_READ: 
            begin
                mem_read <= 1;
                mem_address <= address[31:4];
                busywait <= 1;
                write_from_mem <= 0;
            end
            CACHE_WRITE:
            begin
                mem_read <= 0;
                //mem_address <= 28'dx;
                busywait <= 1;
                write_from_mem <= 1;//this signal assert when data block is come from memoey in this state
            end
        endcase
    end

    // sequential logic for state transitioning 
    integer i;
    always @(negedge clock, posedge reset)
    begin
        if(reset)begin
            state <= IDLE;
        end
        else
            state <= next_state;
    end

    /* Cache Controller FSM End */

endmodule