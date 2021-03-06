# staroeradio.ru downloader
## Description
This script is created to download audio files from the [staroeradio.ru](http://staroeradio.ru/) web site and [related projects](http://www.audiopedia.su/). File is saved as MP3, without recoding and with correct MP3 Tag information set.
## Requirments
Web site is using RTMP streaming protocol, so [FFmpeg](https://www.ffmpeg.org/) with RTMP support is required. Script itself is written on Perl and tested with OSX, but should be portable. Please let me know if it does not work for you for some reasons.
## How to use
You should run the script with `-u <url>`, e.g. 
`./staroe-dl -u http://reportage.su/audio/1598`. Currently supported urls:
- `http://theatrologia.su/audio/<id>`
- `http://lektorium.su/audio/<id> `
- `http://reportage.su/audio/<id>` 
- `http://svidetel.su/audio/<id>`
- `http://staroeradio.ru/audio/<id>`

By default files are saved in the filename provided by the the server. You can override it using `-o <filename>` command line switch. 

Download speed is low, this is a server limitation. Downloader also grabs information from the page and placing it in the MP3 tags. Files are created by FFmpeg without recoding, in the original bitrate.

## Author
Author of the script is Alex Samorukov, samm@os2.kiev.ua. If you found any issues please use [issue tracker](https://github.com/samm-git/staroeradio-dl/issues) or [pull request](https://github.com/samm-git/staroeradio-dl/pulls). 
