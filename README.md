# staroeradio.ru downloader
## Description
This script is created to download audio files from the http://staroeradio.ru/ web site and [related projects](http://www.audiopedia.su/).
## Requirments
Web site using RTMP streaming protocol, so rtmpdump is a requirment. To generate valid MP3 files with metadata FFMPEG is in use. Script itself is written on Perl and tested in OSX, but should be portable
## How to use
You should run it with -u <url>, e.g. 
`./staroe-dl -u http://reportage.su/audio/1598`
## Author
Author of the script is Alex Samorukov, samm@os2.kiev.ua. If you found any issue please submit it via [issue tracker](https://github.com/samm-git/staroeradio-dl/issues) or [pull request](https://github.com/samm-git/staroeradio-dl/pulls). 
