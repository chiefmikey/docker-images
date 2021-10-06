# **Alpine Cassandra**

Initialize an Apache Cassandra database listening on the default port (9042)

_This image requires minimal configuration to install and run Cassandra with
cqlsh or a driver_

[Available on Docker Hub](https://hub.docker.com/r/chiefmikey/alpine-cassandra)

## Usage

### Install

```shell
docker pull chiefmikey/alpine-cassandra:latest
```

### Configure

Run the container with environment variable `CASSANDRA_VERSION` specifying which
release to install or the default (4.0.0) will be used

## Examples

```sh
docker run -d \
  --name cassandra \
  --env CASSANDRA_VERSION=4.0.1 \
  --restart unless-stopped \
  -v cassandra-data:/var/lib/cassandra \
  chiefmikey/alpine-cassandra:latest
```

```yaml
# docker-compose.yaml
services:
  cassandra:
    container_name: cassandra
    image: chiefmikey/alpine-cassandra:latest
    volumes:
      - cassandra-data:/var/lib/cassandra
    environment:
      - CASSANDRA_VERSION=4.0.1
    healthcheck:
      test:
        su -s /opt/cassandra/bin/bash -c 'bin/cqlsh --debug' cassandra
      interval: 10s
      timeout: 10s
      retries: 10
```
