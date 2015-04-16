/*
* @author Patricia Gomes
* @author Kelvin Carmo
* Module: Banco_Registro
* Purpose: Modulo responsável por armazenar os registros.
*/
	
module BR (
  Hab_Escrita, // Habilita a escrita no registrador
  Sel_SA,    	// Endereco da saida de dados A
  Sel_SB,      // Endereco da saida de dados B
  Sel_SC,		// Endereco de entrada de dados C
  reset,       // Limpa todos os registros 
  clock,       // Pulso de clock
  A,           // Saida A do Banco de Registros
  B,           // Saida B do Banco de Registros
  E
  );          // Entrada E do Banco de Registros - novo registro a ser armazenado
  
  parameter bits_palavra = 16;
  parameter end_registros = 2; // Quantidade de bits necessários para endereçar os registros
  parameter num_registros = 4; // Quantidade de registros do Banco de Registros (num_registros = (end_registros^2)-1;)
  
  output reg [bits_palavra-1:0] A, B;
  input [bits_palavra-1:0] E;
  input [end_registros-1:0] Sel_SA, Sel_SB, Sel_SC; 
  input Hab_Escrita, reset, clock;

  reg [bits_palavra-1:0] registro [num_registros-1:0];	// Um vetor de "end_registros" palavras de "bits_palavra" bits
	
	initial // Inicializa os registradores.
			begin
				registro[0] <= 16'b0000000000000001;
				registro[1] <= 16'b0000000000000001;
				registro[2] <= 16'b0000000000000000;
				registro[3] <= 16'b0000000000000000;
			end
	
	always_comb 
	begin   
		A = registro[Sel_SA];// Coloca na saída o dado do registrador informado pela entrada Sel_E_SA
		B = registro[Sel_SB];// Coloca na saída o dado do registrador informado pela entrada Sel_SB
	end

	always@(posedge clock, posedge reset) 
		begin
			if(reset) //Reset assíncrono
				begin 
					registro[0] = 16'b0000000000000000;
					registro[1] = 16'b0000000000000000;
					registro[2] = 16'b0000000000000000;
					registro[3] = 16'b0000000000000000;
				end
			else if(Hab_Escrita) // Se a escrita estiver habilitada
				registro[Sel_SC] <= E; // Escreve o dado no registrador de acordo com o endereço informado pela entrada "Sel_E_SA"
		end
	 
endmodule