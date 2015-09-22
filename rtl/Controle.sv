
module Controle(clock, reset, instrucao, controlePC, Rom_sink_ren, Rom_sink_cen, BR_Sel_E_SA, BR_Sel_SB, BR_Hab_Escrita, MD_Hab_Escrita, EXconstante, EXcontrole, ULA_OP, Controle_Mux1, Controle_Mux2, botao);
  input reset, clock, botao;
  input reg [15:0] instrucao;
  
  output logic [1:0] EXcontrole; 
  output logic [2:0] BR_Sel_E_SA, BR_Sel_SB;
  output reg [7:0] ULA_OP;
  output reg [10:0] EXconstante;
  output logic controlePC, Rom_sink_ren, Rom_sink_cen, BR_Hab_Escrita, MD_Hab_Escrita, Controle_Mux1, Controle_Mux2;
  
  reg [1:0] estado, prox_estado;
  reg [4:0] RegFlag_Controle;
  reg [7:0] auxULA_OP; 
  reg [15:0]aux_PC, BR_Entrada,	Saida_ULA;
			 	
  logic primeiro_ciclo = 1'b1;
  
	
  
  initial begin
   estado = 2'b00; 
  end 

  always @(posedge clock) begin
    /*if(reset)
      estado<=2'b00;
    else*/
      estado <= prox_estado;
   end
     
  always @(estado)
  begin
    case(estado)
      2'b00:begin  // ==================================================================================================
        if(botao) begin
			prox_estado = 2'b01; 
			BR_Hab_Escrita = 1'b0;
			if(!primeiro_ciclo) begin
				Rom_sink_ren = 1'b1; 
				Rom_sink_cen = 1'b1;                                                                                      
				controlePC = 1'b1;	 // Precisa-se alterar		
			end
			primeiro_ciclo = 1'b0;
		end
      end
      2'b01:begin  // ================================================================================================== 
        prox_estado = 2'b10;                                                                                       
		controlePC = 1'b0; 	 // Precisa-se alterar
		Rom_sink_ren = 1'b0; 
		Rom_sink_cen = 1'b0;
        
		MD_Hab_Escrita = 1'b0;
		BR_Hab_Escrita = 1'b0; 
		if(instrucao[15:14] == 2'b10) begin 						// L.A ou Load/Store                    
		    BR_Sel_E_SA = instrucao[5:3];                                                                          
		    BR_Sel_SB = instrucao[2:0];  			
		end else if(instrucao[15:14] == 2'b01) begin                // Constante FI                                                                   
			EXconstante = instrucao[10:0];                                                                          
			EXcontrole = 2'b00;
		end else if(instrucao[15:14] == 2'b11) begin                // Constante FII
            BR_Sel_E_SA = instrucao[13:11]; 		
			EXconstante = instrucao[7:0];
			if(instrucao[10] == 1'b0)                                                                              
				EXcontrole = 2'b01;                                                                               
			if(instrucao[10] == 1'b1)                                                                              
				EXcontrole = 2'b10;  
		end else if(instrucao[15:14] == 2'b00) begin                // Jump
			if(instrucao[13:12] == 2'b00) begin                     // Jump False
				
			
			end if(instrucao[13:12] == 2'b01) begin                 // Jump True
			
			end if(instrucao[13:12] == 2'b10) begin                 // Jump Incondicional
			
			end if(instrucao[13:12] == 2'b11) begin      
				if(instrucao[11] == 1'b0) begin                     // Jump and Link
				
				end if(instrucao[11] == 1'b1) begin                 // Jump Register
				
				end
			end
		end

      end
     2'b10:begin  // ==================================================================================================  
        prox_estado = 2'b11;
		
		Controle_Mux1 = 1'b1;                             
	      
		if(instrucao[15:14] == 2'b10) begin
			Controle_Mux1 = 1'b0; 
			if(instrucao[10:6] == 5'b01011) begin
				BR_Hab_Escrita = 1'b0;  
				MD_Hab_Escrita = 1'b1;
			end	else begin                                                                       
				auxULA_OP[4:0] = instrucao[10:6];  
			end 
		end
		
		auxULA_OP[7:6] = instrucao[15:14];                                                                       
	   	auxULA_OP[5] = instrucao[10];
	    ULA_OP = auxULA_OP;
      end
      2'b11:begin // ================================================================================================== 
        prox_estado = 2'b00;
				
		Controle_Mux2 = 1'b0;		
		BR_Hab_Escrita = 1'b1;	
		BR_Sel_E_SA = instrucao[13:11];
		
		if((instrucao[15:14] == 2'b10) & (instrucao[10:6] == 5'b01010))   // Load
		    Controle_Mux2 = 1'b1;
				
		
		if(
			((instrucao[15:14] == 2'b10) & (instrucao[10:6] == 5'b01011)) |
			(instrucao[15:14] == 2'b00)
		) 	// operacao Store ou Jump
			BR_Hab_Escrita = 1'b0;
		
      end
        default: begin // =============================================================================================
			prox_estado = 2'b00;
		end
      
      endcase

  end
endmodule

