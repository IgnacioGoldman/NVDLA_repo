###################################################################

# Created by write_sdc on Mon Jun 11 16:41:51 2018

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -power mW -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name area_4Kto5K -library CMOS045_SC_14_CORE_LS
set_max_area 0
