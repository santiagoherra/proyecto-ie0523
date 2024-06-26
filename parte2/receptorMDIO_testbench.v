/*
Estudiante: David Lucas Martínez, B74333
Estudiante: Kevin Jimenez Acuna, C13876
Estudiante: Santiago Herra Castro, C1721
Evualuacion: Proyecto

Archivo: receptorMDIO_testbench.v
Descripción: Este es el testbench de la parte 2 del proyecto de Circuitos Digitales II,
donde se ejecutan las pruebas planteadas en el archivo receptorMDIO_tester.v.
*/

`include "receptorMDIO.v"
`include "receptorMDIO_tester.v"

module receptorMDIO_testbench;

wire MDC, reset, MDIO_OUT, MDIO_OE, MDIO_IN, MDIO_DONE, WR_STB;
wire [0:15] RD_DATA;
wire [0:4] ADDR;
wire [0:15] WR_DATA;


    // Instancia del módulo receptorMDIO
    receptorMDIO DUT (
        .MDC(MDC),
        .reset(reset),
        .MDIO_OUT(MDIO_OUT),
        .MDIO_OE(MDIO_OE),
        .RD_DATA(RD_DATA[0:15]),
        .MDIO_IN(MDIO_IN),
        .ADDR(ADDR[0:4]),
        .WR_DATA(WR_DATA[0:15]),
        .MDIO_DONE(MDIO_DONE),
        .WR_STB(WR_STB)
    );

    // Instancia del tester
    receptorMDIO_tester TESTER (
        .MDC(MDC),
        .reset(reset),
        .MDIO_OUT(MDIO_OUT),
        .MDIO_OE(MDIO_OE),
        .RD_DATA(RD_DATA[0:15]),
        .MDIO_IN(MDIO_IN),
        .ADDR(ADDR[0:4]),
        .WR_DATA(WR_DATA[0:15]),
        .MDIO_DONE(MDIO_DONE),
        .WR_STB(WR_STB)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

endmodule
