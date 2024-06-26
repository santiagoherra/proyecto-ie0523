/*
Estudiante: David Lucas Martínez, B74333
Estudiante: Kevin Jimenez Acuna, C13876
Estudiante: Santiago Herra Castro, C1721
Evualuacion: Proyecto

Archivo: generadorMDIO_testbench.v
Descripción: Este es el testbench de la parte 1 del proyecto de Circuitos Digitales II,
donde se ejecutan las pruebas planteadas en el archivo generadorMDIO_tester.v.
*/

`include "generadorMDIO.v"
`include "generadorMDIO_tester.v"

module testbench;
    
    wire clk, reset, MDIO_START, MDIO_IN, MDC, MDIO_OUT, MDIO_OE, DATA_RDY;
    wire [15:0] RD_DATA;
    wire [31:0] T_DATA;
    wire [5:0]  counter;
    
    // Instancia del modulo generador
    MDIO DUT(
        .clk(clk),
        .reset(reset),
        .MDIO_START(MDIO_START),
        .MDIO_IN(MDIO_IN),
        .T_DATA(T_DATA[31:0]),
        .counter(counter[5:0]),
        .MDC(MDC),
        .MDIO_OUT(MDIO_OUT),
        .MDIO_OE(MDIO_OE),
        .RD_DATA(RD_DATA[15:0]),
        .DATA_RDY(DATA_RDY)
    );

    // Instancia del tester
    tester TESTER(
        .clk(clk),
        .reset(reset),
        .MDIO_START(MDIO_START),
        .MDIO_IN(MDIO_IN),
        .T_DATA(T_DATA[31:0]),
        .counter(counter[5:0]),
        .MDC(MDC),
        .MDIO_OUT(MDIO_OUT),
        .MDIO_OE(MDIO_OE),
        .RD_DATA(RD_DATA[15:0]),
        .DATA_RDY(DATA_RDY)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end
    
endmodule