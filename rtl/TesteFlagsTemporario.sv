module TesteFlagsTemporario(RFlag_ZCSO, condicao, Ver_Fal, saida);
input reg [3:0] RFlag_ZCSO, condicao; 
input Ver_Fal;
output reg saida;
logic aux;

always_comb  
begin
	case(condicao)
		4'b0100: saida = ~(Ver_Fal ^ RFlag_ZCSO[2]); 							      // Resultado da ALU negativo 
		4'b0101: saida = ~(Ver_Fal ^ RFlag_ZCSO[0]); 								  // Resultado da ALU zero 
		4'b0110: saida = ~(Ver_Fal ^ RFlag_ZCSO[1]); 							      // Carry da ALU carry
		4'b0111: saida = (~(Ver_Fal ^ RFlag_ZCSO[2])) | (~(Ver_Fal ^ RFlag_ZCSO[0])); // Resultado da ALU negativo ou zero 
		4'b0000: saida = Ver_Fal; 		    	                 				      // TRUE 
		4'b0011: saida = ~(Ver_Fal ^ RFlag_ZCSO[3]); 							      // Resultado da ALU overflow 
		
		4'b1100: saida = 1'b1; // Habilita Jump
		4'b1111: saida = 1'b0; // Desabilita Jump
	endcase
end
endmodule 