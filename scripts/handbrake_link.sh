#!/usr/bin/env bash
#
# Make links for Handrake to MKMKV
#
set -o errexit -o pipefail -o nounset
. "$(dirname "$0")/common.sh"
#
#
#
mkdir -p "${HOME}/lib"
#
#
LIB_SRC="/Applications/MakeMKV.app/Contents/lib/libmmbd.dylib"

LIB_TARGETS=(
libaacs.dylib
libbdplus.dylib
)
  
if [[ -f "${LIB_SRC}" ]]; then

  for target in "${LIB_TARGETS[@]}"; do
    if [[ ! -e "${HOME}/lib/${target}" ]]; then

      putsuccess "Creating link for '${target}'"
      ln -s "${LIB_SRC}" "${HOME}/lib/${target}"

    elif [[ -L "${HOME}/lib/${target}" ]]; then

      link_target=$(stat "${HOME}/lib/${target}" --format '%N' | awk '{print $3}' | tr -d "'")

      if [[ "${link_target}" != "${LIB_SRC}" ]]; then
        puterr "Link '${target}' exists but points to '${link_target}'!"
        exit 1
      else
        putsuccess "Correct link for '${target}' already exists"
      fi
    else

      puterr "'${target}' exists but is not a link!"
      exit 1
    fi
  done
fi
