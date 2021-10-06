# **Alpine Inject**

Connect to other containers to externally inject shell commands when triggered

_This image requires minimal configuration to inject commands, extra useful when combined with healthcheck_

[Available on Docker Hub](https://hub.docker.com/r/chiefmikey/alpine-inject)

## Usage

### Install

```shell
docker pull chiefmikey/alpine-inject:latest
```

### Configure

Run the container with environment variable `INJECT_COMMAND` as the command or string of commands to inject

## Examples

docker-compose.yaml

```yaml
services:
  inject:
    container_name: inject
    image: chiefmikey/alpine-inject:latest
    networks:
      - inject-net
    cap_add:
      - NET_ADMIN
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    depends_on:
      target:
        condition: service_healthy
    env_file:
      - inject.env
```

inject.env

```env
INJECT_COMMAND="
  command 1;
  command 2;
  command 3;
"
```
