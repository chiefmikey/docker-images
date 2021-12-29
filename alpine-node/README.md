# **Alpine Node**

Bare minimum installation for a blank slate Node environment to run applications

_This image requires minimal configuration to install Node and run applications_

[Available on Docker Hub](https://hub.docker.com/r/chiefmikey/alpine-node)

## Usage

### Install

```shell
docker pull chiefmikey/alpine-node:latest
```

### Configure

Copy or mount source to the container `app` directory

`npm ci && npm start` will run on every boot

Includes `healthcheck.js` which can be used to monitor the port connection

## Examples

```sh
docker run -d \
  --name app \
  --health-cmd='node healthcheck.js' \
  --health-interval=10s \
  --health-timeout=10s \
  --health-retries=10 \
  -p 8080:8080 \
  -v .:/app \
  chiefmikey/alpine-node:latest
```

```dockerfile
# Dockerfile

FROM chiefmikey/alpine-node:latest
ENV PORT=8080
EXPOSE 8080
WORKDIR /app
COPY . .
```

```yaml
# docker-compose.yaml

services:
  app:
    container_name: app
    image: chiefmikey/alpine-node:latest
    volumes:
      - .:/app
    healthcheck:
      test: node healthcheck.js
      interval: 10s
      timeout: 10s
      retries: 10
    ports:
      - 8080:8080
```
