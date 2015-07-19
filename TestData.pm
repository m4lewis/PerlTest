package TestData;

use Cwd;
use GUI::DB;
use base 'Exporter';

#Create mailing table if not exists
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

        my $testFolder = "$dir/TestInput/$run/";
        $sql = "INSERT INTO mailing (addr) VALUES (
                        ? );";
	
	#Open Filename to read in test email addresses
	my $filename = "$testFolder"."day$day.txt";
	open my $input, '<' , $filename or die "Could not open $filename: $!";

	while (my $line = <$input>) {

        query($dbh, $sql, $line);

	}
	close($input);
}


###########################################################
#RemoveTestData()
#Purpose: Removes all records from 'mailing' table
###########################################################
sub RemoveTestData {
	my $sql = "DELETE FROM mailing;";
	query($dbh, $sql);
}

1;

__END__

