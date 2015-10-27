#!/bin/bash

mkdir -p /config/{log,lib}
[[ ! -L /var/log/unifi ]] && ln -s /config/log /var/log/unifi/
[[ ! -L /var/lib/unifi ]] && ln -s /config/lib /var/lib/unifi/





























