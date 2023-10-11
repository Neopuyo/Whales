FROM debian:stable-20230109-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

COPY ./config/nodeServer.js .
COPY ./config/index.html .

CMD ["node", "nodeServer.js"]