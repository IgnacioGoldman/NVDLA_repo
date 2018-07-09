#!/usr/bin/env perl
use strict;
use File::Compare;
my $approx = "./error_check/MAC_result.txt";
my $exact = "./error_check/exact_result.txt";
my $output = "./error_check/relative_error.txt";

my $appr;
my $ouf;
my $exac;
open ($appr, "<", $approx) || die "Cannot open $approx";
open ($exac, "<", $exact) || die "Cannot open $exact";
open ($ouf, ">", $output) || die "Cannot open $output";


while(my $res_appr = <$appr>){
	my $res_exac = <$exac>;
  	my $exact = $res_exac;
	my $approx = $res_appr;
	#calculate error
	my $absolute = $exact - $approx;
	my $relative = 0;		
	if ($absolute != 0 && $exact != 0){
		$relative = ($absolute/$exact)*100;
	}
	if($relative == 0){
		print $ouf "relative error is: 0%\n";
	}else{
		print $ouf "relative error is: " . $relative . "%\n";
	}
}
print "exiting file\n";
close $exac;
close $appr;
close $ouf;

