# yt-bash-downloader
--------------------
## Linux Only
### Instalation
**AUR**
> Still working on it
```
yaourt -S yt-bash-downloader
```
**Manually**
> Still working on it
```
git clone https://github.com/DiegoMC9/yt-bash-downloader
cd yt-bash-downloader
makepkg -si
```
--------------------
### Dependencies: youtube-dl ffmpeg curl
#### Get them with:
- **APT** apt-get install youtube-dl ffmpeg curl
- **PACMAN** pacman -S youtube-dl ffmpeg curl

- **They are installed automatically with the aur installation
---------------------
### Usage: 
get-mp3  this is a search
### Options
'''
get-mp3 --location path/to/folder/
get-mp3 --format {best, aac, flac, mp3, m4a, opus, vorbis, wav}
'''
---------------------
### License GPLv3
[READ IT](../master/LICENSE)
