#!/bin/bash
set -eu -o pipefail

# -- setup postgres database user

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

. /etc/upset.inc

DBUSER=deploy

if ! su - postgres -c "psql -c \"select rolname from pg_roles where rolname='$DBUSER'\"" | grep "$DBUSER" > /dev/null ; then
  su - postgres -c "createuser $DBUSER" || true
fi

if ! su - postgres -c "psql -c \"select datname from pg_database where datname='$DATABASE_NAME'\"" | grep "$DATABASE_NAME" > /dev/null ; then
  su - postgres -c "createdb $DATABASE_NAME -O $DBUSER" || true
fi
