/*
* @author Fábio
* Module: ULA_AR
* Purpose: Ula que realiza somente operaçoes aritimeticas
*/
module ULA_AR (
	A,
	B,
	OP,
	RESU,
	O,
	C,
	S,
	Z
);
	parameter bits=16;

	input reg signed [bits-1:0] A,B;	//dados para operacao
	input reg [4:0] OP;					//tipo de operacao
	output reg signed [bits-1:0] RESU;	//resultado da operacao
	output logic 	O,					//flag que indica se ouve overflow na operacao
					C,					//flag que indica se ouve carryout na operacao
					S,					//flag que indica o sinal do resultado da operacao
					Z;					//flag que indica que o resultado da operacao é Zero
	reg [bits+1:0] AUX, auxZERO;		// (18 bits [17:0]) Auxilia na identificação de carry e overflow
	reg [bits+2:0] AUX2; 			// (19 bits [18:0]) AUX2 serve para os casos de carry de operações de subtração
    reg signed [bits-1:0] auxMenosUm;

	always @(A or B or OP) begin
	
		O = 1'b0;
		C = 1'b0;
		S = 1'b0;
		Z = 1'b0;
		auxZERO = 18'b000000000000000000;
		auxMenosUm = 16'b1111111111111111;
		case (OP)
			5'b00000: begin // C = A + B
				AUX = A + B + auxZERO;
				
				if(AUX[bits] == 1)
					C = 1;
			end
			5'b00001: begin // C = A + B + 1
				
				AUX = A + B + auxZERO; // A+B
				
				if(AUX[bits] == 1)
					C = 1;
				
				RESU = AUX[bits-1:0];
				AUX = RESU + 1 + auxZERO; // (A+B) + 1 + 0
				
				if(AUX[bits] == 1)
					C = 1;
			end
			5'b00011: begin // C = A + 1
				AUX = A + 1 + auxZERO; 
				if(AUX[bits] == 1)
					C = 1;
			end
			5'b00100: begin  // C = A – B – 1				
				AUX2 = B-1;
				if (AUX2 > A) 
					C = 1;
				AUX = A-B-1;
			end
			5'b00101: begin // C = A – B
				AUX2 = B;
				if (AUX2> A) 
					C = 1;
				AUX = A-B;
				end
			5'b00110: begin // C = A – 1
					
				AUX = A + auxMenosUm + auxZERO;
				
				if(AUX[bits] == 1)
					C = 1;
			end
			default : AUX = 1'd0;
		endcase
		RESU = AUX[bits-1:0];
		
		if (RESU < -32768 || RESU > 32767)
					O = 1;
				else
					O = 0;
					
		S = RESU [bits-1];

		if(!RESU)
			Z = 1;
	
	end
endmodule