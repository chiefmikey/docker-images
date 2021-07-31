FROM alpine:latest
EXPOSE 3000
WORKDIR /craft
COPY . .
COPY init.sh /bin
RUN ["chmod", "+x", "/bin/init.sh"]
ENTRYPOINT "init.sh"
HEALTHCHECK --interval=5m --timeout=10s \
  CMD curl --silent --fail http://127.0.0.1:3000/fpm-ping.php
