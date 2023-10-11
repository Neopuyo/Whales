FROM debian:stable-20230109-slim

RUN apt-get update \
    && apt-get install -y \
    redis

COPY ./config/redis.conf /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]