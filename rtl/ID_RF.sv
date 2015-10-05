include "Banco_Registro.sv";
include "Extensor.sv";
include "MUX_RESULTADO.sv";
<<<<<<< HEAD
include "Registrador_Copia_PC.sv";
 
module ID_RF(clock, BR_Hab_Escrita, EXcontrole, BR_Sel_E_SA, BR_Sel_SB, entrada_ULA, controleMuxResu, entrada_MD, EXconstante, A, B, constanteExtendida, PC, controlePCcopia);
  input clock;
  input wire BR_Hab_Escrita, controlePCcopia;
  input wire [1:0] controleMuxResu;
  input wire [2:0] EXcontrole, BR_Sel_E_SA, BR_Sel_SB;
  input reg [11:0] EXconstante;
  input reg [15:0] entrada_ULA, entrada_MD, PC;
=======
 
module ID_RF(clock, BR_Hab_Escrita, EXcontrole, BR_Sel_E_SA, BR_Sel_SB, entrada_ULA, controle, entrada_MD, EXconstante, A, B, constanteExtendida);
  input clock;
  input wire BR_Hab_Escrita;
  input wire [1:0] controle; // Seletor mux
  input wire [2:0] EXcontrole, BR_Sel_E_SA, BR_Sel_SB;
  input reg [11:0] EXconstante;
  input reg [15:0] entrada_ULA, entrada_MD, entrada_PC;
>>>>>>> origin/jump
  output reg [15:0] A, B, constanteExtendida;
  wire [15:0] saida_Mux, copiaPC;
  
  Registrador_Copia_PC Registrador_Copia_PC(
    .clock(clock),
	.PC(PC), 
	.controle(controlePCcopia), 
	.CopiaPC(copiaPC)
  );
  
  MUX_RESULTADO MUX_RESULTADO(
  .entrada_ULA(entrada_ULA), 
  .entrada_MD(entrada_MD), 
  .entrada_PC(entrada_PC), 
  .saida_Mux(saida_Mux),
  .controle(controleMuxResu),
  .entrada_PC(copiaPC)
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