#Examples:
#make run TESTNAME=sanity0 (to run sanity0)
#make run TESTNAME=sanity1 (to run sanity1)
#make run TESTNAME=sanity2 (to run sanity2)
#default testcase is sanity0 (case of make run, without parameters)

TESTNAME ?= sanity0
run: 
	@echo Test ${TESTNAME} has started!!!;
	@cd ../../synth_tb/sim_scripts/ && ./inp_txn_to_hexdump.pl ${TESTNAME}
	@cd ../../../../../../vsim -do "project open hw/simulation1/simulation1.mpf;vsim -novopt work.top;"

