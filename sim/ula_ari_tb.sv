include "..\\rtl\\ULA.sv";
module ula_ari_tb;

	logic signed [bits_palavra-1:0] opA, opB, resOp;
	logic [4:0] cont;
	logic Z, C, S, O;
	
	// criando conexao com o modulo incluido
	ULA bula(.operandoA(opA), .operandoB(opB), .resultadoOp(resOp), .controle(cont), .Z(Z), .C(C), .S(S), .O(O));

	initial begin

		case(cont)
			5'b00000: begin 
				
			end
			5'b00001: begin 
				
			end
			5'b00011: begin 
				
			end
			5'b00100: begin 
				
			end
			5'b00101: begin 
				
			end
			5'b00110: begin 
				
			end
		endcase
	end
endmodule
