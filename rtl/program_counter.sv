module program_counter(
	input write_pc,
	input [15:0] next_address_in,
	output reg [15:0] read_adress_out);

	initial read_adress_out <= 16'b0000000000000000;

	always_comb 	begin
		if (write_pc) begin
				read_adress_out = read_adress_in;
		end
	end
endmodule 

