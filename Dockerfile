FROM ubuntu:16.04

# global environment settings
ENV HOME="/root"
ENV TERM="xterm"
ARG DEBIAN_FRONTEND="noninteractive"

# add abc user
RUN \
 useradd -u 911 -U -d /config -s /bin/false abc && \
	usermod -G users abc

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	apt-transport-https \
	apt-utils && \

echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" >> /etc/apt/sources.list && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \

 apt-get update && \
 apt-get install -y \
	openjdk-8-jre-headless \
	unifi \
	wget && \

# add s6 overlay
 wget -O /tmp/s6.tar.gz \
	https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz && \
	tar xvf /tmp/s6.tar.gz -C / && \

# cleanup
 apt-get clean && \
 rm -rfv /tmp/* /var/lib/apt/lists/* /var/tmp/*

# add local files
COPY root/ /

ENTRYPOINT ["/init"]

# Volumes and Ports
WORKDIR /usr/lib/unifi
VOLUME /config
EXPOSE 8080 8081 8443 8843 8880
