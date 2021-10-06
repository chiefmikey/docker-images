# **Alpine Koa**

Run a Koa server with a routing skeleton

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

## Examples

```sh
docker run --name koa -d --restart unless-stopped -p 3000:3000 --env PORT=3000 chiefmikey/alpine-koa:latest
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
