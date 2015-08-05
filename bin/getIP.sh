#!/bin/bash
#
# List out the network interfaces, types, and IPv4 addresses for Mac OS X
#
if [ "$(uname -s)" = "Darwin" ]; then
  for INTERFACE in $(ifconfig -l); do
    IP=$(ifconfig "${INTERFACE}" | grep 'broadcast' | awk '{print $2}')
    if [ -n "$IP" ]; then
      TYPE=$(ifconfig -v "${INTERFACE}" | grep 'type' | awk '{print $2}')
      printf '%-8s (%3s): %s\n' "${TYPE}" "${INTERFACE}" "${IP}"
    fi
  done
fi
