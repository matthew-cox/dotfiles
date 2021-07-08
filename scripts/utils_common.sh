#!/usr/bin/env bash
#
# common message functions
#
set -o errexit -o pipefail -o nounset

#
##############################################################################
#
# Look at a binary file on disk to see if it has ever been run
#
function has_binary_been_launched(){
  local _the_bin="$1"

  if [[ ! -x "${_the_bin}" ]]; then
    >&2 echo -e "\e[31mERROR:\e[39m Provided bin ($_the_bin) is not executable!"
    exit 77
  fi

  local _file_access=$(/usr/bin/stat -f '%B' -L "${_the_bin}")
  local _file_berth=$(/usr/bin/stat -f '%a' -L "${_the_bin}")

  if [[ $_file_access -eq $_file_berth ]]; then
    echo "false"
  else
    echo "true"
  fi
}

export -f has_binary_been_launched

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
