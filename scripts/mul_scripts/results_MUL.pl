#!/usr/bin/env perl
use strict;
use File::Compare;

#The following directory contains the output files of the simulation
my $output_dir = "/home/goldman/testing_environment/results_testbench";

#Output file of simulation
my $input_file = "$output_dir/transcript";

#Output file of results_analyzed.pl
my $output_file = "$output_dir/results_MUL.txt";

my $inf;
my $ouf;

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";

#counter for data
my $flag = 1;

while(my $line = <$inf>){
	if(index($line, 'top.nvdla_top.u_partition_ma.u_NV_NVDLA_cmac.u_core.u_mac_0.u_mul_0')>0 && index($line, 'mult_res: x')<0){ 
		my $str = $line;
		if($flag == 1){		
			print $ouf $str;
			$flag = 0;
		}else{
			$flag = 1;
		}
		
		
	}
}

print "exiting file\n";
close $inf;
close $ouf;

