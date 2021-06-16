module mux2to1 #(parameter WIDTH = 8)
	(input logic [WIDTH-1:0] v1, v2,
	input logic sel,
	output logic [WIDTH-1:0] y);
	
		assign y = sel ? v2 : v1;
		
endmodule 