FROM alpine

RUN apk add --no-cache rtorrent && \
    apk add --no-cache screen

COPY rtorrent.rc "/root/.rtorrent.rc"


# Stop docker container from exiting
ENTRYPOINT ["tail", "-f", "/dev/null"]

#ENTRYPOINT ["screen", "-m", "rtorrent"]

#CMD ["rtorrent", "&"]