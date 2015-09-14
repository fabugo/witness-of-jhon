/*
* @author Fábio
* Module: ULA
* Purpose: bloco que une as 2 ULAS: AR/LO em uma unica ULA
*/
include "rtl\\ULA_AR.sv";
include "rtl\\ULA_LO.sv";
include "rtl\\ULA_C.sv";

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
					

	ULA_AR ULA_AR(.A(A),.B(B),.OP(OP[4:0]));
	ULA_LO ULA_LO(.A(A),.B(B),.OP(OP[4:0]));
	ULA_C ULA_C(.dado(A), .constante(B), .formato(OP[7:6]), .R(OP[5]));

	always  @(A or B or OP)  begin
	
	if (OP[7:6] == 2'b10)
		if (OP[4:3] == 2'b00) begin 
			RESU = ULA_AR.RESU;
			O = ULA_AR.O;
			C = ULA_AR.C;
			S = ULA_AR.S;
			Z = ULA_AR.Z;
		end else begin
			RESU = ULA_LO.RESU;
			O = ULA_LO.O;
			C = ULA_LO.C;
			S = ULA_LO.S;
			Z = ULA_LO.Z;
		end
	else 
		RESU = ULA_C.resultOP;
	
  end	
endmodule
