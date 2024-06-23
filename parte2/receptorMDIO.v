//Este es la parte 2 del proyecto de Circuitos Digitales II, donde se 
//realizara el receptor de transacciones del MDIO


//DEFINICION DE PRUEBAS PARA COMPROBAR FUNCIONAMIENTO

//entradas y salidas del receptor
module receptorMDIO(
    input MDC,
    input reset,
    input MDIO_OUT,
    input [0:15] RD_DATA,
    output reg MDIO_IN,
    output reg [0:4] ADDR,
    output reg [0:15] WR_DATA,
    output reg MDIO_DONE,
    output reg WR_STB;
);

//REGISTROS LOCALES



always @(posedge MDC) begin
    
end

always @(*)begin 

end
    
endmodule