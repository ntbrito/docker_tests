#!/usr/bin/dumb-init /bin/sh
set -e

# Prevent core dumps
ulimit -c 0

VAULT_CONFIG_DIR=/vault/config

# Allow mlock to avoid swapping Vault memory to disk
setcap cap_ipc_lock=+ep $(readlink -f $(which vault))

vault server -config=${VAULT_CONFIG_DIR}