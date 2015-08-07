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
	input reg [2:0] A,B;
	input reg [4:0] OP;
	output reg [2:0] RESU;
	output logic 	O,
					C,
					S,
					Z;
	logic [3:0] TEMP;
	
	always @(A or B or OP)begin
		case (OP)
			5'b01000:begin// logico
			   	TEMP = A << 1;
				C = TEMP[3];
				RESU = TEMP;
			end
			5'b01001:begin// aritimetico
				C = A[0];
			   	TEMP = A >>> 1;
			   	RESU = TEMP;
			   	RESU[2] = TEMP[2-1];
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
				S = RESU[2];
		end
	end
endmodule