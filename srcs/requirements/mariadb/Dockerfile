FROM alpine:3.16

RUN apk update
RUN apk add bash vim
RUN apk add mariadb mariadb-client

#  Pour modifier et accepter les connexions en dehors du localhost
RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
RUN sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

COPY conf/db-entrypoint.sh /

RUN chmod -x /db-entrypoint.sh

CMD ["bash", "/db-entrypoint.sh"]
EXPOSE 3306
