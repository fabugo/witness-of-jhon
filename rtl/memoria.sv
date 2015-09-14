	 module memoria#( parameter bits=16,tamanho=8)(
	  input write,        //Controle da Memória
	  input clock,                
     input [bits-1:0] dado_in,    //Dado de 16 bits de entrada
     input [bits-1:0] endereco, //Endereço da Memória de 16 bits,
     output reg [bits-1:0] dado_out); //Dado de 16 bits de saída);

     logic [bits -1:0] mem [0:(1 << tamanho) -1]; //Memoria com 2^8 posições e cada uma com 8 bits

     
	  always_comb 
	  dado_out=mem[endereco];
	  
	  
	  always@(posedge clock) begin
      
          if (write) mem[endereco] = dado_in;
        
        

    end //Término do Always

  endmodule //Término do Módulo  