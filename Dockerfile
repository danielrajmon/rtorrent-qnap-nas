FROM alpine

RUN apk add --no-cache rtorrent && \
    apk add --no-cache screen && \
    apk add --no-cache nano

RUN adduser rtorrent -D

RUN mkdir -p /home/rtorrent/rtorrent && \
    mkdir /home/rtorrent/rtorrent/downloaded && \
    mkdir /home/rtorrent/rtorrent/downloading && \
    mkdir /home/rtorrent/rtorrent/logs && \
    mkdir /home/rtorrent/rtorrent/session && \
    mkdir /home/rtorrent/rtorrent/watch

COPY rtorrent.rc "/home/rtorrent/.rtorrent.rc"

RUN chown rtorrent:rtorrent "/home/rtorrent/.rtorrent.rc" && \
    chown -R rtorrent:rtorrent /home/rtorrent/rtorrent

VOLUME ["/home/rtorrent/rtorrent/downloaded", \
        "/home/rtorrent/rtorrent/downloading", \
        "/home/rtorrent/rtorrent/logs", \
        "/home/rtorrent/rtorrent/session", \
        "/home/rtorrent/rtorrent/watch"]

EXPOSE 6881
EXPOSE 6881/udp
EXPOSE 50000

USER rtorrent

# Stop docker container from exiting
ENTRYPOINT ["tail", "-f", "/dev/null"]