module main();
	logic [0:7] char [0:40];
	logic clock_25;
	logic reset;
	logic [31:0] WriteData, DataAdr;
	logic MemWrite;
	generate 
		toprom top (clock_50, reset, op, WriteData, DataAdr, MemWrite);
		TopRam TopRam (reset, WriteData, clock_25, DataAdr, clock_50, MemWrite, char);
		clock25mh clock(clock_50, clock_25);
		
	endgenerate	

endmodule 