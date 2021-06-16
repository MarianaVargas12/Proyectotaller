module ALU #(parameter N=5) 
	(input logic[N-1:0] a, b,input logic[3:0] s,output logic[N-1:0] out, output logic [3:0] flags);
	
	logic [N-1:0] sumresO;
	logic cout;
	
	
	//Arithmethics
	sumador_restador #(N) srAlu(a,b,s,sumresO,flagC);
	
	//Flags
	flagN #(N) fN(s,sumresO,a*b,a/b,flagN);
	flagZ #(N) fZ(s,sumresO,a*b,a/b,a%b,flagZ);
	
	flagO #(N) fO(a,b,sumresO,s,foaux,flagO);
	
	 always @*
		begin
			case(s)
				4'b0100 : 
					out = sumresO;//Suma
				4'b1010 : 
					out = a&b;//and
				4'b0001 : 
					out = a^b;//xor
				4'b1000 : 
					out = a<<1;//ShiftL
				4'b1001 : 
					out = a>>1;//ShiftR
				default:
					out= 0;
			endcase
		end
		assign flags = {flagN, flagZ, flagC, flagO};
endmodule 