#!/usr/bin/perl

use strict;
use LWP::Simple;
use XML::Simple;
use Getopt::Std;

# declare the perl command line flags/options we want to allow
my %options=();
getopts("hi:o:", \%options);

if(defined $options{h} || not defined $options{i}){
	print "Usage: $0 -i <mp3id> [-o filename]\n".
		"\tmp3id is http://www.staroeradio.ru/audio/<number>, by default output name taken from the file info\n\n";
	exit 0;
}

my $mp3id = $options{i};

# server using http://server.audiopedia.su:8888/getmp3parms.php?mp3id=<id> to get
# parametr data
binmode STDOUT, ":utf8"; # suppress UTF-8 warnings
my $content = get(" http://server.audiopedia.su:8888/getmp3parms.php?mp3id=".$mp3id);
die "Unable to get file description, exiting\n" unless defined $content;
my $ref = XMLin($content);
print "Saving to '".$ref->{fname}."'\n";
my $reqname = $ref->{fname};
$reqname =~ s/\.mp3$//; # cut mp3 suffix
system("rtmpdump -r 'rtmp://server.audiopedia.su/vod/' -y 'mp3:".$ref->{dir}."/".$reqname."' --live -o - | 
    ffmpeg -loglevel warning -y -i - -acodec copy  -metadata title='$ref->{fullname}' -metadata artist='staroeradio.ru' '".$ref->{fname}."'");
