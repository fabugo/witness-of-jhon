module ADD_PC(pc_in, pc_out, controle);
  input reg [5:0] pc_in;
  input controle;
  output reg [5:0] pc_out;
  
  always@(controle or pc_in)
  begin
    if(controle)
      pc_out = (pc_in+1);  
  end
endmodule

