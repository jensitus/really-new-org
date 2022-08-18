#!/bin/bash
set -eu -o pipefail

# -- update the caddy configuration

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

. /etc/upset.inc

__DIR__=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

PORT=$PORT erb $__DIR__/templates/Caddyfile.erb > /etc/caddy/Caddyfile

# systemctl daemon-reload
systemctl restart caddy
