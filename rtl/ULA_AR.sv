/*
* @author Fabio, Lucas
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
	output logic	O,					//flag que indica se ouve overflow na operacao
					C,					//flag que indica se ouve carryout na operacao
					S,					//flag que indica o sinal do resultado da operacao
					Z;					//flag que indica que o resultado da operacao é Zero
	reg [bits+1:0] AUX, auxZERO;				//Auxilia na identificação de carry e overflow
	reg [bits+2:0] AUX2; //AUX2 serve para os casos de carry de operações de subtração
	reg signed [bits-1:0] auxMenosUm;
	always @(A or B or OP) begin
	
		O = 1'b0;
		C = 1'b0;
		S = 1'b0;
		Z = 1'b0;
		auxZERO = 18'b000000000000000000;		
		auxMenosUm = 16'b1111111111111111;
		case (OP)
			5'b00000: begin
				AUX = A+B; //adicao
				if((A[bits-1] != B[bits-1]) && AUX[bits] == 1'b0)
					C = 1;
				else if (A[bits-1] == 1 && B[bits-1] == 1)
					C = 1;
				else
					C = 0;
				if (A[bits-1] == B[bits-1] && A[bits-1] != AUX[bits-1])
					O = 1;
			end
			5'b00001: begin // adicao com incremento
				AUX = A + B + auxZERO; // A+B
				
				if(AUX[bits] == 1)
					C = 1;
				
				RESU = AUX[bits-1:0];
				AUX = RESU + 1 + auxZERO; // (A+B) + 1 + 0
				
				if(AUX[bits] == 1)
					C = 1;
				if (RESU[bits-1] == 0 && AUX[bits-1] == 1)
					O = 1;
			end
			5'b00011: begin //incremento
				AUX = A + 1 + auxZERO; 
				if(AUX[bits] == 1)
					C = 1;	
				if(A[bits-1] == 0 && AUX[bits-1] == 1)
					O = 1;		
			end
			5'b00100: begin  // subtracao com decremento				
				
				AUX = A - B + auxZERO; //A - B
				if(AUX[bits] == 1)
					C = 1;		
				RESU = AUX[bits-1:0];
				AUX = RESU - auxMenosUm + auxZERO; // (A-B) - 1 + 0
				if(AUX[bits] == 1)
					C = 1;
				if(RESU[bits-1] == 0 && AUX[bits-1] == 1)
					O = 1;
				end
			5'b00101: begin //subtracao
				AUX2 = B;
				if (AUX2 > A) 
					C = 1;
				AUX = A-B;
				if (A[bits-1] == 0 && B[bits-1] == 1 && AUX[bits-1] == 1)
					O = 1;
				else if (A[bits-1] == 1 && B[bits-1] == 0 && AUX[bits-1] == 0)
					O = 1;
			end
			5'b00110: begin
				AUX = A + auxMenosUm + auxZERO;				
				if(AUX[bits] == 1)
					C = 1; //decremento
				if(A[bits-1] == 0 && AUX[bits-1] == 1) // +A - (-1) = -C
					O = 1;
			end
			default : AUX = 1'd0;
		endcase
		RESU = AUX[bits-1:0];
		if (A[bits-1] == B[bits-1] && AUX[bits-1] != A[bits-1])
			O = 1;
		S = RESU [bits-1];

		if(!RESU)
			Z = 1;

	end
endmodule