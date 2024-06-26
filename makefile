generador:
	iverilog -o tb.vvp -Iparte1 parte1/generadorMDIO_testbench.v 
	vvp tb.vvp
	gtkwave tb.vcd

receptor:
	iverilog -o tb.vvp -Iparte2 parte2/receptorMDIO_testbench.v 
	vvp tb.vvp
	gtkwave tb.vcd

clean:
	rm -rf tb.vcd tb.vvp
