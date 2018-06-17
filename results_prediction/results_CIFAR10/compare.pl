# Result of simulation
my $golden_file = "golden.txt";

# Output file of results_analyzed.pl
my $input_file = $ARGV[0];

my $gol;
my $inf;

open ($gol, "<", $golden_file) || die "Cannot open $golden_file";
open ($inf, "<", $input_file) || die "Cannot open $input_file";

my $counter = 0;
my $errors = 0;
print "\n \n";
print "Prediction accuracy for " . $ARGV[0] . "\n";
while(my $golden = <$gol>){
	if($counter < 13){	
		my $input = <$inf>;
		$golden = substr($golden,0,-1);
		$input = substr($input,0,-1);
		$counter++;
		#print $golden . " and " . $input . "\n";

		if($golden ne $input){
			$errors++;
			print "Error at line: " . $counter . "\n";
		}			 
	}
}

print "Number of images: " . $counter . "\n";
print "Number of errors: " . $errors . "\n";
my $accuracy = 100 - (($errors/$counter)*100);
print "Accuracy: " . $accuracy . "%\n";
print "\n \n";
close $gol;
close $inf;

