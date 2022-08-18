#!/bin/bash
set -eu -o pipefail

# -- precompile assets

scripts/rake assets:precompile