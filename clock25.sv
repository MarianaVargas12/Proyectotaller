module clock25(input clock50, output logic clock25);

	logic [0:1] cuentaclock;
	generate
		contparam #(2) divisorclock(clock50, 0, cuentaclock);
	endgenerate
	
	always_comb begin
		clock25 = cuentaclock[1];
	end

endmodule 