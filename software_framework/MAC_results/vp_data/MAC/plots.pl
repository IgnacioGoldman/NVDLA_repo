#!/usr/bin/env perl
use strict;
use File::Compare;

#Output file of simulation
my $input_file = "MNIST_data/approx_reduced_INT8.txt";

#Output file of results_analyzed.pl
my $plot      = "MNIST_plot_data/approx_reduced_INT8_plot.txt";
my $histogram = "MNIST_plot_data/approx_reduced_INT8_histogram.txt";

my $inf;
my $p;
my $h;

open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($p, ">", $plot) || die "Cannot open $plot";
open ($h, ">", $histogram) || die "Cannot open $histogram";

my $counter = 0;
my $flag = 0;
my $result;
my $absolute;
my $multiplication;
my $relative;
my $prev_result;
my $prev_absolute;
my $prev_multiplication;
my $prev_relative;

while(my $line = <$inf>){
	if( length($line) >= 100 && length($line) <= 130 && $counter<5000){
		if($flag eq 0){
			$prev_result = (split (/ /, $line, 14))[2];
			$prev_absolute = (split (/ /, $line, 14))[11];
			$prev_multiplication = (split (/ /, $line, 14))[8];
			$prev_relative = (split (/ /, $line, 15))[14];
			$flag = 1;
			
		}else{
			$result = (split (/ /, $line, 14))[2];
			$absolute = (split (/ /, $line, 14))[11];
			$multiplication = (split (/ /, $line, 14))[8];
			$relative = (split (/ /, $line, 15))[14];
			if($multiplication > $prev_multiplication){			
				$prev_result = $result;
				$prev_absolute = $absolute;
				$prev_multiplication = $multiplication;
				$prev_relative = $relative;
			}else{
				#print previous
				$prev_result = substr($prev_result, 2);		
				$prev_result = (hex($prev_result)^0x80000000)-0x80000000;
				
				my $str_again = $prev_result . "," . $prev_relative; 
				print $p $str_again;
	
				my $str_h = $prev_absolute  . "\n";
				print $h $str_h;
	
				$prev_result = $result;
				$prev_absolute = $absolute;
				$prev_multiplication = $multiplication;
				$prev_relative = $relative;
			}
		}
		
		$counter++;
			
	}	 
}

close $inf;
close $p;
close $h;

