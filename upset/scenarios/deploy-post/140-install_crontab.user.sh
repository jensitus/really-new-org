#!/bin/bash
set -eu -o pipefail

# -- install a project specific crontab file

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

. /etc/upset.inc

if [ -f config/crontab ]; then
  crontab config/crontab
  echo "Installed crontab"
fi
