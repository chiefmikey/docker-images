FROM alpine:latest
WORKDIR /inject
COPY . .
COPY init.sh /bin
RUN rm /inject/init.sh
RUN chmod +x /bin/init.sh
VOLUME /var/run/docker.sock:/var/run/docker.sock
ENV INJECT_COMMAND="echo 'Set environment variable INJECT_COMMAND as the command or string of commands to inject'"
ENTRYPOINT "init.sh"
