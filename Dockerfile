FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    apt-cacher-ng \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3142
VOLUME /var/cache/apt-cacher-ng
VOLUME /data/config
CMD chmod 777 /var/cache/apt-cacher-ng \
    && ln -s /data/config/*.conf /etc/apt-cacher-ng/. \
    && /etc/init.d/apt-cacher-ng start \
    && tail -f /var/log/apt-cacher-ng/*
