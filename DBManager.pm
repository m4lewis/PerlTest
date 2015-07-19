package DBManager;

use strict;
use warnings;
use GUI::DB;
use base 'Exporter';


our @EXPORT = qw(CreateCountTable InsertCountTable SelectAllFromMailingTable 
		SelectAllFromCountTable RemoveFromCountTable
		CreateHashForCountTable SelectWhereDateFromCountTable
		SelectWhereDateAndDomainFromCountTable);

###########################################################
#SelectAllFromMailingTable ()####################
#Purpose: Gets all records from 'mailing' table
###########################################################
sub SelectAllFromMailingTable {
	my $dbh = dbConnect;
	my $sql = "SELECT * FROM mailing;";
	my @results = query($dbh, $sql);
	return @results;
}

###########################################################
#CreateCountTable ()####################
#Purpose: Creates mailing_count table if not exists
###########################################################
sub CreateCountTable {
	my $dbh = dbConnect;
	my $sql = "CREATE TABLE IF NOT EXISTS mailing_count (
		domain VARCHAR(255) NOT NULL,
		date DATE NOT NULL,
		count INT UNSIGNED
		);";
	query($dbh, $sql);
}

###########################################################
# SelectWhereDateFromCountTable()####################
#Purpose: Gets all records from 'mailing_count' Table where date = arg
###########################################################
sub SelectWhereDateFromCountTable {
	my $where = shift;
	my $dbh = dbConnect;
	my $sql = "SELECT domain, count FROM mailing_count WHERE date =
			?;";
	my @results = query($dbh, $sql, $where);
	return @results;
}

###########################################################
# SelectWhereDateAndDomainFromCountTable()####################
#Purpose: Gets all records from 'mailing_count' Table where date = arg
###########################################################
sub SelectWhereDateAndDomainFromCountTable {
	my @params = @_;
	my $dbh = dbConnect;
	my $sql = "SELECT domain, count FROM mailing_count WHERE date =
			? AND domain = ?;";
	my @results = query($dbh, $sql, @params);
	return @results;
}

###########################################################
# SelectAllFromCountTable()####################
#Purpose: Gets all records from 'mailing_count' Table
###########################################################
sub SelectAllFromCountTable {
	my $dbh = dbConnect;
	my $sql = "SELECT * FROM mailing_count;";
	my @results = query($dbh, $sql);
	return @results;
}

###########################################################
#InsertCountTable (domain, date, count)####################
#Purpose: Table used to store counts of email
# per unique domain from mailing table
###########################################################
sub InsertCountTable {
	my @params = @_;
	my $dbh = dbConnect;
	
	my $sql = "INSERT INTO mailing_count (domain, date, count) VALUES (
			?, ?, ? );";
	#print "Inserting into Count Table\n";
	query($dbh, $sql, @params); 	
}

###########################################################
#CreateHashForCountTable (date)####################
#Purpose: One of the main sub-routines for the program 
# Takes in all 'current' values of the mailing table and
# creates a hash where the keys are each unique domain (@domain.com)
# Counts the frequency of each occurence of a given domain
# Updates the mailing_count table with a domain, date, and count 
# The final main program will use this mailing_count table to create
# a report of the top 50 domains based on growth rate in last 30 days
###########################################################
sub CreateHashForCountTable {
	my $date = shift;
        my %dcount = ();

        my @addrs = SelectAllFromMailingTable();


        foreach my $row (@addrs) {
                my $addr = $row->{addr};
                chomp($addr);
                my ($address, $domain) = split /@/, $addr;
                $dcount{$domain} += 1;

        }

        while (my ($key, $value) = each %dcount) {
                #Inserts hash of domain counts into 'mailing_count' table
                #Normally $date would be 'Curdate()' but to simulate testing
                # false dates have been provided
                InsertCountTable($key, $date, $value);
        }
}

###########################################################
#RemoveFromCountTable()####################
#Purpose: Removes all records from 'mailing_count' table
###########################################################
sub RemoveFromCountTable {
	my $dbh = dbConnect;
	my $sql = "DELETE FROM mailing_count;";
	query($dbh, $sql);
}

1;

__END__
