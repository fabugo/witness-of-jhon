include "ULA.sv";

module TesteFlags();
    parameter n = 73;
	logic [7:0] OP;			
	reg signed [15:0] A,B,RESU, RESU_ESP;	
	reg	O,C,S,Z, EO,EC,ES,EZ;					
	integer file, count, num_acerto=0, num_erro=0;
	logic clock;
	
	ULA ULA(
	.A(A), 
	.B(B), 
	.OP(OP),
	.RESU(RESU), 
	.O(O), 
	.C(C), 
	.S(S), 
	.Z(Z) 
	);
	
	initial begin
		file = $fopen("TesteFlagsOCSZ.txt");
		count = 1;
		clock = 1'b1;
	end
	
    always #10 clock = ~clock;
	
	always @(negedge clock) begin
	
		case(count)
			// --------------------------------------------------------------------------
			// Levando em consideração complemento a2
			// Falta Flag Overflow
			1: begin
				// Caso I: Dois números positivos.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 5'b00000; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0100100000000000;
				B = 16'b0010000000000000; // 0110100000000000			        
			end
			
			2: begin
				// Caso II: Um número positivo e outro menor e negativo.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 5'b00000; EO = 0; EC = 1; ES = 0; EZ = 0;
				A = 16'b0100100000000000; // 18432
				B = 16'b1110000000000000; // -8192 1 0010100000000000			        
			end       
			
			3: begin
				// Caso III: Um número positivo e outro maior e negativo.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 5'b00000; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1011100000000000;
				B = 16'b0010000000000000; // 1101100000000000	
			end   
			
			4: begin
				// Caso IV: Dois números negativos.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 5'b00000; EO = 0; EC = 1; ES = 1; EZ = 0;
				A = 16'b1011100000000000;
				B = 16'b1110000000000000; // 1001100000000000	
			end 
			
			5: begin
				// Caso V: Dois números iguais em magnetude mas de sinais contrarios.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 5'b00000; EO = 0; EC = 1; ES = 0; EZ = 1;
				A = 16'b1011100000000000;
				B = 16'b0100100000000000; // 0000000000000000
			end 
			
			73: begin
				// Caso V: Dois números iguais em magnetude mas de sinais contrarios.
				$fdisplay(file,"OP = 00000 	C = A + B  								todas");		
				OP = 5'b00000; EO = 0; EC = 1; ES = 0; EZ = 1;
			    A = 16'b0000000000000001; 
				B = 16'b1111111111111111; 
			end
			// --------------------------------------------------------------------------
			6: begin
				// Caso I: Dois números positivos.
				$fdisplay(file,"OP = 00001 	C = A + B + 1   						todas");
				OP = 5'b00001; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0100100000000000;
				B = 16'b0010000000000000; // 0110100000000001
			end
			
			7: begin
				// Caso II: Um número positivo e outro menor e negativo.
				$fdisplay(file,"OP = 00001 	C = A + B + 1   						todas");		
				OP = 5'b00001; EO = 0; EC = 1; ES = 0; EZ = 0;
				A = 16'b0100100000000000;
				B = 16'b1110000000000000; // 0010100000000001				        
			end 
			
			8: begin
				// Caso III: Um número positivo e outro maior e negativo.
				$fdisplay(file,"OP = 00001 	C = A + B + 1   						todas");	
				OP = 5'b00001; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1011100000000000;
				B = 16'b0010000000000000; 	
			end   
				
			9: begin
				// Caso IV: Dois números negativos. ***
				$fdisplay(file,"OP = 00001 	C = A + B + 1   						todas");		
				OP = 5'b00001; EO = 0; EC = 1; ES = 1; EZ = 0;
				A = 16'b1011100000000000;
				B = 16'b1110000000000000; 	
			end 
				
			10: begin
				// Caso V: Dois números iguais em magnetude mas de sinais contrarios.
				$fdisplay(file,"OP = 00001 	C = A + B + 1   						todas");		
				OP = 5'b00001; EO = 0; EC = 1; ES = 0; EZ = 0;
				A = 16'b1011100000000000;
				B = 16'b0100100000000000; // 0000000000000001
			end 
				
			// --------------------------------------------------------------------------
			11: begin
				// Caso I: A positivo.
				$fdisplay(file,"OP = 00011 	C = A + 1  								todas"); 	
				OP = 5'b00011; EO = 0; EC = 0; ES = 0; EZ = 0;
			    A = 16'b0100100000000000; // 0100100000000001
			end
			
			12: begin
				// Caso II: A negativo (-2).
				$fdisplay(file,"OP = 00011 	C = A + 1  								todas"); 	
				OP = 5'b00011; EO = 0; EC = 0; ES = 1; EZ = 0;
			    A = 16'b1111111111111110; // 1111111111111111
			end
			
			13: begin
				// Caso III: A negativo (-1).
				$fdisplay(file,"OP = 00011 	C = A + 1  								todas"); 	
				OP = 5'b00011; EO = 0; EC = 1; ES = 0; EZ = 1;
			    A = 16'b1111111111111111; // 0000000000000000
			end
			
			// --------------------------------------------------------------------------
			14: begin	$fdisplay(file,"OP = 00100 	C = A – B – 1   						todas"); end
			
			// --------------------------------------------------------------------------
			15: begin	
				$fdisplay(file,"OP = 00101 	C = A – B   							todas"); 
			end
			
			
			// --------------------------------------------------------------------------
			
			16: begin
				// Caso I: A positivo.
				$fdisplay(file,"OP = 00110 	C = A – 1   							todas");  	
				OP = 5'b00110; EO = 0; EC = 1; ES = 0; EZ = 0;
			    A = 16'b0100100000000000; 
			end
			
			17: begin
				// Caso II: A negativo (-2).
				$fdisplay(file,"OP = 00110 	C = A – 1   							todas"); 	
				OP = 5'b00110; EO = 0; EC = 1; ES = 1; EZ = 0;
			    A = 16'b1111111111111110; 
			end
			
			18: begin
				// Caso III: A positivo (1).
				$fdisplay(file,"OP = 00110 	C = A – 1   							todas");  	
				OP = 5'b00110; EO = 0; EC = 1; ES = 0; EZ = 1;
			    A = 16'b0000000000000001; // 0000000000000000
				// 1111111111111110 neg
				// 1111111111111111 neg+1
				// 1111111111111111 + 0000000000000001
				// 10000000000000000
			end
				
			// --------------------------------------------------------------------------
			19: begin	
				$fdisplay(file,"OP = 01000 	C = Deslocamento Lógico Esq. (A)   		S, C, Z");  	
				OP = 5'b01000; EO = 0; EC = 1; ES = 0; EZ = 0;
			    A = 16'b1001110000000001;  // 0011100000000010 14338
			end
			
			20: begin	
				$fdisplay(file,"OP = 01000 	C = Deslocamento Lógico Esq. (A)   		S, C, Z");  	
				OP = 5'b01000; EO = 0; EC = 1; ES = 1; EZ = 0;
			    A = 16'b1101110000000001;  // 1011100000000010
			end
			
			21: begin	
				$fdisplay(file,"OP = 01000 	C = Deslocamento Lógico Esq. (A)   		S, C, Z");  	
				OP = 5'b01000; EO = 0; EC = 0; ES = 1; EZ = 0;
			    A = 16'b0101110000000001;  // 1011100000000010
			end
			
			22: begin	
				$fdisplay(file,"OP = 01000 	C = Deslocamento Lógico Esq. (A)   		S, C, Z");  	
				OP = 5'b01000; EO = 0; EC = 0; ES = 0; EZ = 0;
			    A = 16'b0001110000000001;  // 0011100000000010
			end
			
			23: begin	
				$fdisplay(file,"OP = 01000 	C = Deslocamento Lógico Esq. (A)   		S, C, Z");  	
				OP = 5'b01000; EO = 0; EC = 1; ES = 0; EZ = 1;
			    A = 16'b1000000000000000;  // 0000000000000000
			end
			
			// --------------------------------------------------------------------------
			24: begin	
				$fdisplay(file,"OP = 01001 	C = Deslocamento Aritmético Dir. (A)  	S, C, Z"); 	
				OP = 5'b01001; EO = 0; EC = 0; ES = 1; EZ = 0;
			    A = 16'b1001110000000000; // 1100111000000000
			end
			
			25: begin	
				$fdisplay(file,"OP = 01001 	C = Deslocamento Aritmético Dir. (A)  	S, C, Z"); 	
				OP = 5'b01001; EO = 0; EC = 0; ES = 0; EZ = 0;
			    A = 16'b0001110000000000; // 0000111000000000
			end
			
			26: begin	
				$fdisplay(file,"OP = 01001 	C = Deslocamento Aritmético Dir. (A)  	S, C, Z"); 	
				OP = 5'b01001; EO = 0; EC = 1; ES = 1; EZ = 0;
			    A = 16'b1001110000000001; // 1100111000000000
			end
			
			27: begin	
				$fdisplay(file,"OP = 01001 	C = Deslocamento Aritmético Dir. (A)  	S, C, Z"); 	
				OP = 5'b01001; EO = 0; EC = 1; ES = 0; EZ = 0;
			    A = 16'b0001110000000001; // 0000111000000000
			end
			
			28: begin	
				$fdisplay(file,"OP = 01001 	C = Deslocamento Aritmético Dir. (A)  	S, C, Z"); 	
				OP = 5'b01001; EO = 0; EC = 1; ES = 0; EZ = 1;
			    A = 16'b0000000000000001; // 0000000000000000
			end
			// --------------------------------------------------------------------------
			29: begin	
				$fdisplay(file,"OP = 10000 	C = 0    								Z");			
				OP = 5'b10000; EO = 0; EC = 0; ES = 0; EZ = 1;
			end	
			// --------------------------------------------------------------------------
			30: begin	
				$fdisplay(file,"OP = 10001 	C = A&B                                 Z, S");			
				OP = 5'b10001; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b1101001101010111;
			end
			
			31: begin	
				$fdisplay(file,"OP = 10001 	C = A&B                                 Z, S");	
				OP = 5'b10001; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0010101010101000;
				B = 16'b1101010101010111;
			end
			
			32: begin	
				$fdisplay(file,"OP = 10001 	C = A&B                                 Z, S");	
				OP = 5'b10001; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0101010101010101;
				B = 16'b1010101010101010;
			end
			
			// --------------------------------------------------------------------------
			33: begin	
				$fdisplay(file,"OP = 10010 	C = !A&B 								Z, S");		
				OP = 5'b10010; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010111001101111;
				B = 16'b0111001101110110;
			end
			
			34: begin	
				$fdisplay(file,"OP = 10010 	C = !A&B 								Z, S");
				OP = 5'b10010; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1101101111011101; 
				B = 16'b1101101111011101; 
			end
			
			35: begin	
				$fdisplay(file,"OP = 10010 	C = !A&B 								Z, S");
				OP = 5'b10010; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1111100111011101; 
				B = 16'b1110010111011100; 
			end
			// --------------------------------------------------------------------------
						
			36: begin	
				$fdisplay(file,"OP = 10011 	C = B  									Z, S");			
				OP = 5'b10011; EO = 0; EC = 0; ES = 0; EZ = 0;
				B = 16'b0101101011011101;
			end
			
			37: begin	
				$fdisplay(file,"OP = 10011 	C = B  									Z, S");	
				OP = 5'b10011; EO = 0; EC = 0; ES = 0; EZ = 0;
				B = 16'b0000000000000000;
			end
			
			38: begin
				$fdisplay(file,"OP = 10011 	C = B  									Z, S");			
				OP = 5'b10011; EO = 0; EC = 0; ES = 0; EZ = 0;
				B = 16'b1111101011011101;
			end
			
			// --------------------------------------------------------------------------
			39: begin	
				$fdisplay(file,"OP = 10100 	C = A&!B  								Z, S");			
				OP = 5'b10100; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010111001101111;
				B = 16'b0111001101110110;
			end
			
			40: begin	
				$fdisplay(file,"OP = 10100 	C = A&!B  								Z, S");			
				OP = 5'b10100; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0010111001101111;
				B = 16'b0111001101110110;
			end
			
			41: begin	
				$fdisplay(file,"OP = 10100 	C = A&!B  								Z, S");	
				OP = 5'b10100; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0101101011011101;
				B = 16'b1101101111011101;
			end
			
			// --------------------------------------------------------------------------
			42: begin	
				$fdisplay(file,"OP = 10101 	C = A  									Z, S");			
				OP = 5'b10101; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0101101011011101;
			end
			
			43: begin	
				$fdisplay(file,"OP = 10101 	C = A  									Z, S");	
				OP = 5'b10101; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0000000000000000;
			end
			
			44: begin
				$fdisplay(file,"OP = 10101 	C = A  									Z, S");			
				OP = 5'b10101; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1111101011011101;
			end
			
			// --------------------------------------------------------------------------
			45: begin	
				$fdisplay(file,"OP = 10110 	C = A xor B  							Z, S");				
				OP = 5'b10110; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0010101010111010;
				B = 16'b1101001101010111;
			end
			
			46: begin	
				$fdisplay(file,"OP = 10110 	C = A xor B  							Z, S");
				OP = 5'b10110; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010101000;
				B = 16'b1101010101010111;
			end
			
			47: begin	
				$fdisplay(file,"OP = 10110 	C = A xor B  							Z, S");
				OP = 5'b10110; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1010101010101010;
				B = 16'b1010101010101010;
			end
			
			// --------------------------------------------------------------------------
			48: begin	
				$fdisplay(file,"OP = 10111 	C = A | B 								Z, S");			
				OP = 5'b10111; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101100011011; 
				B = 16'b0010101001010011;
			end
			
			49: begin	
				$fdisplay(file,"OP = 10111 	C = A | B 								Z, S");	
				OP = 5'b10111; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0000000000000000;
				B = 16'b0000000000000000;
			end
			
			50: begin	
				$fdisplay(file,"OP = 10111 	C = A | B 								Z, S");	
				OP = 5'b10111; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0001011101101111;
				B = 16'b0010101001010011;
			end
			
			// --------------------------------------------------------------------------
			51: begin	
				$fdisplay(file,"OP = 11000 	C = !A&!B  								Z, S");			
				OP = 5'b11000; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0010101010111010;
				B = 16'b0101001101010111;
			end
			
			52: begin	
				$fdisplay(file,"OP = 11000 	C = !A&!B  								Z, S");	
				OP = 5'b11000; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0010101010101000;
				B = 16'b1101010101010111;
			end
			
			53: begin	
				$fdisplay(file,"OP = 11000 	C = !A&!B  								Z, S");	
				OP = 5'b11000; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1010101010111111; 
				B = 16'b0101010101010111; 
			end
			// --------------------------------------------------------------------------	
			54: begin	
				$fdisplay(file,"OP = 11001 	C = !(A xor B) 							Z, S"); 			
				OP = 5'b11001; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b1101001101010111;
			end
			
			55: begin	
				$fdisplay(file,"OP = 11001 	C = !(A xor B) 							Z, S"); 
				OP = 5'b11001; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1010101010101000; 
				B = 16'b0101010101010111;
			end
			
			56: begin	
				$fdisplay(file,"OP = 11001 	C = !(A xor B) 							Z, S"); 
				OP = 5'b11001; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1111111111111111;
				B = 16'b0000000000000000;
			end
			
			// --------------------------------------------------------------------------
			57: begin	
				$fdisplay(file,"OP = 11010 	C = !A 									Z, S");			
				OP = 5'b11010; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010111111; 
			end 
			
			58: begin	
				$fdisplay(file,"OP = 11010 	C = !A 									Z, S");	
				OP = 5'b11010; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0010101010111111;
			end
			
			59: begin	
				$fdisplay(file,"OP = 11010 	C = !A 									Z, S");	
				OP = 5'b11010; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b0000000000000000;
			end
			
			// --------------------------------------------------------------------------
			60: begin	
				$fdisplay(file,"OP = 11011 	C = !A|B 								Z, S"); 				
				OP = 5'b11011; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b1101001101010111;
			end
			
			61: begin	
				$fdisplay(file,"OP = 11011 	C = !A|B 								Z, S"); 	
				OP = 5'b11011; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010101000;
				B = 16'b0101010101010111;
			end
			
			62: begin	
				$fdisplay(file,"OP = 11011 	C = !A|B 								Z, S"); 	
				OP = 5'b11011; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1111111111111111;
				B = 16'b0000000000000000;
			end
			
			// --------------------------------------------------------------------------
			63: begin	
				$fdisplay(file,"OP = 11100 	C = !B 									Z, S");				
				OP = 5'b11100; EO = 0; EC = 0; ES = 0; EZ = 0;
				B = 16'b1010101010111111;
			end
			
			64: begin	
				$fdisplay(file,"OP = 11100 	C = !B 									Z, S");	
				OP = 5'b11100; EO = 0; EC = 0; ES = 1; EZ = 0;
				B = 16'b0010101010111111;
			end
			
			65: begin	
				$fdisplay(file,"OP = 11100 	C = !B 									Z, S");	
				OP = 5'b11100; EO = 0; EC = 0; ES = 1; EZ = 0;
				B = 16'b0000000000000000;
			end
			
			// --------------------------------------------------------------------------
			66: begin	
				$fdisplay(file,"OP = 11101 	C = A|!B 								Z, S");			
				OP = 5'b11101; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b0101001101010111;
			end 
			
			67: begin
				$fdisplay(file,"OP = 11101 	C = A|!B 								Z, S");	
				OP = 5'b11101; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b0010101010101000;
				B = 16'b1101010101010111;
			end
			
			68: begin
				$fdisplay(file,"OP = 11101 	C = A|!B 								Z, S");	
				OP = 5'b11101; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b0000000000000000;
				B = 16'b1111111111111111;
			end
			
			// --------------------------------------------------------------------------	 
			69: begin	
				$fdisplay(file,"OP = 11110 	C = !A|!B 								Z, S");				
				OP = 5'b11110; EO = 0; EC = 0; ES = 1; EZ = 0;
				A = 16'b1010101010111010;
				B = 16'b0101001101010111;
			end		
			
			70: begin	
				$fdisplay(file,"OP = 11110 	C = !A|!B 								Z, S");
				OP = 5'b11110; EO = 0; EC = 0; ES = 0; EZ = 0;
				A = 16'b1010101010101000; 
				B = 16'b1101010101010111; 
			end		
			
			71: begin	
				$fdisplay(file,"OP = 11110 	C = !A|!B 								Z, S");
				OP = 5'b11110; EO = 0; EC = 0; ES = 0; EZ = 1;
				A = 16'b1111111111111111;
				B = 16'b1111111111111111;
			end	
			
			// --------------------------------------------------------------------------	
			72: begin	
				$fdisplay(file,"OP = 11111 	C = 1                                   nenhuma");
				OP = 5'b11111; EO = 0; EC = 0; ES = 0; EZ = 0;
			end
			
		endcase
		
		
		$fdisplay(file,"A = %b - %d		B = %b - %d", A, A, B, B); 
		
		#4
		if((O==EO) & (C==EC) & (S==ES) & (Z==EZ))
			num_acerto = num_acerto+1; 
		else begin	
			num_erro = num_erro+1;
			$fdisplay(file,"ERRO %d",count);			
		end
		
		
		$fdisplay(file,"Flag's Obtidas:   O=%b  C=%b  S=%b  Z=%b", O, C, S, Z);
		$fdisplay(file,"Flag's Esperadas: EO=%b EC=%b ES=%b EZ=%b\n", EO, EC, ES, EZ);
				
		if(count >= n) begin
			$fdisplay(file,"Número Acerto = %d \n Número Erro = %d ",num_acerto,num_erro);
			$fclose(file);
			$stop;
		end
		count = count+1;
		OP = 0;
	end
	
endmodule 
