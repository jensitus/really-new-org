#!/bin/bash
set -eu -o pipefail

# -- run DB migrations

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

. /etc/upset.inc

if [ -z "${RAILS_MASTER_KEY:-}" ]; then
  echo "Missing masterkey; to fix run"
  echo "    .../upset configure $(hostname --fqdn) RAILS_MASTER_KEY=12345566..."
  exit 1
fi
