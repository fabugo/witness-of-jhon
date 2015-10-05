/*
* @author Fábio
* Module: ULA
* Purpose: bloco que une as 2 ULAS: AR/LO em uma unica ULA
*/
include "ULA_AR.sv";
include "ULA_LO.sv";
include "ULA_C.sv";

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
	parameter bits=16;

	input reg signed [bits-1:0] A,B;	//dados para operacao
	input reg [7:0] OP;				    // [7:6 = Constante][5 = R][4:0 = Operaçao Lóg Art]
									
	
	output reg signed [bits-1:0] RESU;	//resultado da operacao
	output reg	O,				  	//flag que indica se ouve overflow na operacao
				C,					//flag que indica se ouve carryout na operacao
				S,					//flag que indica o sinal do resultado da operacao
				Z;					//flag que indica que o resultado da operacao é Zero
					
	reg signed [bits-1:0] RESU_LO, RESU_AR, RESU_C;
	reg AR_O, AR_C, AR_S, AR_Z, LO_O, LO_C, LO_S, LO_Z;
	
	ULA_AR ULA_AR(
	.A(A),
	.B(B),
	.OP(OP[4:0]),
	.RESU(RESU_AR),
	.O(AR_O),
	.C(AR_C),
	.S(AR_S),
	.Z(AR_Z)
	);
	
	ULA_LO ULA_LO(
	.A(A),
	.B(B),
	.OP(OP[4:0]),
	.RESU(RESU_LO),
	.O(LO_O),
	.C(LO_C),
	.S(LO_S),
	.Z(LO_Z)
	);
	
	ULA_C ULA_C(
	.dado(A), 
	.constante(B), 
	.formato(OP[7:6]), 
	.R(OP[5]),
	.resultOP(RESU_C)
	);

	always_comb  begin
	
	if ((OP[7:6] == 2'b10) | (OP[7:6] == 2'b00))
		if (OP[4:3] == 2'b00) begin 
			RESU = RESU_AR;	
			O = AR_O;
			C = AR_C;
			S = AR_S;
			Z = AR_Z;
		end else begin
			RESU = RESU_LO;
			O = LO_O;
			C = LO_C;
			S = LO_S;
			Z = LO_Z;			
		end
	else 
		RESU = RESU_C;	
	
  end	
endmodule
