#!/bin/bash
set -eu -o pipefail

# -- install gem dependencies

. /etc/upset.inc

# bundler I hate you
unset RUBYLIB
unset RUBYOPT

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


# gem install bundler
which bundle > /dev/null || (
  echo "Missing bundler"
  exit 1
)

# install required dependencies
bundle install | grep -v Using
