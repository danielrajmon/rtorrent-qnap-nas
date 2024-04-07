# rtorrent-qnap-nas

## Overview
Ultra-minimalistic rtorrent client running on Alpine Linux.
CLI-only with neither web client nor XMLRPC support.
Intended to replace QNAP's Download station as that one doesn't support watch folders and halts after downloading 30 concurrent dead torrents.
This lightweight image is optimized to manage thousands of loaded torrents efficiently.
Done based on rtorrent's official documentation.

## Building
docker build -t rtorrent-qnap-nas .

## Executing (replace /Users/danielrajmon/rtorrent/* folders)
docker run -d \
  -v /Users/danielrajmon/rtorrent/downloaded:/home/rtorrent/rtorrent/downloaded \
  -v /Users/danielrajmon/rtorrent/downloading:/home/rtorrent/rtorrent/downloading \
  -v /Users/danielrajmon/rtorrent/logs:/home/rtorrent/rtorrent/logs \
  -v /Users/danielrajmon/rtorrent/session:/home/rtorrent/rtorrent/session \
  -v /Users/danielrajmon/rtorrent/watch:/home/rtorrent/rtorrent/watch \
  rtorrent-qnap-nas

## Accessing ncurses GUI
su rtorrent
screen
rtorrent