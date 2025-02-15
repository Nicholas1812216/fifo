    vlib work	
	vlog -sv -cover bcs ./../hdl/simple_fifo.sv 
    vlog -sv -cover bcs ./simple_fifo_tb.sv
	vsim -sv_seed random -coverage -voptargs=+acc work.simple_fifo_tb
    source ./wave.do  
	run 12000ns
