include "rtl\\Banco_Registro.sv";
include "rtl\\Extensor.sv";
include "rtl\\MUX_RESULTADO.sv";
 
module ID_RF(clock, BR_Hab_Escrita, EXcontrole, BR_Sel_E_SA, BR_Sel_SB, entrada_ULA, controle, entrada_MD, EXconstante, A, B, constanteExtendida);
  input clock;
  input logic BR_Hab_Escrita, controle;
  input logic [1:0] EXcontrole;
  input logic [2:0] BR_Sel_E_SA, BR_Sel_SB;
  input reg [10:0] EXconstante;
  input reg [15:0] entrada_ULA, entrada_MD;
  output reg [15:0] A, B, constanteExtendida;
    
  MUX_RESULTADO MUX_RESULTADO(.entrada_ULA(entrada_ULA), .entrada_MD(entrada_MD), .controle(controle));	
  Banco_Registro Banco_Registro(.Hab_Escrita(BR_Hab_Escrita), .Sel_E_SA(BR_Sel_E_SA), .Sel_SB(BR_Sel_SB), .clock(clock), .E(MUX_RESULTADO.saida_Mux));
  Extensor Extensor(.controle(EXcontrole), .constante(EXconstante));	  
    
  always @(negedge clock) begin
	A = Banco_Registro.A;
	B = Banco_Registro.B;
    constanteExtendida = Extensor.constanteExtendida;
  end
endmodule 