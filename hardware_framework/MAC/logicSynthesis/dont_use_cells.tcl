set use_cell_list {AND2 AND3 XNOR2 XNOR3 AO12 AOI12 AOI21 BF HA1 IV FA1 NAND2 NAND3 NOR2 NOR3 OA12 OAI12 OAI21 OR2 OR2AB DFPRQ DFPQ LDLQ LDLRQ}

set use_lib_cells ""
foreach cell $use_cell_list {
        set use_lib_cells [add_to_collection $use_lib_cells [get_lib_cell "C28SOI_SC_12_CORE_${vt}/C12T28SOI_${vt}_${cell}X*"]]
        #set use_lib_cells [add_to_collection $use_lib_cells [get_lib_cell "C28SOI_SC_12_COREPBP4_${vt}/C12T28SOI_${vt}_${cell}X*"]]
        #set use_lib_cells [add_to_collection $use_lib_cells [get_lib_cell "C28SOI_SC_12_COREPBP10_${vt}/C12T28SOI_${vt}_${cell}X*"]]
        #set use_lib_cells [add_to_collection $use_lib_cells [get_lib_cell "C28SOI_SC_12_COREPBP16_${vt}/C12T28SOI_${vt}_${cell}X*"]]
}

#set dont_use_lib_cells [get_lib_cell "C28SOI_SC_12_CORE_${vt}/* C28SOI_SC_12_CLK_${vt}/* C28SOI_SC_12_COREPBP4_${vt}/* C28SOI_SC_12_COREPBP10_${vt}/* C28SOI_SC_12_COREPBP16_${vt}/* C28SOI_SC_12_PR_${vt}/*"]
set dont_use_lib_cells [get_lib_cell "C28SOI_SC_12_CORE_${vt}/* C28SOI_SC_12_CLK_${vt}/*"]
set dont_use_lib_cells [remove_from_collection $dont_use_lib_cells $use_lib_cells]

foreach_in_collection cell $dont_use_lib_cells {
	set full_name [get_attribute $cell full_name]
	set_dont_use $full_name
}
