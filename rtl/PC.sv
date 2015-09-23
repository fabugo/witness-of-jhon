module PC(clock, pc_out, controle, jump_pc, hab_jump);
  input controle, hab_jump, clock;
  input reg [15:0] jump_pc;
  output reg [15:0] pc_out = 16'b0000000000000000;
  reg [15:0] pc_in = 16'b0000000000000000;

  always @(posedge clock) 
  begin
	if(controle) 
		if(pc_in < 65536) 
		  pc_out = (pc_in+1);
		else 
		  pc_out = 16'b0000000000000000;
		  
	else if(hab_jump) 
		pc_out = jump_pc;
	
	pc_in = pc_out;	
  end

endmodule 
