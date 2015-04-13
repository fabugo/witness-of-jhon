include "..\\rtl\\ULA.sv";

module ula_tb;
    parameter bits_palavra = 16;

	// criando variaveis
	logic signed [bits_palavra-1:0] opA, opB, resOp;
	logic [4:0] cont;
	logic Z, C, S, O;
	integer file, max = 2;

	// criando conexao com o modulo incluido
	ULA bula(.operandoA(opA), .operandoB(opB), .resultadoOp(resOp), .controle(cont), .Z(Z), .C(C), .S(S), .O(O));
	
	initial begin
		// definir, de acordo com o parametro o valor maximo
		repeat (bits_palavra-1) begin
			max = max * 2;
		end

		// abrindo arquivo e iniciando o controle
		file=$fopen("out_tb.txt");
		cont = 5'b00000;

		// laco para operar todas as possiveis operacoes
		repeat(32)begin
			// define numeros aleatorio de acordo com o valor maximo definido pelo parametro
			opA = $random % max;
			opB = $random % max;

			case(cont)
				5'b00000: begin 
					$fdisplay(file,"Soma: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O);
				end
				5'b00001: begin 
					$fdisplay(file,"Soma +1: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O);
				end
				5'b00011: begin 
					$fdisplay(file,"Incremento: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b00100: begin 
					$fdisplay(file,"Subtração -1: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b00101: begin 
					$fdisplay(file,"Subtração: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b00110: begin 
					$fdisplay(file,"Decremento: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b01000: begin 
					$fdisplay(file,"Deslocamento Logico Esquerda: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b01001: begin 
					$fdisplay(file,"Deslocamento Aritmetico Direita: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b10000: begin 
					$fdisplay(file,"Zero: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b10001: begin 
					$fdisplay(file,"And: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b10010: begin 
					$fdisplay(file,"And Not A: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b10011: begin 
					$fdisplay(file,"Passar B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b10100: begin 
					$fdisplay(file,"And Not B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b10101: begin 
					$fdisplay(file,"Passar A: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b10110: begin 
					$fdisplay(file,"Xor: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b10111: begin 
					$fdisplay(file,"Or: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b11000: begin 
					$fdisplay(file,"Not A And NOT B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b11001: begin 
					$fdisplay(file,"Xnor: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b11010: begin 
					$fdisplay(file,"Passar Not A: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b11011: begin 
					$fdisplay(file,"Or Not A: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b11100: begin 
					$fdisplay(file,"Passar Not B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b11101: begin 
					$fdisplay(file,"Or Not B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b11110: begin 
					$fdisplay(file,"Nor: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				5'b11111: begin 
					$fdisplay(file,"Um: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag: %b,%b,%b,%b\n",cont,opA,opB,resOp,Z,C,S,O); 
				end
				default: begin end
			endcase
			cont ++;
		end
		$fdisplay(file,"__________________________________________________________________________________________________________________________\n\n\n");
		$fclose(file);
	end

endmodule