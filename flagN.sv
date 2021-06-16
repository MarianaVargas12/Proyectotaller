module flagN #(parameter N= 4)
				(input logic [3:0] s,
				input logic [N-1:0] sumres,multO,divO,
				output logic flag);

	always_comb begin
		case(s)
			4'b0000: flag = sumres[N-1];
			4'b0001: flag = sumres[N-1];
			4'b0010: flag = multO[N-1];
			4'b0011: flag = divO[N-1];
			default: flag = 0;
		endcase
	end

endmodule 