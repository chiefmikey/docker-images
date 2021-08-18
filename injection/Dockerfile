FROM alpine:latest
WORKDIR /cass-helper
COPY . .
COPY init.sh /bin
RUN rm /cass-helper/init.sh
RUN chmod +x /bin/init.sh
ENTRYPOINT "init.sh"
