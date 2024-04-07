FROM alpine

RUN apk add --no-cache rtorrent && \
    apk add --no-cache screen && \
    adduser rtorrent -D && \
    mkdir -p /home/rtorrent/rtorrent && \
    mkdir /home/rtorrent/rtorrent/downloaded && \
    mkdir /home/rtorrent/rtorrent/downloading && \
    mkdir /home/rtorrent/rtorrent/logs && \
    mkdir /home/rtorrent/rtorrent/session && \
    mkdir /home/rtorrent/rtorrent/watch && \
    chown -R rtorrent:rtorrent /home/rtorrent/rtorrent

COPY rtorrent.rc "/home/rtorrent/.rtorrent.rc"

VOLUME ["/home/rtorrent/rtorrent/downloaded", \
        "/home/rtorrent/rtorrent/downloading", \
        "/home/rtorrent/rtorrent/logs", \
        "/home/rtorrent/rtorrent/watch"]

EXPOSE 6881
EXPOSE 6881/udp
EXPOSE 16891
EXPOSE 50000

USER rtorrent

# Stop docker container from exiting
ENTRYPOINT ["tail", "-f", "/dev/null"]

#ENTRYPOINT ["screen", "-m", "rtorrent"]

#CMD ["rtorrent", "&"]