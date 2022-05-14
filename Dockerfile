FROM alpine:latest
RUN apk upgrade -U && apk add vsftpd openssl --no-cache
COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./start.sh /usr/sbin/start.sh
RUN chmod +x /usr/sbin/start.sh
ENTRYPOINT [ "/usr/sbin/start.sh" ]