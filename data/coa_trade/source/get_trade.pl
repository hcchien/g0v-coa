#!/usr/local/bin/perl

use strict;
use IO::All;

my @year_export;
my @year_import;
for (sort { $b <=> $a } <*.html>) {
	my $html < io "$_";
	my $order=1;
	my $year = $_;
	my @import;
	my @export;
	$year =~ m/(\d+)\.html/;
	$year = $1;
	while ($html =~ s|<td class=\"ReportLeft\" align=\"left\" valign=\"middle\">(.+?)</td><td class=\"ReportValue\" align=\"right\" valign=\"middle\">(.+?)</td><td class=\"ReportValue\" align=\"right\" valign=\"middle\">(.+?)</td><td class=\"ReportLeft\" align=\"left\" valign=\"middle\">(.+?)</td><td class=\"ReportValue\" align=\"right\" valign=\"middle\">(.+?)</td><td class=\"ReportValue\" align=\"right\" valign=\"middle\">(.+?)<\/td>||s) {
		push(@export, "{\"$order\":{\"country\":\"$1\",\"value\":\"$2\",\"percent\":\"$3\"}}");
		push(@import, "{\"$order\":{\"country\":\"$4\",\"value\":\"$5\",\"percent\":\"$6\"}}");
		$order++;
	}
	my $y_export = join ',', @export; 
	push @year_export, "\"$year\":{$y_export}";
}
my $all_e = join ",", @year_export;
my $all_i = join ",", @year_import;
print "{\"export\":{".$all_e."}";
print "\n\n";
print "{\"import\":{".$all_e."}";
