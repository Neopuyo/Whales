#!/bin/sh

set -xv

adduser --disabled-login --gecos "" $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd
echo "$FTP_USER" | tee -a /etc/vsftpd.userlist

mkdir -p /home/loumarti/ftp_content/

chmod 777 /home/loumarti/ftp_content/
chown -R "$FTP_USER:$FTP_USER" /home/loumarti/ftp_content/

exec "$@"