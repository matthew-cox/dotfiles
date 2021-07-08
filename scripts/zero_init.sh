#!/usr/bin/env bash
#
#
set -o errexit -o pipefail -o nounset
# set -x
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)
#
##############################################################################
#
# Load some utilities
#
readonly THE_UTILS=( "common" )

for utility in "${THE_UTILS[@]}"; do
  if [[ -r "${WORKDIR}/utils_${utility}.sh" ]]; then
    source "${WORKDIR}/utils_${utility}.sh"
  fi
done
#
##############################################################################
#
# config stuff
#
readonly CONFIG_DEST="${HOME}/.config/zero/dotfiles"
readonly CONFIG_SRC="${HOME}/.dotfiles/config/zero/${USER}"

mkdir -p $(dirname "${CONFIG_DEST}")

if [[ ! -e "${CONFIG_DEST}" ]]; then
  putinfo "Creating zero symlink..."
  ln -s "${CONFIG_SRC}" "${CONFIG_DEST}"
elif [[ ! -L "${CONFIG_DEST}" ]]; then
  puterr "Unknown '${CONFIG_DEST}' found!"
  exit 1
fi

if [[ -n "${1:-}" && -d "${CONFIG_SRC}/workspaces" && -d "${CONFIG_SRC}/workspaces/${1:-}" ]]; then
  
  ${HOME}/.dotfiles/zero/setup
  
  zero setup "${1}"
  zero bundle "${1}"

else

  puterr "Workspace required!"
fi