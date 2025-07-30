# rtorrent-qnap-nas

## Overview
Ultra-minimalistic rtorrent client running on Alpine Linux.
CLI-only with neither web client nor XMLRPC support.
Intended to replace QNAP's Download station as that one doesn't support watch folders and halts after downloading 30 concurrent dead torrents.
This lightweight image is optimized to manage thousands of loaded torrents efficiently.
Done based on rtorrent's official documentation.

## Building
```bash
docker build -t rtorrent-qnap-nas .
```

## Executing image (replace /Users/danielrajmon/rtorrent/* folders)
```bash
docker run -d \
  -v /Users/danielrajmon/rtorrent/downloaded:/home/rtorrent/rtorrent/downloaded \
  -v /Users/danielrajmon/rtorrent/downloading:/home/rtorrent/rtorrent/downloading \
  -v /Users/danielrajmon/rtorrent/logs:/home/rtorrent/rtorrent/logs \
  -v /Users/danielrajmon/rtorrent/session:/home/rtorrent/rtorrent/session \
  -v /Users/danielrajmon/rtorrent/watch:/home/rtorrent/rtorrent/watch \
  rtorrent-qnap-nas
```

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

### Moving folders to HDD
```bash
ssh -> sudo -i

mkdir /share/CACHEDEV3_DATA/Media-1/rtorrent

cd /share/CACHEDEV1_DATA/Public/container-station-data/lib/docker/volumes

mv ./downloaded/_data /share/CACHEDEV3_DATA/Media-1/rtorrent/downloaded
mv ./downloading/_data /share/CACHEDEV3_DATA/Media-1/rtorrent/downloading
mv ./logs/_data /share/CACHEDEV3_DATA/Media-1/rtorrent/logs
mv ./session/_data /share/CACHEDEV3_DATA/Media-1/rtorrent/session
mv ./watch/_data /share/CACHEDEV3_DATA/Media-1/rtorrent/watch

cd downloaded; ln -s /share/CACHEDEV3_DATA/Media-1/rtorrent/downloaded _data; cd ..
cd downloading; ln -s /share/CACHEDEV3_DATA/Media-1/rtorrent/downloading _data; cd ..
cd logs; ln -s /share/CACHEDEV3_DATA/Media-1/rtorrent/logs _data; cd ..
cd session; ln -s /share/CACHEDEV3_DATA/Media-1/rtorrent/session _data; cd ..
cd watch; ln -s /share/CACHEDEV3_DATA/Media-1/rtorrent/watch _data; cd ..
```

### Setting folder permissions
```bash
chown pampi:everyone /share/CACHEDEV3_DATA/Media-1/rtorrent
chown pampi:everyone /share/CACHEDEV3_DATA/Media-1/rtorrent/downloaded
chown pampi:everyone /share/CACHEDEV3_DATA/Media-1/rtorrent/downloading
chown pampi:everyone /share/CACHEDEV3_DATA/Media-1/rtorrent/logs
chown pampi:everyone /share/CACHEDEV3_DATA/Media-1/rtorrent/session
chown pampi:everyone /share/CACHEDEV3_DATA/Media-1/rtorrent/watch
```

## Publishing for QNAP NAS
```bash
git log -1 --pretty=%H
docker image build -t danielrajmon/rtorrent-qnap-nas:COMMIT_NUMBER --build-arg VERSION=1.5 --platform linux/amd64 .
docker image tag danielrajmon/rtorrent-qnap-nas:COMMIT_NUMBER danielrajmon/rtorrent-qnap-nas:latest
docker image push danielrajmon/rtorrent-qnap-nas:COMMIT_NUMBER
docker image push danielrajmon/rtorrent-qnap-nas:latest
```

## TODO
- Autostart rtorrent in screen
- Set download speed limit
- Optimize number of concurrent connections
- Delete lock file on restart if it exists
