// Por: Jussara .M
// Objetivo: estender um vetor de 16 para 32 bits mantendo o sinal
// Algoritmo: O bit mais significativo do vetor de entrada é replicado 
// até que o vetor seja completado com 32 bits.

module extensor_sinal(palavra_entrada, palavra_saida);

	input palavra_entrada[15:0];
	output reg palavra_saida[31:0];

	begin
	palavra_saida[15:0] = palavra_entrada;

	palavra_saida[16] = palavra_entrada[15];
	palavra_saida[17] = palavra_entrada[15];
	palavra_saida[18] = palavra_entrada[15];
	palavra_saida[19] = palavra_entrada[15];
	palavra_saida[20] = palavra_entrada[15];
	palavra_saida[21] = palavra_entrada[15];
	palavra_saida[22] = palavra_entrada[15];
	palavra_saida[23] = palavra_entrada[15];
	palavra_saida[24] = palavra_entrada[15];
	palavra_saida[25] = palavra_entrada[15];
	palavra_saida[26] = palavra_entrada[15];
	palavra_saida[27] = palavra_entrada[15];
	palavra_saida[28] = palavra_entrada[15];
	palavra_saida[29] = palavra_entrada[15];
	palavra_saida[30] = palavra_entrada[15];
	palavra_saida[31] = palavra_entrada[15];

	end

endmodule;
