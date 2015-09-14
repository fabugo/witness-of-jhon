<<<<<<< HEAD
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
=======
module PC(pc_in, pc_out);
  input reg [5:0] pc_in;
  output reg [5:0] pc_out;

  always_comb
  begin
    if(pc_in < 41)
      pc_out = pc_in;
    else
      pc_out = 6'b000000;
>>>>>>> origin/mic_arq2
  end

endmodule 
