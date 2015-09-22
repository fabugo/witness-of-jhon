include "MUX_ULA.sv";
include "ULA.sv";
include "Memoria_Dados.sv";

module EX_MEN(clock, MD_Hab_Escrita, controleMUX_ULA, ULA_OP, A, B, constanteExtendida, Saida_ULA, Saida_MemoriaDados);
  input clock;
  input wire MD_Hab_Escrita, controleMUX_ULA;
  input reg [7:0] ULA_OP;
  input reg [15:0] A, B, constanteExtendida;
  output reg [15:0] Saida_ULA, Saida_MemoriaDados;
  wire [15:0] saida_Mux; 
  
  MUX_ULA MUX_ULA(
  .entrada_BR(B), 
  .entrada_EX(constanteExtendida), 
  .saida_Mux(saida_Mux),
  .controle(controleMUX_ULA)
  );
  
  ULA ULA(
  .A(A), 
  .B(saida_Mux), 
  .OP(ULA_OP), 
  .RESU(Saida_ULA)
  );  
  
  Memoria_Dados Memoria_Dados (
  .Hab_Escrita(MD_Hab_Escrita), 
  .endereco(A), 
  .Entrada(B), 
  .Saida(Saida_MemoriaDados),
  .clock(clock)
  );
 
endmodule 