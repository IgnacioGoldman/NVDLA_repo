#	+----------------------------------------+
#	|			DC-topo@28nm 	 |
#	|			POLITO - NUS  	 |
#	|					 |
#	|	author: andrea calimera		 |
#	|	mail:	andrea.calimera@polito.it|
#	|	title:	synthesis.tcl		 |
#	+----------------------------------------+
#	| 	Copyright 2015 	   		 |
#	+----------------------------------------+


########################################
## Suppress Warning Message
#set_message_info -id TFCHK-014 -limit 2
#set_message_info -id TFCHK-049 -limit 2
#set_message_info -id TFCHK-050 -limit 2
#set_message_info -id MWLIBP-324 -limit 2
#set_message_info -id MWLIBP-319 -limit 2
set_message_info -id TIM-179 -limit 2
set_message_info -id PSYN-650 -limit 2
set_message_info -id PSYN-651 -limit 2
set_message_info -id PSYN-025 -limit 2
suppress_message UID-401
########################################
# SPECIFY TECH. PAR, LIBRARIES & SETTINGS
########################################

# TECH & PATH SETTINGS
#########################
source "./logicSynthesis/core_settings.tcl"
source "./logicSynthesis/settings_synthesis.tcl"
source "./tech/synopsys_dc.tcl"

# DEFINE CIRCUITS and WORK DIRS
###############################
set dirname "./saved/${blockName}"
if {![file exists $dirname]} {
	file mkdir $dirname
}


########################################
# READ DESIGN
########################################
set active_design $blockName
define_design_lib WORK -path ./WORK

# ANALYZE HDL SOURCES
#For NVDLA_16_bits and NVDLA_8_bits
set my_sources [list ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mac_unit.v]

#For approx_16_bits or approx_reduced_16_bits
#set my_sources [list ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mac_unit.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mul_unit.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mult8x8.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mult4x4.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mult2x2.v]

#For approx_8_bits or approx_reduced_8_bits
#set my_sources [list ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mac_unit.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mul_unit.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mult4x4.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mult2x2.v]

#For inference_16_bits inference_8_bits inference_reduced_16_bits inference_reduced_8_bits
#set my_sources [list ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mac_unit.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mul_unit.v ~/NVDLA_repo/hardware_framework/MAC/cmac/$unit/mult8x8_inference.v]



read_file $my_sources -recursive -autoread -top $blockName -library $blockName

######################################################################
##
## DEFINE DESIGN ENVIRONMENT
##
######################################################################
#set_operating_condition -library  "${target_library}:${technolibname}" ${process}_${voltage}_${temperature}
#set_wire_load_model -library "${target_library}:${technolibname}" -name area_12Kto18K [find design *]
set_load 0.05 [all_outputs] ;# NOTE: to be checked

######################################################################
##
## SET DESIGN CONSTRAINTS
##
######################################################################
source -echo "./sdc_files/${blockName}.sdc"
set_dp_smartgen_options -all_options false -optimize_for area,speed -mult_arch benc_radix4 -booth_encoding true -booth_radix8 false -booth_mux_based false 

######################################################################
##
## OPTIMIZE DESIGN
##
######################################################################
link
ungroup -all -flatten

## FIX DRC
set compile_final_drc_fix all

# COMPILE INCREMENTAL
#compile_ultra
compile
optimize_registers -clock $clockName -minimum_period_only
set_fix_hold $clockName
compile -incremental_mapping -map_effort high -ungroup_all

uniquify
######################################################################
##
## SAVE DESIGN - STANDARD SYNTHESIS
##
######################################################################
set sdc_write_unambiguous_names false
write -format ddc -hierarchy -output "./saved/${blockName}/${blockName}_postsyn.ddc"
change_names -rules verilog_unicad
write -format verilog -hierarchy -output "./saved/${blockName}/${blockName}_postsyn.v"
write_sdf "./saved/${blockName}/${blockName}_postsyn.sdf"
write_sdc "./saved/${blockName}/${blockName}_postsyn.sdc"
write_parasitics -output "./saved/${blockName}/${blockName}_postsyn.spef"
#write_def -rows_tracks_gcells -all_vias -output "./saved/${blockName}/${blockName}_postsyn.def"
write_milkyway -overwrite -output "${blockName}_postsyn"
report_design -physical -nosplit > "./saved/${blockName}/${blockName}_postsyn_design.rpt"
report_area > "./saved/${blockName}/${blockName}_postsyn_area.rpt"
report_timing -path end > "./saved/${blockName}/${blockName}_postsyn_timing.rpt"
# REPORT TIMING OPTIONS
if {[sizeof_collection [get_flat_pins "*/GN"]] > 0} {
	set_disable_timing [get_flat_pins "*/GN"]
	report_timing >> "./saved/${blockName}/${blockName}_postsyn_timing.rpt"
	remove_attribute [get_flat_pins "*/GN"] disable_timing
} else {
	report_timing >> "./saved/${blockName}/${blockName}_postsyn_timing.rpt"
}
report_timing -delay_type min >> "./saved/${blockName}/${blockName}_postsyn_timing.rpt"
report_power > "./saved/${blockName}/${blockName}_postsyn_power.rpt"
report_cell > "./saved/${blockName}/${blockName}_postsyn_cell.rpt"
report_reference -hierarchy > "./saved/${blockName}/${blockName}_postsyn_reference.rpt"
report_constraint -all_violators > "./saved/${blockName}/${blockName}_postsyn_constraint.rpt"
report_constraint -all_violators -verbose >> "./saved/${blockName}/${blockName}_postsyn_constraint.rpt"
report_qor > "./saved/${blockName}/${blockName}_postsyn_qor.rpt"
report_clock_gating -structure > "./saved/${blockName}/${blockName}_postsyn_cg.rpt"

#######################################################################


######################################################################
##
## CLEAN & EXIT
##
######################################################################

exec rm -rf $libDir

close_mw_lib
remove_design -all
exit
