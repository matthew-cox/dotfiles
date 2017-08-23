#!/usr/bin/env bash
#
# common message functions
#
set -o errexit -o pipefail -o nounset

puterr() {
    msg="$1"
    >&2 echo -e "\e[31mERROR:\e[39m $msg"
}

export -f puterr

putinfo() {
  msg="$1"
  echo -e "\e[34mNOTE:\e[39m $msg"
}

export -f putinfo

putsuccess() {
  msg="$1"
  echo -e "\e[32mSUCCESS:\e[39m $msg"
}

export -f putsuccess
