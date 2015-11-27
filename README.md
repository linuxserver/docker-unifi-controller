![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://www.linuxserver.io/) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io/index.php) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/unifi

The UniFi® Controller software is a powerful, enterprise wireless software engine ideal for high-density client deployments requiring low latency and high uptime performance. [Unifi](https://www.ubnt.com/unifi/unifi-ap/)

## Usage

```
docker create \
  --name=unifi \
  -v /etc/localtime:/etc/localtime:ro \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8443:8443 \
  -p 8880:8880 \
  linuxserver/unifi
```

**Parameters**

* `-p 8080` - the port(s)
* `-p 8081` - the port(s)
* `-p 8443` - the port(s)
* `-p 8880` - the port(s)
* `-v /etc/localtime` for timesync - *optional*
* `-v /config` - where unifi stores it config files etc, needs 3gb free
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it unifi /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application

The webui is at https://ip:8443 , setup with the first run wizard.


## Updates

* Upgrade to the latest version simply `docker restart unifi`.
* To monitor the logs of the container in realtime `docker logs -f unifi`.



## Versions

+ **02.11.2015** Initial Release.
