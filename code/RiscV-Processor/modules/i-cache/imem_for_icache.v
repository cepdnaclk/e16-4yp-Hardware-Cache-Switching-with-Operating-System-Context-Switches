`timescale  1ns/100ps
module Instruction_memory(
    reset,
    clock,
    read,
    address,
    readdata,
    busywait
);

input reset;
input               clock;
input               read;
input[27:0]          address;
output reg [127:0]  readdata;
output reg          busywait;

reg readaccess;

//Declare memory array 1024x8-bits 
reg [7:0] memory_array [1023:0];
reg [4:0] count;
//Initialize instruction memory
initial
begin
         {memory_array[32'd03], memory_array[32'd02], memory_array[32'd01], memory_array[32'd00]} <= 32'h3e800093;           
         {memory_array[32'd07], memory_array[32'd06], memory_array[32'd05], memory_array[32'd04]} <= 32'b00000000000000000000000000000000;           
         {memory_array[32'd11], memory_array[32'd10], memory_array[32'd09], memory_array[32'd08]} <= 32'b00000000000000000000000000000000;         
         {memory_array[32'd15], memory_array[32'd14], memory_array[32'd13], memory_array[32'd12]} <= 32'b00000000000000001111011000010011;       
         {memory_array[32'd19], memory_array[32'd18], memory_array[32'd17], memory_array[32'd16]} <= 32'b00000000000000000000000000000000;       
         {memory_array[32'd23], memory_array[32'd22], memory_array[32'd21], memory_array[32'd20]} <= 32'b00000000000000000000000000000000;       
         {memory_array[32'd27], memory_array[32'd26], memory_array[32'd25], memory_array[32'd24]} <= 32'b00000000000101100000000010100011;       
         {memory_array[32'd31], memory_array[32'd30], memory_array[32'd29], memory_array[32'd28]} <= 32'b00000000000000000000000000000000;      
         {memory_array[32'd35], memory_array[32'd34], memory_array[32'd33], memory_array[32'd32]} <= 32'b00000000000000000000000000000000;
         {memory_array[32'd39], memory_array[32'd38], memory_array[32'd37], memory_array[32'd36]} <= 32'b11110010001101100000000100000011;
         {memory_array[32'd43], memory_array[32'd42], memory_array[32'd41], memory_array[32'd40]} <= 32'b00000000000000000000000000000000;
         {memory_array[32'd47], memory_array[32'd46], memory_array[32'd45], memory_array[32'd44]} <= 32'b11110010110000001010000110100011;
         {memory_array[32'd51], memory_array[32'd50], memory_array[32'd49], memory_array[32'd48]} <= 32'b11110010001100001010011010000011;
         {memory_array[32'd55], memory_array[32'd54], memory_array[32'd53], memory_array[32'd52]} <= 32'b00000000000000000000000000000000;
         {memory_array[32'd59], memory_array[32'd58], memory_array[32'd57], memory_array[32'd56]} <= 32'b00000000000000000000000000000000;
         {memory_array[32'd63], memory_array[32'd62], memory_array[32'd61], memory_array[32'd60]} <= 32'b11110010110100001010000110100011;
end

//ADDI x1,x1,0x8F1
//ADDI x17,x17,0x8F1
//ORI x12,x17,0x800
//AND x13,x17,x11
//LB x12,0x001(x13)
//BEQ x4,x5,0x014


// ADDI x1,x1,0x8F1
// ORI x12,x1,0x800
// SB x1,0xF23(x12)
// SW x12,0xF23(x1)
// LB x2,0xF23(x12)
// LW x13,0xF23(x1)





// ADDI x1,x1,0x8F1
// ANDI x12,x1,0x000 

// SB x1,0x001(x12)  

// LB x2,0xF23(x12) 
// SW  x12,0xF23(x1) 
// LW x13,0xF23(x1)
// SW  x13,0xF23(x1)





















//Detecting an incoming memory access
always @ (posedge clock)
begin
	if(read) begin
		readaccess = 1'b1;
	end else begin
		readaccess = 1'b0;
	end
	
end
//



always @(posedge clock, negedge busywait, posedge readaccess)
begin
	if(~busywait) begin
		count = 5'd15;
	end else if(readaccess) begin
		count = count - 5'd1;
	end
	
   // busywait = (read)? 1 : 0;
    //readaccess = (read)? 1 : 0;
end


//Reading
always @(posedge clock,posedge reset)
begin
    if(reset)begin
        busywait = 0;
    end
    else if(read)
    begin
        busywait =1;
        readdata     =  memory_array[{address,count}];
		  
		  if(count == 5'd0)begin
				busywait = 0;
		  end else begin
				readdata = readdata << 8;
			end
		  
    end
end
 
endmodule
