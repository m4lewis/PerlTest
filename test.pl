use strict;
use warnings;
use GUI::DB;
use TestData;

my $dbh = dbConnect;

#Removes all current data in the table 'mailing'
RemoveTestData;
#Indicates what set of data it will work with
my $run = 'firstrun';

#For 30 days adds a chunk of data to 'mailing'
for (my $day = 1; $day <= 1; $day++) {
	AddTestData($day, $run);
	print "Day $day Complete!\n";
	print "\n";
	print "Selecting Values from mailing Table:\n\n";
}

sub CreateCountHash {
	my @addrs = SelectAllFromCountTable;

	foreach $addr (@addrs) {
		print "$addr\n";
	}

}
