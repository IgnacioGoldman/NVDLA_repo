#
#	+---------------------------------------+
#	|			DC-topo@28nm		   		|
#	|			POLITO - NUS  		   		|
#	|						   				|
#	|	authors: Andrea Calimera, Roberto Giorgio Rizzo				|
#	|	mail:	andrea.calimera@polito.it, robertogiorgio.rizzo@polito.it	|
#	|	title:	settings.tcl  |	
#	+---------------------------------------+
#	| 	Copyright 2015 						|
#	+---------------------------------------+
# 
# 

########################################
# ENABLING MULTI-CORE FUNCTIONALITIES 
########################################
set_host_options -max_cores 2

########################################
# SPECIFY TECH. PAR, LIBRARIES & SETTINGS
########################################

# ModelSim: when simulating synthesized/routed netlists, use libraries with fake timings (-> almost like RTL simulation!)
set use_emul_techlib false

set MaxArea "none"
set UltraOptimization true
set CompileMapEffort medium
set CompileAreaEffort medium
set physoptPowerOptimizationEnable false
set physoptPowerOptimizationEffort "high"
set HFNLimit 80
set HFNPinCapacitance 0.001
set HFNDelayFactor 1
set HFNTransition 0.1
set clockGateMinBitWidth 3
set clockGateMaxFanout 2048
set holdClockUncertainty 0
set STM_TargetSlack "0.0"
set STM_targetFanout 40
set STM_TargetHold "0.0"
set STM_maxRiseTransition "0.4"
set STM_useBlockFlow 1
set STM_SRLoops 10
set target_row_utilization 0.85
set default_row_utilization 0.85
set routing_time_limit 12
set tcl_precision 6

# tool variable settings
set hdlin_auto_save_templates true
set high_fanout_net_pin_capacitance 0.005
set timing_use_enhanced_capacitance_modeling true
set timing_enable_non_sequential_checks true
set extract_enable_vr_layer_blockage true
set extract_enable_vr_res_space_weighting true
set placer_detect_detours true
set report_default_significant_digits 6
set timing_enable_normalized_slack true

