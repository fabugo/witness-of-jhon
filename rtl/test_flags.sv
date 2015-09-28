module test_flags(opcode, condicao, flags, saida_mux);

	input reg opcode; /* só 1 bit, pra dizer se é jfalse ou jtrue , sinal que vem da UC.
	1 => true 0 => false*/
	input reg [3:0] flags; // Z = 0; C = 1; S = 2; O = 3
	input reg [3:0] condicao;// sinal de controle que vem da UC.
	output reg saida_mux; 
	
	
	always_comb
	
	case (condicao)
	
		4'b0100: begin  // resultado da ALU deu negativo
						if (opcode)begin//jtrue
							if(flags[2]) saida_mux = 1'b1;
							else saida_mux = 1'b0;
						end
						else begin//jfalse
							if (flags[2]) saida_mux = 1'b0;
							else saida_mux = 1'b1;
						end
					end

		4'b0101:	begin //Resultado ALU zero
						if (opcode)begin//jtrue
							if(flags[0]) saida_mux = 1'b1;
							else saida_mux = 1'b0;
						end
						else begin//jfalse
							if (flags[0]) saida_mux = 1'b0;
							else saida_mux = 1'b1;
						end
					end

		4'b0110: begin //Carry da ALU
						if (opcode)begin//jtrue
							if(flags[1]) saida_mux = 1'b1;
							else saida_mux = 1'b0;
						end
						else begin//jfalse
							if (flags[1]) saida_mux = 1'b0;
							else saida_mux = 1'b1;
						end
					end

		4'b0111:	begin //Resultado ALU negativo ou zero
						if (opcode)begin//jtrue
							if(flags[0] || flags[2]) saida_mux = 1'b1;
							else saida_mux = 1'b0;
						end
						else begin//jfalse
							if (flags[0] || flags[2]) saida_mux = 1'b0;
							else saida_mux = 1'b1;
						end
					end

		4'b0000: begin //Resultado ALU diferente de zero
						if (opcode)begin//jtrue
							if(!flags[0]) saida_mux = 1'b1;
							else saida_mux = 1'b0;
						end
						else begin//jfalse
							if (!flags[0]) saida_mux = 1'b0;
							else saida_mux = 1'b1;
						end
					end

		4'b0011:	begin //Resultado ALU overflow
						if (opcode)begin//jtrue
							if(flags[3]) saida_mux = 1'b1;
							else saida_mux = 1'b0;
						end
						else begin//jfalse
							if (flags[3]) saida_mux = 1'b0;
							else saida_mux = 1'b1;
						end
					end

		4'b1111:	begin // Não fazer nada
						saida_mux = 1'b0;
					end


		default: begin
						saida_mux = 1'b0;
					end
	endcase
endmodule