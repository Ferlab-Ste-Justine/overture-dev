FROM haproxy:2.1

COPY haproxy.cfg /usr/local/etc/haproxy

#https://www.haproxy.com/documentation/hapee/2-1r1/installation/getting-started/sizing/#optimizing-performance
#Each non-TLS connection uses about 0.0512MB of RAM and the baseline RAM consumption of the HAproxy process is about ~6MB
ENV MAX_MEMORY 128
#This is based on the capacity of HAproxy given the amount of RAM set aside for it.
#If less scalable downstream overture services (ie, SONG and Score) become overwelmed from external traffic, it may be worthwhile to set this value lower
ENV MAX_CONNECTIONS 2000