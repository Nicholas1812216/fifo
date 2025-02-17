    vlib work	
	vlog -sv -cover bcs ./../hdl/async_pkg.sv ./../hdl/async_fifo_top.sv 
    vlog -sv -cover bcs ./async_tb.sv
	vsim -sv_seed random -voptargs=+acc work.async_tb
    source ./wave.do  
	run 12000ns
