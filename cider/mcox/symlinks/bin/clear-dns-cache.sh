#!/usr/bin/env bash
#
# Clear macOS DNS cache
#
if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "Clearing DNS cache..."
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
fi
