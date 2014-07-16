#!/usr/bin/perl

use File::Path;
use MIME::Lite;

#Changing for the sake of cronjob
my $WORK = '/Build/nSWIFT/logs';
chdir $WORK;

#Opening and Reading in the following directory
opendir (DIR, '.');
my @files = readdir (DIR);
closedir (DIR);

#Sorting as per numbers and not as per alphabets
@files = sort {substr($a,15) <=> substr($b,15)} @files;

#To distinguish between the file and the directory
my @dir = grep /root_tqtest.pl/, @files;

# saving the last 1000 directories and deleting the rest
my @selected_directory = @dir[0 ..$#dir-1000];

#Appending the timestamp to the file
my $timestamp = localtime(time);

#Saving the deleted file names to directory.txt
my $number;
open FH, '>>', "directory.txt";
print FH "\n";
print FH $timestamp;
print "\n";
foreach (@selected_directory)
{
        print FH "$_\n";
        $number="$_";
#       rmtree ($number);
}
close FH;


#Emailing the deleted directories list in a file
MIME::Lite->send( 'smtp', "mail.sonicwall.com", Timeout => 60);
my $return = 0;

my $msg = MIME::Lite->new(
    From    => 'deletelogs/@sonicwall.com',
    To      => 'dsutaria@sonicwall.com',
#    Cc      => 'NKwok@SonicWALL.com',
    Subject => 'Logs Clean up',
    Type    => 'multipart/mixed',
);

$msg->attach(
        Type     => 'text',
        Data     => "The Build server logs are cleaned up as scheduled. The attachment tells you the deleted logs. Thank you."
    );

$msg->attach(
    Type     => 'text/html',
    Path     => '/Build/nSWIFT/logs/directory.txt',
    Filename => 'directory.txt',
);
if ( $msg->send() )
        {
                print ("Email has been sent succesfully. \n");
        }else
        {
                print ("Email could not be sent. \n");
        }
 


