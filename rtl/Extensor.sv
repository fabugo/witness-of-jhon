module Extensor(controle, constante, constanteExtendida);

	input reg [1:0] controle; 
	input reg [10:0] constante;
	output reg [15:0] constanteExtendida; 
	
	
	always_comb
	begin	
<<<<<<< HEAD
=======
	constanteExtendida = 16'b0000000000000000;
>>>>>>> origin/mic_arq2
	case(controle)
		2'b00: begin  // loadlit c, Const
			constanteExtendida[15:11] =  {5{constante[10]}};
			constanteExtendida[10:0] = constante;
		end
		2'b01: begin constanteExtendida = constante; end // lch c, Const8
<<<<<<< HEAD
		2'b10: begin 
			constanteExtendida = 16'b0000000000000000;
			constanteExtendida[15:8] = constante[7:0]; end // lch c, Const8
		default: begin end
=======
		2'b10: begin constanteExtendida[15:8] = constante[7:0]; end // lch c, Const8
		default: begin constanteExtendida = 16'b1010101010101010; end
>>>>>>> origin/mic_arq2
	endcase
	end
endmodule

