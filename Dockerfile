FROM lsiobase/xenial

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# install packages
RUN \
 echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" >> /etc/apt/sources.list && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
 apt-get update && \
 apt-get install -y \
	openjdk-8-jre-headless \
	unifi \
	wget && \

# cleanup
 apt-get clean && \
 rm -rfv /tmp/* /var/lib/apt/lists/* /var/tmp/*

# add local files
COPY root/ /

# Volumes and Ports
WORKDIR /usr/lib/unifi
VOLUME /config
EXPOSE 8080 8081 8443 8843 8880
