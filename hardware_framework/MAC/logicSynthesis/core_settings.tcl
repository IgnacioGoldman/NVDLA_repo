### CORE SETTINGS
set blockName "mac_unit"
set unit "NVDLA_16_bits"

set vcd_analysis true
if { $vcd_analysis == true} {
	set vcd_strip_path "/${blockName}_tb/u_${blockName}"
}
