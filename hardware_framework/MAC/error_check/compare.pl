#!/usr/bin/env perl
use strict;
use File::Compare;
#input and output files
my $approx = "./error_check/MAC_result.txt";
my $exact = "./error_check/exact_result.txt";
my $output = "./error_check/relative_error.txt";
#variables related to I/O
my $appr;
my $ouf;
my $exac;
#open in R or W mode
open ($appr, "<", $approx) || die "Cannot open $approx";
open ($exac, "<", $exact) || die "Cannot open $exact";
open ($ouf, ">", $output) || die "Cannot open $output";

while(my $res_appr = <$appr>){
	#get lines of both files
	my $res_exac = <$exac>;
	#exact result of MAC operation
  	my $exact = $res_exac;
	#approximate reuslt o MAC operation
	my $approx = $res_appr;
	#calculate error
	my $absolute = $exact - $approx;
	my $relative = 0;		
	if ($absolute != 0 && $exact != 0){
		$relative = ($absolute/$exact)*100;
	}
	if($relative == 0){
		#print relative error
		print $ouf "relative error is: 0%\n";
	}else{
		#print relative error
		print $ouf "relative error is: " . $relative . "%\n";
	}
}
print "exiting file\n";
close $exac;
close $appr;
close $ouf;

