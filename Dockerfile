FROM linuxserver/baseimage
MAINTAINER Your Name <your@email.com>
ENV APTLIST="unifi"
#Applying stuff
RUN \
echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" >> /etc/apt/sources.list && \
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
apt-get update -q && \
apt-get install -yq $APTLIST && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
ADD cron/ /etc/cron.d/
ADD defaults/ /defaults/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh
RUN rm -rf /config /var/lib/unifi && ln -s /var/lib/unifi/ /config

# Volumes and Ports
VOLUME /config
EXPOSE 8080 8081 8443 8843 8880


## NOTES ##
## Delete files\folders not needed, e.g. if you dont run any cron commands, delete the cron folder and the "ADD cron/ /etc/cron.d/" line. 
## The User abc, should be running everything, give that permission in any case you need it. 
## Use linuxserver/baseimage as often as posible (or linuxserver/baseimage.nginx where applicable)
## When creating init's Use 10's where posible, its to allow add stuff in between when needed. also, do not be afraid to split custom code into several little ones. 
## Make stuff as quiet as posible "e.g. apt-get update -qq" (Does not apply to the "app" itself. e.g. plex)
## user abc and folders /app /config /defaults are all created by baseimage
## the first available init script is 30<your script>.sh 
