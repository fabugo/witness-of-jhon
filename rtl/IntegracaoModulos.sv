include "IF.sv"; 
include "ID_RF.sv";
include "EX_MEN.sv";
include "Controle.sv"; //Controle

module IntegracaoModulos(clock, botao);
  input clock, botao;
<<<<<<< HEAD
  wire controlePC, Rom_sink_ren, Rom_sink_cen, BR_Hab_Escrita, MD_Hab_Escrita, 
		Controle_Mux1, Jump_Ver_Fal, controleMUX_PC, s_hab_jump,controlePCcopia;
=======
  wire controlePC, Rom_sink_ren, Rom_sink_cen, BR_Hab_Escrita, MD_Hab_Escrita, Controle_Mux1, Jump_Ver_Fal, controleMUX_PC, s_hab_jump;
>>>>>>> origin/jump
  wire [1:0] Controle_Mux2;
  wire [2:0] EXcontrole, BR_Sel_E_SA, BR_Sel_SB;
  wire [3:0] condicaoJump;
  wire [4:0] atualizaFlag;
  wire [7:0] ULA_OP;
  wire [11:0] EXconstante;
  wire [15:0] instrucao, Saida_ULA, Saida_MemoriaDados, A, B, constanteExtendida, PC;
  
  
  Controle Controle(
  .clock(clock), 
  .reset(1'b0), 
  .instrucao(instrucao),
  .controlePC(controlePC),
  .Rom_sink_ren(Rom_sink_ren),
  .Rom_sink_cen(Rom_sink_cen),
  .BR_Sel_E_SA(BR_Sel_E_SA), 
  .BR_Sel_SB(BR_Sel_SB),
  .BR_Hab_Escrita(BR_Hab_Escrita), 
  .MD_Hab_Escrita(MD_Hab_Escrita),
  .EXconstante(EXconstante), 
  .EXcontrole(EXcontrole),
  .ULA_OP(ULA_OP),
  .Controle_Mux1(Controle_Mux1),
  .Controle_Mux2(Controle_Mux2),
  .botao(botao),
  .jump_ver_fal(Jump_Ver_Fal),
  .controleMUX_PC(controleMUX_PC),
  .atualizaFlag(atualizaFlag),
  .condicaoJump(condicaoJump),
  .controlePCcopia(controlePCcopia)
  );
  
  IF IF(
  .clock(clock), 
  .instrucao(instrucao),
  .controle_PC(controlePC), 
  .Rom_sink_ren(Rom_sink_ren), 
  .Rom_sink_cen(Rom_sink_cen),
  .jumpPC(Saida_ULA),
  .habJump(s_hab_jump),
  .pc_out(PC)
  );
  
  ID_RF ID_RF(
  .clock(clock), 
  .BR_Hab_Escrita(BR_Hab_Escrita), 
  .EXcontrole(EXcontrole), 
  .BR_Sel_E_SA(BR_Sel_E_SA), 
  .BR_Sel_SB(BR_Sel_SB), 
  .entrada_ULA(Saida_ULA), 
  .controleMuxResu(Controle_Mux2), 
  .entrada_MD(Saida_MemoriaDados),
  .EXconstante(EXconstante), 
  .A(A), 
  .B(B), 
<<<<<<< HEAD
  .constanteExtendida(constanteExtendida),
  .PC(PC),
  .controlePCcopia(controlePCcopia)
=======
  .constanteExtendida(constanteExtendida)
  .entrada_PC(PC)
>>>>>>> origin/jump
  );
  
  EX_MEN EX_MEN(
  .clock(clock), 
  .MD_Hab_Escrita(MD_Hab_Escrita), 
  .controleMUX_ULA(Controle_Mux1), 
  .ULA_OP(ULA_OP), 
  .A(A), 
  .B(B), 
  .constanteExtendida(constanteExtendida),
  .Saida_ULA(Saida_ULA), 
  .Saida_MemoriaDados(Saida_MemoriaDados),
  .PC(PC),
  .controleMUX_PC(controleMUX_PC),
  .atualizaFlag(atualizaFlag),
  .condicaoJump(condicaoJump),
  .s_hab_jump(s_hab_jump),
  .Jump_Ver_Fal(Jump_Ver_Fal)
  );

endmodule


