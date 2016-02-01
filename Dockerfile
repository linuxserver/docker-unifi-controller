FROM linuxserver/baseimage

MAINTAINER Sparklyballs <sparklyballs@linuxserver.io>

ENV APTLIST="openjdk-7-jre-headless unifi"

# install packages
RUN echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" >> /etc/apt/sources.list && \
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
apt-get update -q && \
apt-get install $APTLIST -qy && \

# configure unifi
# unlink /usr/lib/unifi/data && \
# unlink /usr/lib/unifi/logs && \
# unlink /usr/lib/unifi/run && \
#rm /var/lib/unifi/keystore && \
#mv /usr/lib/unifi/dl /usr/lib/unifi/dl_orig && \
#mv /var/lib/unifi /var/lib/unifi_orig && \
#mv /var/log/unifi /var/log/unifi_orig && \
#mv /var/run/unifi /var/run/unifi_orig && \

# clean up
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh

# Volumes and Ports
WORKDIR /usr/lib/unifi
VOLUME /config
EXPOSE 8080 8081 8443 8843 8880
