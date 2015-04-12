include "..\\rtl\\ULA.sv";
module ula_tb;

	// criando variaveis e instanciando link com variaveis do modulo a ser testado
	logic signed [15:0] opA, opB, resOp;
	logic [4:0] cont;

	ULA bula(.operandoA(opA), .operandoB(opB), .resultadoOp(resOp), .controle(cont));
	integer file;

	initial begin

		file=$fopen("out_tb.txt");
		opA = 16'b000000000000001;
		opB = 16'b000000000000010;
		cont = 5'b00000;

		repeat(32)begin
			//$fmonitor(file, "Operador1: %d Operador2: %d Resultado: %d", opA, opB, resOp);
			case(cont)
				5'b00000: begin 
					$fdisplay(file,"Soma: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp);
				end
				5'b00001: begin 
					$fdisplay(file,"Soma +1: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp);
				end
				5'b00011: begin 
					$fdisplay(file,"Incremento: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b00100: begin 
					$fdisplay(file,"Subtração -1: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b00101: begin 
					$fdisplay(file,"Subtração: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b00110: begin 
					$fdisplay(file,"Decremento: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b01000: begin 
					$fdisplay(file,"Deslocamento Logico Esquerda: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b01001: begin 
					$fdisplay(file,"Deslocamento Aritmetico Direita: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b10000: begin 
					$fdisplay(file,"Zero: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b10001: begin 
					$fdisplay(file,"And: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b10010: begin 
					$fdisplay(file,"And Not A: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b10011: begin 
					$fdisplay(file,"Passar B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b10100: begin 
					$fdisplay(file,"And Not B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b10101: begin 
					$fdisplay(file,"Passar A: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b10110: begin 
					$fdisplay(file,"Xor: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b10111: begin 
					$fdisplay(file,"Or: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b11000: begin 
					$fdisplay(file,"Not A And NOT B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b11001: begin 
					$fdisplay(file,"Xnor: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b11010: begin 
					$fdisplay(file,"Passar Not A: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b11011: begin 
					$fdisplay(file,"Or Not A: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b11100: begin 
					$fdisplay(file,"Passar Not B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b11101: begin 
					$fdisplay(file,"Or Not B: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b11110: begin 
					$fdisplay(file,"Nor: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				5'b11111: begin 
					$fdisplay(file,"Um: ");
					#10// espera o resultado
					$fdisplay(file,"Controle: %b // Operando A: %b // Operando B: %b // Resultado: %b // Flag:  \n",cont,opA,opB,resOp); 
				end
				default: begin 
					$fdisplay(file,"Instrução Invalida:\n");
				end
			endcase
			cont ++;
		end
		$fdisplay(file,"\n\n______________________________________________________________________________________________________\n\n");
		$fclose(file);
	end

endmodule