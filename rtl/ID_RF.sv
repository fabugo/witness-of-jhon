include "Banco_Registro.sv";
include "Extensor.sv";
include "MUX_RESULTADO.sv";
 
module ID_RF(clock, BR_Hab_Escrita, EXcontrole, BR_Sel_E_SA, BR_Sel_SB, entrada_ULA, controle, entrada_MD, EXconstante, A, B, constanteExtendida);
  input clock;
  input wire BR_Hab_Escrita;
  input wire [1:0] controle; // Seletor mux
  input wire [2:0] EXcontrole, BR_Sel_E_SA, BR_Sel_SB;
  input reg [11:0] EXconstante;
  input reg [15:0] entrada_ULA, entrada_MD, entrada_PC;
  output reg [15:0] A, B, constanteExtendida;
  wire [15:0] saida_Mux;
  
  MUX_RESULTADO MUX_RESULTADO(
  .entrada_ULA(entrada_ULA), 
  .entrada_MD(entrada_MD), 
  .entrada_PC(entrada_PC), 
  .saida_Mux(saida_Mux),
  .controle(controle)
  );	
  
  Banco_Registro Banco_Registro(
  .Hab_Escrita(BR_Hab_Escrita), 
  .Sel_E_SA(BR_Sel_E_SA), 
  .Sel_SB(BR_Sel_SB), 
  .clock(clock), 
  .A(A), 
  .B(B),
  .E(saida_Mux)
  );
  
  Extensor Extensor(
  .controle(EXcontrole), 
  .constante(EXconstante), 
  .constanteExtendida(constanteExtendida)
  );	  
  
endmodule 