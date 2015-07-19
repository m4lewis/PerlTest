package DomainReport;

use strict;
use warnings;
use DBManager;
use GUI::DB;
use base 'Exporter';

our @EXPORT = qw(CreateDomainReport);

sub CreateDomainReport {
	my $start = shift;
	my $end = shift;
	my @end_counts = SelectWhereDateFromCountTable($end);	
	my %pct_change = ();

	foreach my $row (@end_counts) {
		my $domain = $row->{domain};
		my $count = $row->{count};
		
		my @params = ($start, $domain);
		my @start_check = SelectWhereDateAndDomainFromCountTable(@params);
		if (!@start_check) {
			#Domain found on end date but not in start date
			#Set %change to impossibly high number so 
			# the domain gets put to top of hash after sort
			$pct_change{$domain} = 99999999;	
		}
		else {
			my $start_count = $start_check[0]->{count}; 
			$pct_change{$domain} = ($count - $start_count)/
						$start_count * 100;	

		}
	}

	#Print Out Top 50 Domains based on percentage change between date range
	my $x = 1;
	#Sorts key/value pair based on value in descending numerical order
	foreach my $name (sort { $pct_change{$b} <=> $pct_change{$a} }
			 keys %pct_change) {

		my $current_change = $pct_change{$name};

		#This must be a new domain as it has a very high pct change
		if ($current_change == 99999999) {
			#printf("The %s domain is a new domain since %s\n", $name, $start); 
		}
		else {
			printf("The %s domain had a %.2f %% change since %s\n", $name, $current_change, $start);
			$x++;
		}
		
		#Report is done break out of loop
		if ($x == 50) { last; }
		#$x++;

	}
}
