package DBManager;

use strict;
use warnings;
use GUI::DB;
use base 'Exporter'

my $dbh = dbConnect;

our @EXPORT = qw(CreateCountTable InsertCountTable);

sub SelectAllFromMailingTable {
	my $sql = "SELECT * FROM mailing;";
	my @results = query($dbh, $sql);
	return @results;
}

sub CreateCountTable {
	my $sql = "CREATE TABLE IF NOT EXISTS mailing_count (
		domain VARCHAR(255) NOT NULL,
		[date] DATE NOT NULL,
		[count] INT UNSIGNED
		);";
	query($dbh, $sql);
}

sub SelectAllFromCountTable {
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
	
	my $sql = "INSERT INTO mailing_count (domain, [date], [count]) VALUES (
			?, ?, ? );";
	print "Inserting into Count Table\n";
	query($dbh, $sql, @params); 	
}

1;

__END__
