use strict;
use warnings;
use Data::Dumper;
use GUI::DB;
use TestData;
use DBManager;

my $dbh = dbConnect;

#Removes all current data in the table 'mailing'
RemoveTestData();
#Removes all current data in table 'mailing_count'
RemoveFromCountTable();
#Creates new table to store domain counts (if not exists)
CreateCountTable();

#Indicates what set of data it will work with
my $run = 'firstrun';

#Values used to simulate dates
my $year = '2015';
my $month = '06';



#For 30 days adds a chunk of data to 'mailing'
for (my $day = 1; $day <= 5; $day++) {
	AddTestData($day, $run);
	my $date = "$year-$month-$day";
	print "Day $day Complete!\n";
	CreateHashForCountTable($date);
}


