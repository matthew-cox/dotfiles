#!/usr/bin/env bash
#
# Clear macOS DNS cache
#
if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "Clearing DNS cache..."
  if command -v discoveryutil; then
    sudo discoveryutil udnsflushcaches
  fi
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
fi
