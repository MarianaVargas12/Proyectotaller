module datapath(input logic clk, reset,
					input logic [1:0] RegSrc,
					input logic RegWrite,
					input logic ALUSrc,
					input logic [3:0] ALUControl,
					input logic MemtoReg,
					input logic MemWrite,
					input logic PCSrc,
					input logic [31:0] Instr,
					input logic [23:0] inm,
					output logic [3:0] ALUFlags,
					output logic [31:0] PC,
					output logic [31:0] ALUResult, WriteData, ReadData);
	logic [31:0] PCNext, PCPlus4, PCPlus8;
	logic [31:0] ExtImm, SrcA, SrcB, Result;
	logic [3:0] RA1, RA2;
	// next PC logic
	mux2to1 #(32) pcmux(PCPlus4, Result, PCSrc, PCNext);
	pcreg #(32) pcreg(clk, reset, PCNext, PC);
	adder #(32) pcadd1(PC, 32'b100, PCPlus4);
	adder #(32) pcadd2(PCPlus4, 32'b100, PCPlus8);
	// register file logic
	mux2to1 #(4) ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1);
	mux2to1 #(4) ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2);
	regfile rf(clk, RegWrite, RA1, RA2, Instr[15:12], Result, PCPlus8, SrcA, WriteData);
	mux2to1 #(32) resmux(ALUResult, ReadData, MemtoReg, Result);
	extend ext(inm, PCSrc, ExtImm);
	// ALU logic
	mux2to1 #(32) srcbmux(WriteData, ExtImm, ALUSrc, SrcB);
	ALU #(32) alu(SrcA, SrcB, ALUControl, ALUResult, ALUFlags);

endmodule 