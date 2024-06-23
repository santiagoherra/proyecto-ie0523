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


//DEFINICION DE PRUEBAS PARA COMPROBAR FUNCIONAMIENTO



//entradas y salidas del receptor
module receptorMDIO(
    input MDC,
    input reset,
    input MDIO_OUT,
    input MDIIO_OE,
    input [0:15] RD_DATA,
    output reg MDIO_IN,
    output reg [0:4] ADDR,
    output reg [0:15] WR_DATA,
    output reg MDIO_DONE,
    output reg WR_STB;
);

//REGISTROS LOCALES

reg [31:0] shift_reg;
reg [4:0] bit_count;
reg [2:0] next_state;

// DEFINICION DE ESTADOS
localparam IDLE    = 3'b000,
            RESET   = 3'b001,
            RECEIVE = 3'b010,
            DONE    = 3'b011,
            WRITE   = 3'b100,
            READ    = 3'b101;

always @(posedge MDC or posedge reset) begin

    if (reset) begin
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
                MDIO_IN <= RD_DATA;
                next_state <= IDLE;
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end
endmodule