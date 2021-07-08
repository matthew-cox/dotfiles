#!/usr/bin/env bash
#
# Make links for Handrake to MKMKV
#
set -o errexit -o pipefail -o nounset
# set -x
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)
SCRIPTDIR="${HOME}/.dotfiles/scripts"
readonly WORKDIR SCRIPTDIR
#
##############################################################################
#
# Load some utilities
#
readonly THE_UTILS=( "common" "homebrew" )

for utility in "${THE_UTILS[@]}"; do
  if [[ -r "${SCRIPTDIR}/utils_${utility}.sh" ]]; then
    source "${SCRIPTDIR}/utils_${utility}.sh"
  fi
done
#
##############################################################################
#
# global vars
#
LIB_SRC="/Applications/MakeMKV.app/Contents/lib/libmmbd.dylib"

LIB_TARGETS=(
libaacs.dylib
libbdplus.dylib
)
  
readonly LIB_SRC LIB_TARGETS

#
##############################################################################
#
# Load some utilities
#
if [[ -f "${LIB_SRC}" ]]; then
  
  #
  # Need ~/lib directory
  #
  mkdir -p "${HOME}/lib"

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
