module test_flags(opcode, condicao, flags, saida_mux);

	input reg opcode; /* 1 bit para indicar se é jtrue ou jfalse [ 1 = true ; 0=false].
	1 => true 0 => false*/
	input reg [3:0] flags; // Z = 0; C = 1; S = 2; O = 3
	input reg [3:0] condicao;// sinal de controle que vem da UC.
	output reg saida_mux; 
	
	
	always_comb
	
		case (condicao)
	
		4'b0100: begin  // resultado da ALU deu negativo
						saida_mux = opcode ~^ flags[2];
					end
					
		4'b0101:	begin //Resultado ALU zero
						saida_mux = opcode ~^ flags[0];
					end

		4'b0110: begin //Carry da ALU
						saida_mux = opcode ~^ flags[1];
					end

		4'b0111:	begin //Resultado ALU negativo ou zero
						saida_mux = (opcode ~^ flags[2]) | (opcode ~^ flags[0]) ;
					end

		4'b0000: begin //Resultado ALU diferente de zero
						saida_mux = opcode ^ flags[0];
					end

		4'b0011:	begin //Resultado ALU overflow
						saida_mux = opcode ~^ flags[3];
					end

		4'b1111:	begin // Não fazer nada
						saida_mux = 1'b0;
					end
					
		4'b1100: begin //Para instruções de salto incondicional, jlink e jregister ;
						saida_mux = 1'b1;
					end

		default: begin
						saida_mux = 1'b0;
					end
	endcase
	
endmodule