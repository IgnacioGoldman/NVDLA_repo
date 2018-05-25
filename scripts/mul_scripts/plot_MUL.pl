#!/usr/bin/env perl
use strict;
use File::Compare;
#The following directory contains the output files of the simulation
my $output_dir = "/home/goldman/testing_environment/results_testbench";

#Output file of simulation
my $input_file = "$output_dir/relative_error.txt";

#Output file of results_analyzed.pl
my $output_file = "$output_dir/plot_MUL.txt";

my $inf;
my $ouf;

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";

while(my $line = <$inf>){
	my $data = (split (/ /, $line, 24))[6];
	$data = substr $data, 1;
	my $error = (split (/ /, $line, 30))[23];
	my $str_again = $data . "," . $error . "\n"; 
	print $ouf $str_again;	 
}

print "exiting file\n";
close $inf;
close $ouf;

