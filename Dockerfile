FROM alpine

RUN apk add --no-cache rtorrent && \
    apk add --no-cache screen && \
    adduser rtorrent -D && \
    echo "rtorrent:alma1234" | chpasswd

COPY rtorrent.rc "/home/rtorrent/.rtorrent.rc"


# Stop docker container from exiting
ENTRYPOINT ["tail", "-f", "/dev/null"]

#ENTRYPOINT ["screen", "-m", "rtorrent"]

#CMD ["rtorrent", "&"]