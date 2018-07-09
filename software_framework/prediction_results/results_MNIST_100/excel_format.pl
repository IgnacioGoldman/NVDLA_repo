# Result of simulation
my $input_file = "approx_reduced_INT8_scores.txt";

# Output file of results_analyzed.pl
my $output_file = "approx_reduced_INT8_scores_excel.txt";

my $inp;
my $out;

open ($inp, "<", $input_file) || die "Cannot open $input_file";
open ($out, ">", $output_file) || die "Cannot open $output_file";

while(my $line = <$inp>){
	if(length($line) > 2){	
	print $line;
	@number = split / /, $line;
	print $number;
	print $out $number[0] . "\n";
	}			 
}

close $inp;
close $out;

