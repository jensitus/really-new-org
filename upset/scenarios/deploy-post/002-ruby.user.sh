#!/bin/bash
set -eu -o pipefail

# -- setup rbenv and ruby

. /etc/upset.inc

# we are running in the home dir.

if ! [ -f ~/.rbenv.installed ]; then

  # -- install build dependencies´ -------------------------------------------
  export DEBIAN_FRONTEND=noninteractive
  sudo apt-get -y install gcc make git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

  # -- download rbenv installer -----------------------------------------------

  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  source ~/.bashrc

  # -- install ruby-build
  
  echo "gem: --no-document" > ~/.gemrc

  (
    cd

    git clone https://github.com/rbenv/ruby-build.git
    PREFIX=/usr/local sudo ./ruby-build/install.sh
  )
  
  touch ~/.rbenv.installed
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Make sure we have a ruby installed according to .ruby-version
expected_ruby_version="$(cat .ruby-version)"
if ! [ -d ~/.rbenv/versions/$expected_ruby_version ]; then
  rbenv install $expected_ruby_version
  rbenv rehash
fi
