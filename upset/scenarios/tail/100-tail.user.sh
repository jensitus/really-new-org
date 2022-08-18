#!/bin/bash
set -eu -o pipefail

# script to show logs
sudo journalctl -f -u httpd-$PORT.service

