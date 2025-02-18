onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /async_tb/WIDTH
add wave -noupdate /async_tb/reset
add wave -noupdate /async_tb/rd
add wave -noupdate /async_tb/dataout
add wave -noupdate /async_tb/rdclk
add wave -noupdate /async_tb/empty
add wave -noupdate /async_tb/datain
add wave -noupdate /async_tb/wr
add wave -noupdate /async_tb/rd_del
add wave -noupdate /async_tb/expected_rd_data
add wave -noupdate /async_tb/dut/genblk1/async_fifo_inst/tdp_ram/ADDRB
add wave -noupdate /async_tb/dut/genblk1/async_fifo_inst/tdp_ram/CLKB
add wave -noupdate /async_tb/dut/genblk1/async_fifo_inst/tdp_ram/DIB
add wave -noupdate /async_tb/dut/genblk1/async_fifo_inst/tdp_ram/WEB
add wave -noupdate /async_tb/dut/genblk1/async_fifo_inst/tdp_ram/DOA
add wave -noupdate /async_tb/dut/genblk1/async_fifo_inst/tdp_ram/ADDRA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {27986609 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {70752 ps}
