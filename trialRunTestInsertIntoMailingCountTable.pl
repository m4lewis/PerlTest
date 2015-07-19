use strict;
use warnings;
use Data::Dumper;
use GUI::DB;
use TestData;
use DBManager;

my $dbh = dbConnect;

#Removes all current data in the table 'mailing'
RemoveTestData();
CreateCountTable();
#Indicates what set of data it will work with
my $run = 'firstrun';
my $year = '2015';
my $month = '06';

my %dcount = ();


#For 30 days adds a chunk of data to 'mailing'
for (my $day = 1; $day <= 1; $day++) {
	AddTestData($day, $run);
	my $date = "$year-$month-$day";
	print "Day $day Complete!\n";
	print "\n";
	print "Selecting Values from mailing Table:\n\n";

	my @addrs = SelectAllFromMailingTable();
	my $i = 0;
	
	foreach my $row (@addrs) {
		my $addr = $row->{addr};
		chomp($addr);
		my ($address, $domain) = split /@/, $addr;
		$dcount{$domain} += 1;
		
	}

	while (my ($key, $value) = each %dcount) {
		print "$key: $value\n";
		InsertCountTable($key, $date, $value);
	}
}

