# apt-proxy

Based on https://docs.docker.com/engine/examples/apt-cacher-ng/

To run on macvlan network (called pub_net - dns sets apt-proxy to 192.168.10.123) and persist the data in /mnt/docker/data/apt-cache on docker host

To add extra config, create a file called extra.conf in config directory (these get linked before startup), for example to bypass for https repositories such as docker's one, add following to config/extra.conf

    PassThroughPattern: download\.docker\.com

    docker run \
       -d \
       --name apt-proxy \
       --network=pub_net \
       --ip=192.168.10.123 \
       --restart=unless-stopped \
       -v /mnt/docker/data/apt-proxy:/var/cache/apt-cacher-ng \
       -v ${PWD}/config:/data/config \
       martinjohn/apt-proxy

On clients add the proxy with

    echo 'Acquire::http { Proxy "http://apt-proxy:3142"; };' >> /etc/apt/conf.d/01proxy

To see what's cached connect to host - http://apt-proxy:3142/acng-report.html
