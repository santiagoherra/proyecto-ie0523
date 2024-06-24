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

    initial begin
         // Inicialización de señales
        MDC = 0;
        reset = 1;
        MDIO_OUT = 0;
        MDIO_OE = 0;
        RD_DATA = 16'hA5A5; // Datos de lectura

        // Secuencia de reset
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;

        //ESCRITURA.

        MDIO_OE = 1;
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; // Start of frame
        #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; // Operation code escritura
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; #10 MDIO_OUT = 0; // PHY address
        #10 MDIO_OUT = 0; // PHY address
        #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; // Register address
        #10 MDIO_OUT = 0; // Register address
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; //TA
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; // Data
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; // Data
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; // Data
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; // Data
        MDIO_OE = 0;
        
        // Esperar hasta que la transacción de escritura se complete
        wait (MDIO_DONE == 1);

        // Simulación de transacción de lectura MDIO
        #50;
        MDIO_OE = 1;

        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; // Start of frame
        #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; // Operation code lectura
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; #10 MDIO_OUT = 0; // PHY address
        #10 MDIO_OUT = 0; // PHY address
        #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; #10 MDIO_OUT = 0; // Register address
        #10 MDIO_OUT = 0; // Register address
        #10 MDIO_OUT = 0; #10 MDIO_OUT = 1; //TA
        
        MDIO_OE = 0;
        $finish;
    end

    // Generación de la señal de reloj MDC
    always #5 MDC = ~MDC;

endmodule
