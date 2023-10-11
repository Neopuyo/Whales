FROM debian:stable-20230109-slim

RUN apt-get update \
    && apt-get install -y \
    mariadb-server

COPY config/start_up.sh /usr/local/bin/

RUN mkdir -p /var/run/mysql \
    && chown -R mysql:mysql /var/run/mysql \
    && chmod +x /usr/local/bin/start_up.sh

ENTRYPOINT ["/usr/local/bin/start_up.sh"]

EXPOSE 3306

CMD ["mysqld", "--bind-address=0.0.0.0"]