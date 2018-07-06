#!/usr/bin/env perl
use strict;
use File::Compare;
my $data_lenght="$ARGV[0]";

if($data_lenght != 128 && $data_lenght != 256){
	print "Error!!! Input argument should be 128 or 256\n";	
	exit;
}
# Result of simulation
my $input_file = "/home/goldman/testing_environment/results_testbench/transcript";

# Output file of results_analyzed.pl
my $output_file = "/home/goldman/testing_environment/results_testbench/results_MAC.txt";

my $inf;
my $ouf;

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";

while(my $line = <$inf>){
	if(index($line, 'mac_out_data')>0 && index($line, 'data: x ')<0 && index($line, 'top.nvdla_top.u_partition_ma.u_NV_NVDLA_cmac.u_core')>0){
		my $str = $line;
		my $data = (split (/ /, $str, 9))[2];
		my $weight = (split (/ /, $str, 9))[5];
		my $mac_out_data = (split (/ /, $str, 9))[8];		
	
		#Check if first character is an x and remove it
		while(index($data, 'x')==0){
			$data = substr($data, 1);
		}
		while(index($weight, 'x')==0){
			$weight = substr($weight, 1);
		}
		#Check if first character is an 0 and remove it
		while(index($data, '0')==0){
			$data = substr($data, 1);
		}		
		while(index($weight, '0')==0){
			$weight = substr($weight, 1);
		}
		if(index($mac_out_data, 'x')==0){
			$mac_out_data = substr($mac_out_data, 1);
		}

		#Add zeros until data_lenght
		while(length($data)<$data_lenght){
			$data = "0" . $data;
		}
		while(length($weight)<$data_lenght){
			$weight = "0" . $weight;
			
		}
		
		my $str_again = "# data: " . $data . " * weights: " . $weight . " = mac_out_data: " . $mac_out_data; 
		print $ouf $str_again;	
	}
	 
}

print "exiting file\n";
close $inf;
close $ouf;

