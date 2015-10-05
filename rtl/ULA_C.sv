/*
* @author Fábio
* Module: ULA_C
* Purpose: Ula especial para operacoes com constante. 
*/
module ULA_C (dado, 		// OP_A
			  constante,    // OP_B
			  formato,      // OP
			  R,            // R
			  resultOP);

	parameter bits_palavra = 16;

	input reg [bits_palavra-1:0] constante, dado;
	input reg [1:0] formato; // formato de operação, podendo ser carregar em um determinado byte(11) ou passar valor
	input reg R; // controle para o formato (11) carregar lcl: 0 / lch: 1
	output reg [15:0] resultOP;
	
	reg [15:0] auxxxx;
	
	always @(constante or formato or R) begin
		case (formato)
			2'b01:begin//passa valor para resultado
				resultOP = constante;
			end
			2'b11:begin
				if(R)begin//carrega na direita LCH
					auxxxx = (dado & 16'b0000000011111111) ;
					resultOP = constante | auxxxx; 
				end else begin//carrega na esquerda LCL
					auxxxx = (dado & 16'b1111111100000000) ;
					resultOP = constante | auxxxx;
				end
			end
			default : /* default */;
		endcase
	end
endmodule