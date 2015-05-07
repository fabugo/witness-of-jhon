module ULA_C (dado,constante,tipo,R,resultOP
	/*F,
	S*/
	);

	input reg [15:0] constante, dado;
	input logic [1:0] tipo;
	input logic R;
	output reg resultOP;
	/*output reg S,
				Z;
	*/
	always @(constante or tipo or R) begin
		case (tipo)
			2'b01:begin
				resultOP = constante;
			end
			2'b11:begin
				if(R)begin
					resultOP = constante | (dado & 16'b1111111100000000) ;
				end else begin
					resultOP = constante | (dado & 16'b0000000011111111) ;
				end
			end
			default : /* default */;
		endcase/*
		if(!resultOP)
			Z = 1;
		S = resultOP[15];*/
	end
endmodule