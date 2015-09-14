module MUX_RESULTADO(entrada_ULA, entrada_MD, saida_Mux, controle);
  input controle;
  input [15:0] entrada_ULA, entrada_MD; 
  output reg [15:0] saida_Mux; 
  
 	always_comb 
	begin
		if(controle == 1'b0) // Seleciona entrada Banco de Registros
		  saida_Mux = entrada_ULA;
		else if(controle == 1'b1) // Seleciona entrada Memoria de Dados
		  saida_Mux = entrada_MD;	
	end
endmodule
