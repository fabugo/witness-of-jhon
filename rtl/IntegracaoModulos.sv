include "IF.sv"; 
include "ID_RF.sv";
include "EX_MEN.sv";
include "Controle.sv"; //Controle

module IntegracaoModulos();
  logic clock;
  integer count_stop = 1'd0;
  reg [15:0]instrucao;
  
  Controle Controle(.clock(clock), .reset(1'b0), .instrucao(instrucao));
  IF IF(.clock(clock), .controle_PC(Controle.controlePC), .Rom_sink_ren(Controle.Rom_sink_ren), .Rom_sink_cen(Controle.Rom_sink_cen));
  ID_RF ID_RF(.clock(clock), .BR_Hab_Escrita(Controle.BR_Hab_Escrita), .EXcontrole(Controle.EXcontrole), .BR_Sel_E_SA(Controle.BR_Sel_E_SA), .BR_Sel_SB(Controle.BR_Sel_SB), .EXconstante(Controle.EXconstante), .entrada_ULA(EX_MEN.Saida_ULA), .entrada_MD(EX_MEN.Saida_MemoriaDados), .controle(Controle.Controle_Mux2));
  EX_MEN EX_MEN(.clock(clock), .MD_Hab_Escrita(Controle.MD_Hab_Escrita), .controleMUX_ULA(Controle.Controle_Mux1), .ULA_OP(Controle.ULA_OP), .A(ID_RF.A), .B(ID_RF.B), .constanteExtendida(ID_RF.constanteExtendida));

  initial clock=1;
  always #5 clock = ~clock;
  
  always begin
	instrucao = IF.instrucao;
	
	#1
	if(count_stop>=1200)
		$stop;
	count_stop = count_stop+1;
  end
  
endmodule


