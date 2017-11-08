#!/usr/bin/env bash
#
# Because...Chewie
#
# >&2 echo "$0"
# >&2 echo "$PATH"
CHEWIE_DIR="${HOME}/Devel/SimpliSafe/chewie-tool"

if [[ -d "${CHEWIE_DIR}" ]]; then
  in_path=$(echo "$PATH" | grep -c "${CHEWIE_DIR}")

  if [[ $in_path -le 0 ]]; then
    export PATH="${PATH}:${CHEWIE_DIR}/bin"
  fi
fi
# >&2 echo "$PATH"
