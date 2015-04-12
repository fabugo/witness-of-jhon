/*
*@author Patricia Gomes
*@author Kelvin Carmo
*Module: registers_file
*/
	
module registers_bank #(parameter size_reg=16, addr_reg=2)(/* size_reg = tamanho do dado ( tamanho do registrador) addr_reg = tamanho do endereço do registrador*/
	input [addr_reg-1:0] addr_A, //endereço do registrador onde o operando A será gravado.
	input [addr_reg-1:0] addr_B, //endereço do registrador onde o operando B será gravado.
	input [addr_reg-1:0] addr_R,//endereço do registrador onde o dado será gravado.
	input write_reg, //habilitador de escrita.
	input read_reg, //habilitador de leitura.
	input clock,
	input reset,
	input [size_reg-1:0] write_data, //dado.
	output reg [size_reg-1:0] data_A, //dado que sai do registrador A.
	output reg [size_reg-1:0] data_B); //dado que sai do registrador B.

	reg [size_reg-1:0] registers[0:(1'b1 << addr_reg)-1];//2^N registradores de M bits
	 
	always @ (write_reg or read_reg) 
		begin// habilita a escrita ou leitura
			if (write_reg) //se habilitar a escrita
				registers[addr_R] = write_data; //escreve o dado no registrador destino, de endereço informado pela entrada "addr_R"
				
			else if (read_reg) //se habilitar a leitura
				begin
					data_A = registers[addr_A]; //coloca na saída o dado do registrador informado pela entrada addr_A
					data_B = registers[addr_B]; //coloca na saída o dado do registrador informado pela entrada addr_B
				end
		end
			
	initial // innicializa os registradores.
			begin
				registers[0] = 16'b0000000000000000;
				registers[1] = 16'b0000000000000000;
				registers[2] = 16'b0000000000000000;
				registers[3] = 16'b0000000000000000;
			end

	always_comb 
		begin
			data_A = registers[addr_A]; //coloca na saída o dado do registrador informado pela entrada addr_A
			data_B = registers[addr_B]; //coloca na saída o dado do registrador informado pela entrada addr_B
		end

	always@(posedge clock, negedge reset) 
		begin// sinal de escrita ou leitura
			if(reset) //Reset assíncrono
				begin 
					registers[0] = 16'b0000000000000000;
					registers[1] = 16'b0000000000000000;
					registers[2] = 16'b0000000000000000;
					registers[3] = 16'b0000000000000000;
				end
			else if(write_reg) 
				registers[addr_R] <= write_data;//*escreve o dado no registrador destino, de endereço informado pela entrada "addr_R"
		end
	 
endmodule