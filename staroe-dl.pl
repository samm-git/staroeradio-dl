#!/usr/bin/perl

use strict;
use LWP::Simple;
use XML::Simple;
use Getopt::Std;

# declare the perl command line flags/options we want to allow
my %options=();
getopts("hu:o:", \%options);

if(defined $options{h} || not defined $options{u}){
	print "Usage: $0 -u <url> [-o filename]\n".
		"\tmp3id is http://www.staroeradio.ru/audio/<number>, by default output name taken from the file info\n\n";
	exit 0;
}

my %urls = 
(
	'theatrologia.su' => 'theatrologia',
	'staroeradio.ru' => '',
	'svidetel.su' => 'svidetel',
	'lektorium.su' => 'lektorium',
	'reportage.su' => 'reportage'
);
my $site = ''; my $mp3id; my $domain;
# check if we can parse URL
if ($options{u} =~ m/(www\.)?(staroeradio\.ru|svidetel\.su|theatrologia\.su|lektorium\.su|reportage\.su)\/audio\/(\d+)/i) {
  $mp3id = $3;
  $site = $urls{$2};
  $domain = $2;
} else {
  print "Wrong URL, exiting\n";
  die();
}

# server using http://server.audiopedia.su:8888/getmp3parms.php?mp3id=<id> to get
# parametr data. There is also site parameter to set the namespace
#
# http://theatrologia.su/audio/<id> - getapmp3parms.php?site=theatrologia&mp3id=<id>
# http://lektorium.su/audio/<id> - getapmp3parms.php?site=lektorium&mp3id=<id>
# http://reportage.su/audio/<id> getapmp3parms.php?site=reportage&mp3id=<id>
# http://svidetel.su/audio/<id> getapmp3parms.php?site=svidetel&mp3id=<id>
# http://staroeradio.ru/audio/<id> - getapmp3parms.php?mp3id=<id>

binmode STDOUT, ":utf8"; # suppress UTF-8 warnings
my $content = get("http://server.audiopedia.su:8888/".(length($site)?'getapmp3parms':'getmp3parms').".php?mp3id=".$mp3id.(length($site) ? "&site=$site" : ""));
die "Unable to get file description, exiting\n" unless defined $content;
my $ref = XMLin($content);
my $reqname = $ref->{fname};
my $savefname = '';
if(defined $options{o}) {
	$savefname = $options{o}
} else {
	$savefname = $ref->{fname};
	$savefname =~ s/[\/\\']/_/g; # avoid "'" , / and \ characters in the output file name 
}
print "Saving to '".$savefname."'\n";
$reqname =~ s/\.mp3$//; # cut mp3 suffix
system("rtmpdump -r 'rtmp://server.audiopedia.su/vod/' -y 'mp3:".$ref->{dir}."/".$reqname."' --live -o - | 
    ffmpeg -loglevel warning -y -i - -acodec copy  -metadata title='$ref->{fullname}' -metadata artist='$domain' '$savefname'");
