FROM debian:stable-20230109-slim

RUN apt-get update \
    && apt-get install -y \
    curl

RUN curl -LO https://github.com/google/cadvisor/releases/download/v0.39.0/cadvisor \
    && chmod +x ./cadvisor \
    && mv ./cadvisor /usr/local/bin/

EXPOSE 8888

CMD [ "./usr/local/bin/cadvisor", "--port=8888" ]