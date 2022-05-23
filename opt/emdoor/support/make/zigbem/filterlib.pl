

use strict;
use warnings;
use Getopt::Long;

my $file;

GetOptions(
	"file=s" => \$file,
);
open IN, $file or die "Error: can not open the file!";
my @lines = <IN>;
close (IN);

open OUT, ">$file" or die "Error: can not open file!";

my $i = 0;

for ($i=0; $i < @lines; $i++) {
	my $line = $lines[$i];
	$line =~ s/\bstatic\b//g;
	print OUT $line;
}

close (OUT);