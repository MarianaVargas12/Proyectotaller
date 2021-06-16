module deco(input clk, input reset, input flagZ,
				input [31:0] instruction,
				output useMem, output wMem, output PCSource, output RegWrite, output AluSrc, //Si usa memoria; si es de escritura en memoria; PCSource: 1 si es branches
				output [3:0] rd, //Reg destino
				output [3:0] rs, //Reg operando 1
				output [3:0] rm, //Reg operando 2
				output [3:0] func,
				output [23:0] inm, //Valor inmediato
				output [1:0] flags); //0: Mux Op 1 ; 1: Mux Op 2

	logic vuseMem;
	logic vwMem;
	logic [3:0] vrd;
	logic [3:0] vrs;
	logic [3:0] vrm;
	logic [23:0] vinm;
	logic [3:0] vFunc;
	logic [1:0] vFlags;
	logic vPCSource;
	logic vRegWrite;
	logic vAluSrc;
	assign AluSrc= vAluSrc;
	assign useMem = vuseMem;
	assign wMem = vwMem;
	assign rd = vrd;
	assign rs = vrs;
	assign rm = vrm;

	assign func = vFunc;
	assign inm = vinm;
	assign flags = vFlags;
	assign PCSource = vPCSource;
	assign RegWrite = vRegWrite;
	
	
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
					vPCSource = 0;
					vAluSrc=0;
				end
				
			//Reset en 0	
			else 

				begin
					//Tipos de operaciones
					case(instruction[27:26])
						
						2'b00: //Procesamiento de datos
							
							if(instruction[25]) //Utiliza un operando inmediato
								begin
									vPCSource = 0;
									case(instruction[24:21])
										4'b0001: //EOR
											begin
												vuseMem = 0;
												vwMem = 0;
												vFunc = instruction[24:21];
												vFlags = 2'b11;
												vrd = instruction[15:12];
												vrs = instruction[19:16];
												vrm = 0;
												vinm = instruction[11:0];
												vRegWrite = 1;
												vAluSrc=instruction[25]|vPCSource;
												
											end
											
										4'b0100: //ADD
											begin
												vuseMem = 0;
												vwMem = 0;
												vFunc = instruction[24:21];
												vFlags = 2'b11;
												vrd = instruction[15:12];
												vrs = instruction[19:16];
												vrm = 0;
												vinm = instruction[11:0];
												vRegWrite = 1;
												vAluSrc=instruction[25]|vPCSource;
											end
											
										4'b1010: //CMP
											begin
												vuseMem = 0;
												vwMem = 0;
												vFunc = instruction[24:21];
												vFlags = 2'b11;
												vrd = 0;
												vrs = instruction[19:16];
												vrm = 0;
												vinm = instruction[11:0];
												vRegWrite = 0;
												vAluSrc=instruction[25]|vPCSource;
											end
										
										4'b1101: //MOV
											begin
												vuseMem = 0;
												vwMem = 0;
												vFunc = instruction[24:21];
												vFlags = 2'b11;
												vrd = instruction[15:12];
												vrs = 0;
												vrm = 0;
												vinm = instruction[11:0];
												vRegWrite = 1;
												vAluSrc=instruction[25]|vPCSource;
											end
											
										4'b1111: //MVN
											begin
												vuseMem = 0;
												vwMem = 0;
												vFunc = instruction[24:21];
												vFlags = 2'b11;
												vrd = instruction[15:12];
												vrs = 0;
												vrm = 0;
												vinm = instruction[11:0];
												vRegWrite = 1;
												vAluSrc=instruction[25]|vPCSource;
											end
										default:
											begin
												vuseMem = 0;
												vwMem = 0;
												vFunc = 0;
												vFlags = 0;
												vrd = 0;
												vrs = 0;
												vrm = 0;
												vinm = 0;
												vRegWrite = 0;
												vAluSrc=0;
											end
											
									endcase
								end
								
							else //Sin Inmediato
								begin
									vPCSource = 0;
									case(instruction[24:21])
										4'b0001: //EOR
											begin
												vuseMem = 0;
												vwMem = 0;
												vFlags = 2'b01;
												vFunc = instruction[24:21];
												vrd = instruction[15:12];
												vrs = instruction[19:16];
												vrm = instruction[3:0];
												vinm = 0;
												vRegWrite = 1;
												vAluSrc=instruction[25]|vPCSource;
											end
											
										4'b0100: //ADD
											begin
												vuseMem = 0;
												vwMem = 0;
												vFlags = 2'b01;
												vFunc = instruction[24:21];
												vrd = instruction[15:12];
												vrs = instruction[19:16];
												vrm = instruction[3:0];
												vinm = 0;
												vRegWrite = 1;
												vAluSrc=instruction[25]|vPCSource;
											end
											
										4'b1010: //CMP
											begin
												vuseMem = 0;
												vwMem = 0;
												vFlags = 2'b01;
												vFunc = instruction[24:21];
												vrd = 0;
												vrs = instruction[19:16];
												vrm = instruction[3:0];
												vinm = 0;
												vRegWrite = 0;
												vAluSrc=instruction[25]|vPCSource;
											end
										
										4'b1101: //MOV
											begin
												vuseMem = 0;
												vwMem = 0;
												vFlags = 2'b01;
												vFunc = instruction[24:21];
												vrd = instruction[15:12];
												vrs = 0;
												vrm = instruction[3:0];
												vRegWrite = 1;
												vinm = 0;
												vAluSrc=instruction[25]|vPCSource;
											end
											
										4'b1111: //MVN
											begin
												vuseMem = 0;
												vwMem = 0;
												vFlags = 2'b01;
												vFunc = instruction[24:21];
												vrd = instruction[15:12];
												vrs = 0;
												vrm = instruction[3:0];
												vRegWrite = 1;
												vinm = 0;
												vAluSrc=instruction[25]|vPCSource;
											end
										
									endcase
									
								end
								
								
						2'b01: //Memoria
							if(instruction[25]) //Utiliza un operando inmediato
								begin
									vPCSource = 0;
									vuseMem = 1;
									vFlags = 2'b11;
								
									if (instruction[21]) //LOAD
										begin
											vwMem = 0;
											vRegWrite = 1;
										end
									else
										begin
											vwMem = 1; //WRITE
											vRegWrite = 0;
										end
									
									//cargar el inm
									vinm = instruction[11:0];
									vrd = instruction[15:12];
									vrs = instruction[19:16];
									vrm = 0;
									vFunc = 0;
									vAluSrc=instruction[25]|vPCSource;
								end
							
							else
								begin
									vPCSource = 0;
									vuseMem = 1;
									vFlags = 2'b01;

									if (instruction[21]) //LOAD
										begin
											vwMem = 0;
											vRegWrite = 1;
										end
									else//WRITE
										begin
											vwMem = 1;
											vRegWrite = 0;
										end
									
								
									vinm = 0;
									vrd = instruction[15:12];
									vrs = instruction[19:16];
									vrm = instruction[3:0];
									vFunc = 0;
									vAluSrc=instruction[25]|vPCSource;
								end
								
						2'b10: //Salto
							begin
								//HAY QUE VERIFICAR LO DEL FLAG EN LA INTEGRACION
								case(instruction[31:28])
									4'b0000: //EQ
										if(flagZ)
											begin
												vFlags = 2'b10;
												vuseMem = 0;
												vwMem = 0;
												vrd = 0;
												vrs = 0;
												vrm = 0;
												vinm = instruction[23:0];
												vFunc = 0;
												vPCSource = 1;
												vRegWrite = 0;
												vAluSrc=instruction[25]|vPCSource;
											end
										else
											begin
												vPCSource = 0;
												vFlags = 2'b00;
												vuseMem = 0;
												vwMem = 0;
												vrd = 0;
												vrs = 0;
												vrm = 0;
												vinm = 0;
												vFunc = 0;
												vRegWrite = 0;
												vAluSrc=instruction[25]|vPCSource;
											end
									
									4'b1110:
										//Always
										begin
											vPCSource = 1;
											vFlags = 2'b10;
											vuseMem = 0;
											vwMem = 0;
											vrd = 0;
											vrs = 0;
											vrm = 0;
											vinm = instruction[23:0];
											vFunc = 0;
											vRegWrite = 0;
											vAluSrc=instruction[25]|vPCSource;
										end

									default:
										begin
											vPCSource = 0;
											vFlags = 0;
											vuseMem = 0;
											vwMem = 0;
											vrd = 0;
											vrs = 0;
											vrm = 0;
											vinm = 0;
											vFunc = 0;
											vRegWrite = 0;
											vAluSrc=0;
										end
								endcase
							end
						
						default:
							begin
								vFlags = 2'b00;
								vuseMem = 0;
								vwMem = 0;
								vrd = 0;
								vrs = 0;
								vrm = 0;
								vinm = 0;
								vFunc = 0;
								vPCSource = 0;
								vRegWrite = 0;
								vAluSrc=0;
							end
					endcase
				end
			end
					
endmodule
							
									