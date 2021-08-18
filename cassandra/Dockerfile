FROM alpine:latest
EXPOSE 7000 7001 7199 9042 9160
WORKDIR /cassandra
COPY . .
COPY init.sh /bin
RUN rm /cassandra/init.sh
RUN chmod +x /bin/init.sh
RUN apk add --no-cache bash
ENV \
  CASSANDRA_VERSION=4.0.0 \
  CASSANDRA_HOME=/opt/cassandra \
  CASSANDRA=/opt/cassandra/bin/cassandra \
  CASSANDRA_CONF=/etc/cassandra \
  CASSANDRA_PERSIST_DIR=/var/lib/cassandra \
  CASSANDRA_DATA=/var/lib/cassandra/data \
  CASSANDRA_COMMITLOG=/var/lib/cassandra/commitlog \
  CASSANDRA_LOG=/var/log/cassandra \
  CASSANDRA_USER=cassandra \
  GOSU_VERSION=1.12 \
  BASH_SOURCE=/bin/sh
ENTRYPOINT ["/bin/bash", "init.sh"]
