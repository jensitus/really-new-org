#!/bin/bash
set -eu -o pipefail

# -- check that sudo is set up correctly

# 1. The fact that this script runs shows that we can ssh as root
# 2. check required config settings

. /etc/upset.inc

function die() {
  echo "$@" >&2 
  exit 1 
}

[ "${RAILS_ENV:-}" ] || die "Missing RAILS_ENV configuration"
[ "${DATABASE_NAME:-}" ] || die "Missing DATABASE_NAME configuration"
[ "${RAILS_MASTER_KEY:-}" ] || die "Missing RAILS_MASTER_KEY, set via upset configure $(hostname --fqdn) RAILS_MASTER_KEY=12345566..."
