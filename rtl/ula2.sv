module ula2 (
	A,
	B,
	R,
	S,
	Z,
	O,
	C,
	OP
);
	input signed [2:0] A,B;
	input [4:0] OP;//
	output reg signed [3:0] R;//resultado
	output reg 	S,//sinal
				Z,//zero
				O,//overflow
				C;//carry
	logic [1:0] flags;

	always @(A or B or OP)begin
		case (OP)
			5'b00000: begin
				R = A + B;
				flags = 2'b11;
			end
			5'b00001: begin
				R = A + B + 1;
				flags = 2'b11;
			end
			5'b00011: begin
				R = A + 1;
				flags = 2'b11;
			end
			5'b00100: begin
				R = A - B - 1;
				flags = 2'b11;
			end
			5'b00101: begin
				R = A - B;
				flags = 2'b11;
			end
			5'b00110: begin
				R = A - 1;
				flags = 2'b11;
			end
			5'b01000: begin
				R = A << 1;
				S = R[2];
				C = R[3];
				flags = 2'b10;
			end
			5'b01001: begin
				R = A >>> 1;
				R[2] = A[2];
				C = A[0];
				flags = 2'b10;
			end
			5'b10000: begin
				R = 0;
				flags = 2'b00;
			end
			5'b10001: begin
				R = A & B;
				flags = 2'b10;
			end
			5'b10010: begin
				R = (~A) & B;
				flags = 2'b10;
			end
			5'b10011: begin
				R = B;
				flags = 2'b00;
			end
			5'b10100: begin
				 R = A & (~B);
				 flags = 2'b10;
			end
			5'b10101: begin
				R = A;
				flags = 2'b10;
			end
			5'b10110: begin
				R = A ^ B;
				flags = 2'b10;
			end
			5'b10111: begin
				R = A | B;
				flags = 2'b10;
			end
			5'b11000: begin
				R = (~A) & (~B);
				flags = 2'b10;
			end
			5'b11001: begin
				R = ~(A ^ B);
				flags = 2'b10;
			end
			5'b11010: begin
				R = (~A);
				flags = 2'b10;
			end
			5'b11011: begin
				R = (~A) | (B);
				flags = 2'b10;
			end
			5'b11100: begin
				R = (~B);
				flags = 2'b10;
			end
			5'b11101: begin
				R = A | (~B);
				flags = 2'b10;
			end
			5'b11110: begin
				R = (~A) | (~B);
				flags = 2'b10;
			end
			5'b11111: begin
				R = 1;
			end
			default : R = OP;
		endcase

		case (flags)
			2'b11: begin //todas
				if(!R)
					Z = 1;
				else
					Z = 0;
				if((A[2] == B[2]) && (A[2] != R[2]))
					O = 1;
				else
					O = 0;
				C = R[3];
				S = R[2];
			end
			2'b10: begin //S,C,Z
				if(!R)
					Z = 1;
				else
					Z = 0;
			end
			2'b10: begin //S,Z
				if(!R)
					Z = 1;
				else
					Z = 0;
				S = R[2];
			end
			default :;
		endcase
	end
endmodule
