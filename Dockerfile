# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-ubuntu:focal

# set version label
ARG BUILD_DATE
ARG VERSION
ARG UNIFI_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment settings
ARG UNIFI_BRANCH="stable"
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
  echo "**** install packages ****" && \
  curl -fsSL https://pgp.mongodb.com/server-4.4.asc | \
    gpg -o /usr/share/keyrings/mongodb-server-4.4.gpg \
    --dearmor && \
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    binutils \
    jsvc \
    libcap2 \
    logrotate \
    mongodb-org-server \
    openjdk-17-jre-headless && \
  echo "**** install unifi ****" && \
  if [ -z ${UNIFI_VERSION+x} ]; then \
    UNIFI_VERSION=$(curl -sX GET http://dl-origin.ubnt.com/unifi/debian/dists/${UNIFI_BRANCH}/ubiquiti/binary-amd64/Packages \
    |grep -A 7 -m 1 'Package: unifi' \
    | awk -F ': ' '/Version/{print $2;exit}' \
    | awk -F '-' '{print $1}'); \
  fi && \
  mkdir -p /app && \
  curl -o \
  /tmp/unifi.deb -L \
    "https://dl.ui.com/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb" && \
  dpkg -i /tmp/unifi.deb && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /

# Volumes and Ports
WORKDIR /usr/lib/unifi
VOLUME /config
EXPOSE 8080 8443 8843 8880
