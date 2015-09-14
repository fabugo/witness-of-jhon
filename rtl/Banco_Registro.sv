/*
* @author Patricia Gomes
* @author Kelvin Carmo
* Module: Banco_Registro
* Purpose: Modulo responsável por armazenar os registros.
*/
	
module Banco_Registro (
  Hab_Escrita, // Habilita a escrita no registrador
  Sel_E_SA,    // Endereco da entrada de dados e da saida de dados A, sua função depende do estado de "Hab_Escrita"
  Sel_SB,      // Endereco da saida de dados B
  reset,       // Limpa todos os registros 
  clock,       // Pulso de clock
  A,           // Saida A do Banco de Registros
  B,           // Saida B do Banco de Registros
  E);          // Entrada E do Banco de Registros - novo registro a ser armazenado
  
  parameter bits_palavra = 16;
  parameter end_registros = 3; // Quantidade de bits necessários para endereçar os registros
  parameter num_registros = 8; // Quantidade de registros do Banco de Registros (num_registros = (end_registros^2)-1;)
  
  output reg [bits_palavra-1:0] A, B;
  input [bits_palavra-1:0] E;
  input reg [2:0] Sel_E_SA, Sel_SB; 
  input reset, clock;
  input reg Hab_Escrita;
  reg [bits_palavra-1:0] registro [num_registros-1:0];	// Um vetor de "num_registros" palavras de "bits_palavra" bits
	
	initial // Inicializa os registradores. // Remover
			begin						
			    registro[0] = 16'b0110101111010101;     
				registro[1] = 16'b0001110111010110;
				registro[2] = 16'b0001010101101011;
				registro[3] = 16'b0010101011011101;
				registro[4] = 16'b0000000000001101;     
				registro[5] = 16'b0000000010101100;
				registro[6] = 16'b0000000000000101;
				registro[7] = 16'b0000000010101011;
			end
	
	
	
	always @(negedge clock, posedge reset) begin
		  
			if(reset) begin 
				registro[0] = 16'b0000000000000000;
				registro[1] = 16'b0000000000000000;
				registro[2] = 16'b0000000000000000;
				registro[3] = 16'b0000000000000000;
				registro[4] = 16'b0000000000000000;
				registro[5] = 16'b0000000000000000;
				registro[6] = 16'b0000000000000000;
				registro[7] = 16'b0000000000000000;
			end
			else if(Hab_Escrita) begin 
				registro[Sel_E_SA] <= E; 
		    end else begin
				A = registro[Sel_E_SA]; 	   
				B = registro[Sel_SB];
			end
		
	end
	
endmodule
