#MEASUREMENT SETUP
#source "~/hw/simulation1/hw/logicSynthesis/common_settings.tcl"
source "~/hardware_framework/logicSynthesis/core_settings.tcl"
source "~/hardware_framework/synopsis_pt.tcl"

set power_enable_analysis true
set report_default_significant_digits 3
set_host_options -max_cores 2
set timing_enable_normalized_slack true

# DEFINE INPUT FILES
set dir "~/hardware_framework/saved/mac_unit"
set in_verilog_filename "${dir}/mac_unit_postsyn.v"
set in_sdc_filename "${dir}/mac_unit_postsyn.sdc"
# READ
read_verilog $in_verilog_filename
#read_sdc -version 1.3 $in_sdc_filename
read_sdc $in_sdc_filename
read_parasitics -format SPEF "~/hardware_framework/saved/mac_unit/mac_unit_postsyn.spef"


#READ VCD
set vcd_analysis true
if { $vcd_analysis == true} {
	set vcd_strip_path "/tb_top/UUT"
}

set power_enable_clock_scaling true
set vcd_file "~/hardware_framework/Testbenches/top.vcd"
reset_switching_activity
read_vcd $vcd_file -zero_delay -strip_path ${vcd_strip_path}
set vcd_clock_period [get_attribute [get_clocks *] period]
#set vcd_clock_period 0.25
set_power_clock_scaling -period ${vcd_clock_period} [get_clocks]
#set_power_clock_scaling -period ${vcd_clock_period}

#MEASURE POWER
#update_timing -full
#update_power -full
update_timing
update_power

set power [get_attribute -class design [get_designs *] total_power]
puts $power

exit
