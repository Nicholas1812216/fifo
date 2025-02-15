onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /simple_fifo_tb/dut/WIDTH
add wave -noupdate /simple_fifo_tb/dut/DEPTH
add wave -noupdate /simple_fifo_tb/dut/SYNC_DEPTH
add wave -noupdate /simple_fifo_tb/dut/rst
add wave -noupdate /simple_fifo_tb/dut/clk
add wave -noupdate /simple_fifo_tb/dut/wr
add wave -noupdate /simple_fifo_tb/dut/rd
add wave -noupdate /simple_fifo_tb/dut/data_in
add wave -noupdate /simple_fifo_tb/dut/data_out
add wave -noupdate /simple_fifo_tb/dut/empty
add wave -noupdate /simple_fifo_tb/dut/full
add wave -noupdate /simple_fifo_tb/dut/memory
add wave -noupdate /simple_fifo_tb/dut/rd_addr
add wave -noupdate /simple_fifo_tb/dut/wr_addr
add wave -noupdate /simple_fifo_tb/dut/rst_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {166 ps} 0}
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
WaveRestoreZoom {0 ps} {1 ns}
