/*
Estudiante: David Lucas Martínez, B74333
Estudiante: Kevin Jimenez Acuna, C13876
Estudiante: Santiago Herra Castro, C1721
Evualuacion: Proyecto

Archivo: generadorMDIO_tester.v
Descripción: Este es el tester de la parte 1 del proyecto de Circuitos Digitales II,
aquí se plantean las pruebas para verificar el funcionamiento del generador.
*/

`timescale 1ns/1ps

module tester (
    output reg clk,
    output reg reset,
    output reg MDIO_START,
    output reg MDIO_IN,
    output reg [31:0] T_DATA,
    input MDC,
    input MDIO_OUT,
    input MDIO_OE,
    input [15:0] RD_DATA,
    input DATA_RDY,
    input [5:0] counter
);

always begin
    #5 clk = !clk;  
end

initial begin
    clk = 0;
    reset = 0;
    T_DATA = 0;
    MDIO_START =0;
    MDIO_IN = 0;
end

initial begin
    #10
    reset =1;

    // Caso de escritura
    T_DATA = 32'h5C6AF5B5;  // write 5 = 0101
    #10 
    MDIO_START = 1;
    #10
    MDIO_START = 0;
    #350
    // Caso de lectura
    T_DATA = 32'h6FB246C4;  // read 6 = 0110
    #10 
    MDIO_START = 1;
    #10
    MDIO_START = 0;
    #155
    #10 MDIO_IN = 0; #10 MDIO_IN = 1; #10 MDIO_IN = 0; #10 MDIO_IN = 0;
    #10 MDIO_IN = 0; #10 MDIO_IN = 1; #10 MDIO_IN = 1; #10 MDIO_IN = 0;
    #10 MDIO_IN = 1; #10 MDIO_IN = 1; #10 MDIO_IN = 0; #10 MDIO_IN = 0;
    #10 MDIO_IN = 0; #10 MDIO_IN = 1; #10 MDIO_IN = 0; #10 MDIO_IN = 0;
    

    // Caso de escritura con bits ST incorrectos
    T_DATA = 32'h9C78402B;  // write sin start frame = 1001
    #10 
    MDIO_START = 1;
    #10
    MDIO_START = 0;
    #350
    $finish;  
end

endmodule