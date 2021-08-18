FROM alpine:latest
WORKDIR /injection
COPY . .
COPY init.sh /bin
RUN rm /injection/init.sh
RUN chmod +x /bin/init.sh
VOLUME /var/run/docker.sock:/var/run/docker.sock
ENTRYPOINT "init.sh"
