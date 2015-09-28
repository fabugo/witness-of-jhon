module Teste_em_Massa();
	logic clock;
	integer file, count_clock=-10, count_stop = 1'd0, numero_falhas=0, numero_acertos=0;
    reg [15:0]instrucao, AUX, pc_out, A, B, constanteExtendida, Saida_ULA, Saida_MemoriaDados;
	
    IntegracaoModulos IntegracaoModulos(.clock(clock), .botao(1'b1));
  
	initial begin
	    clock=1;
		file = $fopen("TesteControle.txt");
	end
	
	always #5 clock = ~clock;
  
	always begin
		instrucao = IntegracaoModulos.instrucao; 
		pc_out = IntegracaoModulos.IF.PC.pc_out;
		A = IntegracaoModulos.ID_RF.A;
		B = IntegracaoModulos.ID_RF.B;
		constanteExtendida = IntegracaoModulos.ID_RF.constanteExtendida;
		Saida_ULA = IntegracaoModulos.EX_MEN.Saida_ULA;
		Saida_MemoriaDados = IntegracaoModulos.EX_MEN.Saida_MemoriaDados;
		
		if(count_clock==6) 
			$fdisplay(file,"PC (antes) %b -> %d		Instrução %b -> %h",pc_out, pc_out, instrucao, instrucao);	
		
		if(count_clock==11) 
			$fdisplay(file,"PC (depois) %b -> %d	",pc_out, pc_out);
		
		if(count_clock==16) begin
			if(instrucao[15:14] == 2'b10) begin		        
				$fdisplay(file,"A >> Endereço_Registro %b : Dado_Registro	%b = %d ",instrucao[5:3], A, A);
		        $fdisplay(file,"B >> Endereço_Registro %b : Dado_Registro	%b = %d ",instrucao[2:0], B, B);
								
			end else if(instrucao[15:14] == 2'b01) 
		        $fdisplay(file,"Const. >> Constante %b = %d : Constante_Extendida	%b = %d ",instrucao[10:0], instrucao[10:0], constanteExtendida, constanteExtendida);
			
			else if(instrucao[15:14] == 2'b11) 
				$fdisplay(file,"Const. >> Constante %b = %d : Constante_Extendida	%b = %d ",instrucao[7:0], instrucao[7:0], constanteExtendida, constanteExtendida);
				
		end
		
		if(count_clock==26)begin
			if((instrucao[15:14] == 2'b10) & (instrucao[10:6] == 5'b01010))
				$fdisplay(file,"Mem[%b] : Saida Mem %b = %d",instrucao[5:3], Saida_MemoriaDados, Saida_MemoriaDados); 
				 
			if((instrucao[15:14] == 2'b10) & (instrucao[10:6] == 5'b01011)) begin
				$fdisplay(file,"B : Saida B %b = %d",B, B); 
				$fdisplay(file,"End. Mem %b = %d ", A, A); 
			    $fdisplay(file,"Mem[A] Antes %b = %d ", Saida_MemoriaDados, Saida_MemoriaDados);
				
		 	end else
				$fdisplay(file,"Operação %b%b%b : Resultado %b = %d",instrucao[15:14],instrucao[10],instrucao[10:6], Saida_ULA, Saida_ULA); 
		end
		
		if(count_clock==31)begin
			if((instrucao[15:14] == 2'b10) & (instrucao[10:6] != 5'b01011)) begin
			   $fdisplay(file,"End. C %b = %d ", instrucao[13:11], instrucao[13:11]); 
			   $fdisplay(file,"C Antes %b = %d ", A, A); 
			end
		end
		
		if(count_clock==36)begin
			if((instrucao[15:14] == 2'b10) & (instrucao[10:6] == 5'b01011)) 
			   $fdisplay(file,"Mem[A] Depois %b = %d \n", Saida_MemoriaDados, Saida_MemoriaDados);
			else
			   $fdisplay(file,"C Depois %b = %d \n", A, A); 
		end
		
		//==========================================================================
		
			if(count_clock==27) begin
				if(instrucao[15:14] == 2'b01) begin 
					AUX[15:11] =  {5{instrucao[10]}};
					AUX[10:0] =  instrucao[10:0];
					$fdisplay(file,"C = Constante");
				end
				
				if(instrucao[15:14] == 2'b11) 
					if(instrucao[10] == 1'b0) begin                                                                              
						AUX = instrucao[7:0];
						AUX = AUX | (A & 16'b1111111100000000);
						$fdisplay(file,"C = Const8 | (C&0xff00)");
					end else if(instrucao[10] == 1'b1) begin 
						AUX = 16'b0000000000000000;
						AUX[15:8] = instrucao[7:0]; 					
						AUX = AUX | (A & 16'b0000000011111111);
						$fdisplay(file,"C = (Const8 « 8) | (C&0x00ff)");
					end    
					
				if((instrucao[15:14] == 2'b10) & (instrucao[10:6] != 5'b01011) & (instrucao[10:6] != 5'b01010)) 
					case (instrucao[10:6])
						5'b00000: begin AUX = A+B; 		$fdisplay(file,"C = A+B"); end
						5'b00001: begin AUX = A+B+1; 	$fdisplay(file,"C = A+B+1"); end
						5'b00011: begin AUX = A+1; 		$fdisplay(file,"C = A+1"); end
						5'b00100: begin AUX = A-B-1; 	$fdisplay(file,"C = A-B-1"); end
						5'b00101: begin AUX = A-B; 		$fdisplay(file,"C = A-B"); end
						5'b00110: begin AUX = A-1; 		$fdisplay(file,"C = A-1"); end			
						5'b01000: begin AUX = A << 1; 		$fdisplay(file,"C = A << 1"); end
						5'b01001: begin AUX = A >>> 1; 		$fdisplay(file,"C = A >>> 1"); end
						5'b10011: begin AUX = B; 			$fdisplay(file,"C = B"); end
						5'b11111: begin AUX = 1; 			$fdisplay(file,"C = 1"); end
						5'b10000: begin AUX = 0; 			$fdisplay(file,"C = 0"); end
						5'b10001: begin AUX = A & B; 		$fdisplay(file,"C = A & B"); end
						5'b10010: begin AUX = (~A) & B; 	$fdisplay(file,"C = (~A) & B"); end
						5'b10100: begin AUX = A & (~B); 	$fdisplay(file,"C = A & (~B)"); end
						5'b10101: begin AUX = A; 			$fdisplay(file,"C = A"); end
						5'b10110: begin AUX = A ^ B; 		$fdisplay(file,"C = A ^ B"); end
						5'b10111: begin AUX = A | B; 		$fdisplay(file,"C = A | B"); end
						5'b11000: begin AUX = (~A) & (~B); 	$fdisplay(file,"C = (~A) & (~B)"); end
						5'b11001: begin AUX = ~(A ^ B); 	$fdisplay(file,"C = ~(A ^ B)"); end
						5'b11010: begin AUX = (~A); 		$fdisplay(file,"C = (~A)"); end
						5'b11011: begin AUX = (~A) | (B); 	$fdisplay(file,"C = (~A) | (B)"); end
						5'b11100: begin AUX = (~B); 		$fdisplay(file,"C = (~B)"); end
						5'b11101: begin AUX = A | (~B); 	$fdisplay(file,"C = A | (~B)"); end
						5'b11110: begin AUX = (~A) | (~B); 	$fdisplay(file,"C = (~A) | (~B)"); end
					endcase
				
				$fdisplay(file,"Resultado Obtido %b = %d - Resultado Esperado %b = %d", Saida_ULA, Saida_ULA, AUX, AUX);
				if(Saida_ULA != AUX)begin
					numero_falhas=numero_falhas+1;
					$fdisplay(file,"Falha");
				end else begin
					numero_acertos=numero_acertos+1;
					$fdisplay(file,"Acerto");
				end
			end		 
			
			/* falta colocar essas instruções load store
			if(instrucao[15:14] == 2'b10)  
				if(instrucao[10:6] == 5'b01011)  
				
				if(instrucao[10:6] == 5'b01010)) 
				
			*/	
		//==========================================================================
		// Para Simulação
		if(count_stop>=11000) begin	
			$fdisplay(file,"\n\nFalhas = %d",numero_falhas);	
			$fdisplay(file,"Acertos = %d",numero_acertos);
			$fclose(file);
			$stop;
		end	
		
		// Contador Ciclos
		if(count_clock>=40) 
			count_clock = 0;
		#1
		count_stop = count_stop+1;
		count_clock = count_clock+1;
	end
	
endmodule 
