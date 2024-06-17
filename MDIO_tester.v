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
    input [4:0] counter
);

always begin
    #5 clk = !clk;  
end

initial begin
    clk = 0;
    reset = 0;
    T_DATA = 0;
    MDIO_START =0;

end
initial begin
    #10
    reset =1;
    T_DATA = 32'hAAAAAAAA;
    #10 
    MDIO_START = 1;
    #10
    // MDIO_START = 0;
    //wait(DATA_RDY)
    #400
    $finish;  
end

endmodule