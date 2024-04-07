# rtorrent-qnap-nas

## Overview
Ultra-minimalistic rtorrent client running on Alpine Linux.
CLI-only with no GUI, web access, or XMLRPC support.
Created specifically because QNAP Download Station fails to bypass dead torrents, halting downloads after 30 failures.
This lightweight image is optimized to manage thousands of loaded torrents efficiently. 

## Building
docker build -t rtorrent-qnap-nas ./