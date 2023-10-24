FROM alpine:3.12

# This is the release of Vault to pull in.
ARG VAULT_VERSION=1.6.2

# Create a vault user and group first so the IDs get set the same way,
# even as the rest of this may change over time.
RUN addgroup vault \
 && adduser -S -G vault vault

# Set up certificates, our base tools, and Vault.
RUN set -eux \
 && apk add --no-cache ca-certificates gnupg openssl libcap su-exec dumb-init tzdata \
 && VAULT_GPGKEY=91A6E7F85D05C65630BEF18951852D87348FFC4C; \
    found=''; \
    for server in \
        hkp://p80.pool.sks-keyservers.net:80 \
        hkp://keyserver.ubuntu.com:80 \
        hkp://pgp.mit.edu:80 \
    ; do \
        echo "Fetching GPG key $VAULT_GPGKEY from $server"; \
        gpg --batch --keyserver "$server" --recv-keys "$VAULT_GPGKEY" && found=yes && break; \
    done; \
    test -z "$found" && echo >&2 "error: failed to fetch GPG key $VAULT_GPGKEY" && exit 1; \
    mkdir -p /tmp/build \
 && cd /tmp/build \
 && wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
 && wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS \
 && wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig \
 && gpg --batch --verify vault_${VAULT_VERSION}_SHA256SUMS.sig vault_${VAULT_VERSION}_SHA256SUMS \
 && grep vault_${VAULT_VERSION}_linux_amd64.zip vault_${VAULT_VERSION}_SHA256SUMS | sha256sum -c \
 && unzip -d /bin vault_${VAULT_VERSION}_linux_amd64.zip \
 && cd /tmp \
 && rm -rf /tmp/build \
 && gpgconf --kill dirmngr \
 && gpgconf --kill gpg-agent \
 && apk del gnupg openssl \
 && rm -rf /root/.gnupg

RUN mkdir -p /vault/logs \
 && mkdir -p /vault/file \
 && mkdir -p /vault/config \
 && chown -R vault:vault /vault

VOLUME /vault/logs
VOLUME /vault/file
VOLUME /vault/config

COPY config.hcl /vault/config/local.json

# 8200/tcp is the primary interface that applications use to interact with Vault.
EXPOSE 8200

COPY vault-entrypoint.sh /bin/vault-entrypoint.sh
RUN chmod 755 /bin/vault-entrypoint.sh

ENTRYPOINT ["/bin/vault-entrypoint.sh"]

## for troubleshooting
# CMD ["/bin/sleep", "3600"]