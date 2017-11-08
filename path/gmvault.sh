#!/usr/bin/env bash
# >&2 echo "$0"
# >&2 echo "$PATH"
gm_dir="${HOME}/bin/gmvault-v1.5-beta/bin"
if [[ -d "${gm_dir}" ]]; then
  in_path=$(echo "$PATH" | grep -c "${gm_dir}")
  if [[ $in_path -le 0 ]]; then
    export PATH="${gm_dir}:${PATH}"
  fi
fi
# >&2 echo "$PATH"
