package GUI::DB;

use strict;
use DBI;

use vars qw(@ISA @EXPORT);
use Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(dbConnect query);

#
# dbConnect - connect to the database, get the database handle
#
sub dbConnect {

        # Read database settings from config file:
        my $dsn = "DBI:mysql:database=test";
        my $dbh = DBI->connect( $dsn,
				'root',
				'root',
                                { RaiseError => 1 } 
	);

        return $dbh;

}

#
# query - execute a query with parameters
#       query($dbh, $sql, @bindValues)
#
sub query {
        my $dbh = shift;
        my $sql = shift;
        my @bindValues = @_;            # 0 or serveral parameters

        my @returnData = ();

        # issue query
        my $sth = $dbh->prepare($sql);

        if ( @bindValues ) {
                $sth->execute(@bindValues);
        } else {
                $sth->execute();
        }

        if ( $sql =~ m/^select/i ) {
                while ( my $row = $sth->fetchrow_hashref ) {
                        push @returnData, $row;
                }
        }

        # finish the sql statement
        $sth->finish();

        return @returnData;
}

__END__

