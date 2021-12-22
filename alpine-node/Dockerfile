FROM alpine:latest
COPY init.sh /bin
RUN chmod +x /bin/init.sh
WORKDIR /app
ENTRYPOINT "/bin/init.sh"
