/*
* @author Jussara 
* @author Pedro 
* Module: Bloco
* Purpose: Ligação de todos os modulos desenvolvidos (Banco de Registros, ULA e Registrador das flag's) 
*/

include "BR.sv";
include "ULA.sv";
include "RE.sv";

module BLOCO(
  Hab_Escrita,  // Habilita a escrita no banco de registros
  Sel_SA, /* Endereco onde será armazenado o valor da entrada, caso Hab_Escrita esteja ativo e/ou 
              endereco do registro a ser colocado na saida A do Banco de Registros. */
  Sel_SB, // Endereco do registro a ser colocado na saida A do Banco de Registros.   
  reset_Ban_Registros, // Limpa o estado de todas os registros contidos no Banco de Registros
  controleOperacao, // Escolhe qual a operação a ser realizada na ULA
  reset_Flags, // Limpa o estado de todas as flag's contidas no Banco de Registros das flag's
  resultadoOperacao, // Resultado da operação realizada na ULA
  Flags_ZCSO, // Estado das flag's
  clk,
  en
  ); 
  
  parameter bits_palavra = 16;
  parameter end_registros = 4;

  input Hab_Escrita, reset_Ban_Registros, reset_Flags;
  input [end_registros-1:0] Sel_SA, Sel_SB; 
  input [4:0] controleOperacao; 
  output reg [bits_palavra-1:0] resultadoOperacao; 
  output reg [3:0] Flags_ZCSO;  
  input logic clk,en;
  logic [bits_palavra-1:0] A,B;
  logic Z, C, S, O;

  BR br(.Sel_SA(Sel_SA),.Sel_SB(Sel_SB),.reset(reset_Ban_Registros),.clock(clk),.A(A),.B(B),.E(en));
  ULA u(.operandoA(A),.operandoB(B),.resultadoOp(resultadoOperacao),.controle(controleOperacao),.Z(Z),.C(C),.S(S),.O(O));
  RE be(.Z(Z),.C(C),.S(S),.O(O),.controleOperacao(controleOperacao),.ZCSO(Flags_ZCSO),.clock(clk),.reset(reset_Flags));

endmodule