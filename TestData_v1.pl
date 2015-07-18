package TestData;

use GUI::DB;

#Create table if not exists
my $dbh = dbConnect;
my $sql = "CREATE TABLE IF NOT EXISTS mailing (
        addr VARCHAR(255) NOT NULL
        );";
query($dbh, $sql);

###########################################################
#AddTestData (# of domains to test, #of emails to test)####
#Purpose: Used to generate test data in database###########
###########################################################
sub AddTestData {
        my $numDomains = shift;
        my $numEmails = shift;

	my $sql = "DELETE FROM mailing;";
	print "Deleting Existing Values in 'mailing' table...\n";
	query($dbh, $sql);
	print "Deleting Data Completed!\n";

        for (my $i = 0; $i < $numEmails; $i++) {
                my $username = "u".$i;
                my $dom = int(rand($numDomains));
                my $domain = "domain".$dom.".com";
                my $addr = $username."\@".$domain;
                $sql = "INSERT INTO mailing (addr) VALUES (
                        ? );";

		print "Inserting Data into 'mailing' table...\n";
                query($dbh, $sql, $addr);
        }
	print "Inserting Data Completed!\n";
}

__END__

