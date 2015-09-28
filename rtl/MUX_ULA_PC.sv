module MUX_ULA_PC(entrada_BR, entrada_PC, saida_Mux, controle);
  input controle;
  input [15:0] entrada_BR, entrada_PC; 
  output reg [15:0] saida_Mux; 
  
 	always_comb 
	begin
		if(controle == 1'b1) // Seleciona entrada Banco de Registros
		  saida_Mux = entrada_BR;
		else if(controle == 1'b0) // Seleciona entrada PC
		  saida_Mux = entrada_PC;	
	end
endmodule
