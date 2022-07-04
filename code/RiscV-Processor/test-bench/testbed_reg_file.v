module testreg;

  wire [31:0] out1data,out2data;
  reg [4:0] outaddress1,outaddress2,inaddress;
  reg [31:0] indata;
  reg write,clk,reset;
  integer i;

  //cpu module instantiate OUT1, OUT2, IN, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET
  reg_file myreg(out1data, out2data, indata, inaddress, outaddress1, outaddress2, write, clk, reset);

	//wavedata file
	initial
	begin
		$dumpfile("wavedata.vcd");
		$dumpvars(0,testreg);
    
    for(i = 0;i <3; i = i + 1)begin
			$dumpvars(0, myreg.Register[i]);
		end
			
	end

  //clock 
	always 
	begin
			#5	clk = ~clk;
	end

	//running
	initial
	begin
    clk = 1'b1;
    reset <= 1'b1;
    #1
    reset <= 1'b0;
    #9

		inaddress <= 5'b00001;
    indata <= 32'b00000000000000000000000000000011;
    outaddress1 <= 5'b00010;
    outaddress2 <= 5'b00011;
    write <= 1'b1;
    
    #10
    inaddress <= 5'b00001;
    indata <= 32'b00000000000000000000000000000011;
    outaddress1 <= 5'b00001;
    outaddress2 <= 5'b00011;
    write <= 1'b0;

    #10
    reset <= 1'b1;
    // #1
    // inaddress <= 5'b00001;
    // outaddress1 <= 5'b00010;
    // outaddress2 <= 5'b00011;
    // write <= 1'b1;

		$finish;

	end
		 
endmodule