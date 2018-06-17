use List::Util 'max';
# Result of simulation
my $input_file = "blur2_results/NVDLA_original.txt";

# Output file of results_analyzed.pl
my $output_file = "blur2_results/NVDLA.txt";

my $inp;
my $out;

open ($inp, "<", $input_file) || die "Cannot open $input_file";
open ($out, ">", $output_file) || die "Cannot open $output_file";

my $counter = 0;
my $max_index;

while(my $line = <$inp>){
	if($counter < 3){	
		my @numbers = split / /, $line;
		my $max = $numbers[0];
		my $max_index = 0;
		my $i = 1;
		while($i <length(@numbers)) {
  			if ($numbers[$i] > $max){
				$max = $numbers[$i];
				$max_index = $i;
			}
			$i++;
		}
		print $max . "\n";
		print $max_index;
		print "\n";
		#$golden = substr($golden,0,-1);
		#$input = substr($input,0,-1);
		$counter++;
		#print $golden . " and " . $input . "\n";

		#if($golden ne $input){
		#	$errors++;
		#	print "Error at line: " . $counter . "\n";
		#}			 
	}
}

close $gol;
close $inf;

