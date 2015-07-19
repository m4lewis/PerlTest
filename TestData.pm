package TestData;

use Cwd;
use GUI::DB;
use base 'Exporter';

#Create table if not exists
my $dbh = dbConnect;
my $sql = "CREATE TABLE IF NOT EXISTS mailing (
        addr VARCHAR(255) NOT NULL
        );";
query($dbh, $sql);


our @EXPORT = qw(AddTestData RemoveTestData);

###########################################################
#AddTestData (Day # to run for)############################
#Purpose: Used to generate test data in database###########
#Searches for randomly generated email addressses in
# TestInput folder
###########################################################
sub AddTestData {

	my $day = shift;
	my $run = shift;
	my $dir = getcwd;
	print "Current working dir = $dir\n";

        my $testFolder = "$dir/TestInput/$run/";
        $sql = "INSERT INTO mailing (addr) VALUES (
                        ? );";
	
	print "Inserting Data...\n";
	#Open Filename to read in email addresses
	my $filename = "$testFolder"."day$day.txt";
	open my $input, '<' , $filename or die "Could not open $filename: $!";

	while (my $line = <$input>) {

        query($dbh, $sql, $line);

	}
	close($input);

	print "Inserting Data Completed!\n";
}

sub RemoveTestData {
	my $sql = "DELETE FROM mailing;";
	print "Deleting Existing Values in 'mailing' table...\n";
	query($dbh, $sql);
	print "Deleting Data Completed!\n";
}

1;

__END__

