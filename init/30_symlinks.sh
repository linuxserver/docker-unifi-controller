#!/bin/bash

mkdir -p /config/{data,logs,run,dl}

[[ ! -d /config/data/db ]] && cp -pr /var/lib/unifi_orig/* /config/data/
[[ ! -d /config/dl/firmware ]] && cp -pr /usr/lib/unifi/dl_orig/* /config/dl

[[ ! -L /usr/lib/unifi/data ]] && ln -s /config/data /usr/lib/unifi/data
[[ ! -L /usr/lib/unifi/logs ]] && ln -s /config/logs /usr/lib/unifi/logs
[[ ! -L /usr/lib/unifi/run ]] && ln -s /config/run /usr/lib/unifi/run
[[ ! -L /usr/lib/unifi/dl ]] && ln -s /config/dl /usr/lib/unifi/dl

chown -R abc:abc /config /usr/lib/unifi
