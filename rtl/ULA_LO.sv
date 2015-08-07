/*
* @author Fábio
* Module: ULA_LO
* Purpose: Ula que realiza somente operações logicas
*/
module ULA_LO (
	A,
	B,
	OP,
	RESU,
	O,
	C,
	S,
	Z
);
	parameter bits=3;

	input reg [bits-1:0] A,B;	//dados para operacao
	input reg [4:0] OP;			//tipo de operacao
	output reg [bits-1:0] RESU;	//resultado da operacao
	output logic 	O,			//flag que indica se ouve overflow na operacao
					C,			//flag que indica se ouve carryout na operacao
					S,			//flag que indica o sinal do resultado da operacao
					Z;			//flag que indica que o resultado da operacao é Zero
	logic [bits:0] AUX;			//Auxilia na identificação de carry e overflow
	
	always @(A or B or OP)begin
		case (OP)
			5'b01000:begin//deslocamento logico
			   	AUX = A << 1;
				C = AUX[bits];
				RESU = AUX;
			end
			5'b01001:begin//deslocamento aritimetico
				C = A[0];
			   	AUX = A >>> 1;
			   	RESU = AUX;
			   	RESU[bits-1] = AUX[bits-2];
		   end
			5'b10011: RESU = B;
			5'b11111: RESU = 1;

			5'b10000: RESU = 0;

			5'b10001: RESU = A & B;
			5'b10010: RESU = (~A) & B;
			5'b10100: RESU = A & (~B);
			5'b10101: RESU = A;
			5'b10110: RESU = A ^ B;
			5'b10111: RESU = A | B;
			5'b11000: RESU = (~A) & (~B);
			5'b11001: RESU = ~(A ^ B);
			5'b11010: RESU = (~A);
			5'b11011: RESU = (~A) | (B);
			5'b11100: RESU = (~B);
			5'b11101: RESU = A | (~B);
			5'b11110: RESU = (~A) | (~B);
			default: RESU = OP;
		endcase
		if (!((OP == 5'b10011) || (OP == 5'b11111)))begin
			if(RESU == 0)
				Z = 1;
			else
				Z = 0;
			if(!(OP==5'b10000))
				S = RESU[bits-1];
		end
	end
endmodule