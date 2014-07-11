# arangodb
#
# VERSION: see `TAG`
FROM ubuntu:14.04
MAINTAINER Joao Paulo Dubas "joao.dubas@gmail.com"

# install system deps
RUN apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install wget

# add arangodb source
ENV ARANGO_URL http://www.arangodb.org/repositories/arangodb2/xUbuntu_14.04
RUN echo "deb $ARANGO_URL/ /" >> /etc/apt/sources.list.d/arangodb.list \
    && wget $ARANGO_URL/Release.key \
    && apt-key add - < Release.key \
    && rm Release.key

# install arangodb
RUN apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install arangodb=2.1.2

# cleanup
RUN apt-get -y -qq --force-yes clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# configure execution
EXPOSE 8529
CMD ["/usr/sbin/arangod", "--configuration", "/etc/arangodb/arangod.conf"]
