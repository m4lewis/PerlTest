use strict;
use warnings;

my $numEmails = shift;
my $numDomains = shift;

for (my $i = 0; $i < 30; $i++) {
        my $day = $i + 1;
        my $filename = "day$day.txt";
        open(my $fh, '>', $filename) or die "Could not create file '$filename' $!";

	for (my $x = 0; $x < $numEmails; $x++) {
                my $username = "u".$day.$x;
                my $dom = int(rand($numDomains));
                my $domain = "domain".$dom.".com";
                my $addr = $username."\@".$domain;

		print $fh "$addr\n";
        }
        $numDomains += 3500;
        print "Day $day Complete!\n";
	close $fh;
}


