/*
* @author Jussara
* Module: SIGEX
* Purpose: Extender a constante de bits inferiores aos da ULA
*/

module SIGEX(palavraEntrada, palavraSaida, controle);
  
		input signed [1:0] controle; 
		input signed [10:0] palavraEntrada;
		output reg signed [15:0]palavraSaida; 
		

				
		always @(controle) 
		begin 
		  
			case(controle)
			2'b00: begin 
			  palavraSaida[31:16] =  {16{palavraEntrada[15]}};
				end
				
			2'b01: begin 
	    palavraSaida = palavraEntrada >> 8;
				end
				
			2'b10: begin 
	    palavraSaida = palavraEntrada << 8;
				end
			
			default: begin
				end
				
			endcase 
		end
endmodule