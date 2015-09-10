module PC(pc_in, pc_out);
  input reg [5:0] pc_in;
  output reg [5:0] pc_out;

  always_comb
  begin
    if(pc_in < 41)
      pc_out = pc_in;
    else
      pc_out = 6'b000000;
  end

endmodule 
