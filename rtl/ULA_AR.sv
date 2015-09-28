/*
* @author Fábio
* Module: ULA_AR
* Purpose: Ula que realiza somente operaçoes aritimeticas
*/
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
	parameter bits=16;

	input reg signed [bits-1:0] A,B;	//dados para operacao
	input reg [4:0] OP;					//tipo de operacao
	output reg signed [bits-1:0] RESU;	//resultado da operacao
	output logic 	O,					//flag que indica se ouve overflow na operacao
					C,					//flag que indica se ouve carryout na operacao
					S,					//flag que indica o sinal do resultado da operacao
					Z;					//flag que indica que o resultado da operacao é Zero
	reg [bits+1:0] AUX;				//Auxilia na identificação de carry e overflow
	reg [bits+2:0] unsigned AUX2; //AUX2 serve para os casos de carry de operações de subtração


	always @(A or B or OP) begin
	
		O = 1'b0;
		C = 1'b0;
		S = 1'b0;
		Z = 1'b0;
		
		case (OP)
			5'b00000: begin
				AUX = A+B; //adicao
				if(AUX[bits] == 1)
					C = 1;
				else
					C = 0;
			end
			5'b00001: begin // adicao com incremento
				
				AUX2 = B + 1;
				if (AUX2[bits+1] == 1 || AUX2[bits] == 1)
					C = 1;
				else 
					C = 0;
				AUX = A+B+1; 
			end
			5'b00011: begin
				AUX = A+1; // incremento
				if(AUX[bits] == 1)
					C = 1;
				else
					C = 0;
			end
			5'b00100: begin  // subtracao com decremento				
				AUX2 = B-1;
				if (AUX2 > A) 
					C = 1;
				AUX = A-B-1;
				end
			5'b00101: begin //subtracao
				AUX2 = B;
				if (AUX2> A) 
					C = 1;
				AUX = A-B;
				end
			5'b00110: begin
				AUX2 = A;
				if (AUX2 < 1'b1)
					C = 1;
				AUX = A-1; //decremento
			end
			default : AUX = 1'd0;
		endcase
		RESU = AUX[bits-1:0];
		/*
		
		case (OP[2:1]) 
			2'b00:begin //adicao e adicao com incremento
				
				/*if(A[bits-1] == 1'b1 && B[bits-1] == 1'b0)
					O = 0;
				else if (A[bits-1] == 1'b1 && B[bits-1] == 1'b1 && RESU[bits-1] == 0)
					O = 1;
				else if (A[bits-1] == 1'b0 && B[bits-1] == 1'b0 && RESU[bits-1] == 1)
					O = 1;

				/*if((A[bits-1] == B[bits-1]) && (RESU[bits-1] != A[bits-1]))
					O = 1;
				else
					O = 0;
				end*
			2'b10:begin
				if((A[bits-1] == B[bits-1]) && (RESU[bits-1] != A[bits-1])) 
					O = 1;
				else
					O = 0;
				end
			2'b11:begin
				if((A[bits-1]) && (RESU[bits-1] != A[bits-1]))
					O = 1;
				else
					O = 0;	
					end				
			2'b01:begin
				if((!A[bits-1]) && (RESU[bits-1] != A[bits-1]))
					O = 1;
				else
					O = 0;
				end
			default:  
				O = 0;	
		endcase*/
		if (RESU < -32768 || RESU > 32767)
					O = 1;
				else
					O = 0;
		S = RESU [bits-1];

		if(!RESU)
			Z = 1;

		/*if(OP == 5'b00011 && AUX[bits] == 1)//OP = Incremento 
			C = 1;
		if(Z == 1 && (A == ~B+1 || OP == 5'b00001)) // Z == 1 and A == notB+1 or OP == adicao com incremento or OP == subtracao com decremento
			C = 1;
		else
			C = AUX[bits];
		if (!C)
			C = AUX[bits+1];*/
	end
endmodule
