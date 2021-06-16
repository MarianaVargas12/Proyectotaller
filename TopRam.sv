module TopRam(
	input reset,
	input	[7:0] data,
	input rdclock,
	input	[7:0] wraddress,
	input wrclock,
	input wren,
	output logic [0:7] char [0:40]);
	
	logic	[7:0] q;
	logic [7:0] rdaddress;
	RAM RAM (data,
				rdaddress,
				rdclock,
				wraddress,
				wrclock,
				wren,
				q);
				
	Counter counter (rdclock, reset, 1'b1, rdaddress);
	always@(posedge rdclock) begin
		char[{rdaddress}] = q;
	end				
	
endmodule 