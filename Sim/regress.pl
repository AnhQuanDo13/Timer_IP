#!/usr/bin/perl

#Feature support
#1. Create regression list
#2. Regression
#3. Report
use Term::ANSIColor;
use Getopt::Long;
use IPC::System::Simple qw(system);

GetOptions(
	"gen_list",
	"regress",
	"report"
);

#Main program
main();

sub main {
	if($opt_gen_list) {
		print "Generate regression list regress.list\n";
		system("find  ../testcases/ -type f -printf '%f\n' |sed 's/.v//' | tee regress.list");
	}
	elsif($opt_regress) {
		print "Run regression\n";
		print "Compiling TB and RTL...\n";
		`make build > /dev/null`;
		my $file_name = "regress.list";
		open(FH,'<',$file_name) or die("Could not open file regress.list");
		while(<FH>) {
			if($_ =~ m/\/\//) {}#Ignore run testcase if add comment // in regress.list
			else {
				print "Run testcase: $_";
				`make run_cov TESTNAME=$_ > /dev/null`;
				`make gen_cov `;
			}
		}
		print "Regression done\n";
		gen_report();
	} 
	elsif($opt_report) {
		gen_report();
	}
	else {
		help();
	}
}

sub gen_report {
	my $total  = `cat regress.list | wc -l`;
	my $ignore_tc = `grep // regress.list | wc -l`;
	$total = $total - $ignore_tc;
	$total =~ s/\s*$//;
	my $passed = `grep 'TEST PASSED' log/* | wc -l`;
	$passed =~ s/\s*$//;
	my $failed = `grep 'TEST FAILED' log/* | wc -l`;
	$failed =~ s/\s*$//;
	my $unknown= $total - ($passed + $failed);
	print("Print report\n");
	print("Total/Passed/Failed/Unknown:$total/$passed/$failed/$unknown\n");
	system("grep -H 'TESTCASE RESULT' log/*");	
}

sub help {
	print <<EOF;
This script support regression feature.
regress.pl -{options}:
   gen_list : Create regression list
   regress  : Run regression and print report
   report   : Print report only

Example to run regression:
regress.pl -regress
 
EOF
}
