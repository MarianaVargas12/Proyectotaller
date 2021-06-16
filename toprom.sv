module toprom(input logic clk, reset,
		input logic [4:0] op,
		output logic [31:0] WriteData, DataAdr,
		output logic MemWrite);
	logic [31:0] PC, Instr, ReadData;
	// inicializacion
	arm arm(clk, reset, PC, Instr, MemWrite, DataAdr, WriteData, ReadData);
	memo memo(PC, Instr);
	PAL palabra (DataAdr, clk, ReadData);
endmodule 