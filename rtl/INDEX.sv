include "IntegracaoModulos.sv"; 

module INDEX();
  logic clock;
  integer count_stop = 1'd0;
   
  IntegracaoModulos IntegracaoModulos(.clock(clock), .botao(1'b1));
  
  initial clock=1;
  always #5 clock = ~clock;
  
  always begin
	
	#1
	if(count_stop>=5000)
		$stop;
	count_stop = count_stop+1;
  end
  
endmodule

