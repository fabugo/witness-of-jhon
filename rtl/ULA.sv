/*
* @author Fábio
* Module: ULA
* Purpose: bloco que une as 2 ULAS: AR/LO em uma unica ULA
*/
include "RTL\\ULA_AR.sv";
include "RTL\\ULA_LO.sv";

module ULA (
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

	input reg signed [bits-1:0] A,B;	//dados para operacao
	input reg [4:0] OP;			//tipo de operacao
	output reg [bits-1:0] RESU;	//resultado da operacao
	output logic 	O,			//flag que indica se ouve overflow na operacao
					C,			//flag que indica se ouve carryout na operacao
					S,			//flag que indica o sinal do resultado da operacao
					Z;			//flag que indica que o resultado da operacao é Zero
	reg signed [bits-1:0] 	RES_AR,		//Resultado de operacao aritimetica
					RES_LO;		//resultado de operacao logica

	ULA_AR u_ar(.A(A),.B(B),.OP(OP),.RESU(RES_AR),.O(O1),.C(C1),.S(S1),.Z(Z1));
	ULA_LO u_lo(.A(A),.B(B),.OP(OP),.RESU(RES_LO),.O(O2),.C(C2),.S(S2),.Z(Z2));

	always @(A or B or OP)begin
		if (OP[5:4] == 2'b00)begin
			RESU = RES_AR;
			O = O1;
			C = C1;
			S = S1;
			Z = Z1;
		end else begin
			RESU = RES_LO;
			O = O2;
			C = C2;
			S = S2;
			Z = Z2;
		end
	end
	
endmodule
