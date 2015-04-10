/* 
Módulo do Banco de Registradores, construído com constantes, facilitando a mudança do tamanho do dado e do endereço do 
registrador.
@author Kelvin Carmo
@author Patricia Gomes
*/

module registers_bank #(parameter size_reg=16, addr_reg=2)(/* size_reg = tamanho do dado ( tamanho do registrador) 
addr_reg = tamanho do endereço do registrador*/
	input [addr_reg-1:0] addr_1,
	input [addr_reg-1:0] addr_2,
	input [addr_reg-1:0] end_write,//endereço do registrador onde o dado será gravado.
	input write_reg,
	input clock,
	input reset,
	input [size_reg-1:0] write_data,
	output reg [size_reg-1:0] data_1,
	output reg [size_reg-1:0] data_2);
 
reg [size_reg-1:0] registers[0:(1'b1 << addr_reg)-1];//2^N registradores de M bits

initial
		begin
			registers[0] = 16'b0000000000000000;
			registers[1] = 16'b0000000000000000;
			registers[2] = 16'b0000000000000000;
			registers[3] = 16'b0000000000000000;
		end


always_comb begin
					data_1 = registers[addr_1]; 
					data_2 = registers[addr_2];
				end

always@(posedge clock, negedge reset) 
						begin// sinal de escrita ou leitura
								if(!reset) begin //Reset assíncrono
												registers[0] = 16'b0000000000000000;
												registers[1] = 16'b0000000000000000;
												registers[2] = 16'b0000000000000000;
												registers[3] = 16'b0000000000000000;
												end
								else if(write_reg) registers[end_write] <= write_data;/*escreve o dado no registrador destino, de endereço 
								informado pela entrada "end_wirte"*/
						end

endmodule