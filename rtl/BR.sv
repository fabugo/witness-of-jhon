/*
* @author Patricia Gomes
* @author Kelvin Carmo
* Module: Banco_Registro
* Purpose: Modulo respons�vel por armazenar os registros.
*/
	
module Banco_Registro (
  Hab_Escrita, // Habilita a escrita no registrador
  Sel_E_SA,    // Endereco da entrada de dados e da saida de dados A, sua fun��o depende do estado de "Hab_Escrita"
  Sel_SB,      // Endereco da saida de dados B
  reset,       // Limpa todos os registros 
  clock,       // Pulso de clock
  A,           // Saida A do Banco de Registros
  B,           // Saida B do Banco de Registros
  E);          // Entrada E do Banco de Registros - novo registro a ser armazenado
  
  parameter bits_palavra = 16;
  parameter end_registros = 2; // Quantidade de bits necess�rios para endere�ar os registros
  parameter num_registros = 4; // Quantidade de registros do Banco de Registros (num_registros = (end_registros^2)-1;)
  
  output reg [bits_palavra-1:0] A, B;
  input [bits_palavra-1:0] E;
  input [end_registros-1:0] Sel_E_SA, Sel_SB; 
  input Hab_Escrita, reset, clock;
  
  reg [bits_palavra-1:0] registro [num_registros-1:0];	// Um vetor de "end_registros" palavras de "bits_palavra" bits
	
	initial // Inicializa os registradores. // Remover
			begin
				registro[0] = 16'b0000000000000000;
				registro[1] = 16'b0000000000000000;
				registro[2] = 16'b0000000000000000;
				registro[3] = 16'b0000000000000000;
			end
	
	always_comb 
	begin
		if(!Hab_Escrita)             	// Se a escrita n�o estiver habilitada
			A = registro[Sel_E_SA]; 	// Coloca na sa�da o dado do registrador informado pela entrada Sel_E_SA
		B = registro[Sel_SB]; 			// Coloca na sa�da o dado do registrador informado pela entrada Sel_SB
	end

	always@(posedge clock, posedge reset) 
		begin
			if(reset) //Reset ass�ncrono
				begin 
					registro[0] = 16'b0000000000000000;
					registro[1] = 16'b0000000000000000;
					registro[2] = 16'b0000000000000000;
					registro[3] = 16'b0000000000000000;
				end
			else if(Hab_Escrita) // Se a escrita estiver habilitada
				registro[Sel_E_SA] <= E; // Escreve o dado no registrador de acordo com o endere�o informado pela entrada "Sel_E_SA"
		end
	 
endmodule
