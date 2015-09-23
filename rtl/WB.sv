/*
* @author Fábio Almeida
* Module: WB
* Purpose: Modulo responsavel por unir os modulos que definem o estagio WB
*/
module WB(
input clock,
input ula_out,
input mem_out
);

    input clock;
    wire input [15:0] ula_out;
    wire input [15:0] mem_out;
    MUX_RESULTADO MUX_RESULTADO();
    Registrador_Flags Registrador_Flags();

endmodule
