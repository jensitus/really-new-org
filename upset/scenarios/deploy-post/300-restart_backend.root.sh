#!/bin/bash
set -eu -o pipefail

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

. /etc/upset.inc

export PORT=$PORT

# -- reconfigure and restart backend services
__DIR__=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
erb $__DIR__/templates/httpd.service.erb > /etc/systemd/system/httpd-$PORT.service

systemctl enable httpd-$PORT.service
systemctl restart httpd-$PORT
