module MUX_RESULTADO(entrada_ULA, entrada_MD, saida_Mux, controle, entrada_PC);
  input [1:0] controle;
  input [15:0] entrada_ULA, entrada_MD, entrada_PC; 
  output reg [15:0] saida_Mux; 
  
 	always_comb 
	begin
		case(controle)
			2'b00: saida_Mux = entrada_ULA; // Seleciona entrada Banco de Registros
			2'b01: saida_Mux = entrada_MD;  // Seleciona entrada Memoria de Dados
			2'b10: saida_Mux = entrada_PC;  // Seleciona entrada PC 
			default: begin end
		endcase
	
	end
endmodule
