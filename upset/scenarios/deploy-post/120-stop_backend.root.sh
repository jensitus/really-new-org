#!/bin/bash

# -- stop the backend service

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

. /etc/upset.inc

# Try to stop the httpd-$PORT service, but ignore any failure.
systemctl stop httpd-$PORT || true
