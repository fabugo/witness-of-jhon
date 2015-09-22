module Gera_Conj_Instrucao();
	parameter quant_inst = 10;
	integer file;
	reg [2:0] aux;
	reg [15:0] Instrucao;
	reg [4:0] operacao_ULA = 5'b00000;;

	initial begin
		file = $fopen("Conj_Instrucao.out");
	// Instruções Operação Constante F1 ------------------------------ 
		Instrucao[15:14] = 01;	
		for(int j=0; j<quant_inst; j++) begin	
			Instrucao[13:11] =  $random % 3;
			Instrucao[10:0] =  $random % 10;
			$fdisplay(file,"%h",Instrucao);	
		end
		
	// Instruções Operação Constante F2 ------------------------------
		Instrucao[15:14] = 11;	
		Instrucao[10] = 1'b0;
		for(int i=0; i<2; i++) begin
			for(int j=0; j<quant_inst; j++) begin	
				Instrucao[13:11] =  $random % 3;
				Instrucao[7:0] =  $random % 10;
				$fdisplay(file,"%h",Instrucao);	
			end	
			Instrucao[10] = 1'b1;
		end
	// Instruções Lógicas Aritméticas --------------------------------
		Instrucao[15:14] = 10;
		Instrucao[10:6] = operacao_ULA;
		
		for(int i=0; i<32; i++) begin
			for(int j=0; j<quant_inst; j++) begin
				if(Instrucao[10:6] != 5'b00010 & Instrucao[10:6] != 5'b00111 & Instrucao[10:6] != 5'b01010 & Instrucao[10:6] != 5'b01011 &
				   Instrucao[10:6] != 5'b01100 & Instrucao[10:6] != 5'b01101 & Instrucao[10:6] != 5'b01110 & Instrucao[10:6] != 5'b01111 &
				   Instrucao[10:6] != 5'b11111) begin
				
					Instrucao[13:11] =  $random % 3;
					Instrucao[5:3] =  $random % 3;
					Instrucao[2:0] =  $random % 3;
					$fdisplay(file,"%h",Instrucao);
				end
			end
			operacao_ULA = (operacao_ULA+1);
			Instrucao[10:6] = operacao_ULA;
		end
	// Instruções Acesso Memória --------------------------------
		Instrucao[15:14] = 10;
		Instrucao[10:6] = 5'b01011;
		
		for(int i=0; i<2; i++) begin
			for(int j=0; j<quant_inst; j++) begin
				Instrucao[13:11] = $random % 3;
				Instrucao[5:3] = $random % 3;
				Instrucao[2:0] = $random % 3;
				$fdisplay(file,"%h",Instrucao);
			end
			Instrucao[10:6] = 5'b01010;
		end			
		
		$fclose(file);
	end

endmodule 

