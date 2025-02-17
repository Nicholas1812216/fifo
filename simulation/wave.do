onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /async_tb/dut/wrGreyPtr
add wave -noupdate /async_tb/dut/wr_int
add wave -noupdate /async_tb/dut/wrAddr
add wave -noupdate /async_tb/dut/wbnext
add wave -noupdate /async_tb/wr
add wave -noupdate /async_tb/full
add wave -noupdate /async_tb/wrclk
add wave -noupdate /async_tb/reset
add wave -noupdate /async_tb/dut/wrrst_sync
add wave -noupdate {/async_tb/dut/rdGreyWrSync[2]}
add wave -noupdate /async_tb/dut/wgnext
add wave -noupdate /async_tb/rdclk
add wave -noupdate /async_tb/rd
add wave -noupdate /async_tb/empty
add wave -noupdate /async_tb/dut/rdAddr
add wave -noupdate {/async_tb/dut/wrGreyRdSync[2]}
add wave -noupdate /async_tb/dut/rgnext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {113981 ps} 0}
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
WaveRestoreZoom {0 ps} {393752 ps}
