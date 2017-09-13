# apt-proxy

Based on https://docs.docker.com/engine/examples/apt-cacher-ng/

To run on macvlan network (called pub_net) and persist the data in /mnt/docker/data/apt-cache on docker host

    docker run \
       -d \
       --name apt-proxy \
       --network=pub_net \
       --ip=192.168.10.123 \
       --restart=unless-stopped \
       -v /mnt/docker/data/apt-cache:/var/cache/apt-cacher-ng \
       martinjohn/apt-proxy

On clients add the proxy with
    echo 'Acquire::http { Proxy "http://apt-proxy:3142"; };' >> /etc/apt/conf.d/01proxy

To see what's cached connect to host
    docker run --rm -it apt-proxy /usr/lib/apt-cacher-ng/distkill.pl
