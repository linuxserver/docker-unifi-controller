[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://www.ubnt.com/enterprise/#unifi
[hub]: https://hub.docker.com/r/linuxserver/unifi/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/unifi
[![](https://images.microbadger.com/badges/version/linuxserver/unifi.svg)](https://microbadger.com/images/linuxserver/unifi "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/unifi.svg)](https://microbadger.com/images/linuxserver/unifi "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/unifi.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/unifi.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-unifi)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-unifi/)

The [UniFi®](https://www.ubnt.com/enterprise/#unifi) Controller software is a powerful, enterprise wireless software engine ideal for high-density client deployments requiring low latency and high uptime performance.

[![unifi](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/unifi-banner.png)][appurl]

## Usage

```
docker create \
  --name=unifi \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 3478:3478/udp \
  -p 10001:10001/udp \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8443:8443 \
  -p 8843:8843 \
  -p 8880:8880 \
  -p 6789:6789 \
  linuxserver/unifi
```

Using tags, you can choose between either the latest "LTS Stable" branch (the default, no tag required) or the "Unstable" branch of UniFi. See the UniFi [FAQ Page](https://help.ubnt.com/hc/en-us/articles/360008240754#1) for a breakdown of their various branches.

Add one of the tags, if required, to the linuxserver/unifi line of the run/create command in the following format, linuxserver/unifi:unstable

#### Tags

+ **latest** : releases from the 5.6.x "LTS Stable" branch
+ **unstable** : releases from the 5.9.x "Unstable" branch.

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 3478` - port(s)
* `-p 10001` - port(s) required for AP discovery
* `-p 8080` - port(s) required for Unifi to function
* `-p 8081` - port(s)
* `-p 8443` - port(s)
* `-p 8843` - port(s)
* `-p 8880` - port(s)
* `-p 6789` - port(s) For throughput test
* `-v /config` - where unifi stores it config files etc, needs 3gb free
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on xenial with s6 overlay, for shell access whilst the container is running do `docker exec -it unifi /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id dockeruser
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

The webui is at https://ip:8443, setup with the first run wizard.

For Unifi to adopt other devices, e.g. an Access Point, it is required to change the inform ip address. Because Unifi runs inside Docker by default it uses an ip address not accessable by other devices. To change this go to Settings > Controller > Controller Settings and set the Controller Hostname/IP to an ip address accessable by other devices.

Alternatively to manually adopt a device take these steps:

```
ssh ubnt@$AP-IP
mca-cli
set-inform http://$address:8080/inform
```

Use `ubnt` as the password to login and `$address` is the IP address of the host you are running this container on and `$AP-IP` is the Access Point IP address.

## Common problems

When using a Security Gateway (router) it could be that network connected devices are unable to obtain an ip address. This can be fixed by setting "DHCP Gateway IP", under Settings > Networks > network_name, to a correct (and accessable) ip address.

## Info

* Shell access whilst the container is running: `docker exec -it unifi /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f unifi`


* container version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' unifi`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/unifi`

## Versions

+ **14.09.18:** Update to 5.6.40.
+ **06.07.18:** Update to 5.6.39.
+ **26.04.18:** Update to 5.6.37.
+ **24.03.18:** Update to 5.6.36.
+ **14.03.18:** Add unstable branch for 5.7x releases.
+ **19.02.18:** Add port 6789 to support throughput test
+ **09.02.18:** Update to 5.6.30.
+ **08.02.18:** Use loop to simplify symlinks.
+ **08.01.18:** Update to 5.6.29.
+ **15.12.17:** Update to 5.6.26.
+ **09.12.17:** Fix continuation lines.
+ **12.11.17:** Add STUN server port 3478 mapping to example.
+ **11.11.17:** Update to 5.6.22.
+ **22.10.17:** Fix typos in Dockerfile and cert gen.
+ **05.10.17:** Update to 5.5.24.
+ **03.08.17:** Update to 5.5.20.
+ **15.07.17:** Update to 5.5.19 and switch to using .deb package, no need to keep up with the unifi repo merry-go-round.
+ **05.07.17:** Change repo to stable. Remove execstack command, no longer required.
+ **18.03.17:** Fix execstack warning.
+ **14.10.16:** Add version layer information.
+ **20.09.16** Bump to pick up ver 5.27.
+ **10.09.16** Add layer badges to README.
+ **28.08.16** Add badges to README.
+ **01.07.16** Switch to lsiobase/xenial for conformity.
+ **25.06.16** Rebase to xenial and use updated repository.
+ **02.11.15** Initial Release.
