FROM debian:stable-20230109-slim

# Maj le système + install les dépendances
RUN apt-get update && apt-get install -y \
    less \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    wget \
    mariadb-client \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-imagick \
    php7.4-zip \
    php7.4-intl

RUN mkdir -p /var/www/html /run/php

COPY ./config/www.conf /etc/php/7.4/fpm/pool.d/

# Installation de WP-CLI
RUN wget -qO /usr/local/bin/wp \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# dl wordpress
RUN wget -qO- https://wordpress.org/latest.tar.gz | \
    tar -xz --strip-components=1 -C /var/www/html

# Copie du script de configuration --> besoin de cd sinon le script se fait a la racine [^^]
WORKDIR /var/www/html/
COPY ./config/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh
ENTRYPOINT ["/usr/local/bin/setup.sh"]

# Ecoute nginx sur le port 9000
EXPOSE 9000

# [commande] pour exécuter WordPress 
CMD ["/usr/sbin/php-fpm7.4", "-F"]