/*
Estudiante: David Lucas Martínez, B74333
Estudiante: Kevin Jimenez Acuna, C13876
Estudiante: Santiago Herra Castro, C1721
Evualuacion: Proyecto

Archivo: receptorMDIO_tester.v
Descripción: Este es el tester de la parte 2 del proyecto de Circuitos Digitales II,
aquí se plantean las pruebas para verificar el funcionamiento del receptor del MDIO.
*/

`timescale 1ns/1ps

module receptorMDIO_tester (
    output reg MDC,
    output reg reset,
    output reg MDIO_OUT,
    output reg MDIO_OE,
    output reg [0:15] RD_DATA,
    input MDIO_IN,
    input [0:4] ADDR,
    input [0:15] WR_DATA,
    input MDIO_DONE,
    input WR_STB
);

// Generación de la señal de reloj MDC
always #2 MDC = ~MDC;

initial begin

    // Inicialización de señales
    MDC = 0;
    reset = 0;
    MDIO_OUT = 0;
    MDIO_OE = 0;
    RD_DATA = 16'hAAAA; // Datos de lectura

    // Secuencia de reset
    #6 reset = 1;
    #4

    //ESCRITURA.

    MDIO_OE = 1;
    MDIO_OUT = 0; #4 MDIO_OUT = 1; // Start of frame
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; // Operation code escritura
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; #4 MDIO_OUT = 0; // PHY address
    #4 MDIO_OUT = 0; // PHY address
    #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; // Register address
    #4 MDIO_OUT = 0; // Register address
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; //TA
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; // Data
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; // Data
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; // Data
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; // Data
    #4 MDIO_OE = 0;

    //01010100010100010101010101010101


    #4 MDIO_OUT = 0;

    #200 

    #6 reset = 0;
    #6 reset = 1;

    // Simulación de transacción de lectura MDIO
    #6;
    MDIO_OE = 1;
    MDIO_OUT = 1; #4 MDIO_OUT = 1; // Start of frame
    #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; // Operation code lectura
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; #4 MDIO_OUT = 0; // PHY address
    #4 MDIO_OUT = 0; // PHY address
    #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; #4 MDIO_OUT = 0; // Register address
    #4 MDIO_OUT = 0; // Register address
    #4 MDIO_OUT = 0; #4 MDIO_OUT = 1; //TA
    #4 MDIO_OE = 0;

    #160

    $finish;
end

endmodule