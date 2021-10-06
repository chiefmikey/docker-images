#!/bin/sh

apk update && apk upgrade
apk add --no-cache docker sudo
addgroup root docker
chmod -R 774 /var/run/docker.sock
sudo docker exec target sh -c "$INJECT_COMMAND"
echo "Target container has been injected"
