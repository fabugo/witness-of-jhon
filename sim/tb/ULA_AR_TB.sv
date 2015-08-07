include "rtl\\ULA_AR.sv";

module ULA_AR_TB;
	parameter bits=3;

	reg signed [bits-1:0] A,B;
	reg [4:0] OP;
	reg signed [bits-1:0] RESU;
	logic 	O,
			C,
			S,
			Z;
	
	reg signed [bits-1:0] a2;

	logic signed [bits:0] AUXI;

	ULA_AR u(A,B,OP,RESU,O,C,S,Z);

	initial begin
		OP = 5'b00000;
		A = 3'b010;
		B = 3'b110;
		#1;
		a2 = (~B)+1;
		if(A == a2)
			$display ("Hello World");
		AUXI = A+B;
	end
endmodule
