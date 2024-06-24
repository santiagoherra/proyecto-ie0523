`include "receptorMDIO.v"

module tb_receptorMDIO;

reg MDC;
reg reset;
reg MDIO_OUT;
reg MDIO_OE;
reg [0:15] RD_DATA;
wire MDIO_IN;
wire [0:4] ADDR;
wire [0:15] WR_DATA;
wire MDIO_DONE;
wire WR_STB;

// Instancia del módulo receptorMDIO
receptorMDIO uut (
    .MDC(MDC),
    .reset(reset),
    .MDIO_OUT(MDIO_OUT),
    .MDIO_OE(MDIO_OE),
    .RD_DATA(RD_DATA),
    .MDIO_IN(MDIO_IN),
    .ADDR(ADDR),
    .WR_DATA(WR_DATA),
    .MDIO_DONE(MDIO_DONE),
    .WR_STB(WR_STB)
);

// Generación de la señal de reloj MDC
always #2 MDC = ~MDC;


initial begin

    // Inicialización de señales
    MDC = 0;
    reset = 1;
    MDIO_OUT = 0;
    MDIO_OE = 0;
    RD_DATA = 16'hAAAA; // Datos de lectura

    // Secuencia de reset
    #6 reset = 0;
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

    #6 reset = 1;
    #6 reset = 0;

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

initial begin
    $dumpfile("gtkwave_receptor.vcd");
    $dumpvars;
end


endmodule
