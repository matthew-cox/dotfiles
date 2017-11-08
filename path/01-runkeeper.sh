#!/usr/bin/env bash
# >&2 echo "$0"
# >&2 echo "$PATH"
if [ -d "/usr/local/rk/bin" ]; then
  in_path=$(echo "$PATH" | grep -c "/usr/local/rk/bin")

  if [[ $in_path -le 0 ]]; then
    export PATH="${PATH}:/usr/local/rk/bin:/usr/local/rk/sbin"
  fi
fi
# >&2 echo "$PATH"
