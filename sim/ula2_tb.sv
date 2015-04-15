include "..\\rtl\\ula2.sv";
module ula2_tb;
	logic signed [2:0] opA,
						opB;

	logic signed [3:0] 	opR;

	logic	flagS,
			flagZ,
			flagO,
			flagC;

	logic [4:0]	op;

	ula2 u (
	.A(opA),
	.B(opB),
	.R(opR),
	.S(flagS),
	.Z(flagZ),
	.O(flagO),
	.C(flagC),
	.OP(op)
	);

	integer file;

	initial begin
		file = $fopen("ula2_tb_out.txt");
		$fdisplay(file,"_______________________________________________________________________");
		op = 5'b00000;
		repeat(32)begin
			opA = $random % 8;
			opB = $random % 8;
			#20
			case (op)
				5'b00000: begin
					$fdisplay(file,"\n\n Soma:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b00001: begin
					$fdisplay(file,"\n\n Soma +1:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);	
				end
				5'b00011: begin
					$fdisplay(file,"\n\n A + 1:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b00100: begin
					$fdisplay(file,"\n\n Subtracao -1:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b00101: begin
					$fdisplay(file,"\n\n Subtracao:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b00110: begin
					$fdisplay(file,"\n\n A - 1:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b01000: begin
					$fdisplay(file,"\n\n Des. Log. Esq.:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b01001: begin
					$fdisplay(file,"\n\n Des. Ari. Dir.:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b10000: begin
					$fdisplay(file,"\n\n Zero:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b10001: begin
					$fdisplay(file,"\n\n A & B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b10010: begin
					$fdisplay(file,"\n\n !A & B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b10011: begin
					$fdisplay(file,"\n\n B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b10100: begin
					$fdisplay(file,"\n\n A & !B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b10101: begin
					$fdisplay(file,"\n\n A:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b10110: begin
					$fdisplay(file,"\n\n A xor B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b10111: begin
					$fdisplay(file,"\n\n A | B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b11000: begin
					$fdisplay(file,"\n\n !A & !B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b11001: begin
					$fdisplay(file,"\n\n !( A xor B ):\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b11010: begin
					$fdisplay(file,"\n\n !A:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b11011: begin
					$fdisplay(file,"\n\n !A | B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b11100: begin
					$fdisplay(file,"\n\n !B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b11101: begin
					$fdisplay(file,"\n\n A | !B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b11110: begin
					$fdisplay(file,"\n\n !A | !B:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				5'b11111: begin
					$fdisplay(file,"\n\n 1:\n A = %b, B = %b, R = %b\n Flags: S = %b, Z = %b, O = %b, C = %b",
																					opA,opB,opR,flagS,flagZ,flagO,flagC);
				end
				default :begin end
			endcase	
			op++;
		end
		$fdisplay(file,"_______________________________________________________________________\n\n\n");
		$fclose(file);
	end
endmodule