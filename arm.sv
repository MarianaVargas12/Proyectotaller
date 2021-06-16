module arm(input logic clk, reset,
		output logic [31:0] PC,
		input logic [31:0] Instr,
		output logic MemWrite,
		output logic [31:0] ALUResult, WriteData,
		input logic [31:0] ReadData);
	logic [3:0] ALUFlags;
	logic RegWrite, ALUSrc, MemtoReg, PCSrc;
	logic [1:0] RegSrc, ImmSrc;
	logic [3:0] ALUControl;
	logic [23:0] inm;
	deco uc(clk, reset, ALUFlags[1], Instr, MemtoReg, MemWrite, PCSource, RegWrite, ALUSrc, rd, rs, rm, ALUControl, inm, RegSrc);
	datapath dp(clk, reset,RegSrc, RegWrite, ALUSrc, ALUControl, MemtoReg, MemWrite, PCSrc, Instr, inm, ALUFlags, PC,  ALUResult, WriteData, ReadData);
endmodule 

