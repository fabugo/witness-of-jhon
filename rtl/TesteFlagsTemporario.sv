module TesteFlagsTemporario(RFlag_ZCSO, condicao, Ver_Fal, saida);
input reg [3:0] RFlag_ZCSO, condicao; 
input Ver_Fal;
output reg saida;
logic auxSaida;


always_comb  
begin
	case(condicao)
	4'b0000: begin
		if(Ver_Fal)
			saida = 1'b1;
		else
			saida = 1'b0;
	end
	
	4'b1111: begin
		saida = 1'b0;
	end
	
	default: begin
		saida = 1'b0;
	end
	endcase
end
endmodule 