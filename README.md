# rtorrent-qnap-nas

## Overview
Ultra-minimalistic rtorrent client running on Alpine Linux.
CLI-only with neither web client nor XMLRPC support.
Intended to replace QNAP's Download station as that one doesn't support watch folders and halts after downloading 30 concurrent dead torrents.
This lightweight image is optimized to manage thousands of loaded torrents efficiently.
Done based on rtorrent's official documentation.

## Building
docker build -t rtorrent-qnap-nas .

## Executing image (replace /Users/danielrajmon/rtorrent/* folders)
docker run -d \
  -v /Users/danielrajmon/rtorrent/downloaded:/home/rtorrent/rtorrent/downloaded \
  -v /Users/danielrajmon/rtorrent/downloading:/home/rtorrent/rtorrent/downloading \
  -v /Users/danielrajmon/rtorrent/logs:/home/rtorrent/rtorrent/logs \
  -v /Users/danielrajmon/rtorrent/session:/home/rtorrent/rtorrent/session \
  -v /Users/danielrajmon/rtorrent/watch:/home/rtorrent/rtorrent/watch \
  rtorrent-qnap-nas

## Starting rtorrent
This step is not automatic yet as I need to test session folder discrepancies caused by sudden shutdowns.
screen
rtorrent

## Installing on QNAP NAS
Adjust as needed.

### Creating volumes
Container station -> Volumes ->
- Create -> downloaded
- Create -> downloading
- Create -> logs
- Create -> session
- Create -> watch

### Moving some folders to HDD
ssh -> sudo -i

mv ./downloaded /share/CACHEDEV3_DATA/Media-1/

cd /share/CACHEDEV1_DATA/Public/container-station-data/lib/docker/volumes

ln -s /share/CACHEDEV3_DATA/Media-1/downloaded downloaded

chown pampi:everyone /share/CACHEDEV3_DATA/Media-1/downloaded

### Moving download folder to SSD
ssh -> sudo -i

mkdir /share/CACHEDEV1_DATA/Public/rtorrent

cd /share/CACHEDEV1_DATA/Public/container-station-data/lib/docker/volumes

mv ./downloading /share/CACHEDEV1_DATA/Public/rtorrent/
mv ./logs /share/CACHEDEV1_DATA/Public/rtorrent/
mv ./session /share/CACHEDEV1_DATA/Public/rtorrent/
mv ./watch /share/CACHEDEV1_DATA/Public/rtorrent/

ln -s /share/CACHEDEV1_DATA/Public/rtorrent/downloading downloading
ln -s /share/CACHEDEV1_DATA/Public/rtorrent/logs logs
ln -s /share/CACHEDEV1_DATA/Public/rtorrent/session session
ln -s /share/CACHEDEV1_DATA/Public/rtorrent/watch watch

chown pampi:everyone /share/CACHEDEV1_DATA/Public/rtorrent
chown pampi:everyone /share/CACHEDEV1_DATA/Public/rtorrent/downloading
chown pampi:everyone /share/CACHEDEV1_DATA/Public/rtorrent/logs
chown pampi:everyone /share/CACHEDEV1_DATA/Public/rtorrent/session
chown pampi:everyone /share/CACHEDEV1_DATA/Public/rtorrent/watch

## Publishing
git log -1 --pretty=%H
docker image build -t danielrajmon/rtorrent-qnap-nas:COMMIT_NUMBER --build-arg VERSION=1.5 .
docker image tag danielrajmon/rtorrent-qnap-nas:COMMIT_NUMBER danielrajmon/rtorrent-qnap-nas:latest
docker image push danielrajmon/rtorrent-qnap-nas:COMMIT_NUMBER
docker image push danielrajmon/rtorrent-qnap-nas:latest