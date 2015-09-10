include "Clock.sv";
include "ADD_PC.sv";
include "PC.sv";  
include "Memoria_de_Instrucao.sv";  
include "Banco_Registro.sv";
include "Extensor.sv"; 
include "MUX_ULA.sv";
include "ULA.sv";
include "Registrador_Flags.sv";

module Teste1;
  logic botao;  
	logic [15:0]instrucao;
	integer file;
	
	//------------------------------------------ 1� CICLO
	reg [5:0] aux_PC;
	logic controlePC;
	logic resetMI;
	//------------------------------------------ 2� CICLO
	parameter end_registros = 2; 
	reg [15:0] BR_Entrada;
	logic [end_registros-1:0] BR_Sel_E_SA, BR_Sel_SB; 
	logic BR_Hab_Escrita, BR_reset;
	//------------------------------------------ 3� CICLO
	logic controleMUX_ULA;
	reg signed [15:0] ULA_A, ULA_B;	
	reg [7:0] ULA_OP, auxULA_OP;				

	logic [1:0] EXcontrole; 
	reg [10:0] EXconstante;
	logic Flags_Reset;
	reg [4:0] RegFlag_Controle;
	
	
	Clock Clock (); 
  ADD_PC ADD_PC(.pc_in(aux_PC), .controle(controlePC));
	PC PC(.pc_in(ADD_PC.pc_out));
	Memoria_de_Instrucao Memoria_de_Instrucao(.clk_MI(Clock.clk), .pc(PC.pc_out), .reset(resetMI)); 
	Banco_Registro Banco_Registro(.Hab_Escrita(BR_Hab_Escrita), .Sel_E_SA(BR_Sel_E_SA), .Sel_SB(BR_Sel_SB), .reset(BR_reset), .clock(Clock.clk), .E(BR_Entrada));
  Extensor Extensor(.controle(EXcontrole), .constante(EXconstante));	
  MUX_ULA MUX_ULA(.entrada_BR(Banco_Registro.B), .entrada_EX(Extensor.constanteExtendida), .controle(controleMUX_ULA));
  ULA ULA(.A(Banco_Registro.A), .B(MUX_ULA.saida_Mux), .OP(ULA_OP));
  Registrador_Flags Registrador_Flags(.Z(ULA.Z), .C(ULA.C), .S(ULA.S), .O(ULA.O), .controleOperacao(RegFlag_Controle), .clock(Clock.clk), .reset(Flags_Reset));
	
	initial begin
		file = $fopen("Teste.txt");
				
		repeat(27)begin
		  #10
		  botao = 1'b1;
		  if(botao) begin	 
		    
		     $fdisplay(file,"\n---------------------------------------------------- *** IN�CIO DA INSTRU�AO");      
		       
		     // --------------------------------------------------------------------------- 1� CICLO
		     instrucao = Memoria_de_Instrucao.instrucao;                                                               // L� A INSTRUCAO
			   $fdisplay(file," (antes) PC = %b		Instrucao = %b ",PC.pc_out,Memoria_de_Instrucao.instrucao);
			   
			   aux_PC = PC.pc_out;                                                                                       // ENVIA PC PRA ADICIONAR +1
		     controlePC = 1'b1;                                                                                        // HABILITA A SOMA pc
		    
		     #10
		     $fdisplay(file,"(depois) PC = %b	\n",PC.pc_out);
			   controlePC = 1'b0;                                                                                        // DESABILITA A SOMA PC
		  // --------------------------------------------------------------------------- 2� CICLO
			  
		     controleMUX_ULA = 1'b1;                                                                                   // Usada no ciclo 3, SELECIONA OPERANDO
	      
			   if(instrucao[15:14] == 2'b10) begin                                                                       // SE L�GICA ARITM�TICA
				    BR_Hab_Escrita = 1'b0;                                                                                 // DESABILITA ESCRITA
				    BR_Sel_E_SA = instrucao[5:3];                                                                          // SELECIONA OP A
				    BR_Sel_SB = instrucao[2:0];                                                                            // SELECIONA OP B
	         
	          #50
		        $fdisplay(file,"Instru��o L�gica Aritm�tica ");
		        $fdisplay(file," A >> Endere�o_Registro %b : Dado_Registro	%b = %d ",instrucao[5:3], Banco_Registro.A, Banco_Registro.A);
		        $fdisplay(file," B >> Endere�o_Registro %b : Dado_Registro	%b = %d \n",instrucao[2:0], Banco_Registro.B, Banco_Registro.B);
			 
				    controleMUX_ULA = 1'b0;                                                                                 // Usada no ciclo 3, SELECIONA OPERANDO
				    auxULA_OP[4:0] = instrucao[10:6];  
					  RegFlag_Controle = instrucao[10:6];                                                                    // USADA NO CICLO 3, OPERA�AO DA ULA
					                                                                    
			   end else if(instrucao[15:14] == 2'b01) begin                                                                   // CONTROLE EXTENSOR DE SINAL
	          
	          BR_Hab_Escrita = 1'b0;                                                                                  // DESABILITA ESCRITA
	          BR_Sel_E_SA = instrucao[13:11];                                                                         // SELECIONA A
	          EXconstante = instrucao[10:0];                                                                          // CONSTANTE DA OPERA�AO
				    EXcontrole = 2'b00; 
				    RegFlag_Controle = 5'b11111;
				    
				    #50
		        $fdisplay(file,"Formato I ");
		        $fdisplay(file,"Controle >> %b",EXcontrole);
				    $fdisplay(file," A >> Endere�o_Registro %b : Dado_Registro	%b = %d ",instrucao[13:11], Banco_Registro.A, Banco_Registro.A);
		        $fdisplay(file," B >> Constante %b = %d : Constante_Extendida	%b = %d \n",EXconstante, EXconstante, Extensor.constanteExtendida, Extensor.constanteExtendida);
				
			   end else if(instrucao[15:14] == 2'b11) begin  
			   
				    BR_Hab_Escrita = 1'b0;                                                                                 // DESABILITA ESCRITA
	          BR_Sel_E_SA = instrucao[13:11];                                                                        // SELECIONA A
	          EXconstante = instrucao[7:0];
	          RegFlag_Controle = 5'b11111;                                                            
				    
				    if(instrucao[10] == 1'b0)                                                                              // CASO LCL
					     EXcontrole = 2'b01;                                                                                 // CONTROLE EXTENSOR lcl c, Const8
				    if(instrucao[10] == 1'b1)                                                                              // CASO LCH
					     EXcontrole = 2'b10;                                                                                 // CONTROLE EXTENSOR lch c, Const8 
				    
				    #50          
		        $fdisplay(file,"Formato II \n");
		        $fdisplay(file,"R : %b",instrucao[10]);
		        $fdisplay(file,"Controle >> %b",EXcontrole);
				    $fdisplay(file," A >> Endere�o_Registro %b : Dado_Registro	%b = %d ",instrucao[13:11], Banco_Registro.A, Banco_Registro.A);
		        $fdisplay(file," B >> Constante %b = %d : Constante_Extendida	%b = %d \n",EXconstante, EXconstante, Extensor.constanteExtendida, Extensor.constanteExtendida);
				    
			   end 
			
		  // --------------------------------------------------------------------------- 3� CICLO   
		  
		     auxULA_OP[7:6] = instrucao[15:14];                                                                       // DEFINE TIPO DE OP : L.A, FI, FII
	   	   auxULA_OP[5] = instrucao[10];                                                                            // CASO FORMATO II : R
	   	    	 
	       ULA_OP = auxULA_OP;                                                                                      // CONTROLE ULA
	    
	       #10  	       
			   $fdisplay(file,"Opera��o %b : Resultado %b = %d\n",ULA_OP, ULA.RESU, ULA.RESU); 
			   $fdisplay(file,"ULA Flag's ZCSO %b%b%b%b \n",ULA.Z, ULA.C, ULA.S, ULA.O);  
			   $fdisplay(file,"ContoleBF %b : Banco Flag's ZCSO %b \n",RegFlag_Controle, Registrador_Flags.ZCSO);  
		  
		  // --------------------------------------------------------------------------- 4� CICLO 
		
			   BR_Entrada = ULA.RESU;                                                                                    // RESULTADO ULA
			   BR_Sel_E_SA = instrucao[13:11];                                                                           // ENDERE�O ONDE SALVA RESULTADO
			   #50 
			   $fdisplay(file,"Endere�o_Registro_Escrita %b = %d ", instrucao[13:11], instrucao[13:11]); 
			   $fdisplay(file,"Registrador_Antes %b = %d ", Banco_Registro.A, Banco_Registro.A); 
	       BR_Hab_Escrita = 1'b1;                                                                                   // Habilita escrita
	       #50
			   $fdisplay(file,"Registrador_Depois %b = %d ", Banco_Registro.A, Banco_Registro.A);
		  end // Bot�o
  end // La�o
	$fclose(file);
	
	end
	endmodule 

