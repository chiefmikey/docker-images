# Docker Images

Back end construction of fully customized Docker images

- Fortified stability by proxying PHP renders to process separately from Apache
  using PHP-FPM
- Emphasized security by defining unique user and group permissions for limited
  server access
- Maintained space complexity from retaining a minimal Alpine based image size
  by specifying all installed packages

|Images|   |
|---|---|
|[Injection](https://github.com/chiefmikey/docker-images/tree/main/injection)|Externally inject shell commands|
|[Cassandra](https://github.com/chiefmikey/docker-images/tree/main/cassandra)|Apache Cassandra 4.0.0 database|
|[Koa](https://github.com/chiefmikey/docker-images/tree/main/koa)|Koa server with a routing skeleton|
|[CraftCMS](https://github.com/chiefmikey/docker-images/tree/main/craftcms)|Fresh CraftCMS installation|
