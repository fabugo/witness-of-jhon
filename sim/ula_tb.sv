include "..\\rtl\\ULA.sv";
module ula_tb;

	// criando variaveis e instanciando link com variaveis do modulo a ser testado
	logic[15:0] opA, opB, resOp, clk;
	logic[4:0] cont;
	ULA bula(.operandoA(opA), .operandoB(opB), .resultadoOp(resOp), .controle(cont));
	integer file;
	logic[7:0] random;

	initial begin
		//cont = 4'B00000
		file=$fopen("out_tb.txt");
		random = 8'B00000;
		repeat(10)begin
			random ++;
			$fdisplay(file," %b",random);
		end
		$fclose(file);
	end

endmodule