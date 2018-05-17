#!/usr/bin/env perl
use strict;
use File::Compare;
my $memW="$ARGV[0]";

my $transcript_dir = '/home/goldman';
my $output_dir = '/home/goldman';
my $raw_dir = '/home/goldman/hw/simulation1/hw/verif/synth_tb/sim_scripts';

my $input_file = "$transcript_dir/transcript";
my $output_file = "$output_dir/final_transcript.txn";
my $dumpraw = "$raw_dir/0.chiplib_dump.raw2";
my $replayraw = "$raw_dir/0.chiplib_replay.raw2";

my $info;
my $ouf;
my $dumpr;
my $replayr;

print $memW;
print "accessing $input_file\n";
open ($info, "<", $input_file) || die "Cannot open $input_file";
open ($ouf, ">", $output_file) || die "Cannot open $output_file";

#counter for accesses in memory
my $accesses = 0;

if($memW == 0){
	while(my $line = <$info>){
		if(	(index($line, 'SMEM')>0 || index($line, 'MSEQ')>0 || index($line, 'run')>0 || index($line, 'AXI')>0) && !(index($line, 'Loading')>0) && !(index($line, 				'Warning')>0) && !(index($line, 'assert')>0)	){
			print $ouf $line;
			
			#SMEM and MSEQ are accesses to memory
			if(index($line, 'SMEM')>0 || index($line, 'MSEQ')>0){
				$accesses++;
			}	
		}		
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
}
else{
	while(my $line = <$info>){
		if(index($line, 'Hex_')>0){
			print $ouf $line;
		}		
	}
}
print "exiting file\n";
close $info;
close $ouf;

