/*
* @author Fabio
* @author Jussara 
* @author Pedro 
* Module: ULA
* Purpose: Modulo responsavel por realizar as operacoes logicas, aritmeticas e de deslocamento. Parte no projeto da unidade micro processada. 
*/

module ULA(operandoA, operandoB, resultadoOp, controle, Z, C, S, O);
  
    parameter bits_palavra = 16;
    
	input signed [4:0] controle; // [00000 - 11111]
	input signed [bits_palavra-1:0] operandoA, operandoB; // [15] -> bit de sinal e [14:0] -> valor (de -32768 � 32767)
	output reg signed [bits_palavra-1:0] resultadoOp; // [15] -> bit de sinal e [14:0] -> valor (de -32768 � 32767)

	logic signed [bits_palavra:0] aux_resultadoOp; // [16]-> carry out e [15]-> sinal (utilizado para detectar overflow) [14:0]-> valor
	
	output reg Z, 	// Zero - (Este bit fica a 1 quando o resultado da opera��o for 0)
	           C, 	/* Carry - (Indicar que h� um bit de transporte) 
	              	Em qualquer das formas de deslocamento o bit de estado transporte recebe o bit que se perde com o deslocamento, o bit mais
	              	significativo do operando no caso de deslocamentos � esquerda, ou o bit menos significativo nos deslocamentos � direita.
          			*/ 
	           S, 	// Sinal - (O bit mais significativo do resultado. Este bit indica o sinal do resultado)
	           O; 	// Overflow - (Quando o resultado tem uma magnitude que excede o valor alterando o bit de sinal)
	logic [1:0] flags;
				
	always @(operandoA or operandoB or controle) begin

		case(controle)
			5'b00000: begin // 00000 C = A + B
			   	aux_resultadoOp = operandoA + operandoB;
			   	resultadoOp = aux_resultadoOp;
				flags = 2'b11;
	  		end 
			5'b00001: begin // 00001 C = A + B + 1
			   	aux_resultadoOp = operandoA + operandoB + 1;
			   	resultadoOp = aux_resultadoOp;
				flags = 2'b11;		
		   	end
			5'b00011: begin // 00011 C = A + 1
			   	aux_resultadoOp = operandoA + 1;
				flags = 2'b11;
		  	end 
			5'b00100: begin // 00100 C = A - B - 1 
			   	aux_resultadoOp = operandoA - operandoB - 1;
			   	resultadoOp = aux_resultadoOp;
				flags = 2'b11;
		 	end  
			5'b00101: begin // 00101 C = A - B 
			   	aux_resultadoOp = operandoA - operandoB;
			   	resultadoOp = aux_resultadoOp;
				flags = 2'b11;
		  	end 
			5'b00110: begin // 00110 C = A - 1  
			   	aux_resultadoOp = operandoA - 1;
			   	resultadoOp = aux_resultadoOp;
				flags = 2'b11;
		   	end
			5'b01000: begin // 01000 C = Deslocamento L�gico Esq. (A)
			   	aux_resultadoOp = operandoA << 1;
				S = aux_resultadoOp[bits_palavra-1];
				C = aux_resultadoOp[bits_palavra];// Assume o bit mais significativo (perdido depois do deslocamento)
				resultadoOp = aux_resultadoOp;
				flags = 2'b10;
			end
			5'b01001: begin // 01001 C = Deslocamento Aritm�tico Dir. (A)
			   	resultadoOp = operandoA >>> 1;
				resultadoOp[bits_palavra-1] = operandoA[bits_palavra-1];
				C = operandoA[0];// Assume o bit menos significativo (perdido depois do deslocamento)
				flags = 2'b10;
			end		
			5'b10000: begin // 10000 C = 0 
			   	resultadoOp = 0;
				flags = 2'b00;
			end
			5'b10001: begin // 10001 C = A&B
			   	resultadoOp = operandoA & operandoB;
			   	flags = 2'b10;
			end
			5'b10010: begin // 10010 C = ~A&B
			   	resultadoOp = (~operandoA) & operandoB;
			   	flags = 2'b10;	
			end
			5'b10011: begin // 10011 C = B
			   	resultadoOp = operandoB;
			   	flags = 2'b00;
			end
			5'b10100: begin // 10100 C = A&~B
			   	resultadoOp = operandoA & (~operandoB);
			   	flags = 2'b10;
			end
			5'b10101: begin // 10101 C = A
			   	resultadoOp = operandoA;
			   	flags = 2'b10;
			end
			5'b10110: begin // 10110 C = A xor B 
			   	resultadoOp = operandoA ^ operandoB;
			   	flags = 2'b10;
			end
			5'b10111: begin // 10111 C = A | B
			   	resultadoOp = operandoA | operandoB;
			   	flags = 2'b10;
			end
			5'b11000: begin // 11000 C = ~A&~B
			   	resultadoOp = (~operandoA) & (~operandoB);
			   	flags = 2'b10;
			end
			5'b11001: begin // 11001 C = ~(A xor B) 
			   	resultadoOp = ~(operandoA ^ operandoB);
			   	flags = 2'b10;
			end
			5'b11010: begin // 11010 C = ~A
			   	resultadoOp = (~operandoA);
			   	flags = 2'b10;
			end
			5'b11011: begin // 11011 C = ~A|B
			   	resultadoOp = (~operandoA) | (operandoB);
			   	flags = 2'b10;
			end
			5'b11100: begin // 11100 C = ~B
			   	resultadoOp = (~operandoB);
			   	flags = 2'b10;
			end
			5'b11101: begin // 11101 C = A|~B
			   	resultadoOp = operandoA | (~operandoB);
			   	flags = 2'b10;
			end
			5'b11110: begin // 11110 C = ~A|~B
			   	resultadoOp = (~operandoA) | (~operandoB);
			   	flags = 2'b10;
			end
			5'b11111: begin // 11111 C = 1
			   	resultadoOp = 1;
			   	flags = 2'b00;
			end
			default: begin
				resultadoOp = controle;
			end
		endcase // fim do case
		case (flags)
			2'b11: begin //todas
				if(!resultadoOp)
					Z = 1;
				else
					Z = 0;
				if((operandoA[bits_palavra-1] == operandoB[bits_palavra-1]) && (operandoA[bits_palavra-1] != resultadoOp[bits_palavra-1]))
					O = 1;
				else
					O = 0;
				C = aux_resultadoOp[bits_palavra];
				S = resultadoOp[bits_palavra-1];
			end
			2'b10: begin //S,C,Z
				if(!resultadoOp)
					Z = 1;
				else
					Z = 0;
			end
			2'b10: begin //S,Z
				if(!resultadoOp)
					Z = 1;
				else
					Z = 0;
				S = resultadoOp[bits_palavra-1];
			end
			default :;
		endcase
	end
endmodule