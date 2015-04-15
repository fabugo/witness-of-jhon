module ULA(operandoA, operandoB, resultadoOp, controle, Z, C, S, O);
  
    parameter bits_palavra = 16;
    parameter bits_controle = 5;
    
		input signed [bits_controle-1:0] controle;
		input signed [bits_palavra-1:0] operandoA, operandoB;
		output reg signed [bits_palavra-1:0] resultadoOp;
		
		reg signed [bits_palavra:0] aux_resultadoOp;
		
		output reg Z, // Zero - (Este bit fica a 1 quando o resultado da operação for 0)
		           C, // Carry - (Indicar que há um bit de transporte) 
		              // Em qualquer das formas de deslocamento o bit de estado transporte recebe o bit que se perde com o deslocamento, o bit mais
                  	  // significativo do operando no caso de deslocamentos à esquerda, ou o bit menos significativo nos deslocamentos à direita.
		           S, // Sinal - (O bit mais significativo do resultado. Este bit indica quando o resultado deu negativo)
		           O; // Overflow (Quando o Bit de sinal muda, ocorre sempre quando A e B tem mesmo sinal)
		
				
		always @(operandoA or operandoB or controle) 
		begin 
		  
			case(controle)
			5'b00000: begin // 00000 C = A + B
				aux_resultadoOp = operandoA + operandoB;
				
				if(aux_resultadoOp[])
				O = aux_resultadoOp[15];
			   
				resultadoOp = { aux_resultadoOp[16] , aux_resultadoOp [14:0]};
			   
			   
			   if(operandoA[15] == operandoA[15])
			     if(resultadoOp[15] != operandoA[15])
			       C = 1'b0;  
			       
			end
				
			5'b00001: begin // 00001 C = A + B + 1
			   aux_resultadoOp = operandoA + operandoB + 1;			
			   
			   O = aux_resultadoOp[15];
			   
			   resultadoOp = { aux_resultadoOp[16] , aux_resultadoOp [14:0]};
			   
			   
			   if(operandoA[15] == operandoA[15])
			     if(resultadoOp[15] != operandoA[15])
			       C = 1'b0;  
			end
				
			5'b00011: begin // 00011 C = A + 1
			   aux_resultadoOp = operandoA + 1;
			   
			   O = aux_resultadoOp[15];
			   
			   resultadoOp = { aux_resultadoOp[16] , aux_resultadoOp [14:0]};
			   
			   
			   if(operandoA[15] == operandoA[15])
			     if(resultadoOp[15] != operandoA[15])
			       C = 1'b0;  
			end
				
			5'b00100: begin // 00100 C = A - B - 1 **********************************************
			   aux_resultadoOp = operandoA - operandoB - 1;
			   
			   if((aux_resultadoOp < -32768) || (aux_resultadoOp > 32767))
			     O = 1'b0;
			   
			   resultadoOp = { aux_resultadoOp[16] , aux_resultadoOp [14:0]};
			end
				
			5'b00101: begin // 00101 C = A - B ********************************************
			   aux_resultadoOp = operandoA - operandoB;
			   
			   if((aux_resultadoOp < -32768) || (aux_resultadoOp > 32767))
			     O = 1'b0;
			   
			   resultadoOp = { aux_resultadoOp[16] , aux_resultadoOp [14:0]};
			end
				
			5'b00110: begin // 00110 C = A - 1  ****************************************
			   aux_resultadoOp = operandoA - 1;
			   
			   if((aux_resultadoOp < -32768) || (aux_resultadoOp > 32767))
			     O = 1'b0;
			   
			   resultadoOp = { aux_resultadoOp[16] , aux_resultadoOp [14:0]};
			end
				
			5'b01000: begin // 01000 C = Deslocamento Lógico Esq. (A)
			   C = operandoA[16]; // Assume o bit mais significativo (perdido depois do deslocamento)
			   resultadoOp = operandoA << 1;
			end
				
			5'b01001: begin // 01001 C = Deslocamento Aritmético Dir. (A)
			   C = operandoA[0]; // Assume o bit menos significativo (perdido depois do deslocamento)
			   resultadoOp = operandoA >>> 1;
			end
							
			5'b10000: begin // 10000 C = 0 
			   resultadoOp = 0;
			end
				
			5'b10001: begin // 10001 C = A&B
			   resultadoOp = operandoA & operandoB;
			end
				
			5'b10010: begin // 10010 C = ~A&B
			   resultadoOp = (~operandoA) & operandoB;			
			end
				
			5'b10011: begin // 10011 C = B
			   resultadoOp = operandoB;
			end
				
			5'b10100: begin // 10100 C = A&~B
			   resultadoOp = operandoA & (~operandoB);
			end
				
			5'b10101: begin // 10101 C = A
			   resultadoOp = operandoA; 
			end
				
			5'b10110: begin // 10110 C = A xor B 
			   resultadoOp = operandoA ^ operandoB;
			end
				
			5'b10111: begin // 10111 C = A | B
			   resultadoOp = operandoA | operandoB;
			end
				
			5'b11000: begin // 11000 C = ~A&~B
			   resultadoOp = (~operandoA) & (~operandoB);
			end
				
			5'b11001: begin // 11001 C = ~(A xor B) 
			   resultadoOp = ~(operandoA ^ operandoB);
			end
				
			5'b11010: begin // 11010 C = ~A
			   resultadoOp = (~operandoA);
			end
				
			5'b11011: begin // 11011 C = ~A|B
			   resultadoOp = (~operandoA) | (operandoB);
			end
				
			5'b11100: begin // 11100 C = ~B
			   resultadoOp = (~operandoB);
			end
				
			5'b11101: begin // 11101 C = A|~B
			   resultadoOp = operandoA | (~operandoB);
			end
				 
			5'b11110: begin // 11110 C = ~A|~B
			   resultadoOp = (~operandoA) | (~operandoB);
			end
				
			5'b11111: begin // 11111 C = 1
			   resultadoOp = 1;
			end
				
			default: begin
			   resultadoOp = 0;
			end
			endcase // fim do case
			
			
			// *** Eu quero deslocar um número com sinal, há diferença entre deslocar um número com sinal e deslocar um número sem sinal?	
			
			S = resultadoOp[15]; // Sinal -  Atualiza o bit de sinal, se o bit for 0, o resultado da operação foi positiva, se o bit for 1 o resultado foi negativo
			
			if(resultadoOp == 0) // Zero - Verifica se o resultado da operação foi 0
			  Z = 1'b0;
			
			
		end
endmodule
