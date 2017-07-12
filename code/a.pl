use strict;
use warnings;

my $file = 'load_titles.dump';
open my $info, $file or die "Could not open $file: $!";

my $string = <$info>;
while(<$info>){
   $string = $string . $_;
}
# print length($string);
$string =~ s/\),/\)\n INTO TITLES VALUES /g;
$string =~ s/('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')/TO_DATE\($1\,'YYYY-MM-DD')/g;
$string =~ s/((.*\n){1,500})/$1\nSELECT * FROM DUAL;\n\n INSERT ALL\n/g;
open(my $fh, '>', 'buno.sql');
print $fh $string;
close $fh;