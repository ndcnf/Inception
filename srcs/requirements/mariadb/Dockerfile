FROM alpine:3.16
# RUN mkdir -p /var/lib/mysql

RUN apk update
RUN apk add bash vim
RUN apk add mariadb mariadb-client

# RUN #apk add openrc --no-cache

# RUN #mkdir "/etc/init.d/mariadb/"

# RUN apk add mysql mysql-client
# RUN /etc/init.d/mariadb setup
# RUN /etc/init.d/mariadb start


# COPY ./srcs/requirements/mariadb /var/lib/mysql
#CMD ["mariadb", ""]

COPY conf/db-entrypoint.sh /
# COPY conf/www.conf /etc/php8/php-fpm.d/www.conf

RUN chmod -x /db-entrypoint.sh

CMD ["bash", "/db-entrypoint.sh"]
EXPOSE 3306
