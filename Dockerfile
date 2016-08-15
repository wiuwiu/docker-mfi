# docker image
FROM lsiobase/xenial

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# install packages
RUN echo deb http://dl.ubnt.com/mfi/distros/deb/debian debian ubiquiti >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50
RUN apt-get update -y
RUN apt-get install -y openjdk-7-jre-headless mongodb-server mfi wget

# cleanup
RUN apt-get clean
RUN rm -rfv /tmp/* /var/lib/apt/lists/* /var/tmp/*

# add local files
COPY root/ /

# volumes
WORKDIR /usr/lib/mfi
VOLUME /config

# ports
EXPOSE 2323/tcp 6080/tcp 6443/tcp 6843/tcp 6880/tcp
EXPOSE 1900/udp 3478/udp 10001/udp
