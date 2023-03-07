FROM alpine:3.16
RUN apk update
RUN apk add wget bash php-fpm
#json php-mysqli
# RUN apk add


## Devrait eviter l'erreur "Error response from daemon: failed to create shim: OCI runtime create failed: container_linux.go:380: starting container process caused: exec: "php-fpm": executable file not found in $PATH: unknown"
# RUN chmod
CMD ["php-fpm"]
EXPOSE 80
