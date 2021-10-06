# **Alpine Inject**

Connect to other containers to externally inject shell commands when triggered

_This image requires minimal configuration to inject commands, extra useful when
combined with healthcheck_

[Available on Docker Hub](https://hub.docker.com/r/chiefmikey/alpine-inject)

## Usage

### Install

```shell
docker pull chiefmikey/alpine-inject:latest
```

### Configure

Run the container on the same network as the target with environment variable
`INJECT_COMMAND` as the command or string of commands to inject at startup

## Examples

```sh
docker run --name inject -d -v /var/run/docker.sock:/var/run/docker.sock --network=inject-net --env-file inject.env chiefmikey/alpine-inject:latest`
```

```yaml
#docker-compose.yaml
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

```env
#inject.env
INJECT_COMMAND="
  echo 'command 1';
  echo 'command 2';
  echo 'command 3';
"
```

### [View Demo](https://github.com/chiefmikey/docker-images/tree/main/alpine-inject/demo)
