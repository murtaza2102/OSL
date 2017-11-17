use strict;
use 5.010;

my $filename = <STDIN>;
chomp  $filename;
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
my $txt=""; 
while (my $row = <$fh>) {
  chomp $row;
  $txt=$txt.$row."\n";
}

$filename = 'addressbook.txt';
open($fh, '>>', $filename) or die "Could not open file '$filename' $!";
say $fh $txt;
close $fh;
say "\nImport done";