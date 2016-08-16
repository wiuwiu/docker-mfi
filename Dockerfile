# docker image
FROM lsiobase/xenial

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# add ubiquiti repo
# ADD ./100-ubnt.list /etc/apt/sources.list.d/100-ubnt.list

# install packages
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
    apt-get update -q -y && \
    apt-get install -q -y openjdk-7-jre-headless mongodb-server mfi wget && \

# cleanup
apt-get clean && \
rm -rfv /tmp/* /var/lib/apt/lists/* /var/tmp/*

# add local files
COPY root/ /

# volumes
WORKDIR /usr/lib/mfi
VOLUME /config

# ports
EXPOSE 2323/tcp 6080/tcp 6443/tcp 6843/tcp 6880/tcp
EXPOSE 1900/udp 3478/udp 10001/udp
