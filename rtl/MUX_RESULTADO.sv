module MUX_RESULTADO(entrada_ULA, entrada_MD, entrada_PC, saida_Mux, controle);
  input controle;
  input [15:0] entrada_ULA, entrada_MD, entrada_PC; 
  output reg [15:0] saida_Mux; 
  
 	always_comb 
	begin
		if(controle == 2'b00) // Seleciona entrada Banco de Registros
		  saida_Mux = entrada_ULA;
		else if(controle == 2'b01) // Seleciona entrada Memoria de Dados
		  saida_Mux = entrada_MD;	
		else if(controle == 2'b10) // Seleciona o Pc
		  saida_Mux = entrada_PC;	

	end
endmodule
