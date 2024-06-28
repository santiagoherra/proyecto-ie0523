/*
Estudiante: David Lucas Martínez
Carnet: B74333
Estudiante: Kevin Jimenez Acuna
Carnet: C13876
Estudiante: Santiago Herra Castro
Carnet: C13721
Evualuación: Proyecto
Archivo: receptorMDIO.v
Descripción: Este es la parte 2 del proyecto de Circuitos Digitales II, donde
se realizara el receptor de transacciones del MDIO.
*/

//entradas y salidas del receptor
module receptorMDIO(
    input MDC,
    input reset,
    input MDIO_OUT,
    input MDIO_OE,
    input [0:15] RD_DATA,
    output reg MDIO_IN,
    output reg [0:4] ADDR,
    output reg [0:15] WR_DATA,
    output reg MDIO_DONE,
    output reg WR_STB
);

//REGISTROS LOCALES

reg [31:0] shift_reg; //Registro para almacenar toda la informacion por partes que se 
reg [4:0] bit_count; //formato de transaccion de MDIO
reg [2:0] next_state; //manejo de estados para el modulo
reg [4:0] bit_count_lectura; //conteo de bit a bit para mandar datos de la direccion de memoria de los
//registros en modo lectura

// DEFINICION DE ESTADOS
localparam IDLE    = 0, //estado quieto para tomar desicion
            RECEIVE = 2, //estado de recibir datos de MDIO OUT 
            DONE    = 3, //estado terminado para dividir la informacion y pasar a la accion de escritura o lectura
            WRITE   = 4, //estado de escritura
            READ    = 5; //estado de lectura

always @(posedge MDC or posedge reset) begin
    if(!reset)begin
        bit_count <= 0;
        shift_reg <= 0;
        MDIO_DONE <= 0;
        MDIO_IN <= 0;
        WR_STB <= 0;
        ADDR <= 0;
        WR_DATA <= 0;
        next_state <= IDLE;
        bit_count_lectura = 0;
    end else begin
        case (next_state)
            IDLE: begin
                MDIO_DONE <= 0;
                WR_STB <= 0;
                next_state <= RECEIVE;
            end
            RECEIVE: begin
                if (MDIO_OE) begin
                    shift_reg[31 - bit_count] <= MDIO_OUT;
                    bit_count <= bit_count + 1;
                    if (bit_count == 31) begin
                        next_state <= DONE;
                    end
                end else begin
                    if(bit_count == 16)begin
                    next_state <= DONE;
                    end
                end
            end
            DONE: begin
                MDIO_DONE <= 1;
                ADDR <= shift_reg[28:23];
                if (shift_reg[29:28] == 2'b01) begin
                    next_state <= WRITE;
                end else if (shift_reg[29:28] == 2'b10) begin
                    next_state <= READ;
                end else begin
                    next_state <= IDLE;
                end
            end
            WRITE: begin
                WR_DATA <= shift_reg[15:0];
                WR_STB <= 1;
                next_state <= IDLE;
            end
            READ: begin
                    MDIO_IN <= RD_DATA[15 - bit_count_lectura]; 
                    bit_count_lectura <= bit_count_lectura + 1;
                    if (bit_count_lectura == 16) begin
                        next_state <= IDLE;
                    end
                end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end



endmodule