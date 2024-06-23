//Este es la parte 2 del proyecto de Circuitos Digitales II, donde se 
//realizara el receptor de transacciones del MDIO

/*
Estudiante: David Lucas Martínez
Carnet: B74333
Estudiante: Kevin Jimenez Acuna
Carnet: C13876
Estudiante: Santiago Herra Castro
Carnet: C1721
Evualuacion: Proyecto
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
localparam IDLE    = 3'b000, //estado quieto para tomar desicion
            RECEIVE = 3'b010, //estado de recibir datos de MDIO OUT 
            DONE    = 3'b011, //estado terminado para dividir la informacion y pasar a la accion de escritura o lectura
            WRITE   = 3'b100, //estado de escritura
            READ    = 3'b101; //estado de lectura

always @(posedge MDC or posedge reset) begin
    if(reset)begin
        bit_count <= 0;
        shift_reg <= 0;
        MDIO_DONE <= 0;
        MDIO_IN <= 0;
        WR_STB <= 0;
        ADDR <= 0;
        WR_DATA <= 0;
        next_state <= IDLE;
    end else begin
        case (next_state)
            IDLE: begin
                MDIO_DONE <= 0;
                WR_STB <= 0;
                if (MDIO_OE) begin
                    next_state <= RECEIVE;
                end
            end
            RECEIVE: begin
                if (MDIO_OE) begin
                    shift_reg <= {shift_reg[30:0], MDIO_OUT};
                    bit_count <= bit_count + 1;
                    if (bit_count == 31) begin
                        next_state <= DONE;
                    end
                end
            end
            DONE: begin
                MDIO_DONE <= 1;
                ADDR <= shift_reg[27:23];
                if (shift_reg[30:28] == 3'b010) begin
                    next_state <= WRITE;
                end else if (shift_reg[30:28] == 3'b011) begin
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
                if (bit_count_lectura >= 0) begin
                    MDIO_IN <= RD_DATA[bit_count_lectura];
                    bit_count_lectura <= bit_count_lectura - 1;
                    if (bit_count_lectura == 0) begin
                        next_state <= IDLE;
                    end
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end



endmodule