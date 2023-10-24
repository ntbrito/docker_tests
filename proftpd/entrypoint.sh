#!/bin/sh -e

useradd -s /bin/bash -m -d /home/testftp testftp
echo "testftp:gooDpassword" | chpasswd

mkdir -p /etc/ssh
test -f /etc/ssh/ssh_host_rsa_key   || ssh-keygen -m PEM -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa -b 2048
test -f /etc/ssh/ssh_host_dsa_key   || ssh-keygen -m PEM -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa -b 1024
test -f /etc/ssh/ssh_host_ecdsa_key || ssh-keygen -m PEM -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521

sed -e "/^Port/s/^/#/" \
    -e "/sftp.conf/s/^#//" \
    -i /etc/proftpd/proftpd.conf
sed -e "/mod_sftp.c/s/^#//" \
    -i /etc/proftpd/modules.conf
sed -e "/SFTPEngine/s/^#//" \
    -e "s/#Port[ \s].*/Port 222/" \
    -e "/SFTPCompression/s/^#//" \
    -e "/SFTPHostKey/s/^#//" \
    -i /etc/proftpd/sftp.conf

mkdir -p /run/proftpd && chown proftpd /run/proftpd/

exec proftpd --nodaemon -c /etc/proftpd/proftpd.conf
