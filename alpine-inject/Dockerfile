FROM alpine:latest
WORKDIR /inject
COPY . .
COPY init.sh /bin
RUN rm /inject/init.sh
RUN chmod +x /bin/init.sh
VOLUME /var/run/docker.sock:/var/run/docker.sock
ENTRYPOINT "init.sh"
