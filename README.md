# rtorrent-qnap-nas

## Overview
Ultra-minimalistic rtorrent client running on Alpine Linux.
CLI-only with no GUI, web access, or XMLRPC support.
Created specifically because QNAP Download Station fails to bypass dead torrents, halting downloads after 30 failures.
This lightweight image is optimized to manage thousands of loaded torrents efficiently. 

## Building
docker build -t rtorrent-qnap-nas .

## Executing
docker run -d \
  -v /Users/danielrajmon/rtorrent/session:/home/rtorrent/rtorrent/session \
  -v /Users/danielrajmon/rtorrent/watch:/home/rtorrent/rtorrent/watch \
  -v /Users/danielrajmon/rtorrent/downloading:/home/rtorrent/rtorrent/downloading \
  -v /Users/danielrajmon/rtorrent/downloaded:/home/rtorrent/rtorrent/downloaded \
  rtorrent-qnap-nas