include "RTL\\ULA_AR.sv";
module ULA_TB;


	reg signed [2:0] operandoA, operandoB, resultadoOp;
	reg [4:0] controle;
	logic Z, C, S, O;

	ULA_AR u(.A(operandoA),.B(operandoB),.OP(controle),.RESU(resultadoOp),.O(O),.C(C),.S(S),.Z(Z));

	initial begin
		controle = 5'b00000;
		#1;
		//Testes de flag
		$display("Adicao simples \n");
		if(controle == 5'b00000) begin
			//testando soma de positivo e negativo sem a presenca de overflow com carry
			operandoA = 3'b001; // operandoA = 1 
			operandoB = 3'b111; // operandoB = -1
			#1;
			if(C != 1 || O != 0 || S != 0 || Z != 1) begin
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 0, Sinal == 0, Zero == 1, Carry == 1");
				$display("Resultado: %b",resultadoOp);				
			end
			//testando como estava sendo feita a escrita do dado
			
			if(resultadoOp != 000) begin
				$display("ERRO, resultadoOp apresentado: %b", resultadoOp);
				$display("----, resultadoOp esperado: 000");
			end
			//#10;
			//teste de overflow com numeros positivos
			operandoA = 3'b010; //opa = 2
			operandoB = 3'b011; //opb = 3
			#1;
			if (O != 1 || C != 0 || Z != 0 || S != 1) begin 
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 1, Sinal == 1, Zero == 0, Carry == 0");
				$display("Resultado: %b",resultadoOp);
			end
			//#10;
			//teste de overflow com numeros negativos
			operandoA = 3'b100; //opA == -4
			operandoB = 3'b111; //opB == -1
			#1;
			if(O != 1 || C != 1 || Z != 0 || S != 0) begin
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 1, Sinal == 0, Zero == 0, Carry == 1");
				$display("Resultado: %b",resultadoOp);
			end
			//#10;
			//mudanca de instrução
			controle = 5'b00001; // adição com incremento
			#1;
		end
		$display("Adicao com incremento \n");
		if(controle == 5'b00001) begin
			//testando soma de possitivo e negativo sem a presença do overflow com carry
			operandoA = 3'b000; //opA = 0
			operandoB = 3'b111; //opB = -1
			#1;
			if(O != 0 || C != 1 || Z != 1 || S != 0) begin
					$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
					$display("----, flags esperadas: Overflow = 0, Sinal == 0, Zero == 1, Carry == 1");
					$display("Resultado: %b",resultadoOp);
				end
			//teste de overflow com numeros positivos
			operandoA = 3'b001; //opA = 1
			operandoB = 3'b010; //opB = 2
			#1;
			if (O != 1 || C != 0 || Z != 0 || S != 1) begin 
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 1, Sinal == 1, Zero == 0, Carry == 0");
				$display("Resultado: %b",resultadoOp);
			end
			//teste de overflow com numeros negativos com overflow e carry
			operandoA = 3'b110; //opA == -2
			operandoB = 3'b110; //opB == -2
			#1;
			if(O != 0 || C != 1 || Z != 0 || S != 1) begin
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 0, Sinal == 1, Zero == 0, Carry == 1");
				$display("Resultado: %b",resultadoOp);
			end
			//teste de overflow com numeros positivos e negativos e carry
			operandoA = 3'b100; //opA == -4
			operandoB = 3'b111; //opB == -1
			#1;
			if(O != 0 || C != 1 || Z != 0 || S != 1) begin
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 0, Sinal == 1, Zero == 0, Carry == 1");
				$display("Resultado: %b",resultadoOp);
			end

			//mudando de instrucao
			controle = 5'b00011; //incremento
			#1;
		end
		$display("Incremento \n");
		if(controle == 5'b00011) begin
			//testando incremento com overflow
			operandoA = 3'b011; //opA = 3
			#1;
			if(O != 1 || C != 0 || Z != 0 || S != 1) begin
					$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
					$display("----, flags esperadas: Overflow = 1, Sinal == 1, Zero == 0, Carry == 0");
					$display("Resultado: %b",resultadoOp);
				end
			//testando incremento de negativo com a presença do overflow e carry
			operandoA = 3'b111; //opA = -1
			#1;
			if(O != 0 || C != 1 || Z != 1 || S != 0) begin
					$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
					$display("----, flags esperadas: Overflow = 0, Sinal == 0, Zero == 1, Carry == 1");
					$display("Resultado: %b",resultadoOp);
				end
			//mudando de instrucao
			controle = 5'b00100; //subtracao com decremento
		end
		$display("Subtracao com decremento \n");
		if(controle == 5'b00100) begin
			//testando subtracao de negativos sem a presença do overflow com carry
			operandoA = 3'b110; //opA = -2
			operandoB = 3'b101; //opB = -3
			#1;
			if(O != 0 || C != 1 || Z != 0 || S != 0) begin
					$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
					$display("----, flags esperadas: Overflow = 0, Sinal == 0, Zero == 0, Carry == 1");
					$display("Resultado: %b",resultadoOp);
				end
			//teste de subtracao e decremento com numeros positivos
			operandoA = 3'b011; //opA = 3
			operandoB = 3'b001; //opB = 1
			#1;
			if (O != 0 || C != 1 || Z != 0 || S != 0) begin 
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 0, Sinal == 0, Zero == 0, Carry == 1");
				$display("Resultado: %b",resultadoOp);
			end
			else begin
				$display("Subtracao e decremento de 3 com 1 realizada com sucesso \n");
			end
			//teste de subtracao com decremento de numeros negativos e positivos com overflow e carry
			operandoA = 3'b110; //opA == -3
			operandoB = 3'b010; //opB == 2
			#1;
			if(O != 1 || C != 0 || Z != 0 || S != 0) begin
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 1, Sinal == 0, Zero == 0, Carry == 0");
				$display("Resultado: %b",resultadoOp);
			end
			//teste de subtracao com decremento de numeros positivos e negativos gerando overflow
			operandoA = 3'b010; //opA == 2
			operandoB = 3'b110; //opB == -3
			#1;
			if(O != 1 || C != 1 || Z != 0 || S != 0) begin
				$display("ERRO, flags apresentadas: (Overflow) %b, (Sinal) %b, (Zero) %b, (Carry) %b", O, S, Z, C);
				$display("----, flags esperadas: Overflow = 1, Sinal == 0, Zero == 0, Carry == 1");
				$display("Resultado: %b",resultadoOp);
			end

			//mudando de instrucao
			//controle = 5'b01000; //deslocamento logico a esquerda
			//#10;
		end

		//TESTES DE RESULTADOS
		controle = 5'b00000; //SOMA
		$display("Testando resultado das somas \n",);
		if(controle == 5'b00000) begin
			operandoA = 3'b001; //opa = 1
			operandoB = 3'b010; //opb = 2
			#1;
			if (resultadoOp != 3'b011) begin
					$display("ERRO na SOMA, resultado apresentado: %b", resultadoOp);
					$display("----, resutaldo esperado: 011");
				end
			else begin
				$display("soma entre 1 e 2 correta");
			end
			operandoA = 3'b111; //opa = -1
			operandoB = 3'b000; //opb = 0
			#1;
			if (resultadoOp != 3'b111) begin
					$display("ERRO na SOMA, resultado apresentado: %b", resultadoOp);
					$display("----, resutaldo esperado: 111");
				end
			else begin
				$display("soma entre -1 e 0 correta");
			end

			//soma com flag de carry ativada, deu erro, escopo errado
			operandoA = 3'b111; //opa = -1
			operandoB = 3'b110; //opb = -2
			#1;
			if (resultadoOp != 3'b101) begin
					$display("ERRO na SOMA, resultado apresentado: %b", resultadoOp);
					$display("----, resutaldo esperado: 101");
				end
			else begin
				$display("soma entre -1 e -2 correta");
			end


		end
		//FIM TESTES ARITMETICOS

	end
	
endmodule
