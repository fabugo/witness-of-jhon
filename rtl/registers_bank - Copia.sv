/* 
Módulo do Banco de Registradores, construído com parâmetros, facilitando a mudança do tamanho do dado e do endereço do 
registrador.
@author Kelvin Carmo
@author Patricia Gomes
*/

module registers_bank #(parameter M=16, N=5)(/* M = tamanho do dado ( tamanho do registrador) 
N = tamanho do endereço do registrador*/
	input [N-1:0] addr_1,
	input [N-1:0] addr_2,
	input [N-1:0] end_write,//endereço do registrador onde o dado será gravado.
	input write_reg,
	input read_reg,
	input [M:0] write_data,
	output reg [M:0] data_1,
	output reg [M:0] data_2);
 
reg [M:0] registers[0:(1'b1 << N)-1];//2^N registradores de M bits

always @ (write_reg or read_reg) begin// sinal de escrita ou leitura
	if (write_reg) registers[end_write] = write_data;/*escreve o dado no registrador destino, de endereço informado pela
	entrada "end_wirte"*/
	else if (read_reg) begin
									data_1 = registers[addr_1]; 
									data_2 = registers[addr_2];
							 end
end

endmodule