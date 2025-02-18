vlib work
# compile glbl module
vlog -incr C:/Xilinx/Vivado/2023.1/data/verilog/src/glbl.v
vlog -incr -mfcu C:/Xilinx/Vivado/2023.1/data/verilog/src/unisims/*.v
vlog -incr -mfcu C:/Xilinx/Vivado/2023.1/data/verilog/src/unimacro/*.v
vlog  -incr -mfcu -sv C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv

vcom  -93 C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd

vlog  -incr -mfcu -sv -cover bcs ./../hdl/async_pkg.sv ./../hdl/async_fifo_wrapper.sv ./../hdl/async_fifo_top.sv ./../hdl/dualPortRAM.sv
vlog  -incr -mfcu -sv -cover bcs ./async_tb.sv

vsim -sv_seed random -voptargs=+acc work.async_tb work.glbl
source ./wave.do  
run 1000ns
