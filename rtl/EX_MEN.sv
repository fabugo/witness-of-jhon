include "MUX_ULA.sv";
include "ULA.sv";
include "Memoria_Dados.sv";

module EX_MEN(clock, MD_Hab_Escrita, controleMUX_ULA, ULA_OP, A, B, constanteExtendida, Saida_ULA, Saida_MemoriaDados);
  input clock;
  input logic MD_Hab_Escrita, controleMUX_ULA;
  input reg [7:0] ULA_OP;
  input reg [15:0] A, B, constanteExtendida;
  output reg [15:0] Saida_ULA, Saida_MemoriaDados;
 
  MUX_ULA MUX_ULA(.entrada_BR(B), .entrada_EX(constanteExtendida), .controle(controleMUX_ULA));
  ULA ULA(.A(A), .B(MUX_ULA.saida_Mux), .OP(ULA_OP));  
  Memoria_Dados Memoria_Dados (.Hab_Escrita(MD_Hab_Escrita), .endereco(A), .Entrada(B), .clock(clock));
   
  always @(negedge clock) begin
	  Saida_ULA = ULA.RESU;
	  Saida_MemoriaDados = Memoria_Dados.Saida;
  end
endmodule 