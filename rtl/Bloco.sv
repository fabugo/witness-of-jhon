/*
* @author Jussara 
* @author Pedro 
* Module: Bloco
* Purpose: Ligação de todos os modulos desenvolvidos (Banco de Registros, ULA e Registrador das flag's) 
*/

include "BR.sv";  // Banco de Registros
include "ULA.sv"; // Unidade Logica Aritimetica
include "RE.sv";  // Banco de Registros das Flag's
  
module Bloco(
  Hab_Escrita,  // Habilita a escrita no banco de registros
  Sel_E_SA, // Endereco onde será armazenado o valor da entrada, caso Hab_Escrita esteja ativo e/ou  endereco do registro a ser colocado na saida A do Banco de Registros. 
  Sel_SB, // Endereco do registro a ser colocado na saida A do Banco de Registros.   
  reset_Ban_Registros, // Limpa o estado de todas os registros contidos no Banco de Registros
  controleOperacao, // Escolhe qual a operação a ser realizada na ULA
  reset_Flags, // Limpa o estado de todas as flag's contidas no Banco de Registros das flag's
  resultadoOperacao, // Resultado da operação realizada na ULA
  Flags_ZCSO, // Estado das flag's
  ); 
  
  parameter bits_palavra = 16;
  parameter end_registros = 3; 
    
  input Hab_Escrita, reset_Ban_Registros, reset_Flags;
  input [end_registros-1:0] Sel_E_SA, Sel_SB; 
  input [4:0] controleOperacao; 
  output reg [bits_palavra-1:0] resultadoOperacao; 
  output reg [3:0] Flags_ZCSO;  
  logic clk;
 
  initial #5 clk = 1; // Inicializa clock com um 
  always #50 clk = ~ clk; // Uma transicao de clock a cada 50 unidades de tempo
   
  Banco_Registos BR(.Hab_Escrita(Hab_Escrita), .Sel_E_SA(Sel_E_SA), .Sel_SB(Sel_SB), .reset(reset_Ban_Registros), .clock(clk));

  Unidade_Logica_Aritmetica ULA(.operandoA(BR.A), .operandoB(BR.B), .controle(controleOperacao));
  // Unidade_Logica_Aritmetica ULA(.operandoA(Banco_Registos.A), .operandoB(Banco_Registos.B), .controle(controleOperacao));
  // *** As dual linhas funcionam, tem que verificar se as duas retornam o valor correto

  Registro_Flags RE(.Z(ULA.Z), .C(ULA.C), .S(ULA.S), .O(ULA.O), .C_RE(controleOperacao), .clock(clk), .reset(reset_Flags));
    	
	initial // Inicializa os registradores.
			begin
				resultadoOperacao = ULA.resultadoOp;
				Flags_ZCSO = RE.ZCSO;
			end
			
endmodule