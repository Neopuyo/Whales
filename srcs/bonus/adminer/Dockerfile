FROM debian:stable-20230109-slim

RUN apt-get update \
    && apt-get install -y \
    wget \
    php7.4-mysql \
    php7.4 
   
RUN wget -O /usr/share/adminer.php https://www.adminer.org/latest.php

EXPOSE 8080

CMD ["php7.4", "-S", "0.0.0.0:5123", "-t", "/usr/share/"]