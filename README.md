# Docker Images

Back end construction of fully customized Docker images

- Fortified stability by proxying PHP renders to process separately from Apache
  using PHP-FPM
- Emphasized security by defining unique user and group permissions for limited
  server access
- Maintained space complexity from retaining a minimal Alpine based image size
  by specifying all installed packages
