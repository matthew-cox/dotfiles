#!/usr/bin/env bash
#
# postgresql on Mac OS X
#
# >&2 echo "$0"
# >&2 echo "$PATH"
if [ "$(uname -s)" = "Darwin" ]; then
  for X in 9.3 9.2 9.1; do
    the_dir="/Library/PostgreSQL/${X}/bin"
    if [[ -d "${the_dir}" ]]; then
      in_path=$(echo "$PATH" | grep -c "${the_dir}")
      if [[ $in_path -le 0 ]]; then
        export PATH="${the_dir}:${PATH}"
      fi
    fi
  done
fi
# >&2 echo "$PATH"
