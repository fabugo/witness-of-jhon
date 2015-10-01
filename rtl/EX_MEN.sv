include "Registrador_Flags.sv";
include "TesteFlagsTemporario.sv";
include "MUX_ULA_PC.sv";
include "MUX_ULA.sv";
include "ULA.sv";
include "Memoria_Dados.sv";


module EX_MEN(clock, MD_Hab_Escrita, controleMUX_ULA, ULA_OP, A, B, constanteExtendida, Saida_ULA, Saida_MemoriaDados, PC, controleMUX_PC, atualizaFlag, condicaoJump, Jump_Ver_Fal, s_hab_jump);
  input clock;
  input wire MD_Hab_Escrita, controleMUX_ULA, controleMUX_PC, Jump_Ver_Fal;
  input reg [7:0] ULA_OP;
  input [3:0] condicaoJump;
  input [4:0] atualizaFlag;
  input reg [15:0] A, B, constanteExtendida, PC;
  output reg [15:0] Saida_ULA, Saida_MemoriaDados;
  output s_hab_jump;
  wire [15:0] saida_Mux, saida_Mux_PC; 
  wire Z, C, S, O;
  wire [3:0] ZCSO;
  
  TesteFlagsTemporario TesteFlagsTemporario(
  .RFlag_ZCSO(ZCSO), 
  .condicao(condicaoJump), 
  .Ver_Fal(Jump_Ver_Fal), 
  .saida(s_hab_jump)
  );
  
  	Registrador_Flags Registrador_Flags(
		.Z(Z), 
		.C(C), 
		.S(S), 
		.O(O), 
		.controleOperacao(atualizaFlag), 
		.ZCSO(ZCSO),
		.clock(clock)
	);
  
  
  MUX_ULA_PC MUX_ULA_PC(
  .entrada_BR(A), 
  .entrada_PC(PC), 
  .saida_Mux(saida_Mux_PC),
  .controle(controleMUX_PC)
  );
  
  MUX_ULA MUX_ULA(
  .entrada_BR(B), 
  .entrada_EX(constanteExtendida), 
  .saida_Mux(saida_Mux),
  .controle(controleMUX_ULA)
  );
  
  ULA ULA(
  .A(saida_Mux_PC), 
  .B(saida_Mux), 
  .OP(ULA_OP), 
  .RESU(Saida_ULA),
  .Z(Z), 
  .C(C), 
  .S(S), 
  .O(O)
  );  
  
  Memoria_Dados Memoria_Dados (
  .Hab_Escrita(MD_Hab_Escrita), 
  .endereco(A), 
  .Entrada(B), 
  .Saida(Saida_MemoriaDados),
  .clock(clock)
  );
 
endmodule 
