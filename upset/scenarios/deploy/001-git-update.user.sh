#!/bin/bash
set -eu -o pipefail

# -- update the local checkout

git fetch
git reset --hard origin/main
