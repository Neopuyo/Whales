FROM debian:stable-20230109-slim

RUN apt-get update \
    && apt-get install -y \
    vsftpd

COPY config/vsftpd.conf /etc/
COPY ./config/setup.sh /app/

RUN chmod +x /app/setup.sh

ENTRYPOINT [ "/app/setup.sh" ]

EXPOSE 21 40000-40008

CMD ["vsftpd", "/etc/vsftpd.conf"]