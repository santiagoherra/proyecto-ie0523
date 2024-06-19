/*
Estudiante: David Lucas Martínez
Carnet: B74333
Estudiante: Kevin Jimenez Acuna
Carnet: C13876
Evualuacion: Proyecto

Archivo: MDIO.v

*/
module MDIO (
    input clk,
    input reset,
    input MDIO_START,
    input MDIO_IN,
    input [31:0] T_DATA,
    output reg MDC,
    output reg MDIO_OUT,
    output reg MDIO_OE,
    output reg [15:0] RD_DATA,
    output reg DATA_RDY,
    output [5:0] counter
);

reg [5:0] count;
reg mdio_start_d; 
reg [1:0] state;




always @(posedge clk) begin
    if(!reset) begin
        MDC <= 0;
        MDIO_OUT <= 0;
        MDIO_OE <= 0;
        RD_DATA <= 0;
        DATA_RDY <= 0;
        count <= 6'd32;
        mdio_start_d <=0;
    end
    else begin 
        
        MDC <= ~MDC;//cada posedge se cambia el estado de MDC para dividir a la mitad la frecuencia
        if(MDIO_START) begin
            mdio_start_d <= MDIO_START;//Señal complementaría para poder usarla para iniciar la transmisión
        end
        
        if(mdio_start_d) begin
            MDIO_OE <= 1;// Si mdio_start_1 significa que hay una escritura por lo que se pone en uno
            if(count > 0) begin
                MDIO_OUT <= T_DATA[count-1]; 
                count <= count -1;
            end else begin
                mdio_start_d = 0;
                MDIO_OE <= 0; //Se pone en 0 cuando terminan los 32 ciclos
                count <= 6'd32; //Se reincia el contador
            end
        end else begin 
            MDIO_OE <= 1;
            if(count > 0) begin
                if(count < 16) begin //cuando sea menor a 16 se baja
                    MDIO_OE <= 0;
                    RD_DATA <= {RD_DATA[14:0], MDIO_IN}; //Se concatena el bit de MDIO_IN a los 15 bits menos significativos, 
                    count <= count -1; //y asi generar 16 bits, y se repite hasta haber creado la palabra de 16 bits
                end
            end else begin
                DATA_RDY <= 1;
            end
            
        end
    end
    
end

assign counter = count;

endmodule