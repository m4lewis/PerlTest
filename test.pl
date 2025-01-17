use strict;
use warnings;
use Data::Dumper;
use GUI::DB;
use TestData;
use DBManager;
use DomainReport;

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
for (my $day = 1; $day <= 30; $day++) {
	AddTestData($day, $run);
	my $date = "$year-$month-$day";
	CreateHashForCountTable($date);
}

print "Printing Top 50 Domains By % Change Of Count For Last 30 Days\n\n";
CreateDomainReport('2015-06-01', '2015-06-30');


