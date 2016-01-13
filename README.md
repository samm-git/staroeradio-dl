# staroeradio.ru downloader
## Description
This script is created to download audio files from the [staroeradio.ru](http://staroeradio.ru/) web site and [related projects](http://www.audiopedia.su/). File is saved as MP3, without recoding and with correct MP3 Tag information set.
## Requirments
Web site is using RTMP streaming protocol, so [RTMPDump](https://rtmpdump.mplayerhq.hu/) is a requirment. To generate valid MP3 files with metadata [FFmpeg](https://www.ffmpeg.org/) is in use. Script itself is written on Perl and tested with OSX, but should be portable. Please let me know if it does not work for you for some reasons.
## How to use
You should run the script with `-u <url>`, e.g. 
`./staroe-dl -u http://reportage.su/audio/1598`. Currently supported urls:
- `http://theatrologia.su/audio/<id>`
- `http://lektorium.su/audio/<id> `
- `http://reportage.su/audio/<id>` 
- `http://svidetel.su/audio/<id>`
- `http://staroeradio.ru/audio/<id>`

Download speed is low, because RTMPDump is running with the `--live` switch. This is a server limitation, if this switch is not specified sound is choppy. Downloader also grabs information from the page and placing it in the MP3 tags. Files are created by FFmpeg without recoding, in the original bitrate.

## Author
Author of the script is Alex Samorukov, samm@os2.kiev.ua. If you found any issues please use [issue tracker](https://github.com/samm-git/staroeradio-dl/issues) or [pull request](https://github.com/samm-git/staroeradio-dl/pulls). 
