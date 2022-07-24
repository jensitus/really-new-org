#!/bin/bash
set -eu -o pipefail

# -- set initial configuration ------------------------------------------------

cat > /etc/upset.inc << EOF
#
# upset configuration
#
export GITURL=$GITURL
export HOST=$HOST
export PORT=4001
export RAILS_ENV=production
export DATABASE_NAME=upset
EOF

# -- set hostname -------------------------------------------------------------

hostnamectl set-hostname $HOST

# -- install basic packages ---------------------------------------------------

export DEBIAN_FRONTEND=noninteractive

apt-get -y update
apt-get -y upgrade
apt-get -y install git curl man htop iftop gnupg gnupg2 telnet ruby

# -- setup user ---------------------------------------------------------------

if id -u deploy >/dev/null 2>&1 ; then
  echo "user deploy already exist."
else
  adduser --disabled-password --gecos "" --quiet deploy
  echo "deploy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

# -- setup SSH keys for deployment user ---------------------------------------

mkdir -p /home/deploy/.ssh
cp /root/.ssh/authorized_keys /home/deploy/.ssh/authorized_keys
chown -R deploy:deploy /home/deploy/.ssh

# -- add github keys to known_hosts -------------------------------------------
# see https://stackoverflow.com/questions/13363553/git-error-host-key-verification-failed-when-connecting-to-remote-repository

(
  cd
  touch .ssh/known_hosts
  grep github.com .ssh/known_hosts > /dev/null ||
    ssh-keyscan -t rsa github.com >> .ssh/known_hosts
)

(
  cd /home/deploy
  touch .ssh/known_hosts
  grep github.com .ssh/known_hosts > /dev/null ||
    ssh-keyscan -t rsa github.com >> .ssh/known_hosts
  chown -R deploy:deploy .ssh/known_hosts
)

# -- initial checkout ---------------------------------------------------------

if ! [ -d /home/deploy/src ]; then
  rm -rf /home/deploy/src.tmp
  git clone $GITURL /home/deploy/src.tmp
  mv /home/deploy/src.tmp /home/deploy/src
  chown -R deploy:deploy /home/deploy/src
fi
