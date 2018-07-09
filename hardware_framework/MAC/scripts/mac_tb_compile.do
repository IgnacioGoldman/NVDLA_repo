source ~/NVDLA_repo/hardware_framework/MAC/logicSynthesis/core_settings.tcl

set stage "postsyn"
set netlist "~/NVDLA_repo/hardware_framework/MAC/saved/mac_unit/mac_unit_postsyn.v"

vlib worklib
vlog -work worklib "/space/edalibs/unicad_45nm/CMOS045_SC_14_CORE_LS_SNPS-AVT-CDS_3.0/behaviour/verilog/CMOS045_SC_14_CORE_LS.v"
vmap worklib ./worklib 
vlib work

vlog  "~/NVDLA_repo/hardware_framework/MAC/saved/mac_unit/mac_unit_postsyn.v"
vlog  "~/NVDLA_repo/hardware_framework/MAC/tb_top.v"
#vlog  "~/NVDLA_repo/hardware_framework/MAC/tb_top16.v"
quit -f
