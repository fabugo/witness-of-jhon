include "rtl\\ULA_AR.sv";

module ULA_AR_TB;

	reg signed [2:0] A,B;
	reg [4:0] OP;
	reg signed [2:0] RESU;
	logic 	O,
			C,
			S,
			Z;

	ULA_AR u(A,B,OP,RESU,O,C,S,Z);

	initial begin
		OP = 5'b00100;
		A = 3'b011;//3
		B = 3'b001;//1
		#1;
		if(O != 0 || C != 1 || S != 0 || Z != 0)begin
			$display("flags apresentadas: Overflow = %b, Carry = %b, Sinal = %b, Zero = %b", O, C, S, Z);
			$display("   flags esperadas: Overflow = 0, Carry = 1, Sinal = 0, Zero = 0");
		end 
	end
endmodule
