FROM debian:bullseye-slim


RUN set -eux; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y --no-install-recommends apache2 \
            php-common \
            libapache2-mod-php \
            php-cli \
            ca-certificates \
		    curl

COPY apache2-foreground /usr/local/bin/apache2-foreground

RUN set -eux; \
    chown -R www-data:www-data /var/www/html/; \
    chmod 755 /usr/local/bin/apache2-foreground

## RUN echo "<?php phpinfo(); ?>" > /var/www/html/info.php

WORKDIR /var/www/html

EXPOSE 80

## for troubleshooting
## CMD ["/bin/sleep", "3600"]
CMD ["/usr/local/bin/apache2-foreground"]