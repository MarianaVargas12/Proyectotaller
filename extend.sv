module extend(input logic [23:0] Instr, input logic ImmSrc, output logic [31:0] ExtImm);
	always_comb
		case(ImmSrc)
			// 8 bit
			2'b0: ExtImm = {24'b0, Instr[7:0]};
			// 24 bit
			2'b1: ExtImm = {{6{Instr[23]}}, Instr[23:0], 2'b00};
		default: ExtImm = 32'bx;
	endcase
endmodule 