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

if ! grep -c 'NOPASSWD: /bin/launchctl' /private/etc/sudoers.d/10-service-control >/dev/null; then
  putinfo "Creating sudo config..."
  sudo sh -c 'echo "
#
# allow admin users to disable services without a password
#
%admin          ALL = (root) NOPASSWD: /bin/launchctl disable *
%admin          ALL = (root) NOPASSWD: /bin/launchctl stop *
%admin          ALL = (root) NOPASSWD: /usr/bin/pkill -9 keyboardservicesd
%admin          ALL = (root) NOPASSWD: /usr/bin/dscacheutil -flushcache
%admin          ALL = (root) NOPASSWD: /usr/bin/pkill -HUP mDNSResponder
" > /private/etc/sudoers.d/10-service-control'

else
  putinfo "sudo config not needed"
fi

# restore the settings
eval "${_oldopts}"