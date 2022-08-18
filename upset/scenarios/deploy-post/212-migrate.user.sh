#!/bin/bash
set -eu -o pipefail

# -- run DB migrations
./scripts/rake db:migrate
