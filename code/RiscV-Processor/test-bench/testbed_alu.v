module testalu;

  //for pass instraction to cpu
  reg [31:0] instruction;

  reg [31:0] data1,data2;
  reg [2:0] select;
  reg rotate;
  wire [31:0] result;
  wire zero;

  //cpu module instantiate
  alu myalu(zero, result, data1, data2, select, rotate);

	//wavedata file
	initial
	begin
		$dumpfile("wavedata.vcd");
		$dumpvars(0,testalu);
			
	end

	//running
	initial
	begin
		rotate = 1'b1;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b000;
		#1
    rotate = 1'b1;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b001;
		#1
    rotate = 1'b1;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b010;
		#1
    rotate = 1'b1;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b011;
		#1
    rotate = 1'b1;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b100;
		#1
    rotate = 1'b1;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b101;
		#1
    rotate = 1'b1;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b110;
		#1
    rotate = 1'b0;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b110;
		#1
    rotate = 1'b1;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b111;
		#1
    rotate = 1'b0;
		data1 = 32'b00000000000000000000000000000011;
    data2 = 32'b00000000000000000000000000000001;
    select = 3'b111;
		#1
		$finish;

	end
	
		 
endmodule