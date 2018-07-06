source ~/hardware_framework/logicSynthesis/core_settings.tcl

set stage "postsyn"
set netlist "~/hardware_framework/saved/mac_unit/mac_unit_postsyn.v"

vlib worklib
vlog -work worklib "/space/edalibs/unicad_45nm/CMOS045_SC_14_CORE_LS_SNPS-AVT-CDS_3.0/behaviour/verilog/CMOS045_SC_14_CORE_LS.v"
vmap worklib ./worklib 
vlib work

vlog  "~/hardware_framework/saved/mac_unit/mac_unit_postsyn.v"
vlog  "~/hardware_framework/tb_top.v"
quit -f
