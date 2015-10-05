// Este teste tem como objetivo decodificar as instruções
// e mostrar o resultado final esperado no BR
`ifndef ROM_FILE_TESTE
  `define ROM_FILE_TESTE "Arquivos_Instrucao/T0.out"
`endif

module TesteJumpTO1();
  reg [15:0] mem_instrucao [0:(2**16)-1]; // Memoria de Instrucoes
  reg [15:0] mem_dados [0:(2**16)-1] ;    // Memoria de Dados
  reg [15:0] banco_registro [7:0];        // Banco de Registros
  reg [15:0] instrucao, pc, constanteExtendida, PCcopia;
  reg signed [15:0] A, B;
  integer file, count_stop = 1'd0;
  logic clock, clock1;
  
  IntegracaoModulos IntegracaoModulos(.clock(clock), .botao(1'b1));
  
  initial begin
    $readmemh(`ROM_FILE_TESTE, mem_instrucao); 
	file = $fopen("TesteJumpTO1.txt");
    clock=1;
    clock1=1;
	pc = 0;
  end

  always #5 clock = ~clock;
  always #20 clock1 = ~clock1;

  always @(posedge clock1) begin
	instrucao = mem_instrucao[pc];
	pc = pc+1;
	
	case(instrucao[15:14])
	  2'b00: begin // Jump =======================================================================		
		if((instrucao[13:12] == 2'b00) | (instrucao[13:12] == 2'b01))        // Jump False/True
			if(instrucao != 16'b0000000000000000) begin
				constanteExtendida[15:8] =  {8{instrucao[7]}};               // Extensão do sinal
				constanteExtendida[7:0] = instrucao[7:0];
				// ********* executar a condição
				/*
				case(condicao)
				4'b0100: saida = ~(Ver_Fal ^ RFlag_ZCSO[2]); 							       
				4'b0101: saida = ~(Ver_Fal ^ RFlag_ZCSO[0]); 								   
				4'b0110: saida = ~(Ver_Fal ^ RFlag_ZCSO[1]); 							      
				4'b0111: saida = (~(Ver_Fal ^ RFlag_ZCSO[2])) | (~(Ver_Fal ^ RFlag_ZCSO[0]));  
				4'b0000: saida = Ver_Fal; 		    	                 				       
				4'b0011: saida = ~(Ver_Fal ^ RFlag_ZCSO[3]); 							       
				endcase
				*/
				
				if(1)// se a condição for verdadeira
					pc = (pc + constanteExtendida);
				
				if(instrucao[12] == 1'b0) 
					$fdisplay(file,"%h JF.Cond Destino", instrucao);				
				else if(instrucao[12] == 1'b1)
					$fdisplay(file,"%h JT.Cond Destino", instrucao);
				
			end else
				$fdisplay(file,"%h JF.True 0x00", instrucao);	
				
		else if(instrucao[13:12] == 2'b10) begin                             // Jump Incondicional
			constanteExtendida[15:12] =  {4{instrucao[11]}};
			constanteExtendida[11:0] = instrucao[11:0];
			pc = (pc + constanteExtendida);
			$fdisplay(file,"%h J Destino", instrucao);
			
		end else if(instrucao[13:12] == 2'b11) begin                        // Jump Register/Link
			PCcopia = pc;   
			pc = banco_registro[instrucao[2:0]]; // PC = b
			if(instrucao[15:11] == 5'b00110) begin
				banco_registro[3'b111] = PCcopia;
				$fdisplay(file,"%h JAL B", instrucao);	
			
			end if(instrucao[15:11] == 5'b00111) 
				$fdisplay(file,"%h JR B", instrucao);	
		end
	  end
	  2'b01: begin // C = Constante ==============================================================
		constanteExtendida[15:11] =  {5{instrucao[10]}};
		constanteExtendida[10:0] = instrucao[10:0];		
		banco_registro[instrucao[13:11]] = constanteExtendida;	
		$fdisplay(file,"%h C = Constante", instrucao);	
	  end
	  2'b10: begin // L.A ou Load/Store ==========================================================
		A = banco_registro[instrucao[5:3]];
		B = banco_registro[instrucao[2:0]];
		case(instrucao[10:6])
			5'b00000: begin banco_registro[instrucao[13:11]] = A+B; 		$fdisplay(file,"%h C = A+B", instrucao); 		end
			5'b00001: begin banco_registro[instrucao[13:11]] = A+B+1; 		$fdisplay(file,"%h C = A+B+1", instrucao); 	end
			5'b00011: begin banco_registro[instrucao[13:11]] = A+1; 		$fdisplay(file,"%h C = A+1", instrucao); 		end
			5'b00100: begin banco_registro[instrucao[13:11]] = A-B-1; 		$fdisplay(file,"%h C = A-B-1", instrucao); 	end
			5'b00101: begin banco_registro[instrucao[13:11]] = A-B; 		$fdisplay(file,"%h C = A-B", instrucao); 		end
			5'b00110: begin banco_registro[instrucao[13:11]] = A-1; 		$fdisplay(file,"%h C = A-1", instrucao); 		end			
			5'b10011: begin banco_registro[instrucao[13:11]] = B; 			$fdisplay(file,"%h C = B", instrucao); 		end
			5'b11111: begin banco_registro[instrucao[13:11]] = 1; 			$fdisplay(file,"%h C = 1", instrucao); 		end
			5'b10000: begin banco_registro[instrucao[13:11]] = 0; 			$fdisplay(file,"%h C = 0", instrucao); 		end
			5'b10001: begin banco_registro[instrucao[13:11]] = A & B; 		$fdisplay(file,"%h C = A & B", instrucao);	end
			5'b10010: begin banco_registro[instrucao[13:11]] = (~A) & B; 	$fdisplay(file,"%h C = (~A) & B", instrucao); end
			5'b10100: begin banco_registro[instrucao[13:11]] = A & (~B); 	$fdisplay(file,"%h C = A & (~B)", instrucao); end
			5'b10101: begin banco_registro[instrucao[13:11]] = A; 			$fdisplay(file,"%h C = A", instrucao); 		end
			5'b10110: begin banco_registro[instrucao[13:11]] = A ^ B; 		$fdisplay(file,"%h C = A ^ B", instrucao); 	end
			5'b10111: begin banco_registro[instrucao[13:11]] = A | B; 		$fdisplay(file,"%h C = A | B", instrucao); 	end
			5'b11000: begin banco_registro[instrucao[13:11]] = (~A) & (~B); $fdisplay(file,"%h C = (~A) & (~B)", instrucao); 	end
			5'b11001: begin banco_registro[instrucao[13:11]] = ~(A ^ B); 	$fdisplay(file,"%h C = ~(A ^ B)", instrucao); 	end
			5'b11010: begin banco_registro[instrucao[13:11]] = (~A); 		$fdisplay(file,"%h C = (~A)", instrucao); 		end
			5'b11011: begin banco_registro[instrucao[13:11]] = (~A) | (B); 	$fdisplay(file,"%h C = (~A) | (B)", instrucao); 	end
			5'b11100: begin banco_registro[instrucao[13:11]] = (~B); 		$fdisplay(file,"%h C = (~B)", instrucao); 		end
			5'b11101: begin banco_registro[instrucao[13:11]] = A | (~B); 	$fdisplay(file,"%h C = A | (~B)", instrucao); 	end
			5'b11110: begin banco_registro[instrucao[13:11]] = (~A) | (~B); $fdisplay(file,"%h C = (~A) | (~B)", instrucao); 	end
			5'b01000: begin banco_registro[instrucao[13:11]] = A << 1; 		$fdisplay(file,"%h C = A << 1", instrucao); 		end
			5'b01001: begin banco_registro[instrucao[13:11]] = A >>> 1; 	$fdisplay(file,"%h C = A >>> 1", instrucao); 		end
			5'b01010: begin banco_registro[instrucao[13:11]] = mem_dados[banco_registro[instrucao[5:3]]]; 	$fdisplay(file,"%h C = Mem[A]", instrucao); end
			5'b01011: begin mem_dados[banco_registro[instrucao[5:3]]] = banco_registro[instrucao[2:0]];		$fdisplay(file,"%h Mem[A] = B", instrucao); end
		endcase
	  end
	  2'b11: begin // LCL ou LCH ================================================================
		if(instrucao[10]  == 1'b0) begin // LCL
			constanteExtendida = instrucao[7:0]; 
			banco_registro[instrucao[13:11]] = constanteExtendida | (banco_registro[instrucao[13:11]] & 16'b1111111100000000);
			$fdisplay(file,"%h C = Const8 | (C&0xff00)", instrucao);
			
		end else if(instrucao[10]  == 1'b1) begin // LCH
			constanteExtendida = 16'b0000000000000000;
			constanteExtendida[15:8] = instrucao[7:0]; 
			banco_registro[instrucao[13:11]] = constanteExtendida | (banco_registro[instrucao[13:11]] & 16'b0000000011111111);
			$fdisplay(file,"%h C = (Const8 « 8) | (C&0x00ff)", instrucao);
		end
	  end
	  
	  default: begin end	  
    endcase
	
	if(count_stop>=500) begin
		$fdisplay(file,"\n  Registos Esperados");
		for(int i=7; i>=0; i--)	
			$fdisplay(file,"%d banco_registro = %b - %d",i, banco_registro[i], banco_registro[i]);
		
		$fdisplay(file,"\n  Registos Obtidos");
		for(int j=7; j>=0; j--)
			$fdisplay(file,"%d banco_registro = %b - %d",j, 
			IntegracaoModulos.ID_RF.Banco_Registro.registro[j], 
			IntegracaoModulos.ID_RF.Banco_Registro.registro[j],
			);
		$fclose(file);
		$stop;
	end
	count_stop = count_stop+1;
	
  end
endmodule










