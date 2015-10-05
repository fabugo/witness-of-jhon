module Registrador_Copia_PC(clock, PC, controle, CopiaPC);
input clock, controle;
input reg [15:0] PC;
output reg [15:0] CopiaPC;

always @(negedge clock)
	begin
		if(controle)
			CopiaPC = PC;
	end

endmodule 