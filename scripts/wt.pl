#!/usr/bin/env perl
use strict;
use File::Compare;

#The following directory contains the output files of the simulation
my $output_dir = "/home/goldman/testing_environment/results_testbench";

#Output file of simulation
my $input_file = "$output_dir/transcript";

#Output file of results_analyzed.pl
my $output_file = "$output_dir/wt.txt";

my $inf;
my $ouf;

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";

#counter for data
my $weights = 0;

while(my $line = <$inf>){
	if(index($line, 'wt_actv_data')>0){ 
		my $str = $line;
		$str = (split (/x/, $str, 2))[1];
		while(length($str)!=129){
			$str = "0". $str;		
		}		
		print $ouf $str;
		$weights++;
	}	
}

print $ouf "The number of input weights to MACs: ";
print $ouf $weights;

print "exiting file\n";
close $inf;
close $ouf;

