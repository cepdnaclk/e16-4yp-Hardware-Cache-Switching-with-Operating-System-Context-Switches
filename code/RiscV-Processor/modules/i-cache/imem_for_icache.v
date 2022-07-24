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

//Initialize instruction memory
initial
begin
     $readmemh("hex_memory_file.mem", memory_array);
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


always @(read)
begin
    //busywait = (read)? 1 : 0;
    readaccess = (read)? 1'b1 : 1'b0;
end


//Reading
always @(posedge clock,posedge reset)
begin
    if(reset)begin
        busywait = 0;
    end
    else if(readaccess)
    begin
        busywait =1;
        readdata[7:0]     =  memory_array[{address[27:0],4'b0000}];
        readdata[15:8]    =  memory_array[{address[27:0],4'b0001}];
        readdata[23:16]   =  memory_array[{address[27:0],4'b0010}];
        readdata[31:24]   =  memory_array[{address[27:0],4'b0011}];
        readdata[39:32]   =  memory_array[{address[27:0],4'b0100}];
        readdata[47:40]   =  memory_array[{address[27:0],4'b0101}];
        readdata[55:48]   =  memory_array[{address[27:0],4'b0110}];
        readdata[63:56]   =  memory_array[{address[27:0],4'b0111}];
        readdata[71:64]   =  memory_array[{address[27:0],4'b1000}];
        readdata[79:72]   =  memory_array[{address[27:0],4'b1001}];
        readdata[87:80]   =  memory_array[{address[27:0],4'b1010}];
        readdata[95:88]   =  memory_array[{address[27:0],4'b1011}];
        readdata[103:96]  =  memory_array[{address[27:0],4'b1100}];
        readdata[111:104] =  memory_array[{address[27:0],4'b1101}];
        readdata[119:112] =  memory_array[{address[27:0],4'b1110}];
        readdata[127:120] =  memory_array[{address[27:0],4'b1111}];
        busywait = 0;
    end
end
 
endmodule