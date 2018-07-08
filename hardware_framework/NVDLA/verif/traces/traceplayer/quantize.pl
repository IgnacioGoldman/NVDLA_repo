#!/usr/bin/env perl
use strict;
use File::Compare;

# Result of simulation
my $input_file = "cc_alexnet_conv5_relu5_int16_dtest_cvsram/input_feature_map.dat";

# Output file of results_analyzed.pl
my $output_file = "cc_alexnet_conv5_relu5_int8_dtest_cvsram/input_feature_map.dat";

my $inf;
my $ouf;
my $counter = 0;

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";

while(my $line = <$inf>){
	if(length($line)>=50){
		my @str = split / /, $line;
		my $out_string;
		my $flag = 0;		
		foreach (@str){
			if($flag == 0){
				$out_string = $out_string . " 0x00 ";
				$flag = 1;
			}else{
				$out_string = $out_string . $_;
				$flag = 0;
			}		
		} 
		$out_string = (split(/ /,$out_string,2))[1];
		print $ouf $out_string;
	}
	$counter++;	
}

print "exiting file\n";
close $inf;
close $ouf;

