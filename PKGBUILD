pkgname=yt-bash-downloader
pkgver=1.0
arch=(i686 x86_64)
pkgdesc="CLI application for downloading youtube music written in bash"
url="https://github.com/DiegoMC9/yt-bash-downloader"
license=('GPL3')
depends=('youtube-dl' 'ffmpeg')
source=('https://github.com/DiegoMC9/yt-bash-downloader/$pkgver/$pkgname.tar.gz')
md5sums=('71e3acea29c7e0201b532d9e3d920a6f')

build() {
    cd /usr/share
    mkdir yt-bash-dl
	cp -r $pkgname-$pkgver.tar.gz usr/share/yt-bash-dl/
	untar yt-bash-dl/$pkgname.tar.gz
	rm  yt-bash-dl/$pkgname.tar.gz
	ln -s yt-bash-dl/get-mp3.sh /bin/get-mp3
}
