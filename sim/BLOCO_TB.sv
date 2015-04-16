include "..\\rtl\\BLOCO.sv";
module BLOCO_TB;

	parameter bits_palavra = 16;
	parameter end_registros = 2;

	logic Hab_Escrita, reset_Ban_Registros, reset_Flags;
	logic [end_registros-1:0] Sel_SA, Sel_SB, Sel_SC; 
	logic [4:0] controleOperacao;
	logic clk;

	BLOCO BLOCO(Hab_Escrita,Sel_SA,Sel_SB,Sel_SC,reset_Ban_Registros,
		controleOperacao,reset_Flags,clk);

	initial clk = 0; // inicializa clk com zero
	always #100 clk = ~ clk ;

	initial begin
		Hab_Escrita = 1'b1;
		controleOperacao = 5'b00000;
		Sel_SA = 2'b00; 
		Sel_SB = 2'b01; 
		Sel_SC = 2'b00;
	end

endmodule