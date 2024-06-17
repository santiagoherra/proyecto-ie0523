`include "MDIO.v"
`include "MDIO_tester.v"

module testebench;
    
    wire clk, reset, MDIO_START, MDIO_IN, MDC, MDIO_OUT, MDIO_OE, DATA_RDY;
    wire [15:0] RD_DATA;
    wire [31:0] T_DATA;
    wire [5:0]  counter;
    

    MDIO DUT(
        .clk(clk),
        .reset(reset),
        .MDIO_START(MDIO_START),
        .MDIO_IN(MDIO_IN),
        .T_DATA(T_DATA[31:0]),
        .counter(counter[5:0]),
        .MDC(MDC),
        .MDIO_OUT(MDIO_OUT),
        .MDIO_OE(MDIO_OE),
        .RD_DATA(RD_DATA[15:0]),
        .DATA_RDY(DATA_RDY)
    );

    tester TESTER(
        .clk(clk),
        .reset(reset),
        .MDIO_START(MDIO_START),
        .MDIO_IN(MDIO_IN),
        .T_DATA(T_DATA[31:0]),
        .counter(counter[5:0]),
        .MDC(MDC),
        .MDIO_OUT(MDIO_OUT),
        .MDIO_OE(MDIO_OE),
        .RD_DATA(RD_DATA[15:0]),
        .DATA_RDY(DATA_RDY)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end
    
endmodule