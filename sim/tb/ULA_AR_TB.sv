include "ULA_AR.sv";

module ULA_AR_TB;

	reg [2:0] A,B;
	reg [4:0] OP;
	reg [2:0] RESU;
	logic 	O,
			C,
			S,
			Z;

	ULA_AR u(A,B,OP,RESU,O,C,S,Z);

	initial begin
		OP = 5'b00000;
		A = 1;
		B = -1;
		#1;
	end
endmodule
