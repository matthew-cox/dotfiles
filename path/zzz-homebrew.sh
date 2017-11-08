#!/usr/bin/env bash
#
# misc homebrew keg only paths
#
# >&2 echo "$0"
# >&2 echo "$PATH"
KEG_PATHS=(
# sqlite
"/usr/local/opt/sqlite/bin"
# gpg-agent
"/usr/local/opt/gpg-agent/bin"
)

for keg_path in "${KEG_PATHS[@]}"; do
  if [[ -d "$keg_path" ]]; then
    in_path=$(echo "$PATH" | grep -c "${keg_path}")
    # echo "$keg_path"
    if [[ $in_path -le 0 ]]; then
      export PATH="${keg_path}:$PATH"
    fi
  fi
done
# >&2 echo "$PATH"

# Prefer the Homebrew installed openssl (new hotness)
if [[ -d "/usr/local/opt/openssl" ]]; then
  export LDFLAGS="-L/usr/local/opt/openssl/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl/include"
fi
