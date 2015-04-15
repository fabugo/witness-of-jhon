include "..\\rtl\\ULA.sv";
module ULA_TB;

	parameter bits_palavra = 16;

	logic signed [bits_palavra-1:0] operandoA, operandoB, resultadoOp;
	logic [4:0] controle;
	logic Z, C, S, O;

	ULA u(operandoA, operandoB, resultadoOp, controle, Z, C, S, O);

	initial begin

		controle = 5'b00000;
		operandoA = 16'b1000000000000000;
		operandoB = 16'b1111111111111111;
		#10
		$display("%b,\n%b,\n%b,\n%b,\n%b,\n%b,\n%b",operandoA, operandoB, resultadoOp, controle, Z, C, S, O);
		
	end

endmodule
