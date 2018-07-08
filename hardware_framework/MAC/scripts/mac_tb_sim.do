source ~/hardware_framework/logicSynthesis/core_settings.tcl

set stage "postsyn"
set netlist "~/hardware_framework/saved/mac_unit/mac_unit_postsyn.v"
 
onbreak resume
onerror
 
vsim +notimingchecks -novopt -L worklib work.tb_top
 
vcd file "./Testbenches/top.vcd"
#vcd add -r "/tb_top/UUT/*"
vcd add -in "/tb_top/UUT/*"
#vcd add -out "/tb_top/UUT/*"
 
run 90000ns

quit
  
 
