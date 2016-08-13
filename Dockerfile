# docker image
FROM lsiobase/xenial

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# install packages
RUN \
apt-get update -y && \
apt-get install -y -q --no-install-recommends openjdk-7-jre-headless mongodb-server unzip && \

# cleanup
apt-get clean && \
rm -rfv /tmp/* /var/lib/apt/lists/* /var/tmp/*

# add mfi controller software
ADD https://www.ubnt.com/downloads/mfi/$MFI_VERSION/mFi.unix.zip /

# unpack mfi
RUN unzip mFi.unix.zip && rm mFi.unix.zip

# links
RUN mkdir -p /mFi/logs && ln -s /dev/stderr /mFi/logs/mongod.log && ln -s /dev/stderr /mFi/logs/server.log

# add local files
COPY root/ /

# volumes
VOLUME /mFi/data
WORKDIR /usr/lib/mfi

# ports
EXPOSE 2323/tcp 6080/tcp 6443/tcp 6843/tcp 6880/tcp
EXPOSE 1900/udp 3478/udp 10001/udp

# go go go
CMD ["/usr/bin/java", "-jar", "/usr/lib/mfi/lib/ace.jar", "start"]
