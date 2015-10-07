//Precisa: Replicar sinais nos proximos ciclos
module Controle(clock, reset, instrucao, controlePC, Rom_sink_ren, Rom_sink_cen, BR_Sel_E_SA, BR_Sel_SB, BR_Hab_Escrita, MD_Hab_Escrita, EXconstante, EXcontrole, ULA_OP, Controle_Mux1, Controle_Mux2, botao, jump_ver_fal, controleMUX_PC, atualizaFlag, condicaoJump, controlePCcopia);
  input reset, clock, botao;
  input reg [15:0] instrucao;
  output reg [1:0] Controle_Mux2;
  output reg [2:0] EXcontrole, BR_Sel_E_SA, BR_Sel_SB;
  output reg [3:0] condicaoJump;
  output reg [4:0] atualizaFlag;
  output reg [7:0] ULA_OP;
  output reg [11:0] EXconstante;
  output logic controlePC, Rom_sink_ren, Rom_sink_cen, BR_Hab_Escrita, MD_Hab_Escrita, Controle_Mux1, jump_ver_fal, controleMUX_PC, controlePCcopia;


  reg [1:0] estado, prox_estado;
  reg [4:0] RegFlag_Controle;
  reg [7:0] auxULA_OP;
  reg [15:0] BR_Entrada, Saida_ULA;

  logic primeiro_ciclo = 1'b1;

  initial begin
   estado = 2'b00;
  end

  always @(posedge clock) begin
    if(reset)
      estado<=2'b00;
    else
      estado <= prox_estado;
   end

  always @(estado)
  begin
    case(estado)
      2'b00:begin  // ==================================================================================================
        atualizaFlag = 5'b11111;
		if(botao) begin
			prox_estado = 2'b01;
			BR_Hab_Escrita = 1'b0;
			if(!primeiro_ciclo) begin
				Rom_sink_ren = 1'b1;
				Rom_sink_cen = 1'b1;
				controlePC = 1'b1;
			end
			primeiro_ciclo = 1'b0;
		end
      end
      2'b01:begin  // ==================================================================================================
        prox_estado = 2'b10;
		controlePC = 1'b0;
		Rom_sink_ren = 1'b0;
		Rom_sink_cen = 1'b0;

		MD_Hab_Escrita = 1'b0;
		BR_Hab_Escrita = 1'b0;
		controleMUX_PC = 1'b1;
		atualizaFlag = 5'b11111;

		if(instrucao[15:14] == 2'b10) begin 						// L.A ou Load/Store
		    BR_Sel_E_SA = instrucao[5:3];
		    BR_Sel_SB = instrucao[2:0];

		end else if(instrucao[15:14] == 2'b01) begin                // Constante FI
			EXconstante = instrucao[10:0];
			EXcontrole = 3'b000;

		end else if(instrucao[15:14] == 2'b11) begin                // Constante FII
            BR_Sel_E_SA = instrucao[13:11];
			EXconstante = instrucao[7:0];
			if(instrucao[10] == 1'b0)
				EXcontrole = 3'b001;
			if(instrucao[10] == 1'b1)
				EXcontrole = 3'b010;

		end else if(instrucao[15:14] == 2'b00) begin                // Jump
<<<<<<< HEAD
			if((instrucao[13:12] == 2'b00) |
				(instrucao[13:12] == 2'b01)) begin                   // Jump False ou Jump True
				EXconstante = instrucao[7:0];
				EXcontrole = 3'b011;
=======
			if(instrucao[13:12] == 2'b00) begin                     // Jump False
				controleMUX_PC = 1'b0;
				condicaoJump = instrucao[11:8];
				hab_jump = 1'b0;

			end if(instrucao[13:12] == 2'b01) begin                 // Jump True
				controleMUX_PC = 1'b0;
				condicaoJump = instrucao[11:8];
				hab_jump = 1'b1;
>>>>>>> origin/jump

			end if(instrucao[13:12] == 2'b10) begin                 // Jump Incondicional
				EXconstante = instrucao[11:0];
				EXcontrole = 3'b100;
<<<<<<< HEAD

			end if(instrucao[13:12] == 2'b11) begin
				BR_Sel_SB = instrucao[2:0];                       // Jump Register e Jump and Link

				if(instrucao[11] == 1'b0)                         // Jump and Link
					controlePCcopia = 1'b1;
=======

			end if(instrucao[13:12] == 2'b11) begin
				if(instrucao[11] == 1'b0) begin                     // Jump and Link
					BR_Sel_SB = 3'b111;                             // Escreve em R7 o valor de PC+1
					Controle_Mux2 = 2'b01;                          // Indica que a saída do mux será o pc+1
					BR_Hab_Escrita = 1'b1;                          // Habilita a escrita no banco de registradores

					BR_Sel_SB = instrucao[2:0];                     // Mando para a saída do banco o valor do registrador referenciado por RB

				end if(instrucao[11] == 1'b1) begin                 // Jump Register
					BR_Sel_SB = instrucao[2:0];

				end
>>>>>>> origin/jump
			end
		end

      end
     2'b10:begin  // ==================================================================================================
        prox_estado = 2'b11;
		Controle_Mux1 = 1'b1;
		controlePCcopia = 1'b0;

		if((instrucao[15:14] == 2'b10)                           // Sinal para atualizar flag
			& (instrucao[10:6] != 5'b01010)
			& (instrucao[10:6] != 5'b01011))
			atualizaFlag = instrucao[10:6];
		else
			atualizaFlag = 5'b11111;

		if(instrucao[15:14] == 2'b00) begin  // Se é jump (faço o jump enviando o valor do RB para o PC)
			if (instrucao[13:12] == 2'b11) begin  //Se é jump formato III
				    auxULA_OP[4:0] = 5'b10011;    //Operação passb (pego o valor da saída B do banco de registradores)
				    condicaoJump = 4'b0000;       //Indica por testador de flags pra fazer o jump
				    hab_jump = 1'b1;              //Indico que a condição precisa ser verdadeira
			end
		end

		if(instrucao[15:14] == 2'b10) begin						// L.A ou Load/Store
			Controle_Mux1 = 1'b0;
			if(instrucao[10:6] == 5'b01011)
				MD_Hab_Escrita = 1'b1;
			else
				auxULA_OP[4:0] = instrucao[10:6];

		end else if(instrucao[15:14] == 2'b00) begin
			if((instrucao[13:12] == 2'b00) |
				(instrucao[13:12] == 2'b01)) begin                   // Jump False ou Jump True
				controleMUX_PC = 1'b0;
				auxULA_OP[4:0] = 5'b00000;
				condicaoJump = instrucao[11:8];
				jump_ver_fal = instrucao[12];

			end if(instrucao[13:12] == 2'b10) begin                 // Jump Incondicional
				controleMUX_PC = 1'b0;
				auxULA_OP[4:0] = 5'b00000;
				condicaoJump = 4'b1100;

			end if(instrucao[13:12] == 2'b11) begin                // Jump Register e Jump and Link
				auxULA_OP[4:0] = 5'b10011;
				condicaoJump = 4'b1100;
			end
		end


		auxULA_OP[7:6] = instrucao[15:14];
	   	auxULA_OP[5] = instrucao[10];
	    ULA_OP = auxULA_OP;

      end
      2'b11:begin // ==================================================================================================
        prox_estado = 2'b00;
		condicaoJump = 4'b1111;
		Controle_Mux2 = 2'b00;
		BR_Hab_Escrita = 1'b1;
		MD_Hab_Escrita = 1'b0;
		BR_Sel_E_SA = instrucao[13:11];
		jump_ver_fal = 1'b0;
		atualizaFlag = 5'b11111;

		if(instrucao[15:11] == 5'b00110)
			Controle_Mux2 = 2'b10;

		if((instrucao[15:14] == 2'b10) & (instrucao[10:6] == 5'b01010))   // Load
		    Controle_Mux2 = 2'b01;

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
