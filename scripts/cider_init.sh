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
readonly CONFIG_DIR="${HOME}/.dotfiles/cider/${USER}"



if [[ ! -e ~/.cider ]]; then
  putinfo "Creating cider symlink..."
  ln -s "${CONFIG_DIR}" ~/.cider
elif [[ ! -L ~/.cider ]]; then
  puterr "Unknown ~/.cider found!"
  exit 1
fi
  
putinfo "Installing cider..."
if pip3 install -U cider; then
  putsuccess "Done"
else
  puterr "Failure"
  exit 1
fi

putinfo "Restoring cider env..."
if yes | cider restore 2>&1 | grep -Ev -e 'already installed' -e '(re-|re)install'; then
  putsuccess "Done"
else
  puterr "Failure"
  exit 1
fi

putinfo "Setting defaults..."
if cider apply-defaults; then
  putsuccess "Done"
else
  puterr "Failure"
  exit 1
fi

putinfo "Creating symlinks..."
if cider relink; then
  putsuccess "Done"
else
  puterr "Failure"
  exit 1
fi

