include "PC.sv";    
include "sp_rom.sv";

module IF(clock, instrucao, controle_PC, Rom_sink_ren, Rom_sink_cen);
	input clock;
    input logic controle_PC, Rom_sink_ren, Rom_sink_cen;
	output reg [15:0]instrucao;
		 
	PC PC(.clock(clock), .controle(controle_PC));
	sp_rom sp_rom(.clk(clock), .sink_address(PC.pc_out), .sink_ren(Rom_sink_ren), .sink_cen(Rom_sink_cen));
	
	always @(negedge clock) begin
		instrucao = sp_rom.src_data; 
	end
endmodule 



