#!/bin/bash

mkdir -p /config/{log,lib}
[[ ! -d /config/lib ]] && cp -pr /var/lib/unifi.org /config/lib
[[ ! -L /var/log/unifi ]] && ln -s /config/log /var/log/unifi
[[ ! -L /var/lib/unifi ]] && ln -s /config/lib /var/lib/unifi





























