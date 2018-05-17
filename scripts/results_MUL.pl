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
my $outs = 0;

while(my $line = <$inf>){
	if(index($line, 'mult_res')>0){ 
		my $str = $line;
		#$str = (split (/ /, $str, 3))[2];
		#if(index($str, 'x')<0){						
			#if(length($str)==11){
			#	$str = substr($str, 2);
			#}elsif(length($str)==10){
			#	$str = substr($str, 1);
			#}elsif(length($str)==8){
			#	$str = "0". $str;
			#}
			print $ouf $str;
			
		#	$outs++;
		#}
	}
}

print "exiting file\n";
close $inf;
close $ouf;

