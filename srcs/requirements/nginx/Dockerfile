FROM debian:stable-20230109-slim

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y \
    nginx \
    openssl

COPY config/config_file.conf /etc/nginx/sites-available/default
COPY config/generate_ssl.sh /etc/nginx/ssl/generate_ssl.sh

RUN mkdir -p /etc/nginx/ssl

RUN chmod +x /etc/nginx/ssl/generate_ssl.sh

ENTRYPOINT ["/etc/nginx/ssl/generate_ssl.sh"]

EXPOSE 443

CMD ["nginx", "-g" , "daemon off;"]