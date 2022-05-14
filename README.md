## Docker image for configured vsftpd
I made this image for people who, like me, needs a fast way to deploy a small ftp server.
Each time you start a container, a small script inside generate a random user/password, create user account, apply password and make a new cert from openssl.

It's a very easy way to share temporarly one directory on your server. **Do not use for long support !**.

There is no guess, no public view and no anonymous. It use TLS to encrypt communications.

It's an update [from this project](https://github.com/fauria/docker-vsftpd) with [this article](https://docs.rockylinux.org/guides/file_sharing/secure_ftp_server_vsftpd/).

To get the user/pass, use docker logs.

>Run a container for example :
```bash
$ docker run -it --name ftp --rm -p 20-22:20-22 -p 990:990 -p 21000-21100:21000-21100 -v [local_dir]:[remote_dir] image:tag
```

>You will get somthing like this :
```bash
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

If you use *-d* option, use **docker logs [container_name]** to get user/pass.
