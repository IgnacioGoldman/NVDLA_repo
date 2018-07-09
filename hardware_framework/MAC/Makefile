DESIGNWARE_NOEXIST ?= 1

#TESTBENCH ?= fc
TESTBENCH ?= googlenet
#TESTBENCH ?= alexnet

#BITS ?= 8
BITS ?= 16

#UNIT ?= NVDLA_8_bits
UNIT ?= NVDLA_16_bits
#UNIT ?= approx_8_bits
#UNIT ?= approx_16_bits
#UNIT ?= inference_8_bits
#UNIT ?= inference_16_bits
#UNIT ?= approx_reduced_8_bits
#UNIT ?= approx_reduced_16_bits
#UNIT ?= inference_reduced_8_bits
#UNIT ?= inference_reduced_16_bits

FLAG ?= 0


help:
	@printf "\nEnvironment to test MACs units\n"
	@printf "Commands:\n"
	@printf "make clean\n"
	@printf "make testbench TESTBENCH=googlenet BITS=8\n"	
	@printf "make compile\n"
	@printf "make simulate\n"
	@printf "make synthesis\n"
	@printf "make switching_activity\n"
clean:
	@echo "Deleting *~ files..."
	@find . -name "*~" -type f -delete
	@rm -rf work/
	@rm -rf transcript

testbench:
	@perl ./input_data/format_tb_MAC.pl ${TESTBENCH} ${BITS}
	
compile:
	@vsim -c -do "vlog cmac/${UNIT}/*"

simulate:
	@rm -rf work/
	@rm -rf vsim.wlf	
	@perl ./input_data/format_tb_MAC.pl ${TESTBENCH} ${BITS}
ifeq ($(BITS),8)
	@vsim -c -do "vlog cmac/${UNIT}/*; vlog tb_top.v; vsim -novopt work.tb_top;run 8000ns;exit"
else
	@vsim -c -do "vlog cmac/${UNIT}/*; vlog tb_top16.v; vsim -novopt work.tb_top16;run 8000ns;exit"
endif
	@perl ./error_check/results_generator.pl ${BITS} ${FLAG}
	@perl ./error_check/compare.pl
error:
	@perl ./error_check/results_generator.pl ${BITS} ${FLAG}
	@perl ./error_check/compare.pl

synthesis:
	@dc_shell-xg-t -f logicSynthesis/synthesis.tcl

switching_activity:
	@#First modify manually files mac_unit.v and mul_unit.v according the architecture you want to synthesize
	@#dc_shell-xg-t -f logicSynthesis/synthesis.tcl
	@#At this point the unit in synthesized
	@rm -rf transcript
	@rm -rf work/
	@vsim -c -do ./scripts/mac_tb_compile.do
	@rm transcript
	@vsim -c -do ./scripts/mac_tb_sim.do
	@pt_shell -f ./scripts/MeasurePower.tcl

	
	

