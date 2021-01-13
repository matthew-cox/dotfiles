#!/usr/bin/env bash
#
# allow admin users to disable services without a password
#
# set -x
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)
SCRIPTDIR="${HOME}/.dotfiles/scripts"
readonly WORKDIR SCRIPTDIR
#
##############################################################################
#
# Load some utilities
#
readonly THE_UTILS=( "common" )

for utility in "${THE_UTILS[@]}"; do
  if [[ -r "${SCRIPTDIR}/utils_${utility}.sh" ]]; then
    source "${SCRIPTDIR}/utils_${utility}.sh"
  fi
done

_oldopts="$(set +o)"

# save the existing options
set +o errexit
putinfo "Searching for Creative Cloud Installer..."
_installer=$(find /usr/local/Caskroom/adobe-creative-cloud -iname '*Install.app' 2>/dev/null)

if [[ -d "${_installer}" ]]; then
  putsuccess "done"
  open "${_installer}"
else
  puterr "unable to find installer"
fi


# restore the settings
eval "${_oldopts}"

