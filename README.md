# Docker image for configured vsftpd
I made this image for people who, like me, needs a fast way to deploy a small ftp server.
Each time you start a container, a small script inside generate a random user/password, create user account, apply password and make a new cert from openssl.

It's a very easy way to share temporarly one directory on your server. **Do not use for long support !**.

There is no guess, no public view and no anonymous. It use TLS to encrypt communications.

It's an update [from this project](https://github.com/fauria/docker-vsftpd) with [this article](https://docs.rockylinux.org/guides/file_sharing/secure_ftp_server_vsftpd/).

To get the user/pass, use docker logs.
|Encryption|Passive Ports|Max clients|
|----------|-------------|-----------|
|RSA 4096 bits|21000 to 21100|100|


Run a container for example :
```bash
$ docker run -it --name ftp --rm -p 20-22:20-22 -p 990:990 -p 21000-21100:21000-21100 -v [local_dir]:/home/vsftpd image:tag
```

You will get somthing like this :
```
addgroup: group 'nogroup' in use
chpasswd: password for 'tpronf' changed
Generating a RSA private key
......................................................................................++++
........................................++++
writing new private key to '/etc/vsftpd/vsftpd.key'
-----
- User : tpronf
- Pass : gsmYl6I-7lqMLMA4ccQL
-----
Have a good day !
```

If you use `-d` option, use `docker logs [container_name]` to get user/pass.


# Binds
You can bind 2 folders between container and host :
- `/home/vsftpd` for files
- `/var/log/vsftpd` for logs

### Be Careful !
The container has all rights on the files folder shared (*chrooted for security*). Users who have login/password can upload, create and delete all contents in it. Anonymous can't connect obviously.

**Do not use this container to share readonly/public content !!**

# Arguments
In *passive mode*, vsftpd need sometimes an external IP to deal with. For that, use `PASV_ADDRESS` env.
With command line, use `-e "PASV_ADDRESS=X.X.X.X"`
```bash
$ docker run -e "PASV_ADDRESS=1.2.3.4" image:tag
```

# Official release
To get pre-build online version :
```bash
$ docker pull pijee/vsftpd:latest
```