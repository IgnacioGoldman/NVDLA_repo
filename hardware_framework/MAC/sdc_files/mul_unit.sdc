#set sdc_version 1.3

set clockName "clk"
set rstName "reset"
set clockPeriod 1.0

;# Set-up Clock
#create_clock -period ${clockPeriod} -name $clockName $clockName
create_clock -period ${clockPeriod} -name VCLK
set_dont_touch_network $clockName
set_ideal_network $clockName
set_ideal_network [all_fanout -clock_tree -flat]
set_dont_touch_network $rstName
set_ideal_network $rstName
#set_clock_uncertainty [expr 0.00010*$clockPeriod] [get_clocks $clockName]; #[format %.4f [expr $clockPeriod*0.025]] [get_clocks $clockName]
#set_clock_latency [expr 0.00010*$clockPeriod] [get_clocks $clockName]; #[format %.4f [expr $clockPeriod*0.025]] [get_clocks $clockName]

;# fix hold constraints
#set_min_delay [format %.4f [expr $clockPeriod*0.05]] -through [all_registers] -from [all_inputs] -to [all_outputs]
#set_min_delay [format %.4f [expr $clockPeriod*0.05]] -from [all_registers] -to [all_registers]

set_max_delay ${clockPeriod} -from [all_inputs] -to [all_outputs]

;# Set-up IOs
#set STM_minStrength_buf "C12T28SOI_${vt}_BFX4_P0"
#set_driving_cell -library "C28SOI_SC_12_CORE_${vt}" -lib_cell $STM_minStrength_buf [all_inputs]

;# NOTE: to be checked
#set_input_delay [expr 0.0001*$clockPeriod] -clock $clockName [all_inputs]
#set_output_delay [expr 0.0001*$clockPeriod] -clock $clockName [all_outputs]

set_max_fanout 20 [current_design]
#set max_transition_time [expr 0.020*$clockPeriod]
#set_max_transition $max_transition_time [all_outputs]

;# Set area constraint
set_max_area 0

;# Set power constraints
#set_max_leakage_power "0"
#set_max_dynamic_power "0"
