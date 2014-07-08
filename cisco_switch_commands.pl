#!/usr/bin/perl -w
use strict;
use Net::Telnet::Cisco;
use Data::Dumper;

my $host = 'Enter switch IP';

my $session = Net::Telnet::Cisco->new(Host => $host, -Prompt=>'/(?m:^[\w.&-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)/');

$session->login(Name => 'admin',Password => 'password');

$session->cmd('terminal length 0');
my @ver = $session->cmd('show mac-address-table dynamic');
print @ver;
