module counter #(parameter N=8) (input rst, clk, en, output logic [N-1:0] q);
	always_ff @(posedge clk or posedge rst) begin
		if(rst)
			q=8'h00;
		else
			if(en)
				q=q+1;
	end
endmodule 
