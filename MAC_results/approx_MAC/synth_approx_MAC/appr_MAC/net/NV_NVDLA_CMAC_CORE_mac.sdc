###################################################################

# Created by write_sdc on Thu May 17 18:15:28 2018

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -power mW -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name area_60Kto66K -library CMOS045_SC_14_CORE_LS
set_max_area 0
