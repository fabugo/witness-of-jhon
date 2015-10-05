<<<<<<< HEAD
module MUX_RESULTADO(entrada_ULA, entrada_MD, saida_Mux, controle, entrada_PC);
  input [1:0] controle;
=======
module MUX_RESULTADO(entrada_ULA, entrada_MD, entrada_PC, saida_Mux, controle);
  input controle;
>>>>>>> origin/jump
  input [15:0] entrada_ULA, entrada_MD, entrada_PC; 
  output reg [15:0] saida_Mux; 
  
 	always_comb 
	begin
<<<<<<< HEAD
		case(controle)
			2'b00: saida_Mux = entrada_ULA; // Seleciona entrada Banco de Registros
			2'b01: saida_Mux = entrada_MD;  // Seleciona entrada Memoria de Dados
			2'b10: saida_Mux = entrada_PC;  // Seleciona entrada PC 
			default: begin end
		endcase
	
=======
		if(controle == 2'b00) // Seleciona entrada Banco de Registros
		  saida_Mux = entrada_ULA;
		else if(controle == 2'b01) // Seleciona entrada Memoria de Dados
		  saida_Mux = entrada_MD;	
		else if(controle == 2'b10) // Seleciona o Pc
		  saida_Mux = entrada_PC;	

>>>>>>> origin/jump
	end
endmodule
