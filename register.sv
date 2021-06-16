module register #(parameter N = 30)(input logic [N-1:0] a, input clk, input rst, output logic [N-1:0] b);
	always_ff @(posedge clk)
		if(rst)
			b <= a;		
		else 
			b <= 0;
			
endmodule 