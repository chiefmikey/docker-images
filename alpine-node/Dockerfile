FROM alpine:latest
ENV PORT=8080
EXPOSE 8080
WORKDIR /api
COPY . .
COPY init.sh /bin
RUN rm /api/init.sh
RUN chmod +x /bin/init.sh
ENTRYPOINT "init.sh"
