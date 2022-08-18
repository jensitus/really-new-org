#!/bin/bash
set -eu -o pipefail

# -- setup the caddy webserver

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

. /etc/upset.inc


[ -x /usr/bin/caddy ] || (
  apt install -y debian-keyring debian-archive-keyring apt-transport-https
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
  apt update
  apt install caddy

  ufw allow 22
  ufw allow 80
  ufw allow 443
  ufw --force enable
)
