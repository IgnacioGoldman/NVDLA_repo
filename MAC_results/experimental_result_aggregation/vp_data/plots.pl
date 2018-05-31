#!/usr/bin/env perl
use strict;
use File::Compare;

#Output file of simulation
my $input_file = "MNIST_data/ideal_INT8.txt";

#Output file of results_analyzed.pl
my $plot      = "MNIST_plot_data/ideal_INT8_plot.txt";
my $histogram = "MNIST_plot_data/ideal_INT8_histogram.txt";

my $inf;
my $p;
my $h;

open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($p, ">", $plot) || die "Cannot open $plot";
open ($h, ">", $histogram) || die "Cannot open $histogram";

my $counter = 0;
while(my $line = <$inf>){
	my $line = <$inf>;
	if( length($line) >= 100 && length($line) <= 130 && $counter<5000){
		$counter++;
		my $result = (split (/ /, $line, 16))[11];
		my $absolute = (split (/ /, $line, 16))[14];
		my $relative = (split (/ /, $line, 18))[17];		
		
		$result = substr($result, 2);		
		$result = (hex($result)^0x80000000)-0x80000000;
				
		my $str_again = $result . "," . $relative; 
		print $p $str_again;
	
		my $str_h = $absolute  . "\n";
		print $h $str_h;	
	}	 
}

close $inf;
close $p;
close $h;

