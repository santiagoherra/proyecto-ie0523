/*
Estudiante: David Lucas Martínez
Carnet: B74333
Estudiante: Kevin Jimenez Acuna
Carnet: C13876
Estudiante: Santiago Herra Castro
Carnet: C1721
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
reg [1:0] state;
reg [1:0] verify;  // Verifica el "Start of frame" y el opcode segun la clausula 22

always @(posedge clk) begin
    if(!reset) begin
        MDC <= 0;
        MDIO_OUT <= 0;
        MDIO_OE <= 0;
        RD_DATA <= 0;
        DATA_RDY <= 0;
        count <= 0;
        state <= 0;
        verify <= 2'b01;
    end
    else begin 
        
        MDC <= ~MDC;  //cada posedge se cambia el estado de MDC para dividir a la mitad la frecuencia
        case(state)
            0 : begin  // Estado intermedio
                if(MDIO_START) begin                    
                    count <= 6'd32; // Iniciar el contador
                    
                    // Logica para seleccionar proximo estado
                    if(T_DATA [31:30] == verify) begin  // Condicion ST = 2'b01
                        if (T_DATA [29:28] == verify) begin  // Condicion OP = 2'b01 (Escritura)
                            state <=1;
                        end else if(T_DATA [29:28] == (verify + 2'b01)) begin  // Condicion OP = 2'b10 (Lectura)
                            state <= 2;
                        end
                    end
                end
            end
            1 : begin  // Estado de escritura
                if(count > 0) begin
                    MDIO_OE <= 1;
                    MDIO_OUT <= T_DATA[count-1]; 
                    count <= count -1;
                end else begin
                    MDIO_OUT <= 0;
                    MDIO_OE <= 0; //Se pone en 0 cuando terminan los 32 ciclos
                    state <= 0;
                end
            end
            2 : begin  // Estado de lectura
                if(count > 0) begin
                    MDIO_OE <= 1;
                    if(count < 16) begin //cuando sea menor a 16 se baja
                        MDIO_OE <= 0;
                        RD_DATA <= {RD_DATA[14:0], MDIO_IN}; //Se concatena el bit de MDIO_IN a los 15 bits menos significativos, 
                        count <= count -1; //y asi generar 16 bits, y se repite hasta haber creado la palabra de 16 bits
                    end else begin
                        count <= count -1;
                    end
                end else begin
                    DATA_RDY <= 1;  // Se enciende para comunicar que se concluyo la recepcion
                    RD_DATA <= 0;
                    state <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
    
end

assign counter = count;

endmodule