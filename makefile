verilog:
	iverilog -o tb.vvp MDIO_testbench.v 
	vvp tb.vvp
	gtkwave tb.vcd

clean:
	rm -rf tb.vcd tb.vvp