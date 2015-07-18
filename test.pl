use strict;
use warnings;
use GUI::DB;
use TestData;

my $dbh = dbConnect;

#Use 10 different domains
#Add 1000 different emails
AddTestData(100, 100000);
