#Examples:
#make run TESTNAME=sanity0 (to run sanity0)
#make run TESTNAME=sanity1 (to run sanity1)
#make run TESTNAME=sanity2 (to run sanity2)
#default testcase is sanity0 (case of make run, without parameters)

TESTNAME ?= sanity0
run: 
	#@echo Test started;
	#@pwd;
	@echo Test ${TESTNAME} has started!!!;
	@cd ../../synth_tb/sim_scripts/ && ./inp_txn_to_hexdump.pl ${TESTNAME}
	@cd ../../../../../../ && rm -f transcript
	@cd ../../../../../../ && rm -f final_transcript.txn
	@cd ../../../../../../ && touch final_transcript.txn
	
	#@cd ../../../../../../ && vsim -c
	
	@cd ../../../../../../ && vsim -c -do "project open hw/simulation1/hw/nvdla_syn_20171115_1149/post_simulation/post_simulation.mpf;vsim work.top;run -all;run -all"
	#here it will enter to Questasim>, makefile execution stops here
	#so copy the following lines:
	
	#for loading the project:
	#line to copy: project open hw/simulation1/simulation1.mpf
	
	#for starting simulation:	
	#line to copy: vsim -novopt work.top
	 
	#for running the simulation:
	#line to copy: run "500 ns"
	#could be more than one time depends on the simulation

	#for exiting the simulation:
	#line to copy: exit

	cd ../../synth_tb/sim_scripts/ && ./checktest_synthtb.pl
