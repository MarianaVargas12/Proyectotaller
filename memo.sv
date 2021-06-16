module memo(input logic [31:0] a,
		output logic [31:0] rd);
	logic [31:0] ROM[88:0];
	initial
		$readmemh("C:\Users\maria\OneDrive - Estudiantes ITCR\Escritorio\Computadores\7 semestre\Taller\Proyecto\rom.mif",ROM);
	assign rd = ROM[a[31:2]]; 
	
endmodule 