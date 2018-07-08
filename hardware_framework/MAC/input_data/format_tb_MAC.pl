#!/usr/bin/env perl
use strict;
use File::Compare;
my $testbench="$ARGV[0]";
my $bits     ="$ARGV[1]";
if($testbench ne "fc" && $testbench ne "googlenet" && $testbench ne "alexnet"){
	print "\nError in testbench input variable, try with:\n";
	print "\n";
	print "make testbench TESTBENCH=fc BITS=8\n";
	print "make testbench TESTBENCH=fc BITS=16\n";
	print "make testbench TESTBENCH=googlenet BITS=8\n";
	print "make testbench TESTBENCH=googlenet BITS=16\n";
	print "make testbench TESTBENCH=alexnet BITS=8\n";
	print "make testbench TESTBENCH=alexnet BITS=16\n\n";	
	exit;
}
if($bits != 8 && $bits != 16){
	print "\nError in bits input variable, try with:\n";
	print "\n";
	print "make testbench TESTBENCH=fc BITS=8\n";
	print "make testbench TESTBENCH=fc BITS=16\n";
	print "make testbench TESTBENCH=googlenet BITS=8\n";
	print "make testbench TESTBENCH=googlenet BITS=16\n";
	print "make testbench TESTBENCH=alexnet BITS=8\n";
	print "make testbench TESTBENCH=alexnet BITS=16\n\n";	
	exit;
}

# Result of simulation
my $input_file = "./input_data/". $testbench . "_layer.txt";

# Output file of results_analyzed.pl
my $data_file = "./input_data/data_file.dat";
my $weight_file = "./input_data/weight_file.dat";

my $inf;
my $dat;
my $wt;

# Assign generation variables for each testbench
my $input_data_width = 0;
my $truncate = 0;
if($testbench eq "fc"){
	$input_data_width = 128;
}
else{
	$input_data_width = 256;
}
if($bits == 8){
	$truncate = 1;
}
if($bits == 16){
	$truncate = 0;
}

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($dat, ">", $data_file) || die "Cannot open $data_file";
open ($wt, ">", $weight_file) || die "Cannot open $weight_file";

while(my $line = <$inf>){
		my $i = 0;
		my $counter = 0;		
		my $data = (split (/ /, $line, 9))[2];
		my $weight = (split (/ /, $line, 9))[5];
		while ($i<$input_data_width){		
			my $sub_data = substr($data,$i,4);
			my $sub_weight = substr($weight,$i,4);
			$sub_data =~ tr/x/0/;
			$sub_weight =~ tr/x/0/;
			if($truncate == 1){
				$sub_data = substr($sub_data,0,2);
				$sub_weight = substr($sub_data,0,2);
			}
			print $dat $sub_data;
			print $wt $sub_weight;
			$counter = $counter + 1;
			if($counter == 8){
				print $dat "\n";
				print $wt "\n";	
				$counter = 0;
			}
			$i = $i + 4;
		}	
}
		#my $data = (split (/ /, $line, 9))[2];
		#my $weight = (split (/ /, $line, 9))[5];
		#my $i = 0;
		#my $packet = 0;
		#my $output_data;
		#my $formatted_data;
		#my $output_weight;
		#my $formatted_weight;
		#my $accumulation = 0;
		#while ($i<(256+4)){						
		#	my $sub_data = substr($data,$i,4);
		#	my $sub_weight = substr($weight,$i,4);
		#	
		#	$sub_data = substr($sub_data,0,2);
		#	$sub_weight = substr($sub_weight,0,2);

	
		#	if($packet<8){
		#		$formatted_data = "dat" . $packet . " = 8'h" . $sub_data . "; ";
		#		$output_data = $output_data . $formatted_data;	
		#		$formatted_weight = "wt" . $packet . " = 8'h" . $sub_weight . "; ";
		#		$output_weight = $output_weight . $formatted_weight;
	
				#exact MAC calculation
		#		my $dat = hex($sub_data);
		#		my $wt =  hex($sub_weight); 
		#		$dat -= 256 if $dat >= 128;
		#		$wt  -= 256 if $wt >= 128;
		#		my $mul_res = $dat*$wt;
		#		$accumulation = $accumulation + $mul_res;					
		#		printf("%d (%x) -- %d (%x)-- %d (%x) -- %d (%x)\n", $dat,$dat,$wt,$wt,$mul_res,$mul_res,$accumulation,$accumulation);		
			
		#	}else{
				#print				
		#		printf $ouf $output_weight . "\n" . "#80" . "\n" . $output_data . "\n";			
				#reset				
		#		$output_data = '';
		#		$output_weight = '';
		#		printf("%x\n", $accumulation);
		#		$accumulation = 0;

				#exact MAC calculation
		#		my $dat = hex($sub_data);
		#		my $wt =  hex($sub_weight); 
		#		$dat -= 256 if $dat >= 128;
		#		$wt  -= 256 if $wt >= 128;
		#		my $mul_res = $dat*$wt;
		#		$accumulation = $accumulation + $mul_res;					
		#		printf("%d (%x) -- %d (%x)-- %d (%x) -- %d (%x)\n", $dat,$dat,$wt,$wt,$mul_res,$mul_res,$accumulation,$accumulation);
		#		
				#add
		#		$packet = 0;				
		#		$formatted_data = "dat" . $packet . " = 8'h" . $sub_data . "; ";				
		#		$output_data = $output_data . $formatted_data;
		#		$formatted_weight = "wt" . $packet . " = 8'h" . $sub_weight . "; ";				
		#		$output_weight = $output_weight . $formatted_weight;
		#
		#	}
		#	$i = $i + 4;
		#	$packet++;		
		#}
print "exiting file\n";
close $inf;
close $dat;
close $wt;

