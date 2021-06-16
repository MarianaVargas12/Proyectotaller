module flagZ #(parameter bits = 4)
					(input logic [3:0] s,
					input logic [bits-1:0] sumresO,multO,divO,modO,
					output logic flag);

	always_comb begin
		case(s)
			4'b0000: flag = (sumresO == 0);
			4'b0001: flag = (sumresO == 0);
			4'b0010: flag = (multO == 0);
			4'b0011: flag = (divO == 0);
			4'b0011: flag = (modO == 0);
			default: flag = 0;
		endcase
	end
	
endmodule 