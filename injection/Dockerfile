FROM alpine:latest
WORKDIR /cass-helper
COPY . .
COPY init.sh /bin
RUN rm /cass-helper/init.sh
RUN chmod +x /bin/init.sh
VOLUME /var/run/docker.sock:/var/run/docker.sock
ENTRYPOINT "init.sh"
