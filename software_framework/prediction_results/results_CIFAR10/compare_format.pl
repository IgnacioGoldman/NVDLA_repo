use List::Util 'max';
# Result of simulation
my $input_file = "inference_INT8_original.txt";

# Output file of results_analyzed.pl
my $output_file = "inference_INT8.txt";

my $inp;
my $out;

open ($inp, "<", $input_file) || die "Cannot open $input_file";
open ($out, ">", $output_file) || die "Cannot open $output_file";

my $counter = 0;
my $max_index;

while(my $line = <$inp>){
	if($counter < 30){	
		my @numbers = split / /, $line;
		my $max = $numbers[0];
		my $max_index = 0;
		my $i = 1;
		while($i < $#numbers) {
			  			
			if ($numbers[$i] > $max){
				$max = $numbers[$i];
				$max_index = $i;
			}
			$i++;
		}
		
		my @array = ("0","0","0","0","0","0","0","0","0","0");
		@array[$max_index] = "1";
		foreach my $n (@array) {
  			print $out $n . " ";
		}
		print $out "\n";
		$counter++;
	}
}

close $gol;
close $inf;

