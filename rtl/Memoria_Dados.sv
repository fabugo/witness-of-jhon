module Memoria_Dados (
  Hab_Escrita, 
  endereco,    
  Entrada, 
  Saida,  
  reset,        
  clock      
  );          
  
  parameter bits_palavra = 16;
  parameter end_registros = 16; 
  parameter num_registros = 16; 
  
  input reset, clock;
  input reg Hab_Escrita;
  input [bits_palavra-1:0] Entrada;
  input reg [end_registros-1:0] endereco; 
  output reg [bits_palavra-1:0] Saida;

  reg [bits_palavra-1:0] dado_mem [0:(2**num_registros)-1] ;	
	
	
	always @(posedge clock, posedge reset) begin
		if(reset) begin 
			for(int i=0; i<((2**num_registros)-1); i++)
				dado_mem[i] = 1'd0;
		end 
		else if(Hab_Escrita) begin 
			dado_mem[endereco] = Entrada; 
			Saida = dado_mem[endereco];
		end 
		
		Saida = dado_mem[endereco]; 
	end
	
endmodule
