#!/bin/sh

USER=$(cat /dev/urandom | tr -dc a-z | head -c 6 )
PASS=$(cat /dev/urandom | tr -dc A-Z-a-z-0-9 | head -c 20 )
addgroup nogroup
adduser -h /home/vsftpd -G nogroup -D -s /bin/false $USER
echo "${USER}:${PASS}" | chpasswd
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/vsftpd/vsftpd.key -out /etc/vsftpd/vsftpd.pem -subj "/C=AU/O=My company/CN=example.org"

cat << EOB
-----
- User : ${USER}
- Pass : ${PASS}
-----
Have a good day !
EOB

mkdir /var/log/vsftpd
touch /var/log/vsftpd/xferlog.log

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf