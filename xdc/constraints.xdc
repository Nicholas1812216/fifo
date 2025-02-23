set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports {clk_ref}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports {rd_clk}]

create_clock -period 10.000 -name rd_clk -waveform {0.000 5.000} [get_ports {rd_clk}]
set_false_path -from [get_clocks rd_clk] -to [get_clocks -of_objects [get_pins mmcm/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins mmcm/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks rd_clk]