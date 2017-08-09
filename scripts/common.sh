#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

puterr() {
    msg="$1"
    >&2 echo -e "\e[31mERROR:\e[39m $msg"
}

export -f puterr

putsuccess() {
  msg="$1"
  echo -e "\e[32mSUCCESS:\e[39m $msg"
}

export -f putsuccess
