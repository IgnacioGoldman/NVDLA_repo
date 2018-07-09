#!/usr/bin/env perl
use strict;
use File::Compare;
my $bits     ="$ARGV[0]";
my $flag     ="$ARGV[1]";
my $input_file = "./transcript";
my $output_file = "./error_check/MAC_result.txt";
my $exact_file;
if($flag == 1){
	$exact_file = "./error_check/exact_result.txt";
}
my $inf;
my $ouf;
my $exac;
my $check;
my $input_lenght = 0;
if($bits == 8){
	$input_lenght = 2;
}
if($bits == 16){
	$input_lenght = 4;
}

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";
if($flag == 1){
open ($exac, ">", $exact_file) || die "Cannot open $exact_file";
}
my $C = 0;
my $B = 0;
my $A = 0;
my $k = 0;
while(my $line = <$inf>){
  if(index($line,"weight:")>0){	
	if ($k < 300000){	
		$C = $B;
		$B = $A;
		$A = $line;
		#print $A . " " . $B . " " . $C . " " . $line . "\n";	

		my $data = (split (/ /, $C, 9))[2];
		my $weight = (split (/ /, $C, 9))[5];
		my $result = (split (/ /, $A, 9))[7];
		my $accumulation = 0;
		#print $data . " * " . $weight . " = " . $result . "\n";

		#Fill with zeros
		while(length($data)<(8*$input_lenght)){
			$data = "0" . $data;
		}
		while(length($weight)<(8*$input_lenght)){
			$weight = "0" . $weight;
		}
		my $res =  hex($result);
		my $i = 0;
		while($i<(8*$input_lenght)){
			my $sub_data = substr($data,$i,$input_lenght);
			my $sub_weight = substr($weight,$i,$input_lenght);
			#print $sub_data . " * " . $sub_weight . " = \n"; 
			$i = $i + $input_lenght;

			#exact MAC calculation
			my $dat = hex($sub_data);
			my $wt =  hex($sub_weight);
			 
			if($bits == 8){			
				$dat -= 256 if $dat >= 128;
				$wt  -= 256 if $wt >= 128;
			}
			else{
				$dat -= 65536 if $dat >= 32768;
				$wt  -= 65536 if $wt >= 32768;
			}
			my $mul_res = $dat*$wt;
			$accumulation = $accumulation + $mul_res;					
		}
	  	if($k>1){
			if($bits == 8){			
				$res  -= 65536 if $res >= 32768;
				$res = $res*65536;
			}
			else{
				$res  -= 4294967296 if $res >= 2147483648;
			}
			
			print $ouf $res . "\n";
			if($flag == 1){
				print $exac $accumulation . "\n";
			}
          }
	}
	$k++;
	
  }	
}
print "exiting file\n";
close $inf;
close $ouf;

