module decoder(input clk, input reset,
input [31:0] instruction,
output useMem, output wMem, //Si usa memoria; si es de escritura en memoria
output [3:0] rd, //Reg destino
output [3:0] rs, //Reg operando 1
output [3:0] rm, //Reg operando 2
output [3:0] func,
output [23:0] inm); //Valor inmediato

	logic vuseMem;
	logic vwMem;
	logic [3:0] vrd;
	logic [3:0] vrs;
	logic [3:0] vrm;
	logic [23:0] vinm;
	logic [3:0] vFunc;
	
	assign useMem = vuseMem;
	assign wMem = vwMem;
	assign rd = vrd;
	assign rs = vrs;
	assign rm = vrm;
	assign func = vFunc;
	assign inm = vinm;
	
	always_ff @(posedge clk or posedge reset)
		begin 
			if(reset)
				begin
					vuseMem = 0;
					vwMem = 0;
					vrd = 0;
					vrs = 0;
					vinm = 0;
					vFunc = 0;
				end
			else 
				begin
					case(instruction[27:26])
						2'b00: //Procesamiento de datos
							if(instruction[25]) //Utiliza un operando inmediato
								begin
									vuseMem = 0;
									vwMem = 0;
									vrd = instruction[15:12];
									vrs = instruction[19:16];
									vrm = 0;
									vinm = instruction[7:0];
									vFunc = instruction[24:21];
								end
								else
									begin
										vuseMem = 0;
										vwMem = 0;
										vrd = instruction[15:12];
										vrs = instruction[19:16];
										vrm = instruction[3:0];
										vinm = 0;
										vFunc = instruction[24:21];
									end
						2'b01: //Memoria
							if(instruction[25]) //Utiliza un operando inmediato
								begin
									vuseMem = 1;

								
									if (instruction[21]) //LOAD
										vwMem = 0;
									else
										vwMem = 1; //WRITE
									//cargar el inm
									vinm = instruction[7:0];
									vrd = instruction[15:12];
									vrs = instruction[19:16];
									vrm = 0;
									vFunc = 0;
								end
							
							else
								begin
									vuseMem = 1;
								
									if (instruction[21]) //LOAD
										vwMem = 0;
									else//WRITE
										vwMem = 1;
									vinm = 0;
									vrd = instruction[15:12];
									vrs = instruction[19:16];
									vrm = instruction[3:0];
									vFunc = 0;
								end
								
						2'b10: //Salto
							begin
								vuseMem = 0;
								vwMem = 0;
								vrd = 0;
								vrs = 0;
								vrm = 0;
								vinm = instruction[23:0];
								vFunc = 0;
							end
						
						default:
							begin
								vuseMem = 0;
								vwMem = 0;
								vrd = 0;
								vrs = 0;
								vrm = 0;
								vinm = 0;
								vFunc = 0;
							end
					endcase
				end
			end
					
endmodule 