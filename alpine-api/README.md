# **Alpine API**

An API template served with Koa on a specified port routing data to MongoDB using Mongoose

_This image requires minimal configuration to launch an API connected to MongoDB_

[Available on Docker Hub](https://hub.docker.com/r/chiefmikey/alpine-koa)

## Usage

### Install

```shell
docker pull chiefmikey/alpine-api:latest
```

### Configure

Run the container with a published port and environment variable `PORT`
specifying where Koa should listen or the default (8080) will be used

Include MongoDB URI environment variables `DB_CONTAINER`, `DB_PORT` and `DB_NAME` or the default (mongodb://mongo:27017/db) will be used

The container includes `healthcheck.js` which can be run with node and used to
monitor the port connection

## Examples

```sh
docker run -d \
  --name koa \
  --env \
    PORT=3000 \
    DB_CONTAINER=mongo \
    DB_PORT=27017 \
    DB_NAME=db \
  -p 3000:3000 \
  --restart unless-stopped \
  --health-cmd='node healthcheck.js' \
  --health-interval=10s \
  --health-timeout=10s \
  --health-retries=10 \
  chiefmikey/alpine-api:latest
```

```yaml
# docker-compose.yaml
services:

  api:
    container_name: api
    image: chiefmikey/alpine-api:latest
    healthcheck:
      test: node healthcheck.js
      interval: 10s
      timeout: 10s
      retries: 10
    depends_on:
      mongo:
        condition: service_healthy
    networks:
      - db-net
    ports:
      - 3000:3000
    environment:
      - PORT=3000
      - DB_CONTAINER=mongo
      - DB_PORT=27017
      - DB_NAME=db

  mongo:
    container_name: mongo
    image: mongo:latest
    healthcheck:
      test: echo 'db.runCommand("ping").ok' | mongo localhost:27017/db --quiet
      interval: 10s
      timeout: 10s
      retries: 10
    networks:
      - db-net
    volumes:
      - mongo-data:/data/db
    environment:
      - MONGO_INITDB_DATABASE=db
    ports:
      - 27017:27017

volumes:
  mongo-data:

networks:
  db-net:
```
