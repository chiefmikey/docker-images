FROM alpine:latest
EXPOSE 8080
ENV PORT=8080
WORKDIR /koa
COPY . .
COPY init.sh /bin
RUN rm /koa/init.sh
RUN chmod +x /bin/init.sh
ENTRYPOINT "init.sh"
