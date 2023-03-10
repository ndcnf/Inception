FROM alpine:3.16
# RUN mkdir -p /var/lib/mysql
#RUN apk add maria (voir synthaxe)

RUN apk update
RUN apk add bash vim
RUN apk add mariadb mariadb-client
# RUN apk add mysql mysql-client
# RUN /etc/init.d/mariadb setup
# RUN /etc/init.d/mariadb start


# COPY ./srcs/requirements/mariadb /var/lib/mysql
#CMD ["mariadb", ""]
EXPOSE 3306
CMD sleep infinity
