/*
* @author Jussara Gomes
* Module: RE
* Purpose: Modulo responsável por armazenar o estados das Flag's.
*/
module Registrador_Flags(Z, C, S, O, controleOperacao, ZCSO, clock, reset);

	input reg Z, C, S, O; 			// Flag Zero 0| Flag Carry 1| Flag Sinal 2| Flag Overflow 3 
	input [4:0] controleOperacao;   // Controle RE - Enable Específico: [Z][C][S][O]
	output reg [3:0] ZCSO;          // Saída das flags
	input clock, reset;
	
always @(negedge clock or posedge reset or controleOperacao)
	begin
		if(reset) begin
			ZCSO[0] = 1'b0;
			ZCSO[1] = 1'b0;
			ZCSO[2] = 1'b0;
			ZCSO[3] = 1'b0;
		end
	
		case(controleOperacao)

			5'b01000, 5'b01001: begin // Flag's atualizadas: S, C, Z
				ZCSO[0] = Z;
				ZCSO[1] = C;
				ZCSO[2] = S;
				end
				
			5'b10001, 5'b10010: begin // Flag's atualizadas: Z, S
				ZCSO[0] = Z;
				ZCSO[2] = S;	
				end
				
			5'b00000, 5'b00001,
			5'b00011, 5'b00100,
			5'b00101, 5'b00110: begin // Flag's atualizadas: Todas
				ZCSO[0] = Z;
				ZCSO[1] = C;
				ZCSO[2] = S;	
				ZCSO[3] = O;	
				end
				
			5'b10001, 5'b10010, 
			5'b10100, 5'b10101, 
			5'b10110, 5'b10111, 
			5'b11000, 5'b11001, 
			5'b11010, 5'b11011, 
			5'b11100, 5'b11101, 
			5'b11110: begin // Flag's atualizadas: Z, S
				ZCSO[0] = Z;	
				ZCSO[2] = S;	
				end
				
			default: begin end // Flag's atualizadas: Nenhuma
		endcase
	end
endmodule 