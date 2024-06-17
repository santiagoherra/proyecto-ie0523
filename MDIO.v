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

reg [6:0] count;

always @(posedge clk) begin
    if(!reset) begin
        MDC <= 0;
        MDIO_OUT <= 0;
        MDIO_OE <= 0;
        RD_DATA <= 0;
        DATA_RDY <= 0;
        count <= 6'd32;
    end
    else begin 
        if (MDIO_START) begin
            if(count > 0) begin
                MDIO_OUT <= T_DATA[count-1]; 
                count <= count -1;
            end else begin
                DATA_RDY <= 1;
                MDIO_OE <= 0;
            end
        end
    end
    
end

assign counter = count;

endmodule