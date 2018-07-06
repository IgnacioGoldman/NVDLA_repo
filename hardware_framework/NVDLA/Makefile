#Choose a pair
#-------------
#TESTNAME ?= conv_8x8_fc_int16
#DATA_WIDTH ?= 128

#TESTNAME ?= googlenet_conv2_3x3_int16
#DATA_WIDTH ?= 256

TESTNAME ?= cc_alexnet_conv5_relu5_int16_dtest_cvsram
DATA_WIDTH ?= 256

#TESTNAME ?= conv_8x8_fc_int8
#DATA_WIDTH ?= 128

#TESTNAME ?= googlenet_conv2_3x3_int8
#DATA_WIDTH ?= 256

#TESTNAME ?= cc_alexnet_conv5_relu5_int8_dtest_cvsram
#DATA_WIDTH ?= 256


#Choose the MAC
#--------------
MAC ?= nvdla
#MAC ?= new_nvdla
#MAC ?= approx
#MAC ?= inference


#Pre or Post synthesis (0 or 1)
#--------------
SYNTH ?= 0
#SYNTH ?= 1

#Check waves or not (-c or nothing)
#--------------
WAVES ?=-c

synthrams_PATH  ?= container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/synth/
vlibs_PATH      ?= container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/
include_PATH 	?= container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/inclu
bdma_PATH       ?= container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/bdma/
car_PATH        ?= container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/car/
DESIGNWARE_NOEXIST ?= 1

compile:
	@#Adaptation to Modelsim
	@#Correcting errors...	
	@#Change files from .v to .sv in /synth_tb
	@[ -f synth_tb/axi_slave.v ] && mv synth_tb/axi_slave.v synth_tb/axi_slave.sv || echo "synth_tb/axi_slave.sv exists :)"
	@[ -f synth_tb/slave2mem_rd.v ] && mv synth_tb/slave2mem_rd.v synth_tb/slave2mem_rd.sv || echo "synth_tb/slave2mem_rd.sv exists :)"
	@[ -f synth_tb/tb_top.v ] && mv synth_tb/tb_top.v synth_tb/tb_top.sv || echo "synth_tb/tb_top.sv exists :)"
	@[ -f synth_tb/csb_master_seq.v ] && mv synth_tb/csb_master_seq.v synth_tb/csb_master_seq.sv || echo "synth_tb/csb_master_seq.sv exists :)"

	@#Change files from .v to .sv in /vlibs
	@[ -f ${vlibs_PATH}NV_DW_lsd.v ] && mv ${vlibs_PATH}NV_DW_lsd.v ${vlibs_PATH}NV_DW_lsd.sv || echo "${vlibs_PATH}NV_DW_lsd.sv exists :)"

	@#Change files from .v to .sv in /rams/synth
	@[ -f ${synthrams_PATH}nv_ram_rws_64x116.v ] && mv ${synthrams_PATH}nv_ram_rws_64x116.v ${synthrams_PATH}nv_ram_rws_64x116.sv || echo "${synthrams_PATH}nv_ram_rws_64x116.sv exists :)"
	@[ -f ${synthrams_PATH}nv_ram_rws_16x256.v ] && mv ${synthrams_PATH}nv_ram_rws_16x256.v ${synthrams_PATH}nv_ram_rws_16x256.sv || echo "${synthrams_PATH}nv_ram_rws_16x256.sv exists :)"    
	@[ -f ${synthrams_PATH}nv_ram_rwsp_80x14.v ] && mv ${synthrams_PATH}nv_ram_rwsp_80x14.v ${synthrams_PATH}nv_ram_rwsp_80x14.sv || echo "${synthrams_PATH}nv_ram_rwsp_80x14.sv exists :)"           
	@[ -f ${synthrams_PATH}nv_ram_rwsp_128x11.v ] && mv ${synthrams_PATH}nv_ram_rwsp_128x11.v ${synthrams_PATH}nv_ram_rwsp_128x11.sv || echo "${synthrams_PATH}nv_ram_rwsp_128x11.sv exists :)" 
	@[ -f ${synthrams_PATH}nv_ram_rws_256x3.v ] && mv ${synthrams_PATH}nv_ram_rws_256x3.v ${synthrams_PATH}nv_ram_rws_256x3.sv || echo "${synthrams_PATH}nv_ram_rws_256x3.sv exists :)"           
	@[ -f ${synthrams_PATH}nv_ram_rwsp_80x16.v ] && mv ${synthrams_PATH}nv_ram_rwsp_80x16.v ${synthrams_PATH}nv_ram_rwsp_80x16.sv || echo "${synthrams_PATH}nv_ram_rwsp_80x16.sv exists :)"          
	@[ -f ${synthrams_PATH}nv_ram_rwsp_128x6.v ] && mv ${synthrams_PATH}nv_ram_rwsp_128x6.v ${synthrams_PATH}nv_ram_rwsp_128x6.sv || echo "${synthrams_PATH}nv_ram_rwsp_128x6.sv exists :)"
	@[ -f ${synthrams_PATH}nv_ram_rws_256x512.v ] && mv ${synthrams_PATH}nv_ram_rws_256x512.v ${synthrams_PATH}nv_ram_rws_256x512.sv || echo "${synthrams_PATH}nv_ram_rws_256x512.sv exists :)"          
	@[ -f ${synthrams_PATH}nv_ram_rwsp_80x256.v ] && mv ${synthrams_PATH}nv_ram_rwsp_80x256.v ${synthrams_PATH}nv_ram_rwsp_80x256.sv || echo "${synthrams_PATH}nv_ram_rwsp_80x256.sv exists :)"           
	@[ -f ${synthrams_PATH}nv_ram_rwsp_160x16.v ] && mv ${synthrams_PATH}nv_ram_rwsp_160x16.v ${synthrams_PATH}nv_ram_rwsp_160x16.sv || echo "${synthrams_PATH}nv_ram_rwsp_160x16.sv exists :)"
	@[ -f ${synthrams_PATH}nv_ram_rws_256x7.v ] && mv ${synthrams_PATH}nv_ram_rws_256x7.v ${synthrams_PATH}nv_ram_rws_256x7.sv || echo "${synthrams_PATH}nv_ram_rws_256x7.sv ya exists :)"        
	@[ -f ${synthrams_PATH}nv_ram_rwsp_80x514.v ] && mv ${synthrams_PATH}nv_ram_rwsp_80x514.v ${synthrams_PATH}nv_ram_rwsp_80x514.sv || echo "${synthrams_PATH}nv_ram_rwsp_80x514.sv exists :)"            
	@[ -f ${synthrams_PATH}nv_ram_rwsp_160x514.v ] && mv ${synthrams_PATH}nv_ram_rwsp_160x514.v ${synthrams_PATH}nv_ram_rwsp_160x514.sv || echo "${synthrams_PATH}nv_ram_rwsp_160x514.sv exists :)" 
	@[ -f ${synthrams_PATH}nv_ram_rws_32x16.v ] && mv ${synthrams_PATH}nv_ram_rws_32x16.v ${synthrams_PATH}nv_ram_rws_32x16.sv || echo "${synthrams_PATH}nv_ram_rws_32x16.sv ya exists :)"          
	@[ -f ${synthrams_PATH}nv_ram_rwst_256x8.v ] && mv ${synthrams_PATH}nv_ram_rwst_256x8.v ${synthrams_PATH}nv_ram_rwst_256x8.sv || echo "${synthrams_PATH}nv_ram_rwst_256x8.sv exists :)"           
	@[ -f ${synthrams_PATH}nv_ram_rwsp_20x289.v ] && mv ${synthrams_PATH}nv_ram_rwsp_20x289.v ${synthrams_PATH}nv_ram_rwsp_20x289.sv || echo "${synthrams_PATH}nv_ram_rwsp_20x289.sv existe :)"
	@[ -f ${synthrams_PATH}nv_ram_rws_32x512.v ] && mv ${synthrams_PATH}nv_ram_rws_32x512.v ${synthrams_PATH}nv_ram_rws_32x512.sv || echo "${synthrams_PATH}nv_ram_rws_32x512.sv existe :)"         
	@[ -f ${synthrams_PATH}nv_ram_rwsthp_19x80.v ] && mv ${synthrams_PATH}nv_ram_rwsthp_19x80.v ${synthrams_PATH}nv_ram_rwsthp_19x80.sv || echo "${synthrams_PATH}nv_ram_rwsthp_19x80.sv exists :)"           
	@[ -f ${synthrams_PATH}nv_ram_rwsp_245x514.v ] && mv ${synthrams_PATH}nv_ram_rwsp_245x514.v ${synthrams_PATH}nv_ram_rwsp_245x514.sv || echo "${synthrams_PATH}nv_ram_rwsp_245x514.sv exists :)"
	@[ -f ${synthrams_PATH}nv_ram_rws_32x544.v ] && mv ${synthrams_PATH}nv_ram_rws_32x544.v ${synthrams_PATH}nv_ram_rws_32x544.sv || echo "${synthrams_PATH}nv_ram_rws_32x544.sv exists :)"         
	@[ -f ${synthrams_PATH}nv_ram_rwsthp_60x168.v ] && mv ${synthrams_PATH}nv_ram_rwsthp_60x168.v ${synthrams_PATH}nv_ram_rwsthp_60x168.sv || echo "${synthrams_PATH}nv_ram_rwsthp_60x168.sv exists :)"           
	@[ -f ${synthrams_PATH}nv_ram_rwsp_256x11.v ] && mv ${synthrams_PATH}nv_ram_rwsp_256x11.v ${synthrams_PATH}nv_ram_rwsp_256x11.sv || echo "${synthrams_PATH}nv_ram_rwsp_256x11.sv exists :)" 
	@[ -f ${synthrams_PATH}nv_ram_rws_32x768.v ] && mv ${synthrams_PATH}nv_ram_rws_32x768.v ${synthrams_PATH}nv_ram_rws_32x768.sv || echo "${synthrams_PATH}nv_ram_rws_32x768.sv exists :)"           
	@[ -f ${synthrams_PATH}nv_ram_rwsthp_80x15.v ] && mv ${synthrams_PATH}nv_ram_rwsthp_80x15.v ${synthrams_PATH}nv_ram_rwsthp_80x15.sv || echo "${synthrams_PATH}nv_ram_rwsthp_80x15.sv exists :)"            
	@[ -f ${synthrams_PATH}nv_ram_rwsp_32x32.v ] && mv ${synthrams_PATH}nv_ram_rwsp_32x32.v ${synthrams_PATH}nv_ram_rwsp_32x32.sv || echo "${synthrams_PATH}nv_ram_rwsp_32x32.sv exists :)"     
	@[ -f ${synthrams_PATH}nv_ram_rws_64x10.v ] && mv ${synthrams_PATH}nv_ram_rws_64x10.v ${synthrams_PATH}nv_ram_rws_64x10.sv || echo "${synthrams_PATH}nv_ram_rws_64x10.sv exists :)"      
	@[ -f ${synthrams_PATH}nv_ram_rwsthp_80x72.v ] && mv ${synthrams_PATH}nv_ram_rwsthp_80x72.v ${synthrams_PATH}nv_ram_rwsthp_80x72.sv || echo "${synthrams_PATH}nv_ram_rwsthp_80x72.sv exists :)" 
	@[ -f ${synthrams_PATH}nv_ram_rwsp_61x514.v ] && mv ${synthrams_PATH}nv_ram_rwsp_61x514.v ${synthrams_PATH}nv_ram_rwsp_61x514.sv || echo "${synthrams_PATH}nv_ram_rwsp_61x514.sv exists :)"

	@#Some files have errors when working in Modelsim. The same file without the error is generated and saved in files_without_errors so a replacement is done
	@#cp <source> <destination>	
	@cp files_without_errors/NV_HWACC_NVDLA_tick_defines.vh ${include_PATH}de/NV_HWACC_NVDLA_tick_defines.vh
	@cp files_without_errors/RANDFUNC.vlib ${vlibs_PATH}RANDFUNC.vlib
	@cp files_without_errors/NV_NVDLA_BDMA_csb.v ${bdma_PATH}NV_NVDLA_BDMA_csb.v
	@cp files_without_errors/NV_NVDLA_BDMA_store.v ${bdma_PATH}NV_NVDLA_BDMA_store.v
	@cp files_without_errors/NV_NVDLA_sync3d.v ${car_PATH}NV_NVDLA_sync3d.v
	@cp files_without_errors/NV_NVDLA_sync3d_c.v ${car_PATH}NV_NVDLA_sync3d_c.v
	@cp files_without_errors/NV_NVDLA_sync3d_s.v ${car_PATH}NV_NVDLA_sync3d_s.v
	@cp files_without_errors/DW02_tree.v ${vlibs_PATH}DW02_tree.v
	@cp files_without_errors/DW_lsd.sv ${vlibs_PATH}DW_lsd.sv
	@cp files_without_errors/DW_minmax.v ${vlibs_PATH}DW_minmax.v

	@cd /home/goldman/testing_environment/verif/synth_tb/sim_scripts && ./inp_txn_to_hexdump.pl ${TESTNAME}

ifeq ($(SYNTH),0)
	@#vsim -c -do "vlog mac_units/${MAC}_mac/cmac/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/"
	@#vsim -c -do "vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/"		
	@vsim ${WAVES} -do "vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/model/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/synth/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/apb2csb/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/bdma/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/; vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cacc/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/; vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/car/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cbuf/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cdma/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog mac_units/${MAC}_mac/cmac/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/csb_master/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/csc/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/glb/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/nocif/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/pdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/retiming/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/rubik/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/sdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog synth_tb/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vsim -novopt work.top +incdir+synth_tb/ +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/ +define+functional+DESIGNWARE_NOEXIST;run -all;exit;"
else
	@vsim ${WAVES} -do "vlog /space/edalibs/unicad_45nm/CMOS045_SC_14_CORE_LS_SNPS-AVT-CDS_3.0/behaviour/verilog/CMOS045_SC_14_CORE_LS.v +define+functional;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/model/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/synth/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/apb2csb/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/bdma/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/; vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cacc/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/; vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/car/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cbuf/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cdma/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog mac_units/synth_${MAC}_mac/cmac/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/csb_master/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/csc/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/glb/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/nocif/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/pdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/retiming/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/rubik/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/sdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog synth_tb/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vsim -novopt work.top +incdir+synth_tb/ +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/ +define+functional+DESIGNWARE_NOEXIST;run -all"
endif
	@[ -f transcript ] && mv transcript results_testbench/ || echo "transcript has been moved before :)"

synth:
	@echo "starting synthesis..."

load_exact:	
	@cd /home/goldman/testing_environment/verif/synth_tb/sim_scripts && ./inp_txn_to_hexdump.pl ${TESTNAME}

	@vsim -c -do "vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/model/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/synth/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/apb2csb/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/bdma/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/; vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cacc/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/; vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/car/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cbuf/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cdma/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog mac_units/nvdla_mac/cmac/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/csb_master/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/csc/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/glb/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/nocif/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/pdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/retiming/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/rubik/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/sdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog synth_tb/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vsim -novopt work.top +incdir+synth_tb/ +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/ +define+functional+DESIGNWARE_NOEXIST;run -all;exit;"
	
	@[ -f transcript ] && mv transcript results_testbench/ || echo "transcript has been moved before :)"

	@#Borro y creo un results_MAC.txt vacio
	@[ -f /results_testbench/results_MAC.txt ] && rm /results_testbench/results_MAC.txt || echo "results_MAC.txt has been deleted before :)"
	@cd scripts && ./results_MAC.pl ${DATA_WIDTH}
	
	@#Borro y creo un exact_results_MAC.txt vacio
	@[ -f /results_testbench/exact_results_MAC.txt ] && rm /results_testbench/exact_results_MAC.txt || echo "exact_results_MAC.txt has been deleted before :)"
	@cd scripts && gcc MAC.c -o MAC
	@cd scripts && ./MAC ${DATA_WIDTH}

	@#Borro y creo un exact_results_MAC.txt vacio
	@[ -f /results_testbench/compare_results_MAC.txt ] && rm /results_testbench/compare_results_MAC.txt || echo "compare_results_MAC.txt has been deleted before :)"
	@cd scripts && gcc compare_nvdla_MAC.c -o compare_nvdla_MAC
	@cd scripts && ./compare_nvdla_MAC

calculate_error:
	@cd /home/goldman/testing_environment/verif/synth_tb/sim_scripts && ./inp_txn_to_hexdump.pl ${TESTNAME}
	@vsim -c -do "vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/model/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/vlibs/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/rams/synth/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/apb2csb/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/bdma/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/; vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cacc/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/; vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/car/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cbuf/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cdma/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog mac_units/${MAC}_mac/cmac/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/csb_master/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/csc/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/glb/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/nocif/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/pdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/retiming/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/rubik/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/sdp/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vlog synth_tb/*;vlog container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/* +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/include/;vsim -novopt work.top +incdir+synth_tb/ +incdir+container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/ +define+functional+DESIGNWARE_NOEXIST;run 650000ns;exit;"

	@[ -f transcript ] && mv transcript results_testbench/ || echo "transcript has been moved before :)"

	@#Borro y creo un results_MAC.txt vacio
	@[ -f /results_testbench/results_MAC.txt ] && rm /results_testbench/results_MAC.txt || echo "results_MAC.txt has been deleted before :)"
	@cd scripts && ./results_MAC.pl ${DATA_WIDTH}

	@#Borro y creo un exact_results_MAC.txt vacio
	@[ -f /results_testbench/relative_error_MAC.txt ] && rm /results_testbench/relative_error_MAC.txt || echo "relative_error_MAC.txt has been deleted before :)"
	@cd scripts && gcc relative_error_MAC.c -o relative_error_MAC
	@cd scripts && ./relative_error_MAC

	@#Borro y creo un results_MAC.txt vacio
	@[ -f /results_testbench/results_MUL.txt ] && rm /results_testbench/results_MUL.txt || echo "results_MUL.txt has been deleted before :)"
	@cd scripts/mul_scripts && ./results_MUL.pl

	@#Borro y creo un exact_results_MAC.txt vacio
	@[ -f /results_testbench/relative_error.txt ] && rm /results_testbench/relative_error.txt || echo "relative_error.txt has been deleted before :)"
	@cd scripts/mul_scripts && gcc relative_error.c -o relative_error
	@cd scripts/mul_scripts && ./relative_error

clean:
	@echo "Deleting *~ files..."
	@find . -name "*~" -type f -delete
	
