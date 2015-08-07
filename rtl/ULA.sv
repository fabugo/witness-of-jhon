include "ULA_AR.sv";
include "ULA_LO.sv";

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
	input reg [2:0] A,B;
	input reg [4:0] OP;
	output reg [2:0] RESU;
	output logic 	O,
					C,
					S,
					Z;
	reg [2:0] 	RES1,
				RES2;

	ULA_AR u_ar(.A(A),.B(B),.OP(OP),.RESU(RES1),.O(O1),.C(C1),.S(S1),.Z(Z1));
	ULA_LO u_lo(.A(A),.B(B),.OP(OP),.RESU(RES2),.O(O2),.C(C2),.S(S2),.Z(Z2));

	always @(A or B or OP)begin
		if (OP[5:4] == 2'b00)begin
			RESU = RES1;
			O = O1;
			C = C1;
			S = S1;
			Z = Z1;
		end else begin
			RESU = RES2;
			O = O2;
			C = C2;
			S = S2;
			Z = Z2;
		end
	end
	
endmodule
