#!/usr/bin/env perl
use strict;
use File::Compare;

#The following directory contains the output files of the simulation
my $output_dir = "/home/goldman/testing_environment/results_testbench";

#Output file of simulation
my $input_file = "$output_dir/transcript";

#Output file of results_analyzed.pl
my $output_file = "$output_dir/results_MAC.txt";

my $inf;
my $ouf;

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";

#counter for data
my $outs = 0;

while(my $line = <$inf>){
	if(index($line, 'mac_out_data')>0 && index($line, 'data: x ')<0){ 
		my $str = $line;
		my $data = (split (/ /, $str, 9))[2];
		my $weight = (split (/ /, $str, 9))[5];
		
		while(length($data)<129){
			substr($data, 1, 0) = "0";
		}
		while(length($weight)<129){
			substr($weight, 1, 0) = "0";
		}
		if(length($data) != 129){		
			print length($data);}
		if(length($weight) != 129){		
			print length($weight);} 	
		my $str_again = "# data: " . $data . " * weights: " . $weight . " = mac_out_data: " . (split (/ /, $str, 9))[8]; 
		print $ouf $str_again;	
	}
}

print "exiting file\n";
close $inf;
close $ouf;

