module Memoria_de_Instrucao(clk_MI, reset, pc, instrucao);
	 
	parameter num_registros = 41; // 42 instruções 6 bits
	
	input clk_MI, reset;
	input [5:0] pc;
	output reg [15:0] instrucao;
	integer file;
	reg [15:0] reg_instrucao [num_registros-1:0];	
	
	initial // Bloco para fins de teste
		begin
			reg_instrucao[0] = 16'b1001000000000001;
			reg_instrucao[1] = 16'b1000000001010001;
			reg_instrucao[2] = 16'b1000100011011000;
			reg_instrucao[3] = 16'b1001000100000101;
			reg_instrucao[4] = 16'b1001000101100011;
			reg_instrucao[5] = 16'b1011000110111101;
			reg_instrucao[6] = 16'b1000001000001001;
			reg_instrucao[7] = 16'b1001101001011011;
			reg_instrucao[8] = 16'b1011010011100111;
			reg_instrucao[9] = 16'b1011111111010101;
			reg_instrucao[10] = 16'b1001110000001000;
			reg_instrucao[11] = 16'b1010010001110010;
			reg_instrucao[12] = 16'b1001010010011110;
			reg_instrucao[13] = 16'b1011010100111000;
			reg_instrucao[14] = 16'b1001110101011101;
			reg_instrucao[15] = 16'b1010110110111011;
			reg_instrucao[16] = 16'b1000110111000000;
			reg_instrucao[17] = 16'b1010011000001111;
			reg_instrucao[18] = 16'b1010011001010010;
			reg_instrucao[19] = 16'b1011011010100001;
			reg_instrucao[20] = 16'b1001111011110110;
			reg_instrucao[21] = 16'b1010111100011001;
			reg_instrucao[22] = 16'b1000011101111111;
			reg_instrucao[23] = 16'b1001011110010010;
			reg_instrucao[24] = 16'b0101011100011001;
			reg_instrucao[25] = 16'b1100001101111111;
			reg_instrucao[26] = 16'b1101011110010010;
			
		end
	
	always@(posedge clk_MI, posedge reset) 
		begin
			if(reset) //Reset assíncrono
				begin 
			reg_instrucao[0] = 16'b1001000000000001;
			reg_instrucao[1] = 16'b1000000001010001;
			reg_instrucao[2] = 16'b1000100011011000;
			reg_instrucao[3] = 16'b1001000100000101;
			reg_instrucao[4] = 16'b1001000101100011;
			reg_instrucao[5] = 16'b1011000110111101;
			reg_instrucao[6] = 16'b1000001000001001;
			reg_instrucao[7] = 16'b1001101001011011;
			reg_instrucao[8] = 16'b1011010011100111;
			reg_instrucao[9] = 16'b1011111111010101;
			reg_instrucao[10] = 16'b1001110000001000;
			reg_instrucao[11] = 16'b1010010001110010;
			reg_instrucao[12] = 16'b1001010010011110;
			reg_instrucao[13] = 16'b1011010100111000;
			reg_instrucao[14] = 16'b1001110101011101;
			reg_instrucao[15] = 16'b1010110110111011;
			reg_instrucao[16] = 16'b1000110111000000;
			reg_instrucao[17] = 16'b1010011000001111;
			reg_instrucao[18] = 16'b1010011001010010;
			reg_instrucao[19] = 16'b1011011010100001;
			reg_instrucao[20] = 16'b1001111011110110;
			reg_instrucao[21] = 16'b1010111100011001;
			reg_instrucao[22] = 16'b1000011101111111;
			reg_instrucao[23] = 16'b1001011110010010;
				end
				
			instrucao = reg_instrucao[pc]; // Atualiza a saída
			
		
			
		end	 
endmodule
