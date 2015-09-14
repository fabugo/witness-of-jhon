include "Clock.sv";
include "PC.sv";  
include "Memoria_de_Instrucao.sv";  
include "Banco_Registro.sv";
include "Extensor.sv"; 
include "MUX_ULA.sv";
include "ULA.sv";
include "ADD_PC.sv";


module Controle(botao);
  input botao; 
	reg [15:0]instrucao;
	reg [2:0] estado = 3'b000, prox_estado = 3'b000;	
	
	
	//------------------------------------------ 1º CICLO
	reg [5:0] aux_PC;
	logic controlePC;
	logic resetMI;
	//------------------------------------------ 2º CICLO
	parameter end_registros = 2; 
	reg [15:0] BR_Entrada;
	logic [end_registros-1:0] BR_Sel_E_SA, BR_Sel_SB; 
	logic BR_Hab_Escrita, BR_reset;
	//------------------------------------------ 3º CICLO
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
	
	always
	 estado <= prox_estado; 
	
	always @(estado)
	begin
	  
	  case(estado)
	     
	    3'b000: begin // Leitura da instrução a ser executada. ******************************************************************
	      if(botao) begin	
		       instrucao = Memoria_de_Instrucao.instrucao;  
			     aux_PC = PC.pc_out;                                                                                       
		       controlePC = 1'b1;  
		       #10
			     controlePC = 1'b0; 
			     
	         prox_estado = 3'b001; 
	       end  
	    end
	    
	    3'b001: begin // A instrução é decodificada e os operandos são lidos do banco de registradores *************************
	      			  
		   controleMUX_ULA = 1'b1;                                                                                   
	      
			 if(instrucao[15:14] == 2'b10) begin                                                                       
				  BR_Hab_Escrita = 1'b0;                                                                                 
				  BR_Sel_E_SA = instrucao[5:3];                                                                          
				  BR_Sel_SB = instrucao[2:0];  
	        #50
		      controleMUX_ULA = 1'b0;                                                                                 
				  auxULA_OP[4:0] = instrucao[10:6];  
					RegFlag_Controle = instrucao[10:6];                                                                    
					                                                                    
			 end 
			 else if(instrucao[15:14] == 2'b01) begin                                                                   
	          
					BR_Hab_Escrita = 1'b0;                                                                                  
					BR_Sel_E_SA = instrucao[13:11];                                                                         
					EXconstante = instrucao[10:0];                                                                          
				  EXcontrole = 2'b00; 
				  RegFlag_Controle = 5'b11111;
				    
			 end 
			 else if(instrucao[15:14] == 2'b11) begin  
			   
				  BR_Hab_Escrita = 1'b0;                                                                                 
	        BR_Sel_E_SA = instrucao[13:11];                                                                        
	        EXconstante = instrucao[7:0];
	        RegFlag_Controle = 5'b11111;                                                            
				    
				  if(instrucao[10] == 1'b0)                                                                              
					   EXcontrole = 2'b01;                                                                                 
				  if(instrucao[10] == 1'b1)                                                                              
					   EXcontrole = 2'b10;  
			 end
			    
	         prox_estado = 3'b011; 
	    end
	    
	    3'b011: begin // A instrução é executada e as condições dos resultados são calculados *********************************
	   	    
			     auxULA_OP[7:6] = instrucao[15:14];                                                                       
			     auxULA_OP[5] = instrucao[10];  
	         ULA_OP = auxULA_OP;  
	         #10 
	         prox_estado = 3'b100; 
	    end

	    	    
	    3'b100: begin // Os resultados são escritos no banco de registradores *************************************************
	    
			     BR_Entrada = ULA.RESU;                                                                                    
			     BR_Sel_E_SA = instrucao[13:11];                                                
	         BR_Hab_Escrita = 1'b1;                                                                                   
	         #50
			     prox_estado = 3'b000;
	    end
	    
	    default: begin
	        prox_estado = 3'b000; // (volta ao primeiro ciclo)
	    end
		  
	  endcase
	end
	
endmodule
