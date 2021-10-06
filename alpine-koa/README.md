# **Alpine Koa**

Run a Koa server with a routing template on a specified port

_This image requires minimal configuration to launch Koa on a specified port_

[Available on Docker Hub](https://hub.docker.com/r/chiefmikey/alpine-koa)

## Usage

### Install

```shell
docker pull chiefmikey/alpine-koa:latest
```

### Configure

Run the container with a published port and environment variable `PORT`
specifying where Koa should listen or the default (8080) will be used

The container includes `healthcheck.js` which can be run with node and used to
monitor the port connection

## Examples

```sh
docker run -d \
  --name koa \
  --env PORT=3000 \
  -p 3000:3000 \
  --restart unless-stopped \
  --health-cmd='node healthcheck.js' \
  --health-interval=10s \
  --health-timeout=10s
  --health-retries=10
  chiefmikey/alpine-koa:latest
```

```yaml
# docker-compose.yaml
services:
  target:
    container_name: target
    image: chiefmikey/alpine-koa:latest
    ports:
      - 3000:3000
    environment:
      - PORT=3000
    healthcheck:
      test: node healthcheck.js
      interval: 10s
      timeout: 10s
      retries: 10
```
