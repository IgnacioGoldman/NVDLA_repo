###################################################################

# Created by write_sdc on Mon Jun 4 10:43:53 2018

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -power mW -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name area_3Kto4K -library CMOS045_SC_14_CORE_LS
set_max_area 0
