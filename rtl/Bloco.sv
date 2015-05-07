/*
* @author Jussara 
* @author Pedro 
* Module: Bloco
* Purpose: Ligação de todos os modulos desenvolvidos (Banco de Registros, ULA e Registrador das flag's) 
*/
include "RTL\\BR.sv";
include "RTL\\ULA.sv";
include "RTL\\RE.sv";


module BLOCO(
Hab_Escrita,  // Habilita a escrita no banco de registros
Sel_SA, /* Endereco onde será armazenado o valor da entrada, caso Hab_Escrita esteja ativo e/ou 
          endereco do registro a ser colocado na saida A do Banco de Registros. */
Sel_SB, // Endereco do registro a ser colocado na saida A do Banco de Registros.   
Sel_SC,
reset_Ban_Registros, // Limpa o estado de todas os registros contidos no Banco de Registros
controleOperacao, // Escolhe qual a operação a ser realizada na ULA
reset_Flags, // Limpa o estado de todas as flag's contidas no Banco de Registros das flag's
clk
); 

	parameter bits_palavra = 16;
	parameter end_registros = 2;

	input Hab_Escrita, reset_Ban_Registros, reset_Flags;
	input [end_registros-1:0] Sel_SA, Sel_SB, Sel_SC; 
	input [4:0] controleOperacao; 
	reg [bits_palavra-1:0] resultadoOperacao;
	input logic clk;
	
	logic [bits_palavra-1:0] A,B;
	logic Z, C, S, O;

	BR Banco_Registradores(.Hab_Escrita(Hab_Escrita),.Sel_SA(Sel_SA),.Sel_SB(Sel_SB),.Sel_SC(Sel_SC),.reset(reset_Ban_Registros),
		.clock(clk),.A(A),.B(B),.E(resultadoOperacao));
   ULA Unidade_Logica_Aritimetica(.operandoA(A),.operandoB(B),.resultadoOp(resultadoOperacao),.controle(controleOperacao),.Z(Z),.C(C),.S(S),.O(O));
	
	RE Banco_Estados(.Z(Z),.C(C),.S(S),.O(O),.controleOperacao(controleOperacao),.clock(clk),.reset(reset_Flags));

endmodule