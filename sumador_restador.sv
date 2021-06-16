module sumador_restador #(parameter bits = 4)
								(input logic [bits-1:0] a, b,
								 input logic s,
								 output logic [bits-1:0] c,
								 output logic cout);
	
	//Defning an AUX
	logic [bits-1:0]bAux;
	
	//always_comb automatically executes once at time zero
	always_comb begin
		case(s)
			4'b0000: bAux = b; //if its a sum
			default: bAux = ~b; //if its a difference
		endcase
	end

	assign {cout, c} = a + bAux + s; //complement to the base (base 2)
	
endmodule 