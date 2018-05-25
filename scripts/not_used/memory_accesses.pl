#!/usr/bin/env perl
use strict;
use File::Compare;

#The following directory contains the output files of the simulation
my $output_dir = "/home/goldman/testing_environment/results_testbench";

#Output file of simulation
my $input_file = "$output_dir/transcript";

#Output file of results_analyzed.pl
my $output_file = "$output_dir/memory_accesses.txn";

#my $dumpraw = "$output_dir/0.chiplib_dump.raw2";
#my $replayraw = "$output_dir/0.chiplib_replay.raw2";

my $inf;
my $ouf;
my $dumpr;
my $replayr;

print "accessing $input_file\n";
open ($inf, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";

#counter for accesses in memory
my $accesses = 0;

while(my $line = <$inf>){
	if( index($line, 'SMEM')>0 || index($line, 'AXI')>0){
		print $ouf $line;
		$accesses++;
	}
	#if(	(index($line, 'SMEM')>0 || index($line, 'MSEQ')>0 || index($line, 'run')>0 || index($line, 'AXI')>0) && !(index($line, 'Loading')>0) && !(index($line, 			'Warning')>0) && !(index($line, 'assert')>0)	){
	#	print $ouf $line;
			
		#SMEM and MSEQ are accesses to memory
	#	if(index($line, 'SMEM')>0 || index($line, 'MSEQ')>0){
	#		$accesses++;
	#	}	
	#}		
}

print $ouf "The number of accesses to memory is: ";
print $ouf $accesses;
	
	#COMPARING DUMP WITH REPLAY RAW
	#if ((-e $dumpraw)&&(-e $replayraw)){	
	#	my %results = (); 	
	#	open FILE1, "$dumpraw" or die "Could not open file: $! \n";
	#	while(my $line = <FILE1>){   
	#		$results{$line}=1;
	#	}
	#	close(FILE1); 
	#	open FILE2, "$replayraw" or die "Could not open file: $! \n";
	#	while(my $line =<FILE2>) {  
	#		$results{$line}++;
	#	}
	#	close(FILE2);  
	#	foreach my $line (keys %results) { print $ouf $line if $results{$line} == 1;
	#	}
	#}

print "exiting file\n";
close $inf;
close $ouf;

