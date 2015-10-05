module Extensor(controle, constante, constanteExtendida);

	input reg [2:0] controle; 
	input reg [11:0] constante;
	output reg [15:0] constanteExtendida; 
	
	
	always_comb
	begin	
	case(controle)
		3'b000: begin  // loadlit c, Const
			constanteExtendida[15:11] =  {5{constante[10]}};
			constanteExtendida[10:0] = constante[10:0];
		end
		
		3'b001: begin // lch c, Const8
			constanteExtendida = constante; 
		end 
		
		3'b010: begin // lch c, Const8
			constanteExtendida = 16'b0000000000000000;
			constanteExtendida[15:8] = constante[7:0]; 
		end 
		
		3'b011: begin // Jump FI
			constanteExtendida[15:8] =  {8{constante[7]}};
			constanteExtendida[7:0] = constante[7:0];
		end	
		
		3'b100: begin // Jump FII
			constanteExtendida[15:12] =  {4{constante[11]}};
			constanteExtendida[11:0] = constante;
			//constanteExtendida = 16'b0000000000000011;
		end	
		
		default: begin end
	endcase
	end
endmodule

