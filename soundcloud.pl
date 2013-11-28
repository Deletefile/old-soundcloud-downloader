#!/usr/bin/perl -w
use strict;
use warnings;
require LWP::UserAgent;
use XML::Simple;
use Data::Dumper;
use LWP::Simple;


print "
------------------------------------
Soundcloud Mp3 Downloader Script
author : reda kassame
nerdz  : www.nerdz.eu/deletefile./
------------------------------------

[+] Insert the Soundcloud.com song link:
";

my $link = <STDIN>;
	print $link;

my $ua = LWP::UserAgent->new;
   $ua->timeout(10);
   $ua->env_proxy;
 
my $response = $ua->get($link);
 
 if ($response->is_success) {
   $response->decoded_content;
 }
 else {
     die $response->status_line;
 }

my $link_mp3 = XML::Simple->new()->XMLin( $response->content )->{'stream-url'};

my $name_mp3 = XML::Simple->new()->XMLin( $response->content )->{'title'};


my $file = "C:/".$name_mp3.".mp3";

my $status = getstore($link_mp3,$file);
 
 unless (is_success($status)) {
	die "Couldn't retrieve page: $status";
 }
