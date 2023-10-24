FROM ubuntu:22.04

# ubuntu setup
RUN apt-get update
RUN apt-get upgrade -y 

# install extra packages
RUN apt-get install -y \
    curl \
    cron \
    proftpd \
    proftpd-mod-crypto \
    vim \
    net-tools \
    openssh-server \
    openssl

COPY entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
