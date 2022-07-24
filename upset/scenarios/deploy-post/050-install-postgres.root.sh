#!/bin/bash
set -eu -o pipefail

# -- install local postgres database server

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

. /etc/upset.inc

export DEBIAN_FRONTEND=noninteractive

[ -x /usr/bin/psql ] ||
  apt-get install -y postgresql postgresql-client libpq-dev
