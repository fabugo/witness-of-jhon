// +UEFSHDR---------------------------------------------------------------------
// FILE NAME            : sp_rom.v
// AUTHOR               : João Carlos Nunes Bittencourt
// AUTHOR'S E-MAIL      : joaocarlos@ecomp.uefs.br
// -----------------------------------------------------------------------------
// RELEASE HISTORY
// VERSION  DATE        AUTHOR        DESCRIPTION
// 1.0      2013-02-15  joaocarlos    initial version
// -----------------------------------------------------------------------------
// KEYWORDS: memory, rom, single-port, altera
// -----------------------------------------------------------------------------
// PURPOSE: read hexadecimal values stored in a INPUT_FILE.
// -----------------------------------------------------------------------------
// REUSE ISSUES
//   Reset Strategy: N/A
//   Clock Domains: system clk
//   Critical Timing: N/A
//   Test Features: N/A
//   Asynchronous I/F: N/A
//   Instantiations: N/A
//   Synthesizable (y/n): y
//   Other: N/A
// -UEFSHDR---------------------------------------------------------------------

// Define Input File if it isnt iet
`ifndef ROM_FILE
  `define ROM_FILE "rom.out"
`endif

module sp_rom #(
              parameter ADDRESS_WIDTH   = 16,
              parameter DATA_WIDTH      = 16
            )(
              clk,
              address,  // Address input
              data, 	// Data output
              ren,      // Read Enable
              cen       // Chip Enable
            ) /* synthesis romstyle = "M9K" */;

input  clk;
input  [ADDRESS_WIDTH-1:0] sink_address;
output [DATA_WIDTH-1:0] src_data;
input sink_ren, sink_cen;

// Specify rom style for ALTERA memory block
(* romstyle = "M9K" *) reg [DATA_WIDTH-1:0] mem [0:(2**ADDRESS_WIDTH)-1] ;
reg [DATA_WIDTH-1:0] src_data;
reg [8*40:1] infile;

initial
begin
  $readmemh(`ROM_FILE, mem);  // read memory file
  data = {DATA_WIDTH{1'b0}};
end

// Funcional read block
always @ (posedge clk)
begin
  if (cen && ren)
    data <= mem[address];
end

endmodule
// Thats all folks!
