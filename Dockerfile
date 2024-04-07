FROM alpine

RUN apk add --no-cache rtorrent && \
    apk add --no-cache screen && \
    adduser rtorrent -D && \
    echo "rtorrent:alma1234" | chpasswd && \
    mkdir -p /home/rtorrent/rtorrent && \
    mkdir /home/rtorrent/rtorrent/session && \
    mkdir /home/rtorrent/rtorrent/watch && \
    mkdir /home/rtorrent/rtorrent/downloading && \
    mkdir /home/rtorrent/rtorrent/downloaded


COPY rtorrent.rc "/home/rtorrent/.rtorrent.rc"

VOLUME ["/home/rtorrent/rtorrent/session", \
        "/home/rtorrent/rtorrent/watch", \
        "/home/rtorrent/rtorrent/downloading", \
        "/home/rtorrent/rtorrent/downloaded"]

# Stop docker container from exiting
ENTRYPOINT ["tail", "-f", "/dev/null"]

#ENTRYPOINT ["screen", "-m", "rtorrent"]

#CMD ["rtorrent", "&"]