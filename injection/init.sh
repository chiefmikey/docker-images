#!/bin/sh

apk update && apk upgrade
apk add --no-cache docker sudo
addgroup root docker
chmod -R 774 /var/run/docker.sock
sudo docker exec name-generator_db /cassandra/cqlsh.sh
