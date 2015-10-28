#!/bin/bash

[[ ! -f /config/data/keystore ]] &&  keytool -genkey -keyalg RSA -alias unifi -keystore /config/data/keystore -storepass aircontrolenterprise -keypass aircontrolenterprise -validity 1825 -keysize 4096 -dname "cn=unfi"

chown abc:abc /config/data/keystore
