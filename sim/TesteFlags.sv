module TesteFlags();
    parameter n = 57;
    parameter bits = 16;
    logic i = 1;
	reg [7:0] OP;			
	reg signed [bits-1:0] A,B,RESU, RESU_ESP;	
	reg	O,C,S,Z, EO,EC,ES,EZ;					
	integer file, num_acerto=0, num_erro=0;
	
	ULA ULA(.A(A), .B(B), .OP(OP), .RESU(RESU), .O(O), .C(C), .S(S), .Z(Z) );
	
	initial begin
		file = $fopen("TesteFlags.out");
		for (int i = 1; i < n; i++) begin
			#10
			case(i)
			// --------------------------------------------------------------------------
			// Levando em consideração complemento a2
			// Falta Flag Overflow
			1: begin
				// Caso I: Dois números positivos.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 00000; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0100100000000000;
				B = 16'b0010000000000000;
				#50;	
			end
			
			2: begin
				// Caso II: Um número positivo e outro menor e negativo.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 00000; EO = 0; EC = 1; ES = 0; EZ = 0;
				A = 16'b0100100000000000;
				B = 16'b1110000000000000;
				#50;				        
			end       
			
			3: begin
				// Caso III: Um número positivo e outro maior e negativo.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 00000; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1011100000000000;
				B = 16'b0010000000000000;
				#50;	
			end   
			
			4: begin
				// Caso IV: Dois números negativos.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 00000; EO = 0; EC = 1; ES = 1; EZ = 0;
				A = 16'b1011100000000000;
				B = 16'b1110000000000000;
				#50;	
			end 
			
			5: begin
				// Caso V: Dois números iguais em magnetude mas de sinais contrarios.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 00000; EO = 0; EC = 1; ES = 0; EZ = 1;
				A = 16'b1011100000000000;
				B = 16'b0100100000000000;
				#50;	
			end 
			
			// --------------------------------------------------------------------------
			6: begin
				// Caso I: Dois números positivos.
				$fdisplay(file,"OP = 00001 	C = A + B + 1   						todas");
				OP = 00001; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0100100000000000;
				B = 16'b0010000000000000;
				#50;
			end
			
			7: begin
				// Caso II: Um número positivo e outro menor e negativo.
				$fdisplay(file,"OP = 00001 	C = A + B + 1   						todas");		
				OP = 00001; EO = 0; EC = 1; ES = 0; EZ = 0;
				A = 16'b0100100000000000;
				B = 16'b1110000000000000;
				#50;				        
			end 
			
			8: begin
				// Caso III: Um número positivo e outro maior e negativo.
				$fdisplay(file,"OP = 00001 	C = A + B + 1   						todas");	
				OP = 00001; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1011100000000000;
				B = 16'b0010000000000000;
				#50;	
			end   
						
			// --------------------------------------------------------------------------
			9: begin	$fdisplay(file,"OP = 00011 	C = A + 1  								todas"); end
			10: begin	$fdisplay(file,"OP = 00100 	C = A – B – 1   						todas"); end
			11: begin	$fdisplay(file,"OP = 00101 	C = A – B   							todas"); end
			12: begin	$fdisplay(file,"OP = 00110 	C = A – 1   							todas"); end
			13: begin	$fdisplay(file,"OP = 01000 	C = Deslocamento Lógico Esq. (A)   		S, C, Z"); end
			14: begin	$fdisplay(file,"OP = 01001 	C = Deslocamento Aritmético Dir. (A)  	S, C, Z"); end
			// --------------------------------------------------------------------------
			15: begin	
				$fdisplay(file,"OP = 10000 	C = 0    								Z");			
				OP = 10000; EO = 0; EC = 0; ES = 0; EZ = 1;
				#50;
			end	
			// --------------------------------------------------------------------------
			16: begin	
				$fdisplay(file,"OP = 10001 	C = A&B                                 Z, S");			
				OP = 10001; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b1101001101010111;
				#50;
			end
			
			17: begin	
				$fdisplay(file,"OP = 10001 	C = A&B                                 Z, S");	
				OP = 10001; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0010101010101000;
				B = 16'b1101010101010111;
				#50;
			end
			
			18: begin	
				$fdisplay(file,"OP = 10001 	C = A&B                                 Z, S");	
				OP = 10001; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0101010101010101;
				B = 16'b1010101010101010;
				#50;
			end
			
			// --------------------------------------------------------------------------
			19: begin	
				$fdisplay(file,"OP = 10010 	C = !A&B 								Z, S");		
				OP = 10010; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010111001101111;
				B = 16'b0111001101110110;
				#50;
			end
			
			20: begin	
				$fdisplay(file,"OP = 10010 	C = !A&B 								Z, S");
				OP = 10010; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0101101011011101;
				B = 16'b1101101111011101;
				#50;
			end
			
			21: begin	
				$fdisplay(file,"OP = 10010 	C = !A&B 								Z, S");
				OP = 10010; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1111110111011101;
				B = 16'b1110010111011100;
				#50;
			end
			// --------------------------------------------------------------------------
						
			22: begin	
				$fdisplay(file,"OP = 10011 	C = B  									NENHUMA");			
				OP = 10011; EO = 0; EC = 0; ES = 0; EZ = 0;
				B = 16'b0101101011011101;
				#50;
			end
			
			23: begin	
				$fdisplay(file,"OP = 10011 	C = B  									NENHUMA");	
				OP = 10011; EO = 0; EC = 0; ES = 0; EZ = 0;
				B = 16'b0000000000000000;
				#50;
			end
			
			24: begin
				$fdisplay(file,"OP = 10011 	C = B  									NENHUMA");			
				OP = 10011; EO = 0; EC = 0; ES = 0; EZ = 0;
				B = 16'b1111101011011101;
				#50;
			end
			
			// --------------------------------------------------------------------------
			25: begin	
				$fdisplay(file,"OP = 10100 	C = A&!B  								Z, S");			
				OP = 10100; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010111001101111;
				B = 16'b0111001101110110;
				#50;
			end
			
			26: begin	
				$fdisplay(file,"OP = 10100 	C = A&!B  								Z, S");			
				OP = 10100; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0010111001101111;
				B = 16'b0111001101110110;
				#50;
			end
			
			27: begin	
				$fdisplay(file,"OP = 10100 	C = A&!B  								Z, S");	
				OP = 10100; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0101101011011101;
				B = 16'b1101101111011101;
				#50;
			end
			
			// --------------------------------------------------------------------------
			28: begin	
				$fdisplay(file,"OP = 10101 	C = A  									Z, S");			
				OP = 10101; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0101101011011101;
				#50;
			end
			
			29: begin	
				$fdisplay(file,"OP = 10101 	C = A  									Z, S");	
				OP = 10101; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0000000000000000;
				#50;
			end
			
			30: begin
				$fdisplay(file,"OP = 10101 	C = A  									Z, S");			
				OP = 10101; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1111101011011101;
				#50;
			end
			
			// --------------------------------------------------------------------------
			31: begin	
				$fdisplay(file,"OP = 10110 	C = A xor B  							Z, S");				
				OP = 10110; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0010101010111010;
				B = 16'b1101001101010111;
				#50;
			end
			
			32: begin	
				$fdisplay(file,"OP = 10110 	C = A xor B  							Z, S");
				OP = 10110; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010101000;
				B = 16'b1101010101010111;
				#50;
			end
			
			33: begin	
				$fdisplay(file,"OP = 10110 	C = A xor B  							Z, S");
				OP = 10110; EO = 0; EC = 0; ES = 1; EZ =0;
				A = 16'b1010101010101010;
				B = 16'b1010101010101010;
				#50;
			end
			
			// --------------------------------------------------------------------------
			34: begin	
				$fdisplay(file,"OP = 10111 	C = A | B 								Z, S");			
				OP = 10111; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101100011011;
				B = 16'b0010101001010011;
				#50;
			end
			
			35: begin	
				$fdisplay(file,"OP = 10111 	C = A | B 								Z, S");	
				OP = 10111; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010101010;
				B = 16'b0101010101010101;
				#50;
			end
			
			36: begin	
				$fdisplay(file,"OP = 10111 	C = A | B 								Z, S");	
				OP = 10111; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0001011101101111;
				B = 16'b0010101001010011;
				#50;
			end
			
			// --------------------------------------------------------------------------
			37: begin	
				$fdisplay(file,"OP = 11000 	C = !A&!B  								Z, S");			
				OP = 11000; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0010101010111010;
				B = 16'b0101001101010111;
				#50;
			end
			
			38: begin	
				$fdisplay(file,"OP = 11000 	C = !A&!B  								Z, S");	
				OP = 11000; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0010101010101000;
				B = 16'b1101010101010111;
				#50;
			end
			
			39: begin	
				$fdisplay(file,"OP = 11000 	C = !A&!B  								Z, S");	
				OP = 11000; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1010101010111111;
				B = 16'b0101010101010111;
				#50;
			end
			// --------------------------------------------------------------------------	
			40: begin	
				$fdisplay(file,"OP = 11001 	C = !(A xor B) 							Z, S"); 			
				OP = 11001; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b1101001101010111;
				#50;
			end
			
			41: begin	
				$fdisplay(file,"OP = 11001 	C = !(A xor B) 							Z, S"); 
				OP = 11001; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010101000;
				B = 16'b0101010101010111;
				#50;
			end
			
			42: begin	
				$fdisplay(file,"OP = 11001 	C = !(A xor B) 							Z, S"); 
				OP = 11001; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1111111111111111;
				B = 16'b0000000000000000;
				#50;
			end
			
			// --------------------------------------------------------------------------
			43: begin	
				$fdisplay(file,"OP = 11010 	C = !A 									Z, S");			
				OP = 11010; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010111111;
				#50;
			end
			
			44: begin	
				$fdisplay(file,"OP = 11010 	C = !A 									Z, S");	
				OP = 11010; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0010101010111111;
				#50;
			end
			
			45: begin	
				$fdisplay(file,"OP = 11010 	C = !A 									Z, S");	
				OP = 11010; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0000000000000000;
				#50;
			end
			
			// --------------------------------------------------------------------------
			46: begin	
				$fdisplay(file,"OP = 11011 	C = !A|B 								Z, S"); 				
				OP = 11011; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b1101001101010111;
				#50;
			end
			
			47: begin	
				$fdisplay(file,"OP = 11011 	C = !A|B 								Z, S"); 	
				OP = 11011; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010101000;
				B = 16'b0101010101010111;
				#50;
			end
			
			48: begin	
				$fdisplay(file,"OP = 11011 	C = !A|B 								Z, S"); 	
				OP = 11011; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1111111111111111;
				B = 16'b0000000000000000;
				#50;
			end
			
			// --------------------------------------------------------------------------
			49: begin	
				$fdisplay(file,"OP = 11100 	C = !B 									Z, S");				
				OP = 11100; EO = 0; EC = 0; ES = 0; EZ = 0;
				B = 16'b1010101010111111;
				#50;
			end
			
			50: begin	
				$fdisplay(file,"OP = 11100 	C = !B 									Z, S");	
				OP = 11100; EO = 0; EC = 0; ES = 1; EZ = 0;
				B = 16'b0010101010111111;
				#50;
			end
			
			51: begin	
				$fdisplay(file,"OP = 11100 	C = !B 									Z, S");	
				OP = 11100; EO = 0; EC = 0; ES = 0; EZ = 1;
				B = 16'b0000000000000000;
				#50;
			end
			
			// --------------------------------------------------------------------------
			52: begin	
				$fdisplay(file,"OP = 11101 	C = A|!B 								Z, S");			
				OP = 11101; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b0101001101010111;
				#50;
			end 
			
			53: begin
				$fdisplay(file,"OP = 11101 	C = A|!B 								Z, S");	
				OP = 11101; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0010101010101000;
				B = 16'b1101010101010111;
				#50;
			end
			
			54: begin
				$fdisplay(file,"OP = 11101 	C = A|!B 								Z, S");	
				OP = 11101; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0000000000000000;
				B = 16'b1111111111111111;
				#50;
			end
			
			// --------------------------------------------------------------------------	
			55: begin	
				$fdisplay(file,"OP = 11110 	C = !A|!B 								Z, S");				
				OP = 11110; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b0101001101010111;
				#50;
			end		
			
			56: begin	
				$fdisplay(file,"OP = 11110 	C = !A|!B 								Z, S");
				OP = 11110; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010101000;
				B = 16'b1101010101010111;
				#50;
			end		
			
			57: begin	
				$fdisplay(file,"OP = 11110 	C = !A|!B 								Z, S");
				OP = 11110; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1111111111111111;
				B = 16'b1111111111111111;
				#50;
			end	
			
			// --------------------------------------------------------------------------	
			58: begin	
				$fdisplay(file,"OP = 11111 	C = 1                                   nenhuma");
				OP = 11111; EO = 0; EC = 0; ES = 0; EZ = 0;
			end
			endcase
			
			
			if((O==EO) & (C==EC) & (S==ES) & (Z==EZ))
				num_acerto = num_acerto+1; 
			else begin	
				num_erro = num_erro+1;
				$fdisplay(file,"ERRO %d",i);			
			end
			
			$fdisplay(file,"Flag's Obtidas:   O=%b  C=%b  S=%b  Z=%b", O, C, S, Z);
			$fdisplay(file,"Flag's Esperadas: EO=%b EC=%b ES=%b EZ=%b\n", EO, EC, ES, EZ);
		end // for
		
		$fdisplay(file,"Número Acerto = %d \n Número Erro = %d ",num_acerto,num_erro);
		$fclose(file);
	end
endmodule 