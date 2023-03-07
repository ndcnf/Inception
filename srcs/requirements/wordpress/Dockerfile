FROM alpine:3.16
RUN apk update
RUN apk add bash vim curl
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN php wp-cli.phar --info
#json php-mysqli php-fpm
# RUN apk add


## Devrait eviter l'erreur "Error response from daemon: failed to create shim: OCI runtime create failed: container_linux.go:380: starting container process caused: exec: "php-fpm": executable file not found in $PATH: unknown"
# RUN chmod
# CMD ["php-fpm"]

## SUPPRIMER ET REMPLACER
CMD sleep infinity
EXPOSE 9000
