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
	input reg [2:0] A,B;
	input reg [4:0] OP;
	output reg [2:0] RESU;
	output logic 	O,
					C,
					S,
					Z;
	logic [3:0] TEMP;

	always @(A or B or OP) begin
		case (OP)
			5'b00000: TEMP = A+B;
			5'b00001: TEMP = A+B+1;
			5'b00011: TEMP = A+1;
			5'b00100: TEMP = A-B-1;
			5'b00101: TEMP = A-B;
			5'b00110: TEMP = A-1;
			default : TEMP = OP;
		endcase
		case (OP[2:1])
			2'b00:if((A[2] == B[2]) && (RESU[2] != A[2]))
					O = 1;
				else
					O = 0;
			2'b10:if((A[2] != B[2]) && (RESU[2] != A[2]))
					O = 1;
				else
					O = 0;
			2'b11:if((A[2]) && (RESU[2] != A[2]))
					O = 1;
				else
					O = 0;
			2'b01:if((!A[2]) && (RESU[2] != A[2]))
					O = 1;
				else
					O = 0;
			default :TEMP = OP;
		endcase
		C = TEMP[3];
		RESU = TEMP;
		S = RESU [2];
		if(!RESU)
			Z = 1;
	end
endmodule