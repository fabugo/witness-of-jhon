module IF(clock, instrucao, controle_PC, Rom_sink_ren, Rom_sink_cen, jumpPC, habJump, pc_out);
	input habJump, clock;
    input wire [15:0] jumpPC;
    input wire controle_PC, Rom_sink_ren, Rom_sink_cen;
	output reg [15:0]instrucao;
	output wire [15:0] pc_out;
	
	PC PC(
	.clock(clock), 
	.pc_out(pc_out),
	.controle(controle_PC),
	.jump_pc(jumpPC), 
	.hab_jump(habJump)
	);
	
	sp_rom sp_rom(
	.clk(clock), 
	.sink_address(pc_out),
	.src_data(instrucao), 
	.sink_ren(Rom_sink_ren), 
	.sink_cen(Rom_sink_cen) 
	);

endmodule 



