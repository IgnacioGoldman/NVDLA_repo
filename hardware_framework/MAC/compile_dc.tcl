set my_verilog_files [list ./cmac/mul_unit.v ./cmac/mult8x8.v ./cmac/mult4x4.v ./cmac/mult2x2.v]
set my_toplevel mul_unit
set link_library "/space/edalibs/unicad_45nm/CMOS045_SC_14_CORE_LS_SNPS-AVT-CDS_3.0/libs/CMOS045_SC_14_CORE_LS_nom_1.10V_25C.db"
set target_library "/space/edalibs/unicad_45nm/CMOS045_SC_14_CORE_LS_SNPS-AVT-CDS_3.0/libs/CMOS045_SC_14_CORE_LS_nom_1.10V_25C.db"
define_design_lib WORK -path ./WORK
set verilogout_show_unconnected_pins "true"
set_ultra_optimization true
set_ultra_optimization -force

analyze -f verilog $my_verilog_files
elaborate $my_toplevel
current_design $my_toplevel

#/* The name of the clock pin. If no clock-pin     */
#/* exists, pick anything                          */
set my_period 0.5
set my_clock_pin clk
set find_clock [ find port [list $my_clock_pin] ]
if {  $find_clock != [list] } {
   set clk_name $my_clock_pin
   create_clock -period $my_period -name $clk_name $clk_name
} else {
   set clk_name vclk
   create_clock -period $my_period -name $clk_name
   set_max_delay ${clockPeriod} -from [all_inputs] -to [all_outputs]
}

#Roberto
#set clockPeriod 5
#set clockName "clk"
#create_clock -period ${clockPeriod} -name $clockName
#set_max_delay ${clockPeriod} -from [all_inputs] -to [all_outputs]

set_dp_smartgen_options -all_options false -optimize_for speed -mult_arch benc_radix4 -booth_encoding true -booth_radix8 false -booth_mux_based false
link
ungroup -all -flatten

compile_ultra
uniquify
check_design
report_constraint -all_violators

set filename [format "%s%s"  $my_toplevel ".vh"]
write -f verilog -output $filename

set filename [format "%s%s"  $my_toplevel ".sdc"]
write_sdc $filename

set filename [format "%s%s"  $my_toplevel ".db"]
write -f db -hier -output $filename -xg_force_db

report_dp_smartgen_options > dp_report.txt

redirect timing.rep { report_timing }
redirect cell.rep { report_cell }
redirect power.rep { report_power }
quit
