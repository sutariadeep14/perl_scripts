#!/usr/bin/perl


my $local_runtime = localtime time;
my $sample_time = "Sun May  5 18:19:39 2013";

my ($day1,$mth1,$dt1,$hr1,$min1,$sec1,$yr1);
my ($day2,$mth2,$dt2,$hr2,$min2,$sec2,$yr2);


$local_runtime =~ m/(\w+)\s+(\w+)\s+(\d+)\s+(\d+):(\d+):(\d+)\s+(\d+)/;
$day1 = $1;
$mth1 = $2;
$dt1 = $3;
$hr1 = $4;
$min1 = $5;
$sec1 = $6;
$yr1 = $7;

my %mon2num = qw (
                Jan 01  Feb 02  Mar 03  Apr 04  May 05  Jun 06
                Jul 07  Aug 08  Sep 09  Oct 10 Nov 11 Dec 12);
my $moy1 = $mon2num{$mth1};

my $date1 = "$hr1:$min1:$sec1, $moy1/$dt1/$yr1";
	
$sample_time =~ m/(\w+)\s+(\w+)\s+(\d+)\s+(\d+):(\d+):(\d+)\s+(\d+)/;
$day2 = $1;
$mth2 = $2;
$dt2 = $3;
$hr2 = $4;
$min2 = $5;
$sec2 = $6;
$yr2 = $7;


my $moy2 = $mon2num{$mth2};
my $date2 = "$hr2:$min2:$sec2, $moy2/$dt2/$yr2";
print "$date2\n";

if (to_comparable($date2) < to_comparable($date1)){
	print "It works!!\n";
}
else{
	print "Check, something is broken !!\n"
}

sub to_comparable {
   my ($date) = @_;
   my ($H,$M,$S,$m,$d,$Y) = $date =~ m{^(\d+):(\d+):(\d+), (\d+)/(\d+)/(\d+)\z}
      or die;
   my $pd = sprintf ("%02d", $d);
   return "$Y$m$pd$H$M$S";
}




