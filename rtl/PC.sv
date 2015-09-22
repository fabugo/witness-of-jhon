module PC(clock, pc_out, controle);
  input controle, clock;
  output reg [15:0] pc_out = 16'b0000000000000000;
  reg [15:0] pc_in = 16'b0000000000000000;

  always @(posedge clock) 
  begin
	  if(controle)
		if(pc_in < 65536) 
		  pc_out = (pc_in+1);
		else 
		  pc_out = 16'b0000000000000000;
		  
		pc_in = pc_out;
  end

endmodule 
